test_that("verify that only classes supported by stargazer are selected in global environment", {

  # Check that get_data() results in a list
  x <- get_data()
  expect_is(x, "list")

  # Check that only "lm" objects are selected from global environment
  y <- unique(unlist(lapply(x, class)))
  expect_equal(y, "lm")

})
