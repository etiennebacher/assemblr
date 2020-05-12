# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Add one line by package you want to add as dependency
usethis::use_package( "stargazer" )
usethis::use_package( "shiny" )
usethis::use_package( "shinyBS" )
usethis::use_package( "shinyjs" )
usethis::use_package( "miniUI" )
usethis::use_package( "shinyhelper" )
usethis::use_package( "purrr" )
usethis::use_package( "base" )


## Add modules ----
## Create a module infrastructure in R/
golem::add_module( name = "general" ) # Name of the module
golem::add_module( name = "title_and_columns" ) # Name of the module
golem::add_module( name = "results" ) # Name of the module
golem::add_module( name = "additional_info" ) # Name of the module
golem::add_module( name = "footnote" ) # Name of the module
golem::add_module( name = "modify_labels" ) # Name of the module

## Add helper functions ----
## Creates ftc_* and utils_*
golem::add_fct( "get_data" )
golem::add_fct( "get_variables_names")
golem::add_utils( "get_data" )

## External resources
## Creates .js and .css files at inst/app/www
# golem::add_js_file( "script" )
# golem::add_js_handler( "handlers" )
golem::add_css_file( "styles" )

## Add internal datasets ----
## If you have data in your package
# usethis::use_data_raw( name = "my_dataset", open = FALSE )

## Tests ----
## Add one line by test you want to create
usethis::use_test( "get_data" )
usethis::use_test( "get_variables_names" )
usethis::use_test( "shiny_ui" )

# Documentation

## Vignette ----
usethis::use_vignette("hammer")
devtools::build_vignettes()

## Code coverage ----
## (You'll need GitHub there)
# usethis::use_github()
# usethis::use_travis()
# usethis::use_appveyor()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

