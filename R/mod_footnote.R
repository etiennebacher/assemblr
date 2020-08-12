#' footnote UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_footnote_ui <- function(id){
  ns <- NS(id)

  shinyBS::bsCollapsePanel(
    title = "Footnotes options",
    shiny::tagList(
      shiny::textInput(ns("notes"),
                       "Modifying table notes",
                       placeholder = "These are some notes..."),

      shiny::checkboxInput(ns("notes_append"),
                           "Show the significance notes",
                           value = TRUE),

      shiny::selectInput(
        ns("notes_align"),
        "Notes alignment",
        choices = c(
          "Left" = "l",
          "Centre" = "c",
          "Right" = "r"
        ),
        selected = "r"
      ),

      shiny::textInput(ns("notes_label"),
                       "Note section label",
                       value = "Notes:")
    )
  )

}

#' footnote Server Function
#'
#' @noRd
mod_footnote_server <- function(id) {
  moduleServer(id, function(input, output, session){

  return(
    list(
      notes = reactive({ input$notes }),
      notes_append = reactive({ input$notes_append }),
      notes_align = reactive({ input$notes_align }),
      notes_label = reactive({ input$notes_label })
    )
  )

  })
}

## To be copied in the UI
# mod_footnote_ui("footnote_ui_1")

## To be copied in the server
# callModule(mod_footnote_server, "footnote_ui_1")
