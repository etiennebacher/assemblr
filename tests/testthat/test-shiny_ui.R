test_that("general options are in the good format", {
  x <- mod_general_ui("general_ui_1")
  expect_is(x, "shiny.tag")
})

test_that("title and columns options are in the good format", {
  x <- mod_title_and_columns_ui("title_and_columns_ui_1")
  expect_is(x, "shiny.tag")
})

test_that("result options are in the good format", {
  x <- mod_results_ui("results_ui_1")
  expect_is(x, "shiny.tag")
})

test_that("additional info options are in the good format", {
  x <- mod_additional_info_ui("additional_info_ui_1")
  expect_is(x, "shiny.tag")
})

test_that("footnote options are in the good format", {
  x <- mod_footnote_ui("footnote_ui_1")
  expect_is(x, "shiny.tag")
})
