test_that("only classes supported by stargazer are selected in global environment", {

  # Check that get_data() results in a list
  x <- get_data()
  expect_is(x, "list")

  # Check that the length of x is not 0, i.e that the if condition in get_data() works
  expect_gt(length(x), 0)

  # Check that only "lm" objects are selected from global environment
  y <- unique(unlist(lapply(x, class)))
  expect_equal(y, "lm")

})
