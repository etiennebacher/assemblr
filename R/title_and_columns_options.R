#' Title
#'
#' @return
#' @export
#'
#' @examples NULL
title_and_columns_options <- function(){
  shinyBS::bsCollapsePanel(
    title = "Title and columns options",
    shiny::tagList(
      shiny::textInput("title", "Title of the table"),
      shiny::textInput("caption", "Caption of the table"),

      shiny::checkboxInput("depvar_label",
                    "Include the dependent variable label?",
                    value = TRUE),

      ### COMMENT MODIFIER LES NOMS DE COLONNE FACILEMENT ? ###
      ### voir l'option dep.var.labels et column.labels

      shiny::checkboxInput("add_object_names", "Add object names?")
  )
)
}
