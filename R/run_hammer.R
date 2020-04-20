hammer <- function(){
  source("R/packages_used.R")
  source(here("R/general_options.R"))
  source(here("R/title_and_columns_options.R"))
  source(here("R/result_options.R"))
  source(here("R/additional_info_options.R"))
  source(here("R/footnote_options.R"))
  source("R/ui.R")
  source("R/server.R")
  viewer <- dialogViewer(dialogName = "hammer", width = 1000, height = 1000)
  runGadget(ui, server, viewer = viewer)
}
hammer()
