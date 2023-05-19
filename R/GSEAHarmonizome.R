#' Run Gene Set Enrichment Analysis (GSEA) using Harmonizome gene sets
#'
#' This function performs Gene Set Enrichment Analysis (GSEA) using gene sets
#' from Harmonizome. It uses the fgsea package to calculate enrichment scores
#' and p-values for the given gene set and gene expression data.
#'
#' @param pathways A named list of gene sets, where each element is a vector of
#' gene symbols representing a gene set. The names of the list
#' should correspond to the names of the gene sets.
#' @param stats A vector of numeric gene expression values.
#' @param minSize The minimum size of the gene set to be considered in the analysis.
#' Default is 1.
#' @param maxSize The maximum size of the gene set to be considered in the analysis.
#' Default is 5000.
#'
#' @return A data frame containing the GSEA results, including the gene set name,
#' the size of the gene set, the enrichment score, and the p-value.
#'
#' @import fgsea
#'
#' @export

GSEAHarmonizome <- function(pathways,stats,minSize,maxSize){
  require(fgsea)


  fgsea::fgsea(pathways = pathways,
               stats    = stats,
               minSize  = 1,
               maxSize  = 5000,
               nproc=1,
               eps = 0)
}
