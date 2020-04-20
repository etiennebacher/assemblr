title_and_columns_options <- function(){
  bsCollapsePanel(
    title = "Title and columns options",
    tagList(
      textInput("title", "Title of the table"),
      textInput("caption", "Caption of the table"),

      checkboxInput("depvar_label",
                    "Include the dependent variable label?",
                    value = TRUE),

      ### COMMENT MODIFIER LES NOMS DE COLONNE FACILEMENT ? ###
      ### voir l'option dep.var.labels et column.labels

      checkboxInput("add_object_names", "Add object names?")
  )
)
}
