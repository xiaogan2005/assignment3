assignment3
===========

Assignment 3

We run counts.pig on the Twitter dataset-- this code filters out non tweet lines in the file (like the error lines), then flattens the tweet to get a set of words.
It then splits the words into those from the positive sentiment dictionary (positive-words.txt) and from the negative sentiment dictionary (negative-words.txt).
It counts how many times each of these words appears and then stores these counts into 2 different files, one with counts for positive sentiment (top_positive.txt) and another with counts for negative (top_negative.txt).
We could not get our script to run on the original data set-- we tried with 9 m1.medium nodes and still got errors (10 is our maximum quota). So, we ran on a smaller test dataset: test.txt. We have included those results to show that our script does work correctly.

To run on EMR:

elastic-mapreduce-cli sgarns$ ./elastic-mapreduce --create --name "Test" --pig-script s3://assignment3skg2122/counts.pig --ami-version 2.0 --args "-p,INPUT=s3://assignment3skg2122/test.txt,-p,INPUT2=s3://assignment3skg2122/positive-words.txt,-p,INPUT3=s3://assignment3skg2122/negative-words.txt,-p,OUTPUT=s3://assignment3skg2122/t_output,-p,OUTPUT2=s3://assignment3skg2122/t_output2"
