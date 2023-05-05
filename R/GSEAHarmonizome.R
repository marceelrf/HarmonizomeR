GSEAHarmonizome <- function(pathways,stats,minSize,maxSize){
  require(fgsea)


  fgsea::fgsea(pathways = pathways,
               stats    = stats,
               minSize  = 1,
               maxSize  = 5000)
}
