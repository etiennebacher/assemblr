general_options <- function(){
  bsCollapsePanel(
    title = "General options",
    tagList(
      selectInput(
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
