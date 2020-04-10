## Table of Contents
**[What is Big Data?](#what-is-big-data)**<br>
**[Project Overview](#big-data-with-aws)**<br>
**[Natural Language Processing (NLP)](#natural-language-processing)**<br>
**[ETL process](#etl-process)**<br>
**[Analysis](#analysis)**<br>

## What is Big Data?
What exacltly constitutes big data? At what point does data become big? Is it just the size? A good rule of thumb to apply is: Data is considered big data when it exceeds the capacity of operational databases.

There are four characteristics of big date:
- Volume - size of the data
- Velocity - how quickly data comes in
- Variety - differenr forms of data
- veracity - uncertainty of data

Working with Big Data creates unique challenge including storage, accessability, back-up, etc.

# Big Data with AWS
In this project, we work with US Video Grames Review Dataset from S3 bucket ([Video Games Review dataset](https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Video_Games_v1_00.tsv.gz)). The ETL (extract, transform, load) is performed in the cloud using GoogleColab and upload the DataFrames to RDS instances. We are also required to perform a statistical analysis on the “vine” reviews.

# Natural Language Processing
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



# ETL Process
## Link to analysis
[ETL Google Colab notebook](https://drive.google.com/file/d/1mT-zNKTBYXsclFafV-VxxMT9OGdiyMJ4/view)
## Extract
-	Extract the dataset from S3 bucket and load into dataframe using pyspark and display the head of dataframe

![review_df.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/review_df.png)

-	Count the number of records in the extracted dataset : `1,785,997` reviews
<p>
 <img src="https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/review_size.png" width="50%">
</p>

## Transform the dataset to fit tables’ schemas
Datatypes are prior altered to match tables schema data types
![schema_structure.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/schema_structure.png)
-	review_id_table table

![review_id.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/review_id.png)

-	products table


![products.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/products.png)
-	customers table

![customers.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/customers.png)
-	vine_table table


![vine_table.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/vine_table.png)
## Load the DataFrames that correspond to tables into an RDS instance
-	Code:

![load_code](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/load_code.png)

-	SQL tables

![sql.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/sql.png)
# Analysis
We conducted an analysis on the trustworthiness of “vine” reviews by
-	Creating new tables for vine(paid) reviews and nonvine(unpaid) reviews
-	From the table, we run [SQL queries](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/thi_challenge.sql) to get the metrics below:
 ![analysis.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/analysis.png)

As shown in the table, the percentage of 5-star reviews for paid reviews are relatively low as compared to unpaid reviews (37.46% vs. 57.55%). Average rating and average number of helpful votes per reviews are similar across the two review types. Thus we are confident to conclude that the vine(paid) reviews are unbiased and trustworthy.


