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

  # Get the regressions
  x <- get_data()

  # Manipulations of the stargazer tables
  table_output <- shiny::reactive({
    shiny::HTML(
      stargazer::stargazer(
        x[input$choose_regressions],

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

  ### Close app if cancel or done
  shiny::observeEvent(input$cancel, {
    shiny::stopApp()
  })
  shiny::observeEvent(input$done, {
    shiny::stopApp()
  })

}
