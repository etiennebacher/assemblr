ui <- miniPage(
  # theme = "styles.css",
  gadgetTitleBar("Customize your table with {stargazer}"),
  br(),
  miniTabstripPanel(
    miniTabPanel("Table Options", icon = icon("table"),
                 miniContentPanel(### OPTIONS ###
                   fillRow(
                     flex = c(1, 1),
                     fillCol(
                       dq_accordion(
                         id = "latex_options",
                         bg_color = "LightGray",

                         ### Titles of dropdown menus
                         titles = list(
                           "General options",
                           "Title and columns options",
                           "Result options",
                           "Additional info options",
                           "Footnotes options"
                         ),

                         contents = tagList(
                           ### Inputs for general options
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
                           )),

                           ### Inputs for title and columns
                           tagList(
                             textInput("title", "Title of the table"),
                             textInput("caption", "Caption of the table"),

                             checkboxInput("depvar_label",
                                           "Include the dependent variable label?",
                                           value = TRUE)

                             ### COMMENT MODIFIER LES NOMS DE COLONNE FACILEMENT ? ###
                             ### voir l'option dep.var.labels et column.labels

                           ),

                           ### Inputs for results
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
                           ),

                           ### Inputs for additional info
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
                           ),

                           ### Inputs for footnotes
                           tagList(checkboxInput("foo5", "foo5"))
                         )
                       )
                     ),
                     fillCol(tableOutput("stargazer"))
                   ))),
    miniTabPanel("Code", icon = icon("code"))

  )
)
