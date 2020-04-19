hammer <- function(){
  source("R/packages_used.R")
  source("R/ui.R")
  source("R/server.R")
  viewer <- dialogViewer(dialogName = "hammer", width = 1000, height = 1000)
  runGadget(ui, server, viewer = viewer)
}
hammer()
