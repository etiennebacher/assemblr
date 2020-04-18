server <- function(input, output, session){

  output$stargazer <- renderTable(mtcars)

  ### Close app if cancel or done
  observeEvent(input$cancel, {
    stopApp()
  })
  observeEvent(input$done, {
    stopApp()
  })

}
