#' general UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_general_ui <- function(id){
  ns <- NS(id)

  shinyBS::bsCollapsePanel(
    title = "General options",
    shiny::tagList(
      shiny::selectInput(
        ns("style"),
        "Style",
        choices = c(
          "American Economic Review" = "aer",
          "American Journal of Political Science" = "ajps",
          "American Journal of Sociology" = "ajs",
          "Administrative Science Quarterly" = "asq",
          "American Sociological Review" = "asr",
          "American Political Science Review" = "apsr",
          "Demography" = "demography",
          "International Organization" = "io",
          "Journal of Policy Analysis and Management" = "jpam",
          "Quarterly Journal of Economics" = "qje"
        )
      )
        ### FAIRE AUSSI TABLE LAYOUT
    )
  )
}

#' general Server Function
#'
#' @noRd
mod_general_server <- function(input, output, session){
  ns <- session$ns

}

## To be copied in the UI
# mod_general_ui("general_ui_1")

## To be copied in the server
# callModule(mod_general_server, "general_ui_1")
