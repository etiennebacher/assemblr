ui <- miniPage(
  # theme = "styles.css",
  gadgetTitleBar("Build your {stargazer} tables interactively"),
  br(),
  miniTabstripPanel(
    miniTabPanel("Table Options", icon = icon("table"),
                 miniContentPanel(
                   fillRow(
                     flex = c(1, 0.5, 2),
                     fillCol(
                       bsCollapse(
                         id = "latex_options",
                         bsCollapsePanel(
                           title = "General options",
                           tagList(selectInput(
                             "style",
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
                           ))
                          ),
                         bsCollapsePanel(
                           title = "Title and columns options",
                           tagList(
                             textInput("title", "Title of the table"),
                             textInput("caption", "Caption of the table"),

                             checkboxInput("depvar_label",
                                           "Include the dependent variable label?",
                                           value = TRUE)

                             ### COMMENT MODIFIER LES NOMS DE COLONNE FACILEMENT ? ###
                             ### voir l'option dep.var.labels et column.labels

                           )
                         ),
                         bsCollapsePanel(
                           title = "Result options",
                           tagList(
                             ### COMMENT MODIFIER LES NOMS DE VARIABLE FACILEMENT ? ###
                             ### voir l'option covariates.labels

                             checkboxInput("include_ci",
                                           "Include confidence interval?",
                                           value = FALSE),
                             conditionalPanel(
                               condition = "input.include_ci == 1",
                               numericInput(
                                 "ci_level",
                                 "Level of the confidence interval",
                                 value = 0.9,
                                 min = 0,
                                 max = 1,
                                 width = "50%"
                               ),
                               textInput("ci_separator",
                                         "Separator of the confidence interval",
                                         width = "50%")
                             ),
                             selectInput(
                               "intercept_position",
                               "Position of the intercept",
                               choices = c("Bottom" = "bottom",
                                           "Top" = "top"),
                               selected = "Bottom"
                             ),
                             checkboxInput("single_line",
                                           "Put the results on a single line?",
                                           value = FALSE),
                             textInput(
                               "signif_symbol",
                               "Statitiscal significance symbol",
                               width = "75%",
                               placeholder = 'Ex: "@", "@@", "@@@"'
                             )
                           )
                         ),
                         bsCollapsePanel(
                           title = "Additional info options",
                           tagList(
                             actionButton("add_row_statistics",
                                          "Add a row to table statistics"),
                             bsModal(
                               id = "add_row_details",
                               title = "Add a row",
                               trigger = "add_row_statistics",
                               actionButton("foo", "foo")
                               ### METTRE UI
                               ### dépend du nombre de colonnes donc mettre ça dans un renderUI ?
                             )
                           )
                         ),
                         bsCollapsePanel(
                           title = "Footnotes options",
                           tagList(checkboxInput("foo5", "foo5"))
                         )
                       )
                       ),
                     fillCol(),
                     fillCol(uiOutput("stargazer"))
                   )
                   )
                 ),
    miniTabPanel("Code", icon = icon("code"))

  )
)

