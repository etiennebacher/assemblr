#' General options
#'
#' @return
#' @importFrom magrittr %>%
#' @export
#'
#' @examples NULL
general_options <- function(){
  shinyBS::bsCollapsePanel(
    title = "General options",
    shiny::tagList(
      shiny::selectInput(
        "style",
        "Style",
        choices = c(
          "American Economic Review" = "aer",
          "American Journal of Political Science" = "ajps",
          "American Journal of Sociology" = "ajs",
          "Administrative Science Quarterly" = "asq",
          "American Sociological Review" = "asr",
          "American Political Science Review" = "apsr",
          "Demography" = "demography",
          "International Organization" = "io",
          "Journal of Policy Analysis and Management" = "jpam",
          "Quarterly Journal of Economics" = "qje"
        )
      )

      ### FAIRE AUSSI TABLE LAYOUT

    )
)
}
