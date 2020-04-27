UI_change_cov_labels <- function(id){
  ns <- NS(id)

  shiny::tagList(
    column(6,
           shiny::textInput(ns("cov_current_name"), "")
    ),
    column(6,
           shiny::textInput(ns("cov_new_name"), "")
    )
  )
}
