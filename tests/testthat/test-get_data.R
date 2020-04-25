x <- get_data()
y <- models_supported_stargazer()

test_that("get_data creates a non-empty list", {

  # Check that the returned object is a list
  expect_is(x, "list")

  # Check that the length of x is not 0, i.e that the if condition in get_data() works
  expect_gt(length(x), 0)

})

test_that("only classes supported by stargazer are selected in global environment", {

  # Store all classes that are provided by get_data
  z <- unique(unlist(lapply(x, class)))
  # Logical test to see if unexpected models are used in the addin
  only_supported_objects <- z %in% y
  expect_true(only_supported_objects)

})
