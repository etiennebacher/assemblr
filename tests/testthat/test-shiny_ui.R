test_that("general options are in the good format", {
  x <- mod_general_ui("general")
  expect_is(x, "shiny.tag")
})

test_that("title and columns options are in the good format", {
  x <- mod_title_and_columns_ui("title_and_columns")
  expect_is(x, "shiny.tag")
})

test_that("result options are in the good format", {
  x <- mod_results_ui("results")
  expect_is(x, "shiny.tag")
})

test_that("additional info options are in the good format", {
  x <- mod_additional_info_ui("additional_info")
  expect_is(x, "shiny.tag")
})

test_that("footnote options are in the good format", {
  x <- mod_footnote_ui("footnote")
  expect_is(x, "shiny.tag")
})

test_that("modal to change covnames is in the good format", {
  x <- mod_change_covnames_ui("covnames", all_variables = get_variables_names())
  expect_is(x, "shiny.tag.list")
})
