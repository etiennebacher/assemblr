#' Run the Shiny Application
#'
#' @param ... A series of options to be used inside the app.
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
assemblr <- function(
  ...
) {
  viewer <- shiny::dialogViewer(dialogName = "assemblr", width = 800, height = 1000)
  with_golem_options(
    app = shiny::runGadget(app_ui, app_server, viewer = viewer),
    golem_opts = list(...)
  )
}
