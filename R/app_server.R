#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {

  shinyhelper::observe_helpers(help_dir = app_sys('app/helpers/'))

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
  #
  # # Launch modal to change covariates labels
  # shiny::observeEvent(input$change_covariates_labels, {
  #   showModal(modalDialog(
  #     title = "Change covariates labels",
  #     shiny::column(12,
  #                   shiny::actionButton("apply_covariates_labels_changes",
  #                                       "Apply changes")
  #     ),
  #     UI_change_cov_labels(2)
  #   ))
  #
  #   callModule(server_change_cov_labels, 2)
  # })
  #
  # # Manipulations of the stargazer tables

  opts_general <- callModule(mod_general_server, "1")
  opts_title_and_columns <- callModule(mod_title_and_columns_server, "1")
  opts_results <- callModule(mod_results_server, "1")
  opts_additional_info <- callModule(mod_additional_info_server, "1")
  opts_footnote <- callModule(mod_footnote_server, "1")


  table_output <- shiny::reactive({
    shiny::req(input$choose_regressions)
    shiny::HTML(
      stargazer::stargazer(
        list_regressions[input$choose_regressions],

        ### General options
        type = "html",
        style = opts_general$style(),

        ### Title and columns options"
        title = opts_title_and_columns$title(),
        dep.var.caption = opts_title_and_columns$caption(), ## MARCHE PAS

        ### Result options
        ci = opts_results$include_ci(),
        ci.level = opts_results$ci_level(),
        ci.separator = opts_results$ci_separator(),
        single.row = opts_results$single_row(),
        decimal.mark = opts_results$decimal_mark(),
        digits = opts_results$digits(),
        digits.extra = opts_results$digits_extra(),
        initial.zero = opts_results$initial_zero(),
        omit = opts_results$omit(),

        ### Additional info options
        df = opts_additional_info$df(),

        ### Footnote options
        notes = opts_footnote$notes(),
        notes.append = opts_footnote$notes_append(),
        notes.align = opts_footnote$notes_align(),
        notes.label = opts_footnote$notes_label()
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

  # ### Close app if cancel
  # shiny::observeEvent(input$cancel, {
  #   shiny::stopApp()
  # })
  #

}
