# Big Data with AWS
What exacltly constitutes big data? At what point does data become big? Is it just the size? A good rule of thumb to apply is: Data is considered big data when it exceeds the capacity of operational databases.

Working with Big Data creates unique challenge including storage, accessability, back-up, etc.

In this project, we work with US Video Grames Review Dataset from S3 bucket ([Video Games Review dataset](https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Video_Games_v1_00.tsv.gz)). The ETL (extract, transform, load) is performed in the cloud using GoogleColab and upload the DataFrames to RDS instances. We are also required to perform a statistical analysis on the “vine” reviews.
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


