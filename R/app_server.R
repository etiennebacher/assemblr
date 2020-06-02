#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {

  # Call helper files
  shinyhelper::observe_helpers(help_dir = app_sys('app/helpers/'))

  # Get the regressions and the names of the variables
  list_regressions <- get_data()
  all_variables <- reactiveValues(variable_names = get_variables_names())

  # Call all modules
  opts_general <- callModule(mod_general_server,
                             "mod_general_ui_1")
  opts_title_and_columns <- callModule(mod_title_and_columns_server,
                                       "mod_title_and_columns_ui_1")
  opts_results <- callModule(mod_results_server,
                             "mod_results_ui_1")
  opts_additional_info <- callModule(mod_additional_info_server,
                                     "mod_additional_info_ui_1")
  opts_footnote <- callModule(mod_footnote_server,
                              "mod_footnote_ui_1")


  # Launch modal to select regressions when button is clicked and at startup
  shiny::observeEvent(input$regressions, {
    shiny::showModal(shiny::modalDialog(
      title = "Choose the regressions in the table",
      shiny::HTML(paste("If your environment does not contain object supported by ",
                        code("{stargazer}"), " made-up regressions (",
                        code("regression_1"), " and ",
                        code("regression_2"),
                        ") will be available for you to test this addin.",
                        sep = "")),
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
  shiny::observeEvent(opts_results$change_covariates_labels(), {

    showModal(
      mod_change_covnames_ui(
        "mod_change_covnames_ui_1",
        all_variables = all_variables$variable_names
      )
    )

    change_covnames <- callModule(
      mod_change_covnames_server,
      "mod_change_covnames_ui_1",
      all_variables = all_variables$variable_names
    )

    # What is the interest of ancient names? They are stored in all_variables above (?)
    # all_variables$variable_names <- change_covnames$ancient()

    observeEvent(change_covnames$button(), {
      all_variables$variable_names <- change_covnames$new()
    })

  })

  # Manipulations of the stargazer tables
  table_output <- shinymeta::metaReactive2({
    shiny::req(input$choose_regressions)

      shinymeta::metaExpr({
        "# Replace 'html' by 'latex' to export this table in LaTeX."
        stargazer::stargazer(
          list_regressions[..(input$choose_regressions)],

          ### General options
          type = "html",
          style = ..(opts_general$style()),

          ### Title and columns options"
          title = ..(opts_title_and_columns$title()),
          dep.var.caption = ..(opts_title_and_columns$caption()), ## MARCHE PAS

          ### Result options
          covariate.labels = all_variables$variable_names,
          ci = ..(opts_results$include_ci()),
          ci.level = ..(opts_results$ci_level()),
          ci.separator = ..(opts_results$ci_separator()),
          single.row = ..(opts_results$single_row()),
          decimal.mark = ..(opts_results$decimal_mark()),
          digits = ..(opts_results$digits()),
          digits.extra = ..(opts_results$digits_extra()),
          initial.zero = ..(opts_results$initial_zero()),
          omit = ..(opts_results$omit()),

          ### Additional info options
          df = ..(opts_additional_info$df()),
          # omit.stat = ..(opts_additional_info$omit_stat()),

          ### Footnote options
          notes = ..(opts_footnote$notes()),
          notes.append = ..(opts_footnote$notes_append()),
          notes.align = ..(opts_footnote$notes_align()),
          notes.label = ..(opts_footnote$notes_label())
        )
      })
  })

  ### Result
  output$stargazer <- shiny::renderUI({
    validate(
      need(length(input$choose_regressions) != 0,
           "Please choose at least one regression"
      ))

    # shiny::HTML has to be here.
    # I can't put it in table_output() because I would have to put a metaExpr in it so that shiny::HTML does not appear in the code to reproduce,
    # but shinymeta apparently does not accept when metaExpr is in shiny::HTML.
    shiny::HTML(table_output())
  })



  ### Reproducibility of the code (much easier to do it here than in module)
  code_pour_refaire <- reactive({
    shinymeta::expandChain(
      quote({
        library(stargazer)
      }),
      table_output()
    )
  })

  shiny::observeEvent(input$show_code, {
    shinymeta::displayCodeModal(
      shinymeta::formatCode(
        code_pour_refaire(),
        width = 50L
      ),
      title = "Code to reproduce the table",
      size = "l",
      fontSize = 13,
      height = "400px"
    )
  })

  ### Close app if cancel
  shiny::observeEvent(input$cancel, {
    shiny::stopApp()
  })


}
