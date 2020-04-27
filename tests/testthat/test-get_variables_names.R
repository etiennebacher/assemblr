test_that("get_variables_names produces a vector", {
  x <- get_variables_names()
  expect_is(x, "character")
})
