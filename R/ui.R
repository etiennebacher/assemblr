ui <- miniPage(
  # theme = "styles.css",
  gadgetTitleBar("Build your {stargazer} tables interactively"),
  br(),
  miniTabstripPanel(
    miniTabPanel("Table Options", icon = icon("table"),
                 miniContentPanel(
                   selectInput("choose_format",
                               "Choose the output format",
                               choices = c("HTML", "LaTeX"),
                               selected = "LaTeX"),
                   fillRow(
                     flex = c(1, 0.5, 2),
                     fillCol(
                       bsCollapse(
                         id = "latex_options",
                         general_options(),
                         title_and_columns_options(),
                         result_options(),
                         additional_info_options(),
                         footnote_options()
                       )
                       ),
                     fillCol(),
                     fillCol(uiOutput("stargazer"))
                   )
                   )
                 ),
    miniTabPanel("Code", icon = icon("code")),
    miniTabPanel("About", icon = icon("info"),
                 miniContentPanel(
                   fillRow(
                     flex = c(1, 2, 1),
                     fillCol(),
                     fillCol(
                       wellPanel(
                         p("The goal of this addin is to build {stargazer} tables more easily. At the beginning, choose if you want an HTML or a LaTeX table (note however that some options are only available with LaTeX output).",
                           a("This cheatsheet", href = "https://www.jakeruss.com/cheatsheets/stargazer/"), "by Jake Russ has been extremely useful to build this addin.")
                       )
                     ),
                     fillCol()
                   )
                )
    )

  )
)

