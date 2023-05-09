#' Run GSVA analysis using Harmonizome pathways
#'
#' @param expr A numeric matrix or data frame with gene expression values.
#' @param pathways A list of character vectors, each representing a gene set in the Harmonizome.
#' @return A numeric matrix with GSVA enrichment scores for each pathway.
#' @import GSVA
#' @keywords GSVA, pathway analysis
#' @examples
#' data(example_expr)
#'
#' result <- GSVAHarmonizome(expr = example_expr, pathways = example_pathways)
#' @export
GSVAHarmonizome <- function(expr,pathways){
  require(GSVA)

  GSVA::gsva(expr = expr,
             gset.idx.list = pathways,
             method="gsva",
             verbose = T,
             abs.ranking = F,
             tau = 1,
             ssgsea.norm = FALSE)
}
