#' Title
#'
#' @return
#' @export
#'
#' @examples NULL
additional_info_options <- function(){
  shinyBS::bsCollapsePanel(
    title = "Additional info options",
    shiny::tagList(

      shiny::selectizeInput("omit_stat", "Omit summary statistics",
                     choices = c("All statistics" = "all", "Adjusted R-Squared" = "adj.rsq", "Akaike Information Criterion" = "aic", "Bayesian Information Criterion" = "bic", "Chi-squared" = "chi2", "F statistic" = "f", "Log-likelihood" = "ll", "Score (logrank) test"  = "logrank", "Likelihood ratio (LR) test" = "lr", "Maximum R-squared" = "max.rsq",  "Number of observations" = "n", "Null deviance" = "null.dev", "Inverse Mills Ratio" = "Mills", "Residual deviance" = "res.dev", "Rho" = "rho", "R-squared" = "rsq", "Scale" = "scale", "Theta" = "theta", "Standard error of the regression" = "ser", "Sigma squared" = "sigma2", "Un-Biased Risk Estimator" = "ubre", "Wald test" = "wald"),
                     multiple = TRUE),

      shiny::checkboxInput("df", "Show degrees of freedom", value = FALSE),

      shiny::actionButton("add_row_statistics",
                   "Add a row to table statistics"),
      shinyBS::bsModal(
        id = "add_row_details",
        title = "Add a row",
        trigger = "add_row_statistics",
        shiny::actionButton("foo", "foo")
        ### METTRE UI
        ### dépend du nombre de colonnes donc mettre ça dans un renderUI ?
      )
    )
  )
}
