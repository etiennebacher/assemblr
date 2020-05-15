#' reproduce UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_reproduce_ui <- function(id){
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("reproducible_code"))
  )
}

#' reproduce Server Function
#'
#' @noRd
mod_reproduce_server <- function(input, output, session){
  ns <- session$ns

  output$reproducible_code <- renderText({
    print("some text")
  })
}

## To be copied in the UI
# mod_reproduce_ui("reproduce_ui_1")

## To be copied in the server
# callModule(mod_reproduce_server, "reproduce_ui_1")

