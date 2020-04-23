#' Title
#'
#' @return
#' @export
#'
#' @examples NULL
footnote_options <- function(){
  shinyBS::bsCollapsePanel(
    title = "Footnotes options",
    shiny::tagList(
      shiny::textInput(
        "notes",
        "Modifying table notes",
        placeholder = "These are some notes..."
      ),

      shiny::checkboxInput(
        "notes_append",
        "Show the significance notes",
        value = TRUE
      ),

      shiny::selectInput(
        "notes_align",
        "Notes alignment",
        choices = c("Left" = "l", "Centre" = "c", "Right" = "r"),
        selected = "r"
      ),

      shiny::textInput(
        "notes_label",
        "Note section label",
        value = "Notes:"
      )
    )
  )
}
