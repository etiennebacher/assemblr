server <- function(input, output, session){

  output$stargazer <- renderUI({
    regression <- lm(mpg ~ drat + hp + disp, data =  mtcars)
    HTML(stargazer(regression, regression, regression, type = "html"))
  })

  ### Close app if cancel or done
  observeEvent(input$cancel, {
    stopApp()
  })
  observeEvent(input$done, {
    stopApp()
  })

}
