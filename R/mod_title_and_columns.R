#' title_and_columns UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_title_and_columns_ui <- function(id){
  ns <- NS(id)

  shinyBS::bsCollapsePanel(
    title = "Title and columns options",
    shiny::tagList(
      shiny::textInput(ns("title"), "Title of the table"),
      shiny::textInput(ns("caption"), "Caption of the table"),

      shiny::checkboxInput(
        ns("depvar_label"),
        "Include the dependent variable label?",
        value = TRUE
      ),

      ### COMMENT MODIFIER LES NOMS DE COLONNE FACILEMENT ? ###
      ### voir l'option dep.var.labels et column.labels

      shiny::checkboxInput(ns("add_object_names"), "Add object names?")
    )
  )
}

#' title_and_columns Server Function
#'
#' @noRd
mod_title_and_columns_server <- function(id) {
  moduleServer(id, function(input, output, session){

  return(
    list(
      title = reactive({ input$title }),
      caption = reactive({ input$caption }),
      depvar_label = reactive({ input$depvar_label }),
      add_object_names = reactive({ input$add_object_names })
    )
  )

  })
}

## To be copied in the UI
# mod_title_and_columns_ui("title_and_columns_ui_1")

## To be copied in the server
# callModule(mod_title_and_columns_server, "title_and_columns_ui_1")
