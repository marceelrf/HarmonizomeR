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
#' @import httr
#' @import jsonlite
get_geneset <- function(code) {
  require(dplyr)
  require(httr)
  require(jsonlite)

  load("R/sysdata.rda")
  invisible(harmonizome_datasets)

  tmp <- harmonizome_datasets %>%
    dplyr::filter(Code %in% code) %>%
    dplyr::mutate(query = glue::glue("https://maayanlab.cloud/Harmonizome/api/1.0/dataset/{Link}")) %>%
    dplyr::select(-Name,-Link) %>%
    dplyr::group_by(Code) %>%
    tidyr::nest() %>%
    mutate(cont = purrr::map(data,\(x) x %>%
                               pull(query) %>%
                               GET %>%
                               content("text",encoding = "UTF-8")))
  w1 <- tmp %>%
    filter(stringr::str_detect(cont,"Bad request")) %>%
    pull(Code)

  message(glue::glue("Bad request for the codes: {w1}"))

  tmp %>%
    #Remove bad requests
    filter(stringr::str_detect(cont,"Bad request",negate = TRUE)) %>%
    mutate(cont = map(cont, \(x) x %>% fromJSON %>% pluck("geneSets"))) %>%
    #mutate(gs1 = map(cont,\(x) x %>% ))
    unnest(cont) %>%
    mutate(query = glue::glue("https://maayanlab.cloud/Harmonizome{href}")) %>%
    mutate(cont = map(query, GET,.progress = TRUE)) %>%
    mutate(cont = map(cont, \(x) x %>%
                        content("text",encoding = "UTF-8") %>%
                        fromJSON)) %>%
    mutate(gs = map(cont, ~pluck(.,"associations","gene"))) %>%
    select(-data,-href,-query,-cont) %>%
    unnest(gs) %>%
    select(-href) %>%
    ungroup()

}
