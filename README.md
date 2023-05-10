
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Harmonizome

<!-- badges: start -->
<!-- badges: end -->

The goal of Harmonizome is to provide a fast interface to download and
perform functional and gene set enrichment analysis from the
[Harmonizome](https://maayanlab.cloud/Harmonizome/) database (Rouillard
et al. 2016).

## Installation

You can install the development version of Harmonizome from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("marceelrf/Harmonizome")
```

## Example

The function `show_dataset_collection` is used to check all available
datasets.

``` r
show_dataset_collection()
#> Carregando pacotes exigidos: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
#> To check the complete dataset information,
#> go to: https://maayanlab.cloud/Harmonizome/
#> # A tibble: 129 x 2
#>    Name                                                                    Code 
#>    <chr>                                                                   <chr>
#>  1 Achilles Cell Line Gene Essentiality Profiles                           achi~
#>  2 Allen Brain Atlas Adult Human Brain Tissue Gene Expression Profiles     brai~
#>  3 Allen Brain Atlas Adult Mouse Brain Tissue Gene Expression Profiles     brai~
#>  4 Allen Brain Atlas Developing Human Brain Tissue Gene Expression Profil~ brai~
#>  5 Allen Brain Atlas Developing Human Brain Tissue Gene Expression Profil~ brai~
#>  6 Allen Brain Atlas Prenatal Human Brain Tissue Gene Expression Profiles  brai~
#>  7 BIND Biomolecular Interactions                                          bind 
#>  8 BioGPS Cell Line Gene Expression Profiles                               biog~
#>  9 BioGPS Human Cell Type and Tissue Gene Expression Profiles              biog~
#> 10 BioGPS Mouse Cell Type and Tissue Gene Expression Profiles              biog~
#> # ... with 119 more rows
```

Let’s use the [*SILAC Phosphoproteomics Signatures of Differentially
Phosphorylated Proteins for Drugs*
dataset](https://maayanlab.cloud/Harmonizome/dataset/SILAC+Phosphoproteomics+Signatures+of+Differentially+Phosphorylated+Proteins+for+Drugs)
using the code **silacdrug** in the function `get_geneset`.

**CAUTION**: Depending on the size of your data set and your internet
connection this step could take a long time!!!

``` r
silacdrug_ds <- get_geneset(code = "silacdrug")
#> Carregando pacotes exigidos: tibble
#> Carregando pacotes exigidos: tidyr
#> Carregando pacotes exigidos: purrr
#> Carregando pacotes exigidos: httr
#> Carregando pacotes exigidos: jsonlite
#> 
#> Attaching package: 'jsonlite'
#> The following object is masked from 'package:purrr':
#> 
#>     flatten
#> 
#> =>----------------------------- 4% | ETA: 40s ====>--------------------------
#> 13% | ETA: 17s =====>------------------------- 17% | ETA: 18s
#> =======>----------------------- 22% | ETA: 15s ========>----------------------
#> 26% | ETA: 13s =========>--------------------- 30% | ETA: 12s
#> ==========>-------------------- 35% | ETA: 11s ============>------------------
#> 39% | ETA: 9s =============>----------------- 43% | ETA: 9s
#> ==============>---------------- 48% | ETA: 8s ================>--------------
#> 52% | ETA: 8s =================>------------- 57% | ETA: 7s
#> ==================>------------ 61% | ETA: 6s ====================>----------
#> 65% | ETA: 6s =====================>--------- 70% | ETA: 5s
#> ======================>-------- 74% | ETA: 4s =======================>-------
#> 78% | ETA: 3s =========================>----- 83% | ETA: 3s
#> ==========================>---- 87% | ETA: 2s ===========================>---
#> 91% | ETA: 1s =============================>- 96% | ETA: 1s
```

``` r
head(silacdrug_ds)
#> # A tibble: 6 x 3
#>   Code      name                                                          symbol
#>   <chr>     <chr>                                                         <chr> 
#> 1 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ MAPK3 
#> 2 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ RANBP9
#> 3 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ FAM12~
#> 4 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ NCAPD2
#> 5 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ KIAA1~
#> 6 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ ZNF598
```

## Enrichment analysis

### Over representation analysis (ORA)

``` r
genes <- c("CYP2D26","NCOA7","CCDC3","SNTG2","LIMK1","PPWD1","2900055J20RIK","GM839","HSPA12A","MTIF3","KDM2B","FAM221A","GM19710","CCDC68","CNRIP1","GM7544","LGI2","CLIP3","GM9484","1700034J05RIK","RIPK2","DPF2","RPS6KA4","RUNX1","DNM1L","SGTA","PIP5K1B","MTA1","KIAA1524","NCOR2","HSP90AB1","ARFIP2","DKC1","KMT2A","RPLP2","PLEC","HSP90AA1","PEAK1","ZDHHC5","TBC1D25")

