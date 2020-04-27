#' Obtain variable names
#'
#' @return A vector containing the unique variables names in all regressions
#' @export
#'
#' @examples NULL
get_variables_names <- function(){
  # Obtain the list of objects supported by stargazer
  list_regressions <- get_data()

  # For each regression, store variables names in a part of a list
  variables_regressions <- list()
  for (i in 1:length(list_regressions)){
    variables_regressions[[i]] <- names(list_regressions[[i]]$coefficients)
  }
  # Remove duplicates of names and store it in a vector
  all_variables <- unique(unlist(variables_regressions))
  # Rename "(Intercept)" as "Constant" since it is the name given by stargazer
  all_variables[all_variables == "(Intercept)"] <- "Constant"
  return(all_variables)
}
