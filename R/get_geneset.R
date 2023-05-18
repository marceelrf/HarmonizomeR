#' Get Gene Set
#'
#' This function retrieves the gene sets contained in one or more Harmonizome datasets based on the given code(s).
#' The function requires the dplyr, httr, and jsonlite packages.
#' It first filters the datasets based on the given codes and then retrieves the gene sets for each dataset using the Harmonizome API.
#' The resulting tibble contains information about the gene sets, including the dataset code and the gene IDs in each gene set.
#'
#' @param code A character vector or a string specifying the Harmonizome dataset code(s) for which to retrieve the gene sets.
#' @return A tibble with columns for dataset code and gene IDs in each gene set.
#' @import dplyr
#' @import tidyr
#' @import purrr
#' @import httr
#' @import jsonlite
get_geneset <- function(code) {
  require(dplyr)
  require(tibble)
  require(tidyr)
  require(purrr)
  require(httr)
  require(jsonlite)

  HarmonizomeR:::harmonizome_datasets
  invisible(harmonizome_datasets)

  tmp <- HarmonizomeR:::harmonizome_datasets %>%
    dplyr::filter(Code %in% code) %>%
    dplyr::mutate(query = glue::glue("https://maayanlab.cloud/Harmonizome/api/1.0/dataset/{Link}")) %>%
    dplyr::select(-Name,-Link) %>%
    dplyr::group_by(Code) %>%
    tidyr::nest() %>%
    dplyr::mutate(cont = purrr::map(data,\(x) x %>%
                               pull(query) %>%
                               GET %>%
                               content("text",encoding = "UTF-8")))
  w1 <- tmp %>%
    filter(stringr::str_detect(cont,"Bad request")) %>%
    pull(Code)

  message(glue::glue("Bad request for the codes: {w1}"))

  tmp %>%
    #Remove bad requests
    dplyr::filter(stringr::str_detect(cont,"Bad request",negate = TRUE)) %>%
    dplyr::mutate(cont = purrr::map(cont, \(x) x %>% fromJSON %>% pluck("geneSets"))) %>%
    #mutate(gs1 = map(cont,\(x) x %>% ))
    tidyr::unnest(cont) %>%
    dplyr::mutate(query = glue::glue("https://maayanlab.cloud/Harmonizome{href}")) %>%
    dplyr::mutate(cont = purrr::map(query, GET,.progress = TRUE)) %>%
    dplyr::mutate(cont = purrr::map(cont, \(x) x %>%
                        content("text",encoding = "UTF-8") %>%
                        fromJSON)) %>%
    dplyr::mutate(gs = map(cont, ~pluck(.,"associations","gene"))) %>%
    dplyr::select(-data,-href,-query,-cont) %>%
    tidyr::unnest(gs) %>%
    dplyr::select(-href) %>%
    dplyr::ungroup()

}