ORA <- EnrichHarmonizome(gene = genes,
                  tbl = silacdrug_ds,
                  pvalueCutoff = 0.05,
                  pAdjustMethod = "BH",
                  minGSSize = 5,
                  maxGSSize = 5000)
#> Carregando pacotes exigidos: clusterProfiler
#> 
#> Registered S3 method overwritten by 'ggtree':
#>   method      from 
#>   identify.gg ggfun
#> clusterProfiler v4.2.2  For help: https://yulab-smu.top/biomedical-knowledge-mining-book/
#> 
#> If you use clusterProfiler in published research, please cite:
#> T Wu, E Hu, S Xu, M Chen, P Guo, Z Dai, T Feng, L Zhou, W Tang, L Zhan, X Fu, S Liu, X Bo, and G Yu. clusterProfiler 4.0: A universal enrichment tool for interpreting omics data. The Innovation. 2021, 2(3):100141
#> 
#> Attaching package: 'clusterProfiler'
#> The following object is masked from 'package:purrr':
#> 
#>     simplify
#> The following object is masked from 'package:stats':
#> 
#>     filter

head(ORA@result)
#>                                                                                                                                                                                                                                                                                                          ID
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs       HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs       HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs           10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs   HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#>                                                                                                                                                                                                                                                                                                 Description
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs       HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs       HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs           10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs   HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#>                                                                                                                                                       GeneRatio
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs      4/23
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs      4/23
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs         4/23
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs         4/23
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs          15/23
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs       3/23
#>                                                                                                                                                         BgRatio
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs   91/2770
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs   93/2770
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs     109/2770
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs     115/2770
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs      1182/2770
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs    85/2770
#>                                                                                                                                                            pvalue
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs 0.005979257
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs 0.006460083
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs    0.011265667
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs    0.013542170
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs      0.024166257
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs  0.031710728
#>                                                                                                                                                         p.adjust
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs 0.06783087
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs 0.06783087
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs    0.07109639
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs    0.07109639
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs      0.10149828
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs  0.10400006
#>                                                                                                                                                           qvalue
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs 0.04760061
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs 0.04760061
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs    0.04989221
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs    0.04989221
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs      0.07122686
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs  0.07298250
#>                                                                                                                                                                                                                                                  geneID
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs                                                                         RIPK2/DPF2/RPLP2/HSP90AA1
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs                                                                     RIPK2/HSP90AB1/RPLP2/HSP90AA1
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs                                                                          RIPK2/RPS6KA4/PIP5K1B/RPLP2
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs                                                                          RIPK2/RPS6KA4/PIP5K1B/RPLP2
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs      DPF2/RPS6KA4/DNM1L/SGTA/NCOR2/HSP90AB1/ARFIP2/DKC1/KMT2A/RPLP2/PLEC/HSP90AA1/PEAK1/ZDHHC5/TBC1D25
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs                                                                                RIPK2/DPF2/HSP90AA1
#>                                                                                                                                                       Count
#> HS+LS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs     4
#> HS+LS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs     4
#> HS_10min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs        4
#> HS_90min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs        4
#> 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs         15
#> HS+LS_3min_LPS vs ctrl_RAW264.7_macrophage (Mouse) [20222745]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs      3
```

### Gene set enrichment analysis (GSEA)

To perform the GSEA analysis is necessary to convert the geneset to a
named list. The function `geneset_to_list` handle with this task.

``` r
pathways_list <- geneset_to_list(tbl = silacdrug_ds)

