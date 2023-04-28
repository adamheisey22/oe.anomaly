# Observed to Expected (O/E) Anomaly Detection
Statistical significance and confidence intervals for an Observed to Expected Ratio using Vandenbroucke (1982) method.

Formula Reference: https://rpubs.com/lefkios_paikousis/smr


**Input: Arguments**

1. ```Dataframe(df): input dataframe with column of observed values and expected values```
2. ```obs_column: Argument that specifies the column in data frame with observed values```
3. ```exp_column: Argument that specifies the column in data frame with expected (predicted) values```
4. ```target_column: Argument that specifies the column in data frame with targets (leave argument blank if no targets available)```


**Output: Dataframe with additional columns**

1. ```OE_RATIO``` : Dictionary output {sentence : score} for each sentence in comment/text
2. ```OE_IND``` : Number of sentences in comment/text
3. ```LCL_NO``` : Sum of the individual sentence -- composite score
4. ```UCL_NO``` : Normalizes column of sum_scores to be between -1 and 1. Values range from most negative (-1) to most postive (1)
5. ```CENTER_NO``` : Lables "Positive" and "Negative" comments based on the overall_score. Scores greater than/equal to ZERO are "Positive" 
6. ```VIOL_IND``` : Indicator column 1 or 0 based on overall_sentiment. 1-positive, 0-Negative
7. ```VIOL_DSC``` : List of text tokens filtered for stopwords
8. ```CENTER_METHOD``` : Identifies statistical anomalies. "Out of Control" or "In Control"

**USAGE**

GROUP <- c("A", "B", "C", "D", "E", "F")
NUMERATOR_NO <- c(2, 6, 10, 2, 5, 0)
DENOMINATOR_NO <- c(3, 3.3, 2, 0.5, 8, 10)
TARGET_NO <- c(0.8, 0.5, 0.8, 0.8, 0.7, NA)
 
df_test <- data.frame(GROUP, NUMERATOR_NO, DENOMINATOR_NO, TARGET_NO )

  ```df_out <- oe_anomaly(df_test, "NUMERATOR_NO", "DENOMINATOR_NO", "TARGET_NO" )```




**Citiations**
Formula Reference: https://rpubs.com/lefkios_paikousis/smr

