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
