#' Title
#'
#' @param input something
#' @param output something else
#' @param session something else
#'
#' @return
#' @export
#'
#' @examples NULL
server <- function(input, output, session){

  # shinyhelper::observe_helpers(help_dir = "R/helpers/")

  # Get the regressions and the names of the variables
  list_regressions <- get_data()
  all_variables <- get_variables_names()

  # Launch modal to select regressions when button is clicked and at startup
  shiny::observeEvent(input$regressions, {
    shiny::showModal(shiny::modalDialog(
      title = "Choose the regressions in the table",
      shiny::HTML(paste("If your environment does not contain object supported by {stargazer}, made-up regressions (", code("regression_1"), " and ", code("regression_2"), ") will be available for you to test this addin.", sep = "")),
      shiny::selectInput(
        "choose_regressions",
        "",
        choices = names(list_regressions),
        multiple = TRUE,
        selected = names(list_regressions)
      ),
      easyClose = TRUE
    ))
  }, ignoreNULL = FALSE)

  # Launch modal to change covariates labels
  shiny::observeEvent(input$change_covariates_labels, {
    showModal(modalDialog(
      title = "Change covariates labels",
      shiny::column(12,
                    shiny::actionButton("apply_covariates_labels_changes",
                                        "Apply changes")
      ),
      UI_change_cov_labels(2)
    ))

    callModule(server_change_cov_labels, 2)
  })

  # Manipulations of the stargazer tables
  table_output <- shiny::reactive({
    shiny::req(input$choose_regressions)
    shiny::HTML(
      stargazer::stargazer(
        list_regressions[input$choose_regressions],

        ### General options
        type = "html",
        style = input$style,

        ### Title and columns options"
        title = input$title,
        dep.var.caption = input$caption, ## MARCHE PAS

        ### Result options
        ci = input$include_ci,
        ci.level = input$ci_level,
        ci.separator = input$ci_separator,
        single.row = input$single_row,
        decimal.mark = input$decimal_mark,
        digits = input$digits,
        digits.extra = input$digits_extra,
        initial.zero = input$initial_zero,
        omit = input$omit,

        ### Additional info options
        df = input$df,

        ### Footnote options
        notes = input$notes,
        notes.append = input$notes_append,
        notes.align = input$notes_align,
        notes.label = input$notes_label
      )
    )
  })

  ### Result
  output$stargazer <- shiny::renderUI({
    validate(
      need(length(input$choose_regressions) != 0,
      "Please choose at least one regression"
    ))
    table_output()
  })

  ### Close app if cancel
  shiny::observeEvent(input$cancel, {
    shiny::stopApp()
  })

}
