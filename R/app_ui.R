#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {

  list_regressions <- get_data()

  # List the first level UI elements here
  x <- miniUI::miniPage(
    # load CSS and JS
    golem_add_external_resources(),
    miniUI::gadgetTitleBar(
      "Build your {stargazer} tables interactively",
      left = miniUI::miniTitleBarButton("regressions",
                                        "Regressions", primary = TRUE),
      right = miniUI::miniTitleBarButton("cancel", "Cancel")
    ),
    shiny::br(),
    miniUI::miniTabstripPanel(
      miniUI::miniTabPanel(
        "Table Options",
        icon = shiny::icon("table"),
        miniUI::miniContentPanel(
          shiny::fillRow(
            flex = c(0.5, 0.05, 0.5),
            shiny::fillCol(
              style = "overflow-y:auto; max-height: 600px",
              shinyBS::bsCollapse(
                id = "latex_options",
                mod_general_ui("1"),
                mod_title_and_columns_ui("1"),
                mod_results_ui("1"),
                mod_additional_info_ui("1"),
                mod_footnote_ui("1")
              )
            ),
            shiny::fillCol(),
            shiny::fillCol(
              shiny::uiOutput("stargazer"))
          )
        )
      ),
      miniUI::miniTabPanel(
        "Code",
        icon = shiny::icon("code"),
        miniUI::miniContentPanel(
          shiny::fillRow(
            flex = c(1, 2, 1),
            mod_reproduce_ui("1")
          )
        )
      ),
      miniUI::miniTabPanel(
        "About",
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
        )
      )

    )
  )

  return(x)
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'assemblr'
    ),
    shinyjs::useShinyjs()
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}