pathways_list[1]
#> $`10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs`
#>    [1] "MAPK3"     "RANBP9"    "FAM122A"   "NCAPD2"    "KIAA1468"  "ZNF598"   
#>    [7] "TAB3"      "TMEM106B"  "CYLD"      "ARHGEF28"  "ZC3HC1"    "CBX8"     
#>   [13] "CBX3"      "FAM76B"    "PLCH1"     "CLSPN"     "U2AF2"     "PLXNB3"   
#>   [19] "TFAP4"     "MXRA8"     "CBX5"      "HMHA1"     "ELF1"      "SHROOM3"  
#>   [25] "BCL2L13"   "CACTIN"    "CENPV"     "FRA10AC1"  "ARGLU1"    "HNRNPA2B1"
#>   [31] "KIAA0430"  "DNM1L"     "TRIP11"    "BIRC6"     "TXNL1"     "CTNNA1"   
#>   [37] "GTSE1"     "UBE2O"     "UCK2"      "RAPGEF3"   "CNPY2"     "UTP15"    
#>   [43] "SH3GL1"    "IRF2BP1"   "TCEB3"     "MCM6"      "AKT1S1"    "SHC1"     
#>   [49] "MTUS1"     "PHACTR4"   "UBR4"      "CSNK1E"    "RBM10"     "CXADR"    
#>   [55] "LEO1"      "MAP3K2"    "CRK"       "FAF1"      "NCBP1"     "NT5C3A"   
#>   [61] "BSG"       "BCAR1"     "CTNNB1"    "SH2B1"     "VIM"       "RPS3"     
#>   [67] "USP48"     "HCK"       "CHFR"      "YWHAZ"     "SNRNP200"  "PALLD"    
#>   [73] "RPS2"      "CHAF1B"    "N4BP2L2"   "NASP"      "CD2BP2"    "ASAP1"    
#>   [79] "C12ORF45"  "WIBG"      "RAVER1"    "MAP4K4"    "NUP205"    "SNX2"     
#>   [85] "JUN"       "PPP1R13L"  "ARFGEF1"   "FNBP4"     "ADNP"      "NELFE"    
#>   [91] "SIK2"      "ZNF608"    "SORD"      "KLHL6"     "DOCK1"     "ZNF7"     
#>   [97] "AAK1"      "DDX1"      "ARFGEF2"   "MAP1S"     "ULK1"      "SMTN"     
#>  [103] "C2ORF44"   "DDX20"     "YBX1"      "PJA2"      "SMAP2"     "SYNRG"    
#>  [109] "SPEN"      "PEX1"      "APOBR"     "MLF2"      "OPTN"      "CD2AP"    
#>  [115] "CAPZA2"    "ARMC1"     "FLRT1"     "NOP56"     "LGR5"      "SPRED1"   
#>  [121] "EIF6"      "C5ORF30"   "ZNF687"    "DLGAP4"    "GRAMD3"    "EIF4B"    
#>  [127] "EDC4"      "PURB"      "SMG6"      "ETHE1"     "DAXX"      "DLGAP5"   
#>  [133] "LUC7L"     "BCKDHA"    "KANK2"     "DSTN"      "DUSP7"     "DNMT1"    
#>  [139] "DENND5B"   "UTP18"     "PRUNE2"    "CTIF"      "CD44"      "TRAPPC8"  
#>  [145] "STAMBPL1"  "KIF20B"    "CLASP1"    "RIN2"      "STRN3"     "PUM2"     
#>  [151] "NFRKB"     "RPS6KA1"   "AARSD1"    "MED24"     "INO80C"    "GOLGA3"   
#>  [157] "CDKN2AIP"  "ZC3H13"    "TMCC2"     "ALKBH5"    "HNRNPC"    "KIAA1598" 
#>  [163] "EIF2S2"    "UACA"      "RNF187"    "ZFC3H1"    "CNOT3"     "DTD1"     
#>  [169] "LRRC41"    "IFITM3"    "MAPK1"     "CHD2"      "NR2C2AP"   "PIKFYVE"  
#>  [175] "NUCB1"     "CKAP2"     "EEF2"      "CEP170"    "USP39"     "POLA2"    
#>  [181] "NVL"       "SLC33A1"   "PLEKHA6"   "C10ORF88"  "NAB2"      "SAMD4B"   
#>  [187] "DOCK7"     "NIFK"      "ZCCHC11"   "SYNE2"     "NPM1"      "MED1"     
#>  [193] "CFDP1"     "RFX7"      "RPS17"     "RIF1"      "NHSL1"     "SSB"      
#>  [199] "PTPRG"     "ZNF462"    "SMEK1"     "CDK16"     "WDR62"     "RANGAP1"  
#>  [205] "GCFC2"     "SLIRP"     "NCL"       "PRKAA1"    "IRF3"      "NMT1"     
#>  [211] "NOL10"     "CTTNBP2NL" "CHERP"     "PLEKHG3"   "CAMSAP2"   "SMARCAD1" 
#>  [217] "EIF4G3"    "AKIRIN2"   "RBM25"     "TTLL12"    "SNX5"      "STRN4"    
#>  [223] "TAOK1"     "SIPA1L1"   "GAPVD1"    "NEDD4"     "SLC16A1"   "RTN4"     
#>  [229] "WBP11"     "PHLDB2"    "AGAP1"     "RPL13"     "TCF4"      "CDK4"     
#>  [235] "PXN"       "RBMX"      "BRD8"      "DKC1"      "RFX1"      "CBL"      
#>  [241] "CPD"       "ALAD"      "SH3KBP1"   "ATAD2"     "LRP4"      "TTI1"     
#>  [247] "PCIF1"     "GPSM2"     "RIN1"      "ARMC10"    "PVRL1"     "HIST1H1C" 
#>  [253] "CRTC2"     "RPLP2"     "SLC4A1AP"  "KANSL1"    "CDK17"     "NEO1"     
#>  [259] "TMEM55A"   "LEMD2"     "ATF2"      "RAI14"     "MTMR3"     "ZZEF1"    
#>  [265] "CHD4"      "FXR1"      "CDC42EP1"  "ITPKB"     "PCM1"      "ACTC1"    
#>  [271] "PRPF4B"    "RAD51AP1"  "NUP93"     "MUS81"     "MBD5"      "C17ORF49" 
#>  [277] "MOB1B"     "RBM33"     "TNS1"      "LSM14B"    "SNX16"     "KNOP1"    
#>  [283] "MAP7D1"    "CLUAP1"    "MTF1"      "QARS"      "LRRFIP1"   "SETD2"    
#>  [289] "TBC1D1"    "NUFIP2"    "NBN"       "NCAPH"     "HNRNPH1"   "KDM3B"    
#>  [295] "TJP2"      "PDCD4"     "ADD3"      "PDXDC1"    "LPP"       "PA2G4"    
#>  [301] "RPRD2"     "EIF1"      "ESYT2"     "TDP1"      "INCENP"    "MEPCE"    
#>  [307] "GTF3C4"    "ZZZ3"      "ANAPC1"    "IFIH1"     "DNAJC2"    "GOLM1"    
#>  [313] "REPS1"     "SLMAP"     "CCDC43"    "ENSA"      "YTHDC2"    "PRPF40A"  
#>  [319] "HCFC1"     "SRGAP2"    "EML3"      "HNRNPU"    "HEATR3"    "BCLAF1"   
#>  [325] "RNASEH2A"  "C19ORF47"  "LLPH"      "NOC2L"     "TMSB10"    "CGN"      
#>  [331] "PELP1"     "MORC3"     "EAF1"      "RBM17"     "EIF4H"     "ARID4A"   
#>  [337] "MLLT4"     "PRKD3"     "HSPB8"     "MYO1E"     "HMGXB4"    "TMEM230"  
#>  [343] "ATG16L1"   "SCAF4"     "TCF20"     "TMEM176B"  "TTC7A"     "PHAX"     
#>  [349] "PSMD4"     "USP15"     "CCNL2"     "PAWR"      "EPN3"      "PCBP2"    
#>  [355] "EPB41"     "FAM195B"   "ASUN"      "MED14"     "SDC1"      "ZMYM2"    
#>  [361] "MDH1"      "KIF3A"     "NAV1"      "CDV3"      "AATF"      "WDR43"    
#>  [367] "HNRNPUL2"  "RAB3GAP1"  "C2CD5"     "CDC42EP5"  "NDRG3"     "EPS15L1"  
#>  [373] "SRRT"      "RPS6KA4"   "MAP3K3"    "URI1"      "GAB1"      "SH3BP4"   
#>  [379] "LASP1"     "ATRX"      "KIF5B"     "PUS10"     "APRT"      "BAG3"     
#>  [385] "ARHGEF7"   "CNOT2"     "SPATA13"   "PHF14"     "TRA2A"     "EIF3J"    
#>  [391] "MYC"       "LATS1"     "PSRC1"     "INTS6"     "ARFGAP2"   "HNRNPAB"  
#>  [397] "RPL6"      "PML"       "FEZ2"      "RBM14"     "IRF2BP2"   "APLF"     
#>  [403] "VPS51"     "DNAJC5"    "ZFP36L1"   "CTR9"      "RHBDF2"    "ARHGAP32" 
#>  [409] "FAM160A2"  "FBXW8"     "TMEM63B"   "TSR3"      "G3BP1"     "CNPY4"    
#>  [415] "ESAM"      "EIF2B5"    "KLC3"      "RAB7A"     "KIF21A"    "TAF7"     
#>  [421] "HLA-A"     "ZC3H14"    "MAST2"     "PPFIBP1"   "PUM1"      "BAZ2A"    
#>  [427] "OSBPL11"   "MLLT6"     "DBNL"      "MATR3"     "UBR5"      "RALY"     
#>  [433] "KRT8"      "ZRANB2"    "CDCA2"     "ABL2"      "RPL30"     "STON1"    
#>  [439] "ARL6IP4"   "DST"       "TFEB"      "PSMD11"    "PSMF1"     "CGNL1"    
#>  [445] "SLC4A4"    "STK4"      "NPM3"      "MTA3"      "ARFIP1"    "HNRNPLL"  
#>  [451] "EIF3D"     "TOP2A"     "BNIP3"     "SF3B1"     "ACLY"      "NCOA3"    
#>  [457] "PARD3"     "TRIP6"     "MDC1"      "C7ORF43"   "HSF1"      "RICTOR"   
#>  [463] "REXO1"     "CWC27"     "PPP2R5D"   "RSRC2"     "PAK2"      "UBE2J1"   
#>  [469] "LARP4"     "ARPC1B"    "PLCB3"     "HNRNPA3"   "LIMD1"     "POLA1"    
#>  [475] "SLC4A7"    "KMT2A"     "KANK1"     "MARS"      "IFI35"     "IKBKB"    
#>  [481] "KIAA1522"  "CAST"      "MTHFD1"    "DIP2B"     "FBL"       "CCDC92"   
#>  [487] "ARHGEF11"  "TBX3"      "VCL"       "WIPF2"     "CEP97"     "ING4"     
#>  [493] "KLF16"     "SFR1"      "SNTB2"     "DGKQ"      "THRAP3"    "DSP"      
#>  [499] "GFPT2"     "SPRY4"     "ERBB2IP"   "C1ORF52"   "DTX2"      "PHC3"     
#>  [505] "BAIAP2"    "MIER3"     "SRA1"      "CCDC88A"   "KDM1A"     "NCOR2"    
#>  [511] "SFSWAP"    "HELLS"     "RALGAPA2"  "SBNO1"     "IRS2"      "SNAP23"   
#>  [517] "DMWD"      "NFATC2IP"  "PPP1R12C"  "SNIP1"     "PCGF6"     "BRCA1"    
#>  [523] "SAP30BP"   "LTV1"      "ZFR"       "NUP35"     "LTBP4"     "GNL3"     
#>  [529] "SUB1"      "GMEB2"     "TRIP12"    "ARFIP2"    "CTDP1"     "ITPR3"    
#>  [535] "EIF4G1"    "ERF"       "MDN1"      "ZNF330"    "YAP1"      "PCBP1"    
#>  [541] "COBLL1"    "PLEKHM1"   "KAT7"      "EPB41L1"   "STXBP5"    "KIF4A"    
#>  [547] "FKBP3"     "CASP8AP2"  "TPR"       "RBM6"      "ZCCHC9"    "CDC26"    
#>  [553] "TMPO"      "ASPSCR1"   "SNX17"     "WDR70"     "NSUN2"     "MIA3"     
#>  [559] "TRRAP"     "CDK18"     "SQSTM1"    "RANBP2"    "ERCC6L"    "SRSF11"   
#>  [565] "FAM207A"   "PRPF3"     "NCOR1"     "WDR20"     "ELMSAN1"   "EML4"     
#>  [571] "RNMT"      "MCM4"      "ETV3"      "TRIP10"    "ZDHHC5"    "PLCG1"    
#>  [577] "JADE3"     "RPRD1B"    "FHOD1"     "RBM7"      "CSTF3"     "HDAC4"    
#>  [583] "TSC2"      "STRIP1"    "TRIM2"     "FAT1"      "EIF3C"     "FAM92A1"  
#>  [589] "WDR55"     "ARHGAP6"   "ROCK2"     "BRD7"      "SPRY1"     "SGTA"     
#>  [595] "INTS12"    "PEAK1"     "ABI1"      "ETV6"      "BAIAP2L1"  "SPHK2"    
#>  [601] "CRTC3"     "SSBP3"     "PRKRA"     "DDX46"     "PNISR"     "NMNAT1"   
#>  [607] "SPIDR"     "NME2"      "RPL37"     "PRRC2A"    "NEK9"      "MRE11A"   
#>  [613] "IRS1"      "MED15"     "MAGI3"     "ARHGAP21"  "EXOC1"     "HNRNPK"   
#>  [619] "TSC22D4"   "NCOA5"     "FOXK1"     "RPL7"      "TRAF3IP1"  "SPAG9"    
#>  [625] "SVIL"      "LRP1"      "COIL"      "EMG1"      "ZAK"       "ATXN2"    
#>  [631] "CLIP1"     "CCNK"      "RRAD"      "VAMP8"     "RAD18"     "ZC3H11A"  
#>  [637] "CES5A"     "CLUH"      "TFIP11"    "TRIM28"    "SKA3"      "SLTM"     
#>  [643] "TRIOBP"    "SMARCC2"   "EPS15"     "MYO9B"     "THUMPD3"   "TOR1AIP1" 
#>  [649] "PITPNB"    "LSR"       "CDC42EP4"  "FLNC"      "KIFAP3"    "ZC3HAV1"  
#>  [655] "SALL1"     "KRT20"     "ATF7"      "SRP14"     "BET1"      "TOP1"     
#>  [661] "ARHGAP35"  "TUBA1B"    "FAM160B1"  "ARHGEF40"  "CAMK2G"    "LRRFIP2"  
#>  [667] "SMARCA4"   "AKAP13"    "SRSF2"     "RIPK1"     "BIN1"      "CDK12"    
#>  [673] "RBBP6"     "CCNL1"     "KRT18"     "STK24"     "YY1"       "SNX7"     
#>  [679] "NUP153"    "PTPN1"     "LMNA"      "MAP4"      "POF1B"     "REEP3"    
#>  [685] "DPF2"      "FAM91A1"   "RNF168"    "CPEB4"     "UBA2"      "RRP9"     
#>  [691] "SGSM3"     "STIM1"     "NUSAP1"    "MYBBP1A"   "USP10"     "CC2D1B"   
#>  [697] "CEP55"     "IGHMBP2"   "ZNF503"    "AKAP10"    "ARHGDIA"   "SIN3A"    
#>  [703] "IQSEC1"    "TBC1D25"   "TSC22D2"   "ARHGAP1"   "MTSS1"     "CKAP4"    
#>  [709] "PDAP1"     "SRRM1"     "PWWP2B"    "CAMSAP1"   "UBA1"      "SRM"      
#>  [715] "CEBPZ"     "WHSC1"     "EMD"       "CCNT1"     "PLEKHA1"   "RPTOR"    
#>  [721] "GIGYF2"    "SLC23A2"   "DUSP16"    "TBC1D4"    "PRKAB2"    "BRWD1"    
#>  [727] "SMCR8"     "FAM195A"   "DENND4C"   "PTPN12"    "HDGF"      "ANKRD17"  
#>  [733] "BAD"       "LBR"       "MTDH"      "POLR2A"    "MCM2"      "TMEM115"  
#>  [739] "PPP6R3"    "HSP90AB1"  "SF3B2"     "KPNA3"     "METTL1"    "CIC"      
#>  [745] "ABCF1"     "PRKD2"     "HDAC6"     "RB1CC1"    "PLEC"      "ITGB4"    
#>  [751] "PFKFB3"    "RSL1D1"    "LMO7"      "VAPB"      "SH3BP1"    "SRPK2"    
#>  [757] "PRRC2C"    "SOS1"      "CKAP5"     "GTF2F1"    "ZMYM4"     "FLNA"     
#>  [763] "UBE2T"     "RAB9A"     "SH3PXD2B"  "FOSL2"     "FNBP1L"    "PPP4R2"   
#>  [769] "UBA52"     "TNS3"      "DYNC1LI1"  "ARFGAP1"   "NUDC"      "CDC5L"    
#>  [775] "FAM83H"    "HNF1B"     "ERRFI1"    "SMG9"      "SUN1"      "MLX"      
#>  [781] "NFKB1"     "SSH3"      "CHD8"      "UFL1"      "BMS1"      "PDZD8"    
#>  [787] "LYSMD3"    "GOLGA5"    "UBAP1"     "ABI2"      "CDK1"      "WIZ"      
#>  [793] "F11R"      "EIF2AK3"   "NOL9"      "EGFR"      "VPRBP"     "TNKS1BP1" 
#>  [799] "MTFR1L"    "PPFIA1"    "ZCCHC8"    "HJURP"     "DHX16"     "PPP1R18"  
#>  [805] "DEPTOR"    "TPD52L2"   "EIF4EBP1"  "NUP133"    "AP3B1"     "PNN"      
#>  [811] "C12ORF10"  "TRIM24"    "INPP5E"    "ADD1"      "XRCC6"     "RFTN1"    
#>  [817] "LMNB1"     "SPTAN1"    "RFC1"      "EIF3B"     "LVRN"      "TCEAL5"   
#>  [823] "TLE6"      "YBX3"      "LIMK2"     "TRA2B"     "MAST4"     "YTHDF1"   
#>  [829] "CAP1"      "KLC1"      "RASA3"     "TOX4"      "MCM3"      "HTATSF1"  
#>  [835] "CHAMP1"    "WNK1"      "MARK2"     "MAPRE2"    "RAB11FIP5" "HDLBP"    
#>  [841] "CCT8"      "MKL2"      "DOCK5"     "C11ORF58"  "PPHLN1"    "OTUD7B"   
#>  [847] "GORASP2"   "RACGAP1"   "PBX2"      "NUP188"    "LYSMD2"    "TCIRG1"   
#>  [853] "NELFA"     "KIF23"     "FKBP15"    "GATAD2B"   "CUX1"      "CDC37"    
#>  [859] "TNS2"      "THUMPD1"   "PTPRJ"     "RBL1"      "LMBRD2"    "HN1"      
#>  [865] "SYNPO"     "FAM175A"   "CDCA3"     "LARP1"     "MFF"       "GOLGB1"   
#>  [871] "LIG3"      "SLC1A5"    "CYSRT1"    "ATXN2L"    "IWS1"      "APBB2"    
#>  [877] "EPS8L2"    "ZBED9"     "NUMA1"     "TAGLN2"    "SUPT5H"    "SLC16A10" 
#>  [883] "SPATS2"    "NOM1"      "SRSF10"    "AKT1"      "PLEKHA7"   "SMN1"     
#>  [889] "TLK1"      "LIPE"      "POLDIP3"   "NOLC1"     "SF3A1"     "OTUD4"    
#>  [895] "ETL4"      "MARK3"     "PSD4"      "NF1"       "MYO18A"    "UHRF1BP1L"
#>  [901] "EPHA2"     "MARCKS"    "NEDD4L"    "PJA1"      "KIAA1715"  "ANP32B"   
#>  [907] "ACACA"     "LRRC8A"    "ESF1"      "RABEPK"    "TJAP1"     "SPIRE2"   
#>  [913] "MAPK14"    "HIRIP3"    "CASP3"     "SLAIN2"    "NMT2"      "CASP7"    
#>  [919] "STK11IP"   "MYH10"     "DDX55"     "SLC35C2"   "NUP214"    "GPN1"     
#>  [925] "ZYX"       "AMPD2"     "MRPL23"    "RBM3"      "RSF1"      "PEA15"    
#>  [931] "CHEK1"     "CRIP2"     "TICRR"     "TCOF1"     "PIGB"      "TRIO"     
#>  [937] "PDIA6"     "TLK2"      "ZNRF2"     "NUP98"     "PRRC2B"    "PSIP1"    
#>  [943] "TMEM245"   "NUFIP1"    "RPL24"     "KIF20A"    "UBXN7"     "ZMYND8"   
#>  [949] "NOL4L"     "TXLNA"     "DIDO1"     "ZC3H8"     "NFX1"      "PLEKHG2"  
#>  [955] "ATG2B"     "LEMD3"     "SMARCC1"   "CBX4"      "YWHAE"     "NPAT"     
#>  [961] "FBXO30"    "RAB3IP"    "ACIN1"     "SIK3"      "UBAP2L"    "TP53BP1"  
#>  [967] "MKI67"     "KLC2"      "HP1BP3"    "EPB41L2"   "HNRNPA1"   "HDGFRP2"  
#>  [973] "MFAP1"     "TJP1"      "RRP1"      "KSR1"      "PDS5B"     "FAM63A"   
#>  [979] "TPX2"      "STRN"      "BCR"       "GPRC5C"    "MKL1"      "ZNF569"   
#>  [985] "AMPD3"     "TOM1"      "RPS10"     "SLC9A6"    "RBM39"     "ALS2"     
#>  [991] "PPIL4"     "HSP90AA1"  "NSFL1C"    "MTUS2"     "CHD1"      "AGFG1"    
#>  [997] "UBAP2"     "RABEP1"    "DDX51"     "PTMA"      "NUCKS1"    "BCL9L"    
#> [1003] "COL4A3BP"  "IVNS1ABP"  "RTKN"      "PKN2"      "PRR12"     "NIPBL"    
#> [1009] "PFAS"      "JAG1"      "SLC26A2"   "BNIP2"     "BICC1"     "ZCCHC6"   
#> [1015] "C8ORF33"   "CEP170B"   "PAXBP1"    "GBF1"      "ZW10"      "MPHOSPH10"
#> [1021] "IBTK"      "FAM193A"   "TULP3"     "RPS20"     "TP53BP2"   "DDX27"    
#> [1027] "RAB11FIP1" "MYH9"      "GRASP"     "KIF2C"     "TRAF7"     "PTPRC"    
#> [1033] "PICK1"     "XPO4"      "PLEKHA5"   "NOP2"      "WDR75"     "FXR2"     
#> [1039] "API5"      "CFL2"      "CFL1"      "SDC2"      "ZNF281"    "EHBP1L1"  
#> [1045] "MAP2K4"    "PKP4"      "PTPN21"    "SET"       "EIF4A3"    "SCRIB"    
#> [1051] "AEBP2"     "MAPK10"    "NUP50"     "SLC9A3R1"  "GMIP"      "HMGN1"    
#> [1057] "PPIP5K2"   "SUGP1"     "DPYSL2"    "CHTF18"    "HSPA4"     "HS1BP3"   
#> [1063] "RNF20"     "BOD1L1"    "AFTPH"     "EI24"      "PAPOLA"    "NFIC"     
#> [1069] "HMGA1"     "SERBP1"    "TAF3"      "PAN3"      "ZUFSP"     "MBD3"     
#> [1075] "TRAM1"     "PABPN1"    "SAV1"      "NECAP2"    "STMN1"     "ARHGAP5"  
#> [1081] "C2ORF49"   "RPS6KA3"   "MINK1"     "DNTTIP2"   "SLC20A2"   "GINS2"    
#> [1087] "FAM104A"   "CTNND1"    "R3HDM2"    "GIGYF1"    "AHCTF1"    "PID1"     
#> [1093] "PHLDB1"    "MELK"      "PRKAB1"    "FAM208A"   "FARP1"     "CALM2"    
#> [1099] "ZNF106"    "CTTN"      "LUZP1"     "ARRB1"     "TWISTNB"   "EPHB4"    
#> [1105] "TRMT1"     "SNTB1"     "SOD1"      "ZRANB3"    "MAVS"      "SLC7A7"   
#> [1111] "SUPT6H"    "CTAGE5"    "AHNAK"     "SORBS2"    "GPHN"      "ABLIM1"   
#> [1117] "PCNP"      "BMI1"      "VTI1B"     "TAB2"      "PDCL3"     "WASF2"    
#> [1123] "GRB7"      "ZFHX3"     "GIT1"      "CASC3"     "LARP7"     "CXORF23"  
#> [1129] "STK3"      "PPP1R10"   "SEC22B"    "OSBP"      "HN1L"      "VPS26B"   
#> [1135] "SRRM2"     "SPTBN1"    "RANBP3"    "SAFB2"     "BCL9"      "ZWINT"    
#> [1141] "ASAP2"     "SSFA2"     "SIK1"      "MCRS1"     "METAP2"    "SUFU"     
#> [1147] "LUC7L2"    "UGDH"      "FTSJ3"     "NMD3"      "RNF8"      "PARD6B"   
#> [1153] "PRPF38A"   "PPP1R12A"  "RBM15"     "TFE3"      "DCP2"      "SLK"      
#> [1159] "WDHD1"     "IFITM2"    "DDX42"     "ADRBK1"    "DOPEY1"    "BRAF"     
#> [1165] "TRAPPC10"  "HAUS6"     "DMXL1"     "HYPK"      "USP4"      "PDLIM7"   
#> [1171] "TMOD3"     "ARHGEF10L" "PEX19"     "EIF4ENIF1" "PEX14"     "SLC38A2"  
#> [1177] "SPECC1L"   "RBM8A"     "FRMD4B"    "SDPR"      "EIF5B"     "IRF2BPL"
```

``` r
data("example_gsea")
GSEA <- GSEAHarmonizome(pathways = pathways_list,
                        stats = gene_ranks,minSize = 10,maxSize = 500)
