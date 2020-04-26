#' Title
#'
#' @return
#' @export
#'
#' @examples NULL
ui <- function(){

  list_regressions <- get_data()

  miniUI::miniPage(
  # theme = "styles.css",
  miniUI::gadgetTitleBar("Build your {stargazer} tables interactively"),
  shiny::br(),
  miniUI::miniTabstripPanel(
    miniUI::miniTabPanel("Table Options", icon = shiny::icon("table"),
                         miniUI::miniContentPanel(
                           # shiny::selectInput("choose_format",
                           #             "Choose the output format",
                           #             choices = c("HTML", "LaTeX"),
                           #             selected = "LaTeX"),
                           shiny::selectInput("choose_regressions",
                                              "Choose the regressions in the table",
                                              choices = names(list_regressions),
                                              multiple = TRUE,
                                              selected = names(list_regressions)),
                           shiny::fillRow(
                             flex = c(0.5, 0.2, 0.5),
                             shiny::fillCol(
                               style = "overflow-y:auto; max-height: 600px",
                               shinyBS::bsCollapse(
                                 id = "latex_options",
                                 general_options(),
                                 title_and_columns_options(),
                                 result_options(),
                                 additional_info_options(),
                                 footnote_options()
                               )
                             ),
                             shiny::fillCol(),
                             shiny::fillCol(shiny::uiOutput("stargazer"))
                           )
                         )
    ),
    miniUI::miniTabPanel("Code", icon = shiny::icon("code")),
    miniUI::miniTabPanel("About",
                         icon = shiny::icon("info"),
                         miniUI::miniContentPanel(
                           shiny::fillRow(
                             flex = c(1, 2, 1),
                             shiny::fillCol(),
                             shiny::fillCol(shiny::wellPanel(
                               shiny::p(
                                 "The goal of this addin is to build {stargazer} tables more easily. At the beginning, choose if you want an HTML or a LaTeX table (note however that some options are only available with LaTeX output).",
                                 shiny::a("This cheatsheet", href = "https://www.jakeruss.com/cheatsheets/stargazer/"),
                                 "by Jake Russ has been extremely useful to build this addin."
                               )
                             )),
                             shiny::fillCol()
                           )
                         ))

  )
  )
}
