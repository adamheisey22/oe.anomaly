# OE Anomaly Detection Python Script

**Description**
This Python script provides a function to detect OE (Observed to Expected) anomalies in a dataset. It calculates the upper and lower control limits (UCL and LCL) based on a confidence level of 95% and determines if the data points fall within or outside of these limits. The script returns a dataframe with additional columns indicating OE ratio, whether the data point is an OE anomaly or not, the UCL and LCL values, the center value (either 1 or the user-specified target value), and a violation indicator.

**Prerequisites**
This script requires the following libraries to be installed:
- Pandas
- Numpy
- Scipy

**Usage**
The function oe_anomaly() can be used with a user-supplied dataset. The function requires three arguments: 
- df: the dataframe to analyze
- obs_column: the column with the observed values
- exp_column: the column with the expected values
- target_column (optional): the column with the target values. If not specified, a target value of 1 will be used.

To use the function with the provided test dataset, simply uncomment the last line of the script and run it.

The resulting dataframe will include the following columns:
- OE_RATIO: the ratio of observed to expected values
- OE_IND: a binary indicator of whether the data point is an OE anomaly or not
- LCL_NO: the lower control limit for OE anomalies
- UCL_NO: the upper control limit for OE anomalies
- CENTER_NO: the center value (either 1 or the user-specified target value)
- VIOL_IND: a binary indicator of whether the data point violates the control limits or not
- VIOL_DSC: a description of the violation indicator (either "Yes" or "No")
- CENTER_METHOD: a description of the center value calculation method (either "Center" or "Target").

**Example**
An example of how to use this script with the provided test dataset is included in the script as a comment. 

Use You can use the **OE_anomaly_notebook** in **Jupyter Notebook** to run and test the function. 

**Author**
Formula Reference: https://rpubs.com/lefkios_paikousis/smr

For questions reach out to **Adam Heisey** at ```admrussel@gmail.com```