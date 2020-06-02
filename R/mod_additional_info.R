#' additional_info UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_additional_info_ui <- function(id){
  ns <- NS(id)

  shinyBS::bsCollapsePanel(
    title = "Additional info options",
    shiny::tagList(
      shiny::selectizeInput(
        ns("omit_stat"),
        "Omit summary statistics",
        choices = c(
          # "All statistics" = "all",
          "Adjusted R-Squared" = "adj.rsq",
          "Akaike Information Criterion" = "aic",
          "Bayesian Information Criterion" = "bic",
          "Chi-squared" = "chi2",
          "F statistic" = "f",
          "Log-likelihood" = "ll",
          "Score (logrank) test"  = "logrank",
          "Likelihood ratio (LR) test" = "lr",
          "Maximum R-squared" = "max.rsq",
          "Number of observations" = "n",
          "Null deviance" = "null.dev",
          "Inverse Mills Ratio" = "Mills",
          "Residual deviance" = "res.dev",
          "Rho" = "rho",
          "R-squared" = "rsq",
          "Scale" = "scale",
          "Theta" = "theta",
          "Standard error of the regression" = "ser",
          "Sigma squared" = "sigma2",
          "Un-Biased Risk Estimator" = "ubre",
          "Wald test" = "wald"
        ),
        multiple = TRUE
      ),

      shiny::checkboxInput(ns("df"), "Show degrees of freedom", value = FALSE),

      shiny::actionButton(ns("add_row_statistics"),
                          "Add a row to table statistics"),
      shinyBS::bsModal(
        id = ns("add_row_details"),
        title = "Add a row",
        trigger = ns("add_row_statistics"),
        shiny::actionButton(ns("foo"), "foo")
        ### METTRE UI
        ### dépend du nombre de colonnes donc mettre ça dans un renderUI ?
      )
    )
  )
}

#' additional_info Server Function
#'
#' @noRd
mod_additional_info_server <- function(input, output, session){

  return(
    list(
      omit_stat = reactive({ input$omit_stat }),
      df = reactive({ input$df }),
      add_row_statistics = reactive({ input$add_row_statistics }),
      add_row_details = reactive({ input$add_row_details })
    )
  )

}

## To be copied in the UI
# mod_additional_info_ui("additional_info_ui_1")

## To be copied in the server
# callModule(mod_additional_info_server, "additional_info_ui_1")
