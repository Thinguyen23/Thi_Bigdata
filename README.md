## Table of Contents
**[Concepts](#concepts)**<br>
1. **[What is Big Data?](#what-is-big-data)**<br>
2. **[Natural Language Processing (NLP)](#natural-language-processing)**<br>
3. **[Cloud Computing](#cloud-computing)**<br>

**[Project](#project)**<br>
1. **[Project Overview](#big-data-with-aws)**<br>
2. **[ETL process](#etl-process)**<br>
3. **[Analysis](#analysis)**<br>

# Concepts
## What is Big Data?
What exacltly constitutes big data? At what point does data become big? Is it just the size? A good rule of thumb to apply is: Data is considered big data when it exceeds the capacity of operational databases.

There are four characteristics of big date:
- Volume - size of the data
- Velocity - how quickly data comes in
- Variety - differenr forms of data
- veracity - uncertainty of data

Working with Big Data creates unique challenge including storage, accessability, back-up, etc.
## Natural Language Processing
Natural language processing (NLP) is a growing field of study that combines linguistics and computer science for computers to understand written, spoken, and typed natural language. NLP is the process of converting normal language to a machine readable format, which allows a computer to analyze text as if it were numerical data.
Key concepts:
- Tokenization: splitting a document or sentence into small subsets of data that can be  analyzed with NLTK or spaCy libraries.
- Normalization: taking mispelled words and converting them into their original form. Two common practices are stemming and lemmatization:
  - Stemming: a "rough" cut at the end of the word
  - Lemmatization: a "smoother" cut off of the end of word
- Part of Speech Tagging (PoS): find each word’s part of speech in a given document
- Natural Language Generation: a growing field in NLP that entails writing code insuch a way that it will generate new text
- Bag-of-Words (BoW) model: a text is represented as the bag (multiset) of its words, disregarding grammar and even word order but keeping multiplicity.
- N-gram: a sequence of items from a given text
- Text Similarity: a use case of NLP used to determine document or sentence similarity.
### NLP pipeline
<p align="center">
  <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/nlp_pipeline.png" width="60%">
</p>
                                                                                                                        
## Cloud computing
'In the cloud' is an oft-repeated phrase these days, and nearly every technology used promises cloud access. What does it mean? It’s computing hosted on a shared virtual environment, interconnected to a massive storage facility with contained servers, storage, and different sites.

There are many cloud provider in the market such as Amazon Web Services (AWS), Google, Microsoft...
Cloud services, such as AWS, allow a company to scale easily. Before cloud services, you would need to buy and store your own servers, which is costly, time-consuming, and requires physical space. Cloud services allow the flexibility to adjust on the fly for budget and resources.


# Project
# Big Data with AWS
In this project, we work with US Video Grames Review Dataset from S3 bucket on AWS ([Video Games Review dataset](https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Video_Games_v1_00.tsv.gz)). Many of Amazon's shoppers depend on product reviews to make a purchase. Amazon makes these datasets publicly available. However, they are quite large and can exceed the capacity of local machines to handle. One dataset alone contains more than 1.5 million rows. That is why I used Spark to work with the Video game dataset.

The ETL (extract, transform, load) is performed in the cloud using GoogleColab and PySpark. The cleaned dataframe is then saved to RDS instance on AWS. With Postgresql, I also performed a statistical analysis on the “vine” (paid) reviews and "non-vine" reviews.
#### Link to analysis
[ETL Google Colab notebook](https://drive.google.com/file/d/1mT-zNKTBYXsclFafV-VxxMT9OGdiyMJ4/view)

## ETL Process
### Extract
-	Extract the dataset from S3 bucket and load into dataframe using pyspark and display the head of dataframe
```
# Read in data from S3 Buckets
from pyspark import SparkFiles
url = 'https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Video_Games_v1_00.tsv.gz'
spark.sparkContext.addFile(url)
review_data_df = spark.read.csv(SparkFiles.get("amazon_reviews_us_Video_Games_v1_00.tsv.gz"), schema=review_schema, sep="\t", header=True)

# show dataframe
review_data_df.show(5)
review_data_df.printSchema()
```
-	Count the number of records in the extracted dataset : `1,785,997` reviews
<p>
 <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/review_size.png" width="40%">
</p>

### Transform the dataset to fit tables’ schemas
- Datatypes are prior altered to match tables schema data types
```
# Import struct fields that we can use
from pyspark.sql.types import StructField, StringType, IntegerType, StructType, DateType
# Next we need to create alist of structure fields
schema = [StructField("marketplace", StringType(), True), 
          StructField("customer_id", IntegerType(), True),
          StructField("review_id", StringType(), True), 
          StructField("product_id", StringType(), True),
          StructField("product_parent", IntegerType(), True),
          StructField("product_title", StringType(), True),
          StructField("product_category", StringType(), True),
          StructField("star_rating", IntegerType(), True),
          StructField("helpful_votes", IntegerType(), True),
          StructField("total_votes", IntegerType(), True),
          StructField("vine", StringType(), True),
          StructField("verified_purchase", StringType(), True),
          StructField("review_headline", StringType(), True),
          StructField("review_body", StringType(), True),
          StructField("review_date", DateType(), True),]
# Pass in our fields
review_schema = StructType(fields=schema)
```

The data is then cleaned and saved into 4 tables:
<ol>
  <li>review_id_table table</li>
  <li>products table</li>
  <li>customers table</li>
  <li>vine_table table</li>
</ol>
<p align="center">
  <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/review_id.png" width="60%"><br>
  <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/products.png" width="20%">
  <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/customers.png" width="20%">
  <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/vine_table.png" width="20%">
</p>

## Load the DataFrames that correspond to tables into an RDS instance
-	Code:
```
# Configure settings for RDS
mode = "append"
jdbc_url="jdbc:postgresql://dataviz.cbni11wajxqm.us-east-2.rds.amazonaws.com:5432/thi_challenge"
config = {"user":"postgres",
          "password": "******",
          "driver":"org.postgresql.Driver"}
# Write DataFrame to review_id_table table in RDS
review_id_df.write.jdbc(url=jdbc_url, table='review_id_table', mode=mode, properties=config)
# Write DataFrame to products table in RDS
unique_products_df.write.jdbc(url=jdbc_url, table='products', mode=mode, properties=config)
# Write DataFrame to customers table in RDS
customers_df.write.jdbc(url=jdbc_url, table='customers', mode=mode, properties=config)
# Write DataFrame to vine_table table in RDS
vine_df.write.jdbc(url=jdbc_url, table='vine_table', mode=mode, properties=config)
```
-	SQL tables
<p align="center">
  <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/sql.png" width="60%">
</p>

## Analysis
We conducted an analysis on the trustworthiness of “vine” reviews by
-	Creating new tables for vine(paid) reviews and nonvine(unpaid) reviews
-	From the table, we run [SQL queries](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/thi_challenge.sql) to get the metrics below:
<p>
  <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/analysis.png" width="60%">
</p>
As shown in the table, the percentage of 5-star reviews for paid reviews are relatively low as compared to unpaid reviews (37.46% vs. 57.55%). Average rating and average number of helpful votes per reviews are similar across the two review types. Thus we are confident to conclude that the vine(paid) reviews are unbiased and trustworthy.


