# Observed to Expected (O/E) Anomaly Detection
Statistical significance and confidence intervals for an Observed to Expected Ratio using Vandenbroucke (1982) method.

Formula Reference: https://rpubs.com/lefkios_paikousis/smr


**Input: Arguments**

1. ```Dataframe(df): input dataframe with column of observed values and expected values```
2. ```obs_column: Argument that specifies the column in data frame with observed values```
3. ```exp_column: Argument that specifies the column in data frame with expected (predicted) values```
4. ```target_column: Argument that specifies the column in data frame with targets (leave argument blank if no targets available)```


**Output: Dataframe with additional columns**

1. ```OE_RATIO``` : Outputs the Observed to Expected ratio
2. ```OE_IND``` : If the O/E ratio is greater than the target target value then 1 otherwise 0
3. ```LCL_NO``` : Lower control Limit
4. ```UCL_NO``` : Upper control limit
5. ```CENTER_NO``` : Target value -- default value is 1 without specified targets. 
6. ```VIOL_IND``` : Indicator equal to 1 for values beyond the control limits and 0 otherwise
7. ```VIOL_DSC``` : "Yes" to identify values beyond the control limits, "No" otherwise
8. ```CENTER_METHOD``` : Identifies the center method. "Center" if target is 1, "Target" if comparing to specified targets.

**USAGE**

GROUP <- c("A", "B", "C", "D", "E", "F")
NUMERATOR_NO <- c(2, 6, 10, 2, 5, 0)
DENOMINATOR_NO <- c(3, 3.3, 2, 0.5, 8, 10)
TARGET_NO <- c(0.8, 0.5, 0.8, 0.8, 0.7, NA)
 
df_test <- data.frame(GROUP, NUMERATOR_NO, DENOMINATOR_NO, TARGET_NO )

  ```df_out <- oe_anomaly(df_test, "NUMERATOR_NO", "DENOMINATOR_NO", "TARGET_NO" )```




**Citiations**
Formula Reference: https://rpubs.com/lefkios_paikousis/smr

For questions reach out to **Adam Heisey** at ```admrussel@gmail.com```
