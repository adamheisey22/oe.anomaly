

#' @title Observed to Expected (O/E) Anomaly Detection
#'
#' @description
#' Statistical significance and confidence intervals for an Observed to Expected Ratio
#' Vandenbroucke (1982) method.
#'
#' Formula Reference: https://rpubs.com/lefkios_paikousis/smr
#'
#'
#' @param df input data frame with column of observed values and expected values
#' @param obs_column Argument that specifies the column in data frame with observed values
#' @param exp_column Argument that specifies the column in data frame with expected (predicted) values
#' @param target_column Argument that specifies the column in data frame with targets (leave argument blank if no targets available)
#' @return This function returns a data frame with O/E ratio control limits columns and violation indicators (anomalies) as well as target method ("center" -> O/E Ratio of 1 OR "Target" -> selected target) **NOTE: Expected Values must be greater than ZERO.
#' @import dplyr
#' @importFrom stats qnorm
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' GROUP <- c("A", "B", "C", "D", "E", "F")
#' NUMERATOR_NO <- c(2, 6, 10, 2, 5, 0)
#' DENOMINATOR_NO <- c(3, 3.3, 2, 0.5, 8, 10)
#' TARGET_NO <- c(0.8, 0.5, 0.8, 0.8, 0.7, NA)
#' 
#' df_test <- data.frame(GROUP, NUMERATOR_NO, DENOMINATOR_NO, TARGET_NO )
#'
#'  df_out <- oe_anomaly(df_test, "NUMERATOR_NO", "DENOMINATOR_NO", "TARGET_NO" )
#'  
#' 
#' 
#'  }


oe_anomaly <- function(df, obs_column, exp_column, target_column) {

  if(missing(target_column)) {

    df$TARGET_NO <- 1
    target <- df$TARGET_NO

  } else {

    df[[target_column]][is.na(df[[target_column]])] <- 1
    target <- df[[target_column]]

  }

  o=df[[obs_column]]
  e=df[[exp_column]]
  conf.level = 0.95
  N. <- 1 - ((1 - conf.level) / 2)
  z <- qnorm(N., mean = 0, sd = 1)

  df_out <- df %>%
    dplyr:: mutate(OE_RATIO = o/e,
                  OE_IND = ifelse(OE_RATIO > target, 1, 0),
                  LCL_NO = (sqrt(o) - (z * 0.5))^(2) / e,
                  UCL_NO = (sqrt(o) + (z * 0.5))^(2) / e,
                  CENTER_NO = target,
                  VIOL_IND = ifelse(UCL_NO > target & LCL_NO > target | UCL_NO < target & LCL_NO < target, 1, 0),
                  VIOL_DSC = ifelse(VIOL_IND > 0, 'Yes', 'No'),
                  CENTER_METHOD = ifelse(CENTER_NO == 1, "Center", "Target")
                  )

   return(df_out)
}


