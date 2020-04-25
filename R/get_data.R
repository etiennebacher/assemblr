#' get_data
#'
#' A function that captures the objects that work with {stargazer}, such as `lm` objects. It is necessary since the user has to choose the objects he/she wants to put in the table. Function coming from [this answer](https://community.rstudio.com/t/how-can-i-access-the-users-global-environment/62688/2)
#'
#' @return A list containing the objects that {stargazer} can deal with.
#' @export
#'
#' @examples # make a random regression and create a random dataframe
#' @examples regression <- lm(mpg ~ drat + hp + disp, data = datasets::mtcars)
#' @examples test <- mtcars
#' @examples # store only the objects whose class is "lm" in a list
#' @examples get_data()
get_data <- function(){
  get_ge <- base::ls(envir = base::globalenv())
  dd <- purrr::map(get_ge, base::get) # get object contents
  names(dd) <- get_ge
  dd <- dd[purrr::map_lgl(dd, inherits, what = 'lm')]

  if(length(dd) == 0){
    dd <- list(regression_1 = lm(mpg ~ drat + hp + disp, data = datasets::mtcars),
               regression_2 = lm(mpg ~ drat, data = datasets::mtcars))
  }
  return(dd)
}

