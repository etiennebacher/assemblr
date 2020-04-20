footnote_options <- function(){
  bsCollapsePanel(
    title = "Footnotes options",
    tagList(
      textInput(
        "notes",
        "Modifying table notes",
        placeholder = "These are some notes..."
      ),

      checkboxInput(
        "notes_append",
        "Show the significance notes",
        value = TRUE
      ),

      selectInput(
        "notes_align",
        "Notes alignment",
        choices = c("Left" = "l", "Centre" = "c", "Right" = "r"),
        selected = "r"
      ),

      textInput(
        "notes_label",
        "Note section label",
        value = "Notes:"
      )
    )
  )
}
