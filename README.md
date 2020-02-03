# Module 16 - Big Data Challenge
In this challenge, we are required to perform ETL process on a US review dataset ([Video Games Review dataset](https://s3.amazonaws.com/amazon-reviews-pds/tsv/amazon_reviews_us_Video_Games_v1_00.tsv.gz)) in the cloud and upload the DataFrames to RDS instances. We are also required to perform a statistical analysis on the “vine” reviews.
# ETL Process
## Extract
-	Extract the dataset from S3 bucket and load into dataframe using pyspark and display the head of dataframe. : 
![review_df.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/review_df.png)
-	Count the number of records in the extracted dataset
![review_size.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/review_size.png)
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
-	Splits the reviews between vine (paid) and non-vine (unpaid)
-	Compares metrics between vine and non-vine reviews such as, but not limited to:
-	Number of reviews ![no_reviews.png](https://github.com/Thinguyen23/Thi_Module16_Bigdata/blob/master/images/no_reviews.png)
In conclusion,
Comes up with a conclusion on the trustworthiness of vine reviews with data to back up their claim

# Link to analysis
[ETL Google Colab notebook](https://drive.google.com/file/d/1mT-zNKTBYXsclFafV-VxxMT9OGdiyMJ4/view)
