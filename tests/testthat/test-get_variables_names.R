test_that("get_variables_names produces a vector", {
  x <- get_variables_names()
  expect_is(x, "character")
})

test_that("last variable name is 'constant'", {
  x <- get_variables_names()
  expect_equal(x[length(x)], "Constant")
})
