import pandas as pd
import numpy as np
from scipy.stats import norm

def oe_anomaly(df, obs_column, exp_column, target_column=None):
    
    if target_column is None:
        df['TARGET_NO'] = 1
        target = df['TARGET_NO']
    else:
        df[target_column].fillna(1, inplace=True)
        target = df[target_column]
    
    o = df[obs_column]
    e = df[exp_column]
    conf_level = 0.95
    N_ = 1 - ((1 - conf_level) / 2)
    z = norm.ppf(N_, loc=0, scale=1)

    LCL_NO = ((np.sqrt(o)) - (z * 0.5))**2 / e
    UCL_NO = ((np.sqrt(o)) + (z * 0.5))**2 / e
    VIOL_IND = np.where((UCL_NO > target) & (LCL_NO > target) | (UCL_NO < target) & (LCL_NO < target), 1, 0)
    CENTER_NO=target
    
    df_out = df.assign(OE_RATIO=o/e,
                       OE_IND=np.where(o/e > target, 1, 0),
                       LCL_NO=LCL_NO,
                       UCL_NO=UCL_NO,
                       CENTER_NO=CENTER_NO,
                       VIOL_IND=VIOL_IND,
                       VIOL_DSC=np.where(VIOL_IND > 0, 'Yes', 'No'),
                       CENTER_METHOD=np.where(CENTER_NO == 1, 'Center', 'Target')
                       )
    
    return df_out




GROUP = ["A", "B", "C", "D", "E", "F"]
NUMERATOR_NO = [2, 6, 10, 2, 5, 0]
DENOMINATOR_NO = [3, 3.3, 2, 0.5, 8, 10]
TARGET_NO = [0.8, 0.5, 0.8, 0.8, 0.7, None]

df_test = pd.DataFrame({
    "GROUP": GROUP,
    "NUMERATOR_NO": NUMERATOR_NO,
    "DENOMINATOR_NO": DENOMINATOR_NO,
    "TARGET_NO": TARGET_NO
})


#Use with test dataset
#df_out = oe_anomaly.oe_anomaly(df_test, "NUMERATOR_NO", "DENOMINATOR_NO", "TARGET_NO" )