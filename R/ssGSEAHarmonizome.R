#' Run single-sample GSEA (ssGSEA) analysis using Harmonizome pathways
#'
#' This function performs single-sample GSEA (ssGSEA) analysis using gene expression data
#' and gene sets from Harmonizome. It utilizes the GSVA package to calculate enrichment scores
#' for each gene set in each sample.
#'
#' @param expr A numeric matrix or data frame with gene expression values.
#' @param pathways A list of character vectors, each representing a gene set in the Harmonizome.
#'
#' @return A numeric matrix with ssGSEA enrichment scores for each pathway in each sample.
#'
#' @import GSVA
#'
#' @examples
#' data(example_expr)
#' data(example_pathways)
#' result <- ssGSEA(expr = example_expr, pathways = example_pathways)
#'
#' @export
ssGSEAHarmonizome <- function(expr,pathways){
  require(GSVA)

  GSVA::gsva(expr = expr,
             gset.idx.list = pathways,
             method="ssgsea",
             verbose = TRUE,
             abs.ranking = FALSE,
             tau = 0.25,
             ssgsea.norm = TRUE)

}
