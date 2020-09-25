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
  opts_general <- mod_general_server("mod_general")
  opts_title_and_columns <- mod_title_and_columns_server("mod_title_and_columns")
  opts_results <- mod_results_server("mod_results")
  opts_additional_info <- mod_additional_info_server("mod_additional_info")
  opts_footnote <- mod_footnote_server("mod_footnote")


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
        "mod_change_covnames",
        all_variables = all_variables$variable_names
      )
    )

    change_covnames <- mod_change_covnames_server(
      "mod_change_covnames",
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
    input$validate_options

    isolate({
      shinymeta::metaExpr({
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
          intercept.bottom = ..(opts_results$intercept_position()),
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
  code_to_reproduce <- reactive({
    shinymeta::expandChain(
      quote({
        base::library(stargazer)
      }),
      table_output()
    )
  })

  ### Copy the code
  output$copy_code <- shiny::renderUI({
    code_to_copy <- shinymeta::formatCode(
      code_to_reproduce(),
      width = 30L
    ) %>%
      gsub("html", "latex", .) %>%
      gsub("base::", "", .)
    code_to_copy_2 <- paste(code_to_copy, collapse = "\n")
    rclipboard::rclipButton("clipbtn", "Copy the code", code_to_copy_2, icon("clipboard"))
  })


  ### Close app if cancel
  shiny::observeEvent(input$cancel, {
    shiny::stopApp()
  })


}
