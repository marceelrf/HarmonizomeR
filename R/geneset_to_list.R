#' Gene Set to List
#'
#' This function takes a tibble and converts it into a named list of vectors.
#' The tibble should contain a "name" column and any number of additional columns containing gene IDs or other gene-related data.
#' The resulting list will have names equal to the values in the "name" column and will contain vectors of the remaining columns' values.
#' This function makes use of the tibble, dplyr, tidyr, and purrr packages.
#'
#' @import tibble
#' @import dplyr
#' @import tidyr
#' @import purrr
#'
#' @param tbl A tibble containing gene IDs or other gene-related data.
#'
#' @return A named list of vectors containing the gene IDs or other gene-related data.
#'
#' @export
#'
#' @examples
#' data("my_geneset")
#' geneset_to_list(my_geneset)
#'
#' @seealso https://tibble.tidyverse.org/
#' @seealso https://dplyr.tidyverse.org/
#' @seealso https://tidyr.tidyverse.org/
#' @seealso https://purrr.tidyverse.org/
#'
#' @keywords gene, tibble, list
geneset_to_list <- function(tbl) {
  require(tibble)
  require(dplyr)
  require(tidyr)
  require(purrr)

  tbl %>%
    select(-Code) %>%
    group_by(name) %>%
    nest() %>%
    mutate(res = map(data, pull)) %>%
    select(-data) %>%
    deframe()
}
