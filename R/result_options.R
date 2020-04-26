#' Result options
#' Function that details the content of the "Result options" dropdown
#'
#' @return The part of the Shiny UI that details the options for the results in the {\code{stargazer}} table.
#' @importFrom magrittr %>%
#' @export
#'
#' @examples NULL
result_options <- function(){

  # Obtain the list of objects supported by stargazer
  list_regressions <- get_data()

  # For each regression, store variables names in a part of a list
  variables_regressions <- list()
  for (i in 1:length(list_regressions)){
    variables_regressions[[i]] <- names(list_regressions[[i]]$coefficients)
  }
  # Remove duplicates of names and store it in a vector
  all_variables <- unique(unlist(variables_regressions))
  # Rename "(Intercept)" as "Constant" since it is the name given by stargazer
  all_variables[all_variables == "(Intercept)"] <- "Constant"


  result_options_ui <- shinyBS::bsCollapsePanel(
    title = "Result options",
    shiny::tagList(
      ### COMMENT MODIFIER LES NOMS DE VARIABLE FACILEMENT ? ###
      ### voir l'option covariates.labels
      shiny::textInput("report", "Values to report") %>%
        shinyhelper::helper(
          type = "markdown",
          content = "report"
        ),

      shiny::checkboxInput(
        "include_ci",
        "Include confidence interval?",
        value = FALSE),

      shiny::conditionalPanel(
        condition = "input.include_ci == 1",
        shiny::numericInput(
          "ci_level",
          "Level of the confidence interval",
          value = 0.9,
          min = 0,
          max = 1
        ),
        shiny::textInput(
          "ci_separator",
          "Separator of the confidence interval"
        )
      ),

      shiny::selectInput(
        "intercept_position",
        "Position of the intercept",
        choices = c("Bottom" = "bottom",
                    "Top" = "top"),
        selected = "Bottom"
      ),

      shiny::checkboxInput(
        "single_row",
        "Put the results on a single row?",
        value = FALSE
      ),

      shiny::textInput(
        "signif_symbol",
        "Statitiscal significance symbol",
        width = "75%",
        placeholder = 'Ex: "@", "@@", "@@@"'
      ),

      shiny::textInput(
        "star_cutoffs",
        "Change the cutoffs for significance",
        placeholder = 'Ex: 0.05, 0.01, 0.001'
        ),

      ### METTRE UN UPDATE DANS LA PARTIE SERVER POUR RAJOUTER LES CHOIX
      ## faire un modal avec un selectinput par regression et l'utilisateur peut choisir les variables à omettre dans chaque regression
      shiny::selectizeInput(
        "omit",
        "Omit parts of the default output",
        choices = all_variables,
        multiple = TRUE),

      shiny::textInput("omit_labels", "Report the omitted variables") %>%
        shinyhelper::helper(type = "markdown",
               content = "omit_labels"
        ),

      shiny::textInput(
        "decimal_mark",
        "Decimal character",
        value = "."
      ),

      shiny::numericInput(
        "digits",
        "Number of decimal places (max 20)",
        value = 2,
        min = 0,
        max = 20
      ),

      shiny::numericInput(
        "digits_extra",
        "Additional decimal control",
        value = 1,
        min = 0,
        max = 20
      ) %>%
        shinyhelper::helper(type = "markdown",
                            content = "digits_extra"),

      shiny::checkboxInput("initial_zero",
                    "Keep leading zeros from decimals",
                    value = TRUE)

    )
  )

  return(result_options_ui)
}
