#' Run the addin
#'
#' @return The addin
#' @export
#'
#' @examples NULL
hammer <- function(){
  viewer <- shiny::dialogViewer(dialogName = "hammer", width = 1000, height = 1000)
  shiny::runGadget(ui, server, viewer = viewer)
}
