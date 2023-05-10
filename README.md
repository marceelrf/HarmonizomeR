
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
#> =>----------------------------- 4% | ETA: 42s ===>---------------------------
#> 9% | ETA: 25s ====>-------------------------- 13% | ETA: 18s
#> =====>------------------------- 17% | ETA: 18s =======>-----------------------
#> 22% | ETA: 16s ========>---------------------- 26% | ETA: 14s
#> =========>--------------------- 30% | ETA: 12s ==========>--------------------
#> 35% | ETA: 11s ============>------------------ 39% | ETA: 10s
#> =============>----------------- 43% | ETA: 9s ==============>----------------
#> 48% | ETA: 8s ================>-------------- 52% | ETA: 7s
#> =================>------------- 57% | ETA: 6s ==================>------------
#> 61% | ETA: 5s ====================>---------- 65% | ETA: 5s
#> =====================>--------- 70% | ETA: 4s ======================>--------
#> 74% | ETA: 4s =======================>------- 78% | ETA: 3s
#> =========================>----- 83% | ETA: 3s ==========================>----
#> 87% | ETA: 2s ===========================>--- 91% | ETA: 1s
#> =============================>- 96% | ETA: 1s
```

``` r
head(silacdrug_ds)
#> # A tibble: 6 x 3
#>   Code      name                                                          symbol
#>   <chr>     <chr>                                                         <chr> 
#> 1 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ MCM2  
#> 2 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ MKL1  
#> 3 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ RIF1  
#> 4 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ DCP2  
#> 5 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ BOD1L1
#> 6 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ CAST
```

## Enrichment analysis

### Over representation analysis (ORA)

``` r
genes <- c("CYP2D26","NCOA7","CCDC3","SNTG2","LIMK1","PPWD1","2900055J20RIK","GM839","HSPA12A","MTIF3","KDM2B",
           "FAM221A","GM19710","CCDC68","CNRIP1","GM7544","LGI2","CLIP3","GM9484","1700034J05RIK","RIPK2","DPF2","RPS6KA4","RUNX1","DNM1L","SGTA","PIP5K1B","MTA1","KIAA1524","NCOR2",
           "HSP90AB1","ARFIP2","DKC1","KMT2A","RPLP2","PLEC","HSP90AA1","PEAK1","ZDHHC5","TBC1D25")

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
#>    [1] "MCM2"      "MKL1"      "RIF1"      "DCP2"      "BOD1L1"    "CAST"     
#>    [7] "UBE2T"     "NFRKB"     "MAP4"      "MCM6"      "ACACA"     "WDR20"    
#>   [13] "ETV3"      "ANP32B"    "RFX1"      "TAF7"      "VPRBP"     "HMGA1"    
#>   [19] "ERCC6L"    "RNF20"     "TMEM63B"   "SH3KBP1"   "FAM160A2"  "AATF"     
#>   [25] "GTF2F1"    "ARGLU1"    "C8ORF33"   "PARD6B"    "CDC26"     "IFITM2"   
#>   [31] "NHSL1"     "NOLC1"     "SRGAP2"    "RBM8A"     "PTPRC"     "ATAD2"    
#>   [37] "EML4"      "MAP7D1"    "PAXBP1"    "KPNA3"     "HLA-A"     "LARP7"    
#>   [43] "KIF4A"     "ARHGAP6"   "RNF187"    "LRRFIP2"   "BCR"       "SNRNP200" 
#>   [49] "BRWD1"     "SLC4A4"    "PID1"      "MTUS1"     "DDX51"     "IKBKB"    
#>   [55] "USP10"     "ITPR3"     "PEA15"     "KANK1"     "PDS5B"     "SPEN"     
#>   [61] "RPS6KA3"   "NSUN2"     "NELFA"     "SFR1"      "HN1"       "SH3PXD2B" 
#>   [67] "FAM63A"    "RANBP2"    "ZNRF2"     "SF3B2"     "SUPT6H"    "IRF2BP1"  
#>   [73] "HTATSF1"   "CD2AP"     "ACTC1"     "PLEKHA1"   "TRIP10"    "CRTC3"    
#>   [79] "LTV1"      "MAPRE2"    "GPN1"      "TBC1D25"   "EIF3B"     "PCNP"     
#>   [85] "NMD3"      "ZNF608"    "SIK1"      "ING4"      "GINS2"     "PCBP1"    
#>   [91] "TMEM115"   "SLC16A10"  "GAPVD1"    "ARMC10"    "MLX"       "ZMYM4"    
#>   [97] "TRIP12"    "EAF1"      "DSP"       "DDX42"     "ALKBH5"    "CHD4"     
#>  [103] "CFL1"      "UBXN7"     "SNAP23"    "CEP170"    "NFKB1"     "SUGP1"    
#>  [109] "ZZZ3"      "PLEKHA6"   "EPS8L2"    "CBX4"      "TMEM176B"  "DBNL"     
#>  [115] "AKIRIN2"   "MAPK14"    "KRT18"     "PFKFB3"    "LARP4"     "WIPF2"    
#>  [121] "PITPNB"    "SIK2"      "PPIL4"     "NPAT"      "KIAA0430"  "ABL2"     
#>  [127] "KLHL6"     "DOCK1"     "HDLBP"     "ARHGAP5"   "WDR70"     "COBLL1"   
#>  [133] "TRRAP"     "ETV6"      "JUN"       "SIK3"      "YAP1"      "MINK1"    
#>  [139] "USP4"      "KNOP1"     "PRRC2B"    "NCOR1"     "FAM193A"   "EIF3C"    
#>  [145] "HNRNPLL"   "ZNF569"    "DSTN"      "ZC3HC1"    "GMEB2"     "SDPR"     
#>  [151] "TPX2"      "ANKRD17"   "CNPY4"     "NCOA5"     "MXRA8"     "C10ORF88" 
#>  [157] "C19ORF47"  "DTX2"      "SAMD4B"    "MTUS2"     "GAB1"      "ATXN2L"   
#>  [163] "SUN1"      "CDC37"     "MAST4"     "MKI67"     "HAUS6"     "ATG2B"    
#>  [169] "CUX1"      "REXO1"     "TNS3"      "MRPL23"    "TNS1"      "PDXDC1"   
#>  [175] "PLEKHA7"   "DDX20"     "EPB41L1"   "EIF4G1"    "DDX46"     "SYNRG"    
#>  [181] "ZCCHC11"   "FKBP15"    "NUCB1"     "WIBG"      "DHX16"     "THUMPD3"  
#>  [187] "UGDH"      "THUMPD1"   "API5"      "BNIP3"     "NMT1"      "HEATR3"   
#>  [193] "LMNA"      "UCK2"      "PNN"       "FBL"       "CAMK2G"    "HIRIP3"   
#>  [199] "FLRT1"     "SETD2"     "KAT7"      "RIPK1"     "RSF1"      "CTTN"     
#>  [205] "HMGXB4"    "BMS1"      "SLC9A3R1"  "BIRC6"     "DGKQ"      "LIG3"     
#>  [211] "AEBP2"     "CASP8AP2"  "PDIA6"     "SPAG9"     "TOP1"      "LPP"      
#>  [217] "CLSPN"     "FARP1"     "CDC5L"     "WHSC1"     "LATS1"     "LMBRD2"   
#>  [223] "STXBP5"    "PRRC2A"    "SHROOM3"   "RNASEH2A"  "CHD1"      "RANBP3"   
#>  [229] "WDHD1"     "PXN"       "ELF1"      "TMEM106B"  "SMARCC2"   "ZW10"     
#>  [235] "CALM2"     "EIF4G3"    "SLC38A2"   "DMWD"      "ABCF1"     "GPSM2"    
#>  [241] "CEP170B"   "KANK2"     "DDX55"     "RAB9A"     "BAZ2A"     "SRSF10"   
#>  [247] "KIAA1468"  "UBR4"      "SMARCAD1"  "IFITM3"    "PPFIA1"    "TNS2"     
#>  [253] "CTDP1"     "WBP11"     "RRP1"      "F11R"      "DAXX"      "PDCL3"    
#>  [259] "TOP2A"     "SNX17"     "GFPT2"     "KIFAP3"    "SLTM"      "EIF4H"    
#>  [265] "HYPK"      "SPIDR"     "POLA1"     "EMD"       "CDC42EP4"  "MDH1"     
#>  [271] "PEX14"     "RPRD1B"    "HNRNPA1"   "MLF2"      "SSFA2"     "KIF20A"   
#>  [277] "RALY"      "CENPV"     "FAM175A"   "MARK3"     "NME2"      "PARD3"    
#>  [283] "BCL9"      "YWHAE"     "PRKD3"     "SET"       "FRA10AC1"  "SLC9A6"   
#>  [289] "NUDC"      "EIF4EBP1"  "PEX1"      "TRIM24"    "CDK1"      "PDZD8"    
#>  [295] "CASC3"     "CLASP1"    "KRT8"      "IWS1"      "VCL"       "NCAPH"    
#>  [301] "WDR55"     "PUM2"      "U2AF2"     "CXADR"     "TMPO"      "R3HDM2"   
#>  [307] "SQSTM1"    "ARHGAP35"  "TCOF1"     "SCRIB"     "CRK"       "LGR5"     
#>  [313] "CTTNBP2NL" "LYSMD3"    "SMG9"      "CIC"       "SBNO1"     "PUM1"     
#>  [319] "C12ORF45"  "SPHK2"     "GOLGA3"    "CKAP4"     "KIF20B"    "RFX7"     
#>  [325] "PURB"      "GPHN"      "ZFR"       "NOL4L"     "ARFGEF1"   "CNPY2"    
#>  [331] "G3BP1"     "SIPA1L1"   "PRPF4B"    "CHEK1"     "WASF2"     "NAB2"     
#>  [337] "GRAMD3"    "CLUH"      "EIF2AK3"   "NPM1"      "GOLM1"     "ESAM"     
#>  [343] "RBM39"     "DNAJC2"    "KIF2C"     "ZRANB2"    "HNRNPUL2"  "RBM3"     
#>  [349] "UBAP2L"    "MARS"      "MKL2"      "CXORF23"   "MAP3K2"    "TJP1"     
#>  [355] "VIM"       "LYSMD2"    "MIA3"      "WIZ"       "PUS10"     "BAIAP2L1" 
#>  [361] "TSC22D2"   "IRF3"      "TRA2B"     "CAPZA2"    "SLK"       "RFC1"     
#>  [367] "ABLIM1"    "ARRB1"     "TAOK1"     "MBD5"      "DLGAP5"    "PHAX"     
#>  [373] "CD2BP2"    "ARHGAP32"  "DENND4C"   "HDAC4"     "TRIM28"    "MYH10"    
#>  [379] "TRIP11"    "NUFIP2"    "SLC4A1AP"  "TWISTNB"   "CAMSAP1"   "SRM"      
#>  [385] "TOX4"      "NUCKS1"    "BICC1"     "SIN3A"     "NEK9"      "UBR5"     
#>  [391] "APOBR"     "HS1BP3"    "BCKDHA"    "HNRNPA3"   "LRRC41"    "VAPB"     
#>  [397] "UBAP1"     "PRPF38A"   "DUSP16"    "CHD8"      "NCOR2"     "RNMT"     
#>  [403] "BMI1"      "OSBP"      "MAPK3"     "LMNB1"     "CTNNA1"    "ZNF106"   
#>  [409] "SNIP1"     "ADD1"      "N4BP2L2"   "PPP2R5D"   "RPL24"     "IRS1"     
#>  [415] "SPRY4"     "FAM91A1"   "TTC7A"     "STK11IP"   "RICTOR"    "CGN"      
#>  [421] "PAN3"      "ZCCHC9"    "INTS12"    "NASP"      "POLDIP3"   "TMSB10"   
#>  [427] "KIF23"     "SKA3"      "PRRC2C"    "CES5A"     "TTI1"      "MTSS1"    
#>  [433] "ARHGDIA"   "UFL1"      "INPP5E"    "ZCCHC8"    "RBBP6"     "SMN1"     
#>  [439] "STAMBPL1"  "C17ORF49"  "UBA2"      "FKBP3"     "MAP3K3"    "KMT2A"    
#>  [445] "PRUNE2"    "ZC3HAV1"   "MEPCE"     "STRIP1"    "FAM122A"   "MTHFD1"   
#>  [451] "CAMSAP2"   "PCM1"      "HCFC1"     "PSMF1"     "TAF3"      "CDKN2AIP" 
#>  [457] "CBX3"      "PTPN1"     "C12ORF10"  "CCDC88A"   "TOR1AIP1"  "CLIP1"    
#>  [463] "ACLY"      "IRS2"      "MDC1"      "UACA"      "IRF2BP2"   "DKC1"     
#>  [469] "RPL37"     "FBXO30"    "CEP97"     "SLC35C2"   "TNKS1BP1"  "PHLDB1"   
#>  [475] "DENND5B"   "SRSF2"     "PSRC1"     "SRRM1"     "SLC16A1"   "AAK1"     
#>  [481] "ZMYND8"    "TRIOBP"    "IRF2BPL"   "CWC27"     "RNF168"    "KIAA1715" 
#>  [487] "RPLP2"     "MCM4"      "FNBP1L"    "APRT"      "CNOT3"     "ATG16L1"  
#>  [493] "QARS"      "ARFGAP2"   "RBL1"      "ABI2"      "KDM1A"     "CC2D1B"   
#>  [499] "EIF4A3"    "VTI1B"     "REPS1"     "ABI1"      "AHCTF1"    "AKT1"     
#>  [505] "FXR1"      "SH2B1"     "PBX2"      "HSPA4"     "RPS3"      "FAM195A"  
#>  [511] "MFF"       "RSL1D1"    "CHTF18"    "EPB41"     "RBMX"      "KIF5B"    
#>  [517] "PLCH1"     "MTDH"      "RPL30"     "SNX5"      "DPF2"      "NUP188"   
#>  [523] "TRIO"      "PSMD4"     "ENSA"      "DIDO1"     "DNTTIP2"   "PELP1"    
#>  [529] "EIF3D"     "NMT2"      "HSF1"      "TRA2A"     "ARMC1"     "PTPRG"    
#>  [535] "NOP56"     "ZNF598"    "ZNF330"    "DDX1"      "FTSJ3"     "SMCR8"    
#>  [541] "GATAD2B"   "ETL4"      "MAP2K4"    "BRAF"      "ATRX"      "RANBP9"   
#>  [547] "C7ORF43"   "RB1CC1"    "FOXK1"     "PLEKHG2"   "MTFR1L"    "MYBBP1A"  
#>  [553] "ATF7"      "CDK4"      "PLEKHA5"   "FHOD1"     "ASUN"      "TP53BP1"  
#>  [559] "SGSM3"     "LASP1"     "ARHGEF40"  "GOLGB1"    "FAM92A1"   "NOL9"     
#>  [565] "STK3"      "HIST1H1C"  "ADRBK1"    "PLXNB3"    "DLGAP4"    "LSM14B"   
#>  [571] "RPL13"     "SAFB2"     "PML"       "SRRT"      "TBX3"      "PWWP2B"   
#>  [577] "USP39"     "OTUD7B"    "ALAD"      "RBM6"      "UBA52"     "NBN"      
#>  [583] "POF1B"     "HMGN1"     "ITPKB"     "CCNT1"     "TJP2"      "ZBED9"    
#>  [589] "BAG3"      "RABEPK"    "PCBP2"     "DST"       "AFTPH"     "PTPN21"   
#>  [595] "RAVER1"    "SRP14"     "PHC3"      "TRIP6"     "SLC23A2"   "TLE6"     
#>  [601] "AARSD1"    "BCL9L"     "RASA3"     "ZNF503"    "UBAP2"     "BAIAP2"   
#>  [607] "SOS1"      "IGHMBP2"   "PPIP5K2"   "ZMYM2"     "DOCK5"     "MYH9"     
#>  [613] "VPS51"     "SLC1A5"    "NFATC2IP"  "APLF"      "ZCCHC6"    "ZNF462"   
#>  [619] "CSNK1E"    "PSD4"      "AMPD3"     "TMOD3"     "NIPBL"     "EPS15"    
#>  [625] "SFSWAP"    "ZFC3H1"    "HNRNPA2B1" "ARL6IP4"   "MED14"     "ZUFSP"    
#>  [631] "TAGLN2"    "NOL10"     "RAD18"     "FAM104A"   "SNX2"      "RSRC2"    
#>  [637] "BCLAF1"    "AGFG1"     "PRPF40A"   "ZNF7"      "ZFHX3"     "LVRN"     
#>  [643] "CGNL1"     "SAV1"      "MTF1"      "LTBP4"     "MTMR3"     "AKAP13"   
#>  [649] "LRP1"      "CNOT2"     "HDAC6"     "DNM1L"     "CRTC2"     "NUMA1"    
#>  [655] "RBM25"     "SLIRP"     "C11ORF58"  "PSMD11"    "CTIF"      "FAM160B1" 
#>  [661] "NIFK"      "REEP3"     "RAI14"     "PLEKHG3"   "RPS2"      "NT5C3A"   
#>  [667] "JADE3"     "SRPK2"     "SORD"      "SPTBN1"    "NEDD4"     "POLR2A"   
#>  [673] "SLC26A2"   "SMTN"      "XPO4"      "PRPF3"     "TAB2"      "SLAIN2"   
#>  [679] "TMCC2"     "FAT1"      "RTN4"      "PLEC"      "UHRF1BP1L" "NOM1"     
#>  [685] "STK4"      "SSBP3"     "MED1"      "ARHGEF10L" "PA2G4"     "HJURP"    
#>  [691] "PJA2"      "MLLT6"     "UTP18"     "NFX1"      "EDC4"      "MAST2"    
#>  [697] "RBM7"      "CDCA2"     "ADNP"      "C2ORF44"   "FLNC"      "COL4A3BP" 
#>  [703] "TCEB3"     "TPR"       "CCNL2"     "RFTN1"     "MARK2"     "MRE11A"   
#>  [709] "CAP1"      "DNAJC5"    "EIF4ENIF1" "FAM208A"   "NR2C2AP"   "BET1"     
#>  [715] "KANSL1"    "TCEAL5"    "ARHGEF11"  "LUZP1"     "RPS20"     "PRKAB2"   
#>  [721] "CTNNB1"    "RAB11FIP1" "SEC22B"    "THRAP3"    "RAB3GAP1"  "RIN2"     
#>  [727] "APBB2"     "BRD7"      "YY1"       "VPS26B"    "SRSF11"    "RRAD"     
#>  [733] "HNRNPH1"   "PDCD4"     "EPHB4"     "ESF1"      "SRA1"      "ZC3H11A"  
#>  [739] "UBE2O"     "TCF4"      "EPS15L1"   "CTR9"      "PTMA"      "SPRY1"    
#>  [745] "SPIRE2"    "DYNC1LI1"  "NUP214"    "NUP93"     "SPATA13"   "GIT1"     
#>  [751] "PPP1R13L"  "NMNAT1"    "MYO18A"    "TJAP1"     "MCRS1"     "TRIM2"    
#>  [757] "RABEP1"    "STMN1"     "SMAP2"     "NAV1"      "EIF2B5"    "PLCG1"    
#>  [763] "TFE3"      "MYO1E"     "EHBP1L1"   "CDCA3"     "CEBPZ"     "C2ORF49"  
#>  [769] "ARPC1B"    "ARFIP2"    "PHF14"     "PPHLN1"    "INTS6"     "WDR62"    
#>  [775] "RAB11FIP5" "SLMAP"     "PLCB3"     "CHAF1B"    "KLC2"      "ANAPC1"   
#>  [781] "PDLIM7"    "DOCK7"     "C5ORF30"   "NEDD4L"    "TSC2"      "RAPGEF3"  
#>  [787] "OPTN"      "SPECC1L"   "ROCK2"     "TCF20"     "PVRL1"     "ZYX"      
#>  [793] "NOC2L"     "TRAF7"     "NFIC"      "ERF"       "SGTA"      "AP3B1"    
#>  [799] "TRAPPC8"   "CBX8"      "WDR43"     "ULK1"      "SPTAN1"    "ATXN2"    
#>  [805] "EGFR"      "ZC3H13"    "TRMT1"     "HSP90AA1"  "TPD52L2"   "CYLD"     
#>  [811] "WNK1"      "TRAM1"     "ARHGEF7"   "IBTK"      "SMEK1"     "ARFIP1"   
#>  [817] "CCT8"      "PRR12"     "KSR1"      "CDC42EP5"  "EI24"      "SSH3"     
#>  [823] "SALL1"     "CHERP"     "CYSRT1"    "LIMK2"     "ZAK"       "NCL"      
#>  [829] "URI1"      "HNRNPK"    "BSG"       "PIGB"      "JAG1"      "HNRNPAB"  
#>  [835] "DOPEY1"    "ERBB2IP"   "RPS10"     "ARID4A"    "DIP2B"     "TSC22D4"  
#>  [841] "PJA1"      "PKP4"      "IVNS1ABP"  "PEX19"     "KLC3"      "PCGF6"    
#>  [847] "TULP3"     "TLK1"      "DMXL1"     "HDGFRP2"   "CCNK"      "RBM33"    
#>  [853] "CASP7"     "ZC3H8"     "TUBA1B"    "USP15"     "TBC1D4"    "TFIP11"   
#>  [859] "PIKFYVE"   "RAB7A"     "SAP30BP"   "IFI35"     "CDC42EP1"  "HMHA1"    
#>  [865] "FNBP4"     "PSIP1"     "PDAP1"     "FBXW8"     "NEO1"      "KIAA1598" 
#>  [871] "STRN"      "PHLDB2"    "OTUD4"     "ARHGAP21"  "MCM3"      "GRASP"    
#>  [877] "BIN1"      "CASP3"     "TMEM230"   "GCFC2"     "WDR75"     "PTPN12"   
#>  [883] "HNRNPU"    "NUP35"     "HN1L"      "ARFGAP1"   "FAM76B"    "YBX1"     
#>  [889] "METTL1"    "STON1"     "SOD1"      "SF3A1"     "PEAK1"     "DTD1"     
#>  [895] "RPS6KA4"   "TBC1D1"    "FOSL2"     "SH3BP1"    "HSPB8"     "AKAP10"   
#>  [901] "MARCKS"    "CHD2"      "PPP1R12C"  "TSR3"      "AHNAK"     "EEF2"     
#>  [907] "STIM1"     "MYO9B"     "EPN3"      "CTAGE5"    "UBE2J1"    "ZRANB3"   
#>  [913] "CKAP2"     "LMO7"      "SNX7"      "SDC2"      "POLA2"     "PAWR"     
#>  [919] "TCIRG1"    "PPP1R12A"  "SDC1"      "LUC7L2"    "EIF4B"     "RBM10"    
#>  [925] "SUB1"      "IFIH1"     "CSTF3"     "RPL7"      "NUP153"    "HP1BP3"   
#>  [931] "KIAA1522"  "DPYSL2"    "LEO1"      "SNX16"     "PALLD"     "NUP133"   
#>  [937] "AKT1S1"    "BCL2L13"   "MYC"       "ARFGEF2"   "ESYT2"     "LBR"      
#>  [943] "BCAR1"     "ARHGAP1"   "CHAMP1"    "TFEB"      "CDK18"     "GMIP"     
#>  [949] "SF3B1"     "NCOA3"     "LRP4"      "SNTB2"     "RACGAP1"   "MIER3"    
#>  [955] "EIF5B"     "ASAP1"     "MAVS"      "RPS17"     "FAM83H"    "PABPN1"   
#>  [961] "PRKAB1"    "NECAP2"    "ASAP2"     "RBM17"     "SLC4A7"    "TDP1"     
#>  [967] "ZC3H14"    "RRP9"      "COIL"      "PLEKHM1"   "GRB7"      "CTNND1"   
#>  [973] "ASPSCR1"   "NCAPD2"    "CRIP2"     "YWHAZ"     "YBX3"      "GNL3"     
#>  [979] "CDK17"     "RIN1"      "TXNL1"     "RPL6"      "SLC33A1"   "TMEM245"  
#>  [985] "NUP98"     "DEPTOR"    "LSR"       "FAM207A"   "RAD51AP1"  "YTHDC2"   
#>  [991] "FXR2"      "HDGF"      "SRRM2"     "EIF6"      "MDN1"      "CD44"     
#>  [997] "ATF2"      "CLUAP1"    "MED15"     "C2CD5"     "INCENP"    "PHACTR4"  
#> [1003] "ACIN1"     "CPD"       "SORBS2"    "YTHDF1"    "STRN3"     "OSBPL11"  
#> [1009] "ZZEF1"     "EIF2S2"    "BNIP2"     "RANGAP1"   "TXLNA"     "LIMD1"    
#> [1015] "TRAF3IP1"  "SPRED1"    "NCBP1"     "RPTOR"     "FEZ2"      "MPHOSPH10"
#> [1021] "PPP1R18"   "DDX27"     "SMARCC1"   "RBM15"     "CDV3"      "AMPD2"    
#> [1027] "MORC3"     "NELFE"     "XRCC6"     "MFAP1"     "CFDP1"     "HCK"      
#> [1033] "EIF3J"     "EPB41L2"   "BAD"       "PPP6R3"    "SYNE2"     "LIPE"     
#> [1039] "METAP2"    "PAPOLA"    "PRKD2"     "SLC7A7"    "NF1"       "NSFL1C"   
#> [1045] "RHBDF2"    "SH3BP4"    "NDRG3"     "TFAP4"     "GTF3C4"    "ADD3"     
#> [1051] "STRN4"     "PRKRA"     "SUPT5H"    "ARHGEF28"  "TRAPPC10"  "PFAS"     
#> [1057] "AGAP1"     "GBF1"      "CEP55"     "BRCA1"     "RALGAPA2"  "PPFIBP1"  
#> [1063] "INO80C"    "PRKAA1"    "CFL2"      "SHC1"      "TICRR"     "LEMD2"    
#> [1069] "UTP15"     "SPATS2"    "UBA1"      "CCDC92"    "ETHE1"     "PAK2"     
#> [1075] "PKN2"      "TAB3"      "ELMSAN1"   "MAP4K4"    "CDK16"     "KIF3A"    
#> [1081] "SLC20A2"   "PNISR"     "MLLT4"     "CBL"       "RAB3IP"    "MAPK10"   
#> [1087] "SUFU"      "RTKN"      "CBX5"      "TP53BP2"   "NVL"       "SYNPO"    
#> [1093] "BRD8"      "HNF1B"     "SMARCA4"   "ERRFI1"    "SCAF4"     "MUS81"    
#> [1099] "MBD3"      "ZWINT"     "PTPRJ"     "NUFIP1"    "EML3"      "C1ORF52"  
#> [1105] "RPS6KA1"   "ZFP36L1"   "VAMP8"     "GIGYF1"    "KIF21A"    "ZDHHC5"   
#> [1111] "NUP205"    "EXOC1"     "USP48"     "EMG1"      "FRMD4B"    "GTSE1"    
#> [1117] "CDK12"     "TLK2"      "MAP1S"     "SVIL"      "CCNL1"     "MOB1B"    
#> [1123] "GIGYF2"    "TMEM55A"   "MELK"      "LEMD3"     "ZNF687"    "NUSAP1"   
#> [1129] "RBM14"     "HNRNPC"    "SMG6"      "FAF1"      "GORASP2"   "PPP1R10"  
#> [1135] "NUP50"     "GOLGA5"    "SNTB1"     "LLPH"      "CKAP5"     "ZNF281"   
#> [1141] "NOP2"      "GPRC5C"    "DNMT1"     "DUSP7"     "KLF16"     "LRRFIP1"  
#> [1147] "FLNA"      "HELLS"     "ALS2"      "CHFR"      "MATR3"     "NPM3"     
#> [1153] "SH3GL1"    "CPEB4"     "LARP1"     "CCDC43"    "SSB"       "IQSEC1"   
#> [1159] "RNF8"      "KRT20"     "MAPK1"     "PICK1"     "MED24"     "EIF1"     
#> [1165] "TOM1"      "LUC7L"     "PCIF1"     "TTLL12"    "RPRD2"     "CACTIN"   
#> [1171] "LRRC8A"    "FAM195B"   "EPHA2"     "MAGI3"     "KDM3B"     "KLC1"     
#> [1177] "ITGB4"     "STK24"     "PPP4R2"    "MTA3"      "SERBP1"    "HSP90AB1"
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
#> 1: 9.972618e-34 2.293702e-32 1.50926284  0.4545874  2.1288230 1049
#> 2: 8.549784e-01 8.549784e-01 0.05652995 -0.3858994 -0.6617586    3
#> 3: 8.549784e-01 8.549784e-01 0.05652995 -0.3858994 -0.6617586    3
#> 4: 1.382749e-12 7.950804e-12 0.91011973  0.4320662  1.9248869  441
#> 5: 1.013381e-03 1.942313e-03 0.45505987  0.4375812  1.6648528  104
#> 6: 3.183163e-03 4.880850e-03 0.43170770  0.4170298  1.5587777   88
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

## Funding

The authors thanks [FAPESP](https://fapesp.br/)(n 2018/05731-7) for the
funding.

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