#> Carregando pacotes exigidos: fgsea
#> Warning in preparePathwaysAndStats(pathways, stats, minSize, maxSize, gseaParam, : There are ties in the preranked stats (0.09% of the list).
#> The order of those tied genes will be arbitrary, which may produce unexpected results.
#> Warning in preparePathwaysAndStats(pathways, stats, minSize, maxSize,
#> gseaParam, : There are duplicate gene names, fgsea may produce unexpected
#> results.

head(GSEA)
#>                                                                                                                                             pathway
#> 1: 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> 2:            10uM_erlotinib vs ctrl_KG-1 (Human) [22115753]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> 3:            10uM_gefitinib vs ctrl_KG-1 (Human) [22115753]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> 4:              4h_cisplatin vs ctrl_mESC (Mouse) [22006019]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> 5:            50nM_dasatinib vs ctrl_K562 (Human) [19651622]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#> 6:             5nM_dasatinib vs ctrl_K562 (Human) [19651622]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs
#>            pval         padj    log2err         ES        NES size
#> 1: 1.489295e-33 3.425378e-32 1.50926284  0.4545874  2.1283595 1049
#> 2: 8.467909e-01 8.467909e-01 0.05490737 -0.3858994 -0.6578715    3
#> 3: 8.467909e-01 8.467909e-01 0.05490737 -0.3858994 -0.6578715    3
#> 4: 5.114029e-12 2.940566e-11 0.88707499  0.4320662  1.9279317  441
#> 5: 6.241671e-04 1.305077e-03 0.47727082  0.4375812  1.6786553  104
#> 6: 5.988519e-03 9.838282e-03 0.40701792  0.4170298  1.5572539   88
#>                                 leadingEdge
#> 1:     LIPE,RPRD2,ZW10,LVRN,ARFGEF2,ZYX,...
#> 2:                        CTDSPL2,PTPN6,SYK
#> 3:                          PTPN6,COPS8,SYK
#> 4: MCM10,RRP7A,ZW10,KIDINS220,JAM2,RFX2,...
#> 5:   RPUSD2,PTRH1,TNK1,TTC25,PRKCB,SAFB,...
#> 6:    RPUSD2,PTRH1,PRKCB,RET,RCSD1,TNIK,...
```

### Gene set variation analysis

``` r
data("example_gsva")

