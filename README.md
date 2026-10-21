# Observed to Expected (O/E) Anomaly Detection

## The problem

Healthcare quality and performance reporting often compares units (hospitals, clinics, departments, providers) using an **observed-to-expected (O/E) ratio**. It compares the events a unit actually had (deaths, readmissions, infections) with the number a risk-adjustment model predicted. An O/E of 1.0 means the unit performed as expected.

A raw ratio alone is misleading. A unit with 2 observed events against 0.5 expected has an O/E of 4.0, while a unit with 60 against 50 has an O/E of 1.2. The first ratio looks much worse, yet it rests on so few events that it may be noise. The second may be the real signal. The question is which units have an O/E ratio that is **statistically abnormal**, not just high or low.

`oe_anomaly()` answers that question. For each unit it computes the O/E ratio and a 95% confidence interval. It then flags the unit when the whole interval falls above or below a benchmark: 1.0 by default, or a target you supply for each unit.

## Method

Observed counts are treated as Poisson, and the confidence limits use the square-root approximation from Vandenbroucke (1982):

```
LCL = (sqrt(O) - z/2)^2 / E
UCL = (sqrt(O) + z/2)^2 / E
```

Here `O` is the observed count, `E` is the expected count, and `z` is the standard normal quantile for the confidence level (1.96 for 95%).

A unit is flagged (`VIOL_IND = 1`) when both limits lie on the same side of the benchmark:

- **both above:** significantly worse than expected or target
- **both below:** significantly better than expected or target

Expected values must be greater than zero.

## Usage

### Arguments

| Argument | Description |
|---|---|
| `df` | Data frame with a column of observed values and a column of expected values |
| `obs_column` | Name of the column with observed values |
| `exp_column` | Name of the column with expected (predicted) values |
| `target_column` | Optional. Name of the column with per-unit targets. If omitted, the benchmark is 1. Missing targets default to 1. |

### R

```r
# install.packages("devtools")
devtools::install_github("adamheisey22/oe.anomaly")
library(oe.anomaly)

GROUP <- c("A", "B", "C", "D", "E", "F")
NUMERATOR_NO <- c(2, 6, 10, 2, 5, 0)
DENOMINATOR_NO <- c(3, 3.3, 2, 0.5, 8, 10)
TARGET_NO <- c(0.8, 0.5, 0.8, 0.8, 0.7, NA)

df_test <- data.frame(GROUP, NUMERATOR_NO, DENOMINATOR_NO, TARGET_NO)

df_out <- oe_anomaly(df_test, "NUMERATOR_NO", "DENOMINATOR_NO", "TARGET_NO")
```

### Python

Requires `pandas`, `numpy` and `scipy`. The function is in [`Python/oe_anomaly.py`](Python/oe_anomaly.py). For a worked example, see [`Python/OE_anomaly_notebook.ipynb`](Python/OE_anomaly_notebook.ipynb).

```python
import pandas as pd
from oe_anomaly import oe_anomaly  # run from the Python/ directory

df_test = pd.DataFrame({
    "GROUP": ["A", "B", "C", "D", "E", "F"],
    "NUMERATOR_NO": [2, 6, 10, 2, 5, 0],
    "DENOMINATOR_NO": [3, 3.3, 2, 0.5, 8, 10],
    "TARGET_NO": [0.8, 0.5, 0.8, 0.8, 0.7, None],
})

df_out = oe_anomaly(df_test, "NUMERATOR_NO", "DENOMINATOR_NO", "TARGET_NO")
```

## Output columns

The input data frame is returned with these columns added:

| Column | Description |
|---|---|
| `OE_RATIO` | Observed-to-expected ratio |
| `OE_IND` | 1 if the O/E ratio is greater than the target, otherwise 0 |
| `LCL_NO` | Lower confidence limit of the O/E ratio |
| `UCL_NO` | Upper confidence limit of the O/E ratio |
| `CENTER_NO` | Benchmark compared against: the target, or 1 when no target is given |
| `VIOL_IND` | 1 if the whole confidence interval is above or below the benchmark (statistically abnormal), otherwise 0 |
| `VIOL_DSC` | `"Yes"` / `"No"` text version of `VIOL_IND` |
| `CENTER_METHOD` | `"Center"` if the benchmark is 1, `"Target"` if it is a supplied target |

## Citations

- Vandenbroucke JP. A shortcut method for calculating the 95 per cent confidence interval of the standardized mortality ratio. *American Journal of Epidemiology*. 1982;115(2):303–304.
- Formula reference: https://rpubs.com/lefkios_paikousis/smr
