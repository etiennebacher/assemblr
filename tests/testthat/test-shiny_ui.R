test_that("ui is a shiny tagList", {
  x <- ui()
  expect_is(x, "shiny.tag.list")
})

test_that("general options are a shiny tagList", {
  x <- general_options()
  expect_is(x, "shiny.tag")
})

test_that("title and columns options are a shiny tagList", {
  x <- title_and_columns_options()
  expect_is(x, "shiny.tag")
})

test_that("result options are a shiny tagList", {
  x <- result_options()
  expect_is(x, "shiny.tag")
})

test_that("additional info options are a shiny tagList", {
  x <- additional_info_options()
  expect_is(x, "shiny.tag")
})

test_that("footnote options are a shiny tagList", {
  x <- footnote_options()
  expect_is(x, "shiny.tag")
})
