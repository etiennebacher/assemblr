#' change_covnames UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_change_covnames_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      shiny::column(
        6,
        shinyjs::disabled(
          shiny::textInput(ns("test"), "Test", value = "truc")
        )
      ),
      shiny::column(
        6,
        shiny::textInput(ns("test_2"), "Test", value = "blabla")
      )
    )

  )
}

#' change_covnames Server Function
#'
#' @noRd
mod_change_covnames_server <- function(input, output, session){
  ns <- session$ns

  observe({
    updateTextInput(
      session = session,
      inputId = "test_2",
      value = "machin"
    )
  })

  print("this is a test")

}

## To be copied in the UI
# mod_change_covnames_ui("change_covnames_ui_1")

## To be copied in the server
# callModule(mod_change_covnames_server, "change_covnames_ui_1")

