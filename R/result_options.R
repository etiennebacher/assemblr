result_options <- function(){
  bsCollapsePanel(
    title = "Result options",
    tagList(
      ### COMMENT MODIFIER LES NOMS DE VARIABLE FACILEMENT ? ###
      ### voir l'option covariates.labels
      textInput("report", "Values to report") %>%
        helper(
          type = "markdown",
          content = "report"
        ),

      checkboxInput("include_ci",
                    "Include confidence interval?",
                    value = FALSE),
      conditionalPanel(
        condition = "input.include_ci == 1",
        numericInput(
          "ci_level",
          "Level of the confidence interval",
          value = 0.9,
          min = 0,
          max = 1
        ),
        textInput(
          "ci_separator",
          "Separator of the confidence interval"
        )
      ),
      selectInput(
        "intercept_position",
        "Position of the intercept",
        choices = c("Bottom" = "bottom",
                    "Top" = "top"),
        selected = "Bottom"
      ),
      checkboxInput("single_row",
                    "Put the results on a single row?",
                    value = FALSE),
      textInput(
        "signif_symbol",
        "Statitiscal significance symbol",
        width = "75%",
        placeholder = 'Ex: "@", "@@", "@@@"'
      ),

      textInput(
        "star_cutoffs",
        "Change the cutoffs for significance",
        placeholder = 'Ex: 0.05, 0.01, 0.001'
        ),

      ### METTRE UN UPDATE DANS LA PARTIE SERVER POUR RAJOUTER LES CHOIX
      selectizeInput("omit", "Omit parts of the default output",
                     choices = NULL, multiple = TRUE),
      textInput("omit_labels", "Report the omitted variables") %>%
        helper(type = "markdown",
               content = "omit_labels"
        )
    )
  )
}
