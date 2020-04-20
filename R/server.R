server <- function(input, output, session){

  regression <- lm(mpg ~ drat + hp + disp, data =  mtcars)

  table_output <- reactive({
    HTML(
      stargazer(
        regression,
        regression,
        regression,

        ### General options
        type = "html",
        style = input$style,

        ### Title and columns options"
        title = input$title,
        dep.var.caption = input$caption, ## MARCHE PAS

        ### Result options
        ci = input$include_ci,
        ci.level = input$ci_level,
        ci.separator = input$ci_separator
      )
    )
  })

  ### Result
  output$stargazer <- renderUI({
    table_output()
  })

  ### Close app if cancel or done
  observeEvent(input$cancel, {
    stopApp()
  })
  observeEvent(input$done, {
    stopApp()
  })

}
