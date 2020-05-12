#' results UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
mod_results_ui <- function(id){
  ns <- NS(id)
  all_variables <- get_variables_names()

  result_options_ui <- shinyBS::bsCollapsePanel(
    title = "Result options",
    shiny::tagList(
      # Idée : faire un modal avec deux colonnes. Dans chaque colonne, il y a exactement autant de textInput qu'il y a de covariates et donc il y a des textinput face à face. Titre de la colonne de gauche est "noms actuels" et celui de la colonne de droite est "nouveaux noms". Colonnes déjà remplies avec les noms des variables, gauche et droite identiques. Faire un truc avec shinyjs pour que les textinput à gauche ne puissent pas etre modifiés et qu'on puisse seulement modifier les nouveaux noms.
      # actionbutton à la fin pour valider et appliquer les changements
      shiny::actionButton(ns("change_covariates_labels"),
                          "Change covariates labels"),

      shiny::br(),

      shiny::textInput(ns("report"), "Values to report") %>%
        shinyhelper::helper(type = "markdown",
                            content = "report"),

      shiny::checkboxInput(ns("include_ci"),
                           "Include confidence interval?",
                           value = FALSE),

      shiny::conditionalPanel(
        condition = "input.include_ci == 1",
        ns = ns,
        shiny::numericInput(
          ns("ci_level"),
          "Level of the confidence interval",
          value = 0.9,
          min = 0,
          max = 1
        ),
        shiny::textInput(ns("ci_separator"),
                         "Separator of the confidence interval")
      ),

      shiny::selectInput(
        ns("intercept_position"),
        "Position of the intercept",
        choices = c("Bottom" = "bottom",
                    "Top" = "top"),
        selected = "Bottom"
      ),

      shiny::checkboxInput(ns("single_row"),
                           "Put the results on a single row?",
                           value = FALSE),

      shiny::textInput(
        ns("signif_symbol"),
        "Statitiscal significance symbol",
        width = "75%",
        placeholder = 'Ex: "@", "@@", "@@@"'
      ),

      shiny::textInput(
        ns("star_cutoffs"),
        "Change the cutoffs for significance",
        placeholder = 'Ex: 0.05, 0.01, 0.001'
      ),

      ### METTRE UN UPDATE DANS LA PARTIE SERVER POUR RAJOUTER LES CHOIX
      ## faire un modal avec un selectinput par regression et l'utilisateur peut choisir les variables à omettre dans chaque regression
      shiny::selectizeInput(
        ns("omit"),
        "Omit parts of the default output",
        choices = all_variables,
        multiple = TRUE
      ),

      shiny::textInput(ns("omit_labels"), "Report the omitted variables") %>%
        shinyhelper::helper(type = "markdown",
                            content = "omit_labels"),

      shiny::textInput(ns("decimal_mark"),
                       "Decimal character",
                       value = "."),

      shiny::numericInput(
        ns("digits"),
        "Number of decimal places (max 20)",
        value = 2,
        min = 0,
        max = 20
      ),

      shiny::numericInput(
        ns("digits_extra"),
        "Additional decimal control",
        value = 1,
        min = 0,
        max = 20
      ) %>%
        shinyhelper::helper(type = "markdown",
                            content = "digits_extra"),

      shiny::checkboxInput(ns("initial_zero"),
                           "Keep leading zeros from decimals",
                           value = TRUE)

    )
  )

  return(result_options_ui)
}

#' results Server Function
#'
#' @noRd
mod_results_server <- function(input, output, session){

  return(
    list(
      change_covariates_labels = reactive({ input$change_covariates_labels }),
      report = reactive({ input$report }),
      include_ci = reactive({ input$include_ci }),
      ci_level = reactive({ input$ci_level }),
      ci_separator = reactive({ input$ci_separator }),
      intercept_position = reactive({ input$intercept_position }),
      single_row = reactive({ input$single_row }),
      signif_symbol = reactive({ input$signif_symbol }),
      star_cutoffs = reactive({ input$star_cutoffs }),
      omit = reactive({ input$omit }),
      omit_labels = reactive({ input$omit_labels }),
      decimal_mark = reactive({ input$decimal_mark }),
      digits = reactive({ input$digits }),
      digits_extra = reactive({ input$digits_extra }),
      initial_zero = reactive({ input$initial_zero })
    )
  )

}

## To be copied in the UI
# mod_results_ui("results_ui_1")

## To be copied in the server
# callModule(mod_results_server, "results_ui_1")