GSVA <- GSVAHarmonizome(expr = example_expr,pathways = pathways_list)
#> Carregando pacotes exigidos: GSVA
#> Estimating GSVA scores for 23 gene sets.
#> Estimating ECDFs with Gaussian kernels
#>   |                                                                              |                                                                      |   0%  |                                                                              |===                                                                   |   4%  |                                                                              |======                                                                |   9%  |                                                                              |=========                                                             |  13%  |                                                                              |============                                                          |  17%  |                                                                              |===============                                                       |  22%  |                                                                              |==================                                                    |  26%  |                                                                              |=====================                                                 |  30%  |                                                                              |========================                                              |  35%  |                                                                              |===========================                                           |  39%  |                                                                              |==============================                                        |  43%  |                                                                              |=================================                                     |  48%  |                                                                              |=====================================                                 |  52%  |                                                                              |========================================                              |  57%  |                                                                              |===========================================                           |  61%  |                                                                              |==============================================                        |  65%  |                                                                              |=================================================                     |  70%  |                                                                              |====================================================                  |  74%  |                                                                              |=======================================================               |  78%  |                                                                              |==========================================================            |  83%  |                                                                              |=============================================================         |  87%  |                                                                              |================================================================      |  91%  |                                                                              |===================================================================   |  96%  |                                                                              |======================================================================| 100%
```

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-rouillard2016" class="csl-entry">

Rouillard, Andrew D., Gregory W. Gundersen, Nicolas F. Fernandez, Zichen
Wang, Caroline D. Monteiro, Michael G. McDermott, and Avi Ma’ayan. 2016.
“The Harmonizome: A Collection of Processed Datasets Gathered to Serve
and Mine Knowledge about Genes and Proteins.” *Database* 2016: baw100.
<https://doi.org/10.1093/database/baw100>.

</div>

</div>
