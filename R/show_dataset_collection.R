#' Show Dataset Collection
#'
#' This function loads and displays information about the datasets available in the Harmonizome collection.
#' The information is displayed in a table format, and the function also provides a link to the complete dataset information available online.
#'
#' @import dplyr
#'
#' @return A table with information about the Harmonizome dataset collection.
#'
#' @export
#'
#' @examples
#' show_dataset_collection()
#'
#' @seealso https://maayanlab.cloud/Harmonizome/
#'
#' @keywords dataset, harmonizome
show_dataset_collection <- function(){
  suppressPackageStartupMessages(require(dplyr))

  load("R/sysdata.rda")

  invisible(harmonizome_datasets)

  message("To check the complete dataset information,\ngo to: https://maayanlab.cloud/Harmonizome/")
  harmonizome_datasets %>%
    dplyr::select(-Link)
}


