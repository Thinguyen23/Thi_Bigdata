-- Vine review analysis 
-- Paid reviews table
CREATE TABLE paid_reviews AS
   SELECT *
   FROM vine_table
   WHERE vine= 'Y';
-- Unpaid reviews table
CREATE TABLE unpaid_reviews AS
   SELECT *
   FROM vine_table
   WHERE vine= 'N';

-- Number of Reviews
SELECT COUNT(*) AS no_of_paid_reviews FROM paid_reviews;	--paid
SELECT COUNT(*) as no_of_unpaid_reviews FROM unpaid_reviews;	--unpaid

-- Number of 5-star reviews
SELECT COUNT(*) AS no_5star_paid_reviews	--paid
FROM paid_reviews
WHERE star_rating=5;
SELECT COUNT(*) AS no_5star_unpaid_reviews	--unpaid
FROM unpaid_reviews
WHERE star_rating=5;
		
--Average Rating
SELECT AVG(star_rating) AS avg_rating_paid_reviews	--paid
FROM paid_reviews;
SELECT AVG(star_rating) AS avg_rating_unpaid_reviews	--unpaid
FROM unpaid_reviews;

-- Number of helpful votes
SELECT SUM(helpful_votes) AS No_of_helpful_vote_paidreviews 	--paid
FROM paid_reviews;
SELECT SUM(helpful_votes) AS No_of_helpful_vote_unpaidreviews 	--unpaid
FROM unpaid_reviews;

-- Number of unhelpful votes
SELECT (SUM(total_votes)-SUM(helpful_votes)) AS No_of_unhelpful_vote_paidreviews 	--paid
FROM paid_reviews;
SELECT (SUM(total_votes)-SUM(helpful_votes)) AS No_of_unhelpful_vote_unpaidreviews 	--unpaid
FROM unpaid_reviews;
