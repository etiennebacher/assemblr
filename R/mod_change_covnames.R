#' change_covnames UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' @param all_variables Vector containing variables names, so that new names are in the left column when the modal is launched another time.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_change_covnames_ui <- function(id, all_variables){
  ns <- NS(id)

  # We create vectors containing names of variables and ids to create two columns and then collect all input values with these ids
  all_variables <- all_variables
  ids_ancient <- paste0("ancient", seq_len(length(all_variables)))
  ids_new <- paste0("new", seq_len(length(all_variables)))

  tagList(
      modalDialog(
        title = "Change covariates labels",
        fluidRow(
          shiny::column(
            6,
            strong("Current covariates labels"),
            shinyjs::disabled(
              purrr::map2(ids_ancient, all_variables, ~ textInput(
                ns(.x), label = NULL, value = .y)
              )
            )
          ),
          shiny::column(
            6,
            strong("New covariates labels"),
            purrr::map2(ids_new, all_variables, ~ textInput(
              ns(.x), label = NULL, value = .y)
            )
          )
        ),
        footer = tagList(
          modalButton("Dismiss"),
          actionButton(ns("apply_covnames"),
                       "Apply",
                       style = "background-color: #286090;
                                color: #fff;")
        )
    )
  )
}

#' change_covnames Server Function
#'
#'#' @param all_variables Vector containing variables names, so that new names are in the left column when the left column is scraped.
#'
#' @return This returns three outputs:
#' \itemize{
#'   \item ancient - A vector containing all values in \code{textInput} in the column "current names".
#'   \item new - A vector containing all values in \code{textInput} in the column "new names".
#'   \item button - The value taken by the button "Apply". This is useful in \code{server} part to save the values stored in "new". Indeed, this is the only way to order the two buttons (the one to launch the modal and the one to apply the changes).
#' }
mod_change_covnames_server <- function(input, output, session, all_variables){
  ns <- session$ns

  all_variables <- all_variables
  ids_ancient <- paste0("ancient", seq_len(length(all_variables)))
  ids_new <- paste0("new", seq_len(length(all_variables)))

  observeEvent(input$apply_covnames, {
    removeModal()
  })

  return(
    list(
      ancient = reactive({ purrr::map_chr(ids_ancient, ~input[[.x]]) }),
      new = reactive({ purrr::map_chr(ids_new, ~input[[.x]]) }),
      button = reactive({ input$apply_covnames })
    )
  )


}

## To be copied in the UI
# mod_change_covnames_ui("change_covnames_ui_1")

## To be copied in the server
# callModule(mod_change_covnames_server, "change_covnames_ui_1")

