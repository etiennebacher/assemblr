#' modify_labels UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_modify_labels_ui <- function(id){
  ns <- NS(id)
  tagList(
    column(6,
           shiny::textInput(ns("cov_current_name"), "")
    ),
    column(6,
           shiny::textInput(ns("cov_new_name"), "")
    )
  )
}

#' modify_labels Server Function
#'
#' @noRd
mod_modify_labels_server <- function(input, output, session){
  ns <- session$ns

}

## To be copied in the UI
# mod_modify_labels_ui("modify_labels_ui_1")

## To be copied in the server
# callModule(mod_modify_labels_server, "modify_labels_ui_1")
