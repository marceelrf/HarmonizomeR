
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Harmonizome

<!-- badges: start -->
<!-- badges: end -->

The goal of `{Harmonizome}` is to provide a fast interface to download
and perform functional and gene set enrichment analysis from the
[Harmonizome](https://maayanlab.cloud/Harmonizome/) database (Rouillard
et al. 2016).

## Installation

You can install the development version of `{Harmonizome}` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("marceelrf/Harmonizome")
```

## Example

The function `show_dataset_collection()` is used to check all available
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
using the code **silacdrug** in the function `get_geneset()`.

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
#> =>----------------------------- 4% | ETA: 40s ===>---------------------------
#> 9% | ETA: 26s ====>-------------------------- 13% | ETA: 19s
#> =====>------------------------- 17% | ETA: 19s =======>-----------------------
#> 22% | ETA: 16s ========>---------------------- 26% | ETA: 16s
#> =========>--------------------- 30% | ETA: 14s ==========>--------------------
#> 35% | ETA: 12s ============>------------------ 39% | ETA: 11s
#> =============>----------------- 43% | ETA: 10s ==============>----------------
#> 48% | ETA: 9s ================>-------------- 52% | ETA: 8s
#> =================>------------- 57% | ETA: 7s ==================>------------
#> 61% | ETA: 7s ====================>---------- 65% | ETA: 6s
#> =====================>--------- 70% | ETA: 5s ======================>--------
#> 74% | ETA: 4s =======================>------- 78% | ETA: 4s
#> =========================>----- 83% | ETA: 3s ==========================>----
#> 87% | ETA: 2s ===========================>--- 91% | ETA: 1s
#> =============================>- 96% | ETA: 1s
```

``` r
head(silacdrug_ds)
#> # A tibble: 6 x 3
#>   Code      name                                                          symbol
#>   <chr>     <chr>                                                         <chr> 
#> 1 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ DUSP7 
#> 2 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ RAD51~
#> 3 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ DDX27 
#> 4 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ TJAP1 
#> 5 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ BCL9L 
#> 6 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ RPS3
```

## Enrichment analysis

### Over representation analysis (ORA)

To perform the ORA the function `EnrichHarmonizome()` uses the
`{clusterProfiler}` package (Wu et al. 2021).

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
named list. The function `geneset_to_list()` handle with this task.

The function `GSEAHarmonizome()` uses the `{fgsea}` package to compute
the GSEA algorithm (Korotkevich, Sukhov, and Sergushichev 2019;
Subramanian et al. 2005; Mootha et al. 2003).

``` r
pathways_list <- geneset_to_list(tbl = silacdrug_ds)

pathways_list[1]
#> $`10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs`
#>    [1] "DUSP7"     "RAD51AP1"  "DDX27"     "TJAP1"     "BCL9L"     "RPS3"     
#>    [7] "SOD1"      "FAM104A"   "TMEM63B"   "VAPB"      "FNBP1L"    "UBE2T"    
#>   [13] "EIF4G3"    "ATG2B"     "PARD6B"    "WDR20"     "PHF14"     "FAM76B"   
#>   [19] "NMNAT1"    "PKP4"      "PXN"       "RBM3"      "FEZ2"      "ARFGAP2"  
#>   [25] "PPP1R13L"  "PRKD2"     "MAP4K4"    "OTUD4"     "DNAJC5"    "YTHDF1"   
#>   [31] "ENSA"      "RRP1"      "DPYSL2"    "MTFR1L"    "PLCB3"     "CBX3"     
#>   [37] "RIN1"      "TFE3"      "AATF"      "CASC3"     "TNKS1BP1"  "CDKN2AIP" 
#>   [43] "VPS26B"    "DTX2"      "CDK16"     "SLC16A1"   "AAK1"      "SCRIB"    
#>   [49] "TJP1"      "NUDC"      "GIT1"      "PPP1R12C"  "LRP1"      "NUP93"    
#>   [55] "TAF3"      "HNRNPUL2"  "LIMD1"     "LMO7"      "PKN2"      "DOPEY1"   
#>   [61] "KDM3B"     "ING4"      "CAMK2G"    "ITPKB"     "IRS1"      "RRAD"     
#>   [67] "BMS1"      "LARP4"     "PSRC1"     "EIF3D"     "MTA3"      "PWWP2B"   
#>   [73] "PCGF6"     "AGFG1"     "EMD"       "TMEM245"   "ATRX"      "INTS6"    
#>   [79] "CEP97"     "ZNF462"    "MYO1E"     "UBE2O"     "HNRNPK"    "ITPR3"    
#>   [85] "FRMD4B"    "CSTF3"     "APOBR"     "GORASP2"   "MPHOSPH10" "CTNNB1"   
#>   [91] "NFRKB"     "BRCA1"     "LIG3"      "ZCCHC11"   "OSBP"      "ERRFI1"   
#>   [97] "LYSMD3"    "HMHA1"     "CTAGE5"    "TRA2A"     "IRF3"      "MAPRE2"   
#>  [103] "SMARCA4"   "PRPF4B"    "RHBDF2"    "SEC22B"    "EIF2B5"    "CCNL2"    
#>  [109] "PLCG1"     "NASP"      "POLA2"     "YWHAE"     "CLUH"      "EIF4B"    
#>  [115] "CACTIN"    "GINS2"     "BRAF"      "REXO1"     "ARMC1"     "DNAJC2"   
#>  [121] "AKT1S1"    "BSG"       "MCM3"      "INCENP"    "UBAP2L"    "CHEK1"    
#>  [127] "EAF1"      "SET"       "SMG9"      "MARCKS"    "ZNF569"    "TOP1"     
#>  [133] "MAP7D1"    "SH3BP1"    "SORD"      "IWS1"      "RSRC2"     "CDC42EP5" 
#>  [139] "RTN4"      "SRSF10"    "ZCCHC9"    "NAB2"      "DDX55"     "UTP15"    
#>  [145] "TULP3"     "SORBS2"    "KIF5B"     "CD2BP2"    "FKBP3"     "SIK3"     
#>  [151] "TMCC2"     "SMEK1"     "FAM83H"    "RABEP1"    "CEP170B"   "CKAP5"    
#>  [157] "NPM1"      "USP4"      "NPM3"      "KIF3A"     "REPS1"     "DOCK5"    
#>  [163] "RPS2"      "SPATA13"   "CLASP1"    "RPS20"     "SALL1"     "NUCKS1"   
#>  [169] "BCKDHA"    "FBXW8"     "CDCA3"     "MAPK3"     "FHOD1"     "NFATC2IP" 
#>  [175] "JUN"       "EPS15L1"   "CGNL1"     "ANP32B"    "HP1BP3"    "CDC42EP1" 
#>  [181] "TMEM55A"   "ATF2"      "NEK9"      "NUP133"    "RAD18"     "NFIC"     
#>  [187] "API5"      "TOR1AIP1"  "AFTPH"     "MAP3K2"    "SDC1"      "GOLGA5"   
#>  [193] "TMEM106B"  "RPLP2"     "CES5A"     "SHC1"      "CCNL1"     "PPP1R18"  
#>  [199] "EHBP1L1"   "PRUNE2"    "GMEB2"     "ARFIP1"    "SGTA"      "MCM2"     
#>  [205] "TRIP6"     "ZNF598"    "TXLNA"     "TNS2"      "RRP9"      "CC2D1B"   
#>  [211] "ASAP1"     "FLNC"      "TRIM2"     "SVIL"      "ZZEF1"     "SLC35C2"  
#>  [217] "ZZZ3"      "PDAP1"     "ZAK"       "NT5C3A"    "MKI67"     "DDX42"    
#>  [223] "FAM63A"    "KLC1"      "PDS5B"     "SUFU"      "NCOR1"     "HNRNPH1"  
#>  [229] "LPP"       "PTMA"      "ARHGEF11"  "VPS51"     "ARID4A"    "LARP1"    
#>  [235] "ASPSCR1"   "ZNF503"    "RBM10"     "MTSS1"     "SNX7"      "NUP35"    
#>  [241] "PRRC2A"    "PHACTR4"   "ESYT2"     "TRAF7"     "LYSMD2"    "C5ORF30"  
#>  [247] "MED14"     "HLA-A"     "WNK1"      "PHC3"      "MCRS1"     "DAXX"     
#>  [253] "CRIP2"     "NELFA"     "ZMYM4"     "AKT1"      "ETHE1"     "SNX2"     
#>  [259] "NCOA5"     "TDP1"      "PPP2R5D"   "NOP56"     "PBX2"      "EPB41L1"  
#>  [265] "C7ORF43"   "EIF5B"     "TRAPPC10"  "HMGXB4"    "NUP153"    "RPL37"    
#>  [271] "RBM15"     "ARHGEF7"   "TRAPPC8"   "SUN1"      "PML"       "FAM208A"  
#>  [277] "PSMD11"    "ATG16L1"   "ESF1"      "RIN2"      "SHROOM3"   "SAFB2"    
#>  [283] "DIP2B"     "CUX1"      "ALKBH5"    "XPO4"      "SYNRG"     "SLC20A2"  
#>  [289] "ABCF1"     "CBL"       "SPHK2"     "GCFC2"     "TCIRG1"    "CRTC3"    
#>  [295] "ATXN2"     "AEBP2"     "DNMT1"     "CALM2"     "STK3"      "RBM8A"    
#>  [301] "ASUN"      "DDX51"     "PAK2"      "MOB1B"     "PRPF40A"   "CCNK"     
#>  [307] "TMPO"      "DSTN"      "HTATSF1"   "TTC7A"     "BCR"       "CBX4"     
#>  [313] "NUCB1"     "IKBKB"     "TSC22D2"   "SPRED1"    "KRT18"     "STMN1"    
#>  [319] "SMG6"      "KIF23"     "NOL4L"     "TAB2"      "MAST2"     "DEPTOR"   
#>  [325] "LGR5"      "THUMPD1"   "DLGAP5"    "MARK3"     "MRE11A"    "ARHGAP6"  
#>  [331] "CASP7"     "RPL30"     "POLR2A"    "MYH10"     "PHLDB2"    "POF1B"    
#>  [337] "TRA2B"     "GRASP"     "AGAP1"     "SFR1"      "SNAP23"    "PLEKHA7"  
#>  [343] "UCK2"      "STRN4"     "IRF2BP1"   "SSBP3"     "WIBG"      "BOD1L1"   
#>  [349] "C2ORF44"   "KIF2C"     "PAPOLA"    "SQSTM1"    "HMGN1"     "LRRC8A"   
#>  [355] "HNRNPLL"   "SMAP2"     "NUSAP1"    "C17ORF49"  "PRKD3"     "RPL7"     
#>  [361] "DCP2"      "ARHGDIA"   "TAOK1"     "YWHAZ"     "SUPT5H"    "LEO1"     
#>  [367] "ABL2"      "NOL9"      "USP48"     "HEATR3"    "USP10"     "SSB"      
#>  [373] "HDAC6"     "CLIP1"     "ALAD"      "MIER3"     "FKBP15"    "ERCC6L"   
#>  [379] "REEP3"     "ESAM"      "CDC42EP4"  "UBAP1"     "CKAP2"     "BAD"      
#>  [385] "WDR70"     "KLC2"      "GAB1"      "PAWR"      "CPD"       "ZNF106"   
#>  [391] "SDPR"      "GNL3"      "NUP214"    "LRRC41"    "RNF187"    "PDCD4"    
#>  [397] "SAV1"      "TRRAP"     "ZBED9"     "OSBPL11"   "SLC33A1"   "IRS2"     
#>  [403] "MKL1"      "NUP98"     "CDC5L"     "STRIP1"    "PCIF1"     "OPTN"     
#>  [409] "MBD5"      "TRIM24"    "SLAIN2"    "NME2"      "MDC1"      "CAPZA2"   
#>  [415] "KLC3"      "RPL6"      "MAVS"      "RBM33"     "ZCCHC6"    "TRIM28"   
#>  [421] "EIF4G1"    "VIM"       "MTMR3"     "EML4"      "ELF1"      "HN1"      
#>  [427] "RFX1"      "GTF2F1"    "SF3B2"     "SIK1"      "AMPD2"     "KIF20B"   
#>  [433] "PPIP5K2"   "CCT8"      "VCL"       "KRT20"     "LTV1"      "NUFIP2"   
#>  [439] "SPECC1L"   "SRRT"      "KIFAP3"    "MYO18A"    "FNBP4"     "PVRL1"    
#>  [445] "NMD3"      "SLTM"      "SLC26A2"   "CHAF1B"    "PCBP2"     "UBA52"    
#>  [451] "SRP14"     "FAM193A"   "FRA10AC1"  "RNMT"      "BAG3"      "ABI2"     
#>  [457] "WHSC1"     "NEO1"      "NOM1"      "ETL4"      "RBM6"      "PNISR"    
#>  [463] "MTDH"      "WIZ"       "BICC1"     "FARP1"     "HNRNPC"    "ZRANB2"   
#>  [469] "ZWINT"     "CKAP4"     "HSF1"      "DOCK1"     "CHERP"     "POLDIP3"  
#>  [475] "MLF2"      "MAP2K4"    "LIMK2"     "DIDO1"     "TRIOBP"    "TRAF3IP1" 
#>  [481] "C2ORF49"   "RANBP9"    "TPD52L2"   "CFDP1"     "UTP18"     "SAMD4B"   
#>  [487] "ABLIM1"    "SOS1"      "APRT"      "RANGAP1"   "SRRM1"     "ZNF330"   
#>  [493] "PPP1R10"   "C12ORF45"  "DMXL1"     "HNRNPAB"   "PRRC2C"    "CDK17"    
#>  [499] "DPF2"      "LEMD2"     "CNOT2"     "MYC"       "RNF20"     "NFKB1"    
#>  [505] "STRN"      "ADD1"      "CHD4"      "GBF1"      "ROCK2"     "CDK1"     
#>  [511] "SPATS2"    "NUP188"    "RASA3"     "IFITM3"    "RAB11FIP1" "SSH3"     
#>  [517] "ZNRF2"     "HSPB8"     "RAI14"     "RAB3GAP1"  "MCM6"      "AKAP10"   
#>  [523] "XRCC6"     "STIM1"     "SYNPO"     "GIGYF2"    "DYNC1LI1"  "PTPN12"   
#>  [529] "SMARCC2"   "ZNF7"      "STK4"      "DKC1"      "LATS1"     "PRKAB2"   
#>  [535] "LASP1"     "HDGFRP2"   "ZC3H13"    "SPTBN1"    "DENND4C"   "PLEKHA6"  
#>  [541] "FBXO30"    "CNPY2"     "ZCCHC8"    "GFPT2"     "DLGAP4"    "ARHGEF28" 
#>  [547] "SF3A1"     "SRGAP2"    "MATR3"     "MED24"     "PITPNB"    "TFIP11"   
#>  [553] "ZFC3H1"    "LVRN"      "RNASEH2A"  "CAST"      "CEP55"     "ITGB4"    
#>  [559] "FAM160A2"  "ANAPC1"    "PICK1"     "PUM2"      "ZMYM2"     "SPEN"     
#>  [565] "SLIRP"     "DTD1"      "RBM39"     "TAGLN2"    "PLEKHG3"   "METAP2"   
#>  [571] "SH3KBP1"   "CCDC92"    "SRPK2"     "MDH1"      "ARHGEF10L" "PHLDB1"   
#>  [577] "HSP90AB1"  "CDK18"     "TRIO"      "MAPK1"     "PIGB"      "EIF3J"    
#>  [583] "KSR1"      "CTIF"      "CTDP1"     "ZNF687"    "TUBA1B"    "NOL10"    
#>  [589] "YBX1"      "PDCL3"     "WDR43"     "DENND5B"   "PRPF38A"   "FTSJ3"    
#>  [595] "NDRG3"     "PJA1"      "TBC1D4"    "PRRC2B"    "TP53BP1"   "YY1"      
#>  [601] "BAZ2A"     "SMCR8"     "U2AF2"     "TSC2"      "SPIDR"     "CGN"      
#>  [607] "TRIP12"    "CDC26"     "PLEKHG2"   "ATAD2"     "GIGYF1"    "YTHDC2"   
#>  [613] "ZNF281"    "ZMYND8"    "FAM175A"   "CNPY4"     "UFL1"      "BAIAP2"   
#>  [619] "RPL24"     "DOCK7"     "TXNL1"     "FLNA"      "POLA1"     "EML3"     
#>  [625] "SERBP1"    "TAB3"      "TMEM115"   "TMSB10"    "TMEM176B"  "CDK12"    
#>  [631] "EIF2AK3"   "LMBRD2"    "TICRR"     "TCOF1"     "G3BP1"     "APLF"     
#>  [637] "SMARCAD1"  "LSR"       "EPN3"      "SLC16A10"  "MBD3"      "HNRNPA3"  
#>  [643] "RPS6KA1"   "BRD8"      "PPFIA1"    "TWISTNB"   "TLK1"      "PTPRC"    
#>  [649] "RPS6KA4"   "MLLT4"     "NFX1"      "PPFIBP1"   "CRTC2"     "PTPRG"    
#>  [655] "FXR1"      "CTNNA1"    "ELMSAN1"   "PID1"      "EIF4EBP1"  "KAT7"     
#>  [661] "JADE3"     "CEP170"    "SNX16"     "NOLC1"     "N4BP2L2"   "HJURP"    
#>  [667] "ARHGAP1"   "UBA1"      "MXRA8"     "DNTTIP2"   "PTPRJ"     "TOM1"     
#>  [673] "CENPV"     "DDX20"     "TBC1D1"    "DBNL"      "EMG1"      "PPHLN1"   
#>  [679] "CXADR"     "SIN3A"     "C2CD5"     "DHX16"     "AKAP13"    "RAPGEF3"  
#>  [685] "SRM"       "CAP1"      "CHD8"      "PFAS"      "CEBPZ"     "MED1"     
#>  [691] "HELLS"     "CDC37"     "GTF3C4"    "MEPCE"     "ARFGEF2"   "PSD4"     
#>  [697] "RPRD1B"    "TRAM1"     "KRT8"      "YBX3"      "CHFR"      "SNTB2"    
#>  [703] "KIAA0430"  "ZUFSP"     "PDXDC1"    "GPHN"      "MLX"       "SH3PXD2B" 
#>  [709] "NCAPH"     "NSFL1C"    "TLE6"      "ASAP2"     "FAT1"      "AHCTF1"   
#>  [715] "EIF3C"     "SRA1"      "RALY"      "KANK2"     "CPEB4"     "MARK2"    
#>  [721] "CFL1"      "C11ORF58"  "ARRB1"     "ATF7"      "TMEM230"   "STAMBPL1" 
#>  [727] "PNN"       "MYBBP1A"   "BNIP3"     "SLC4A4"    "NCL"       "PPP4R2"   
#>  [733] "NCBP1"     "RALGAPA2"  "CHTF18"    "DNM1L"     "RNF8"      "PLEKHA1"  
#>  [739] "PEX1"      "RIF1"      "STRN3"     "SH3BP4"    "CBX8"      "PCM1"     
#>  [745] "HDAC4"     "EPHA2"     "FAM91A1"   "SLC4A7"    "THUMPD3"   "DSP"      
#>  [751] "PRPF3"     "CDK4"      "PSMF1"     "MORC3"     "SUB1"      "TLK2"     
#>  [757] "DMWD"      "SETD2"     "KMT2A"     "FOXK1"     "TMOD3"     "TBC1D25"  
#>  [763] "MDN1"      "SH2B1"     "BAIAP2L1"  "WDHD1"     "AKIRIN2"   "NUP205"   
#>  [769] "TRIP10"    "CYSRT1"    "WIPF2"     "NAV1"      "IFI35"     "INPP5E"   
#>  [775] "NBN"       "SIPA1L1"   "FAM207A"   "IFITM2"    "TBX3"      "METTL1"   
#>  [781] "BCL9"      "FXR2"      "EIF4ENIF1" "CDV3"      "FAM92A1"   "KIF4A"    
#>  [787] "PFKFB3"    "SLC4A1AP"  "PEAK1"     "EGFR"      "RBM17"     "TRIP11"   
#>  [793] "NIFK"      "GTSE1"     "BCLAF1"    "KIF20A"    "SYNE2"     "RPS6KA3"  
#>  [799] "CTNND1"    "PSMD4"     "TSR3"      "MAP1S"     "ZFHX3"     "PRKAB1"   
#>  [805] "RNF168"    "BNIP2"     "ZFR"       "PELP1"     "HSP90AA1"  "LBR"      
#>  [811] "PTPN1"     "PARD3"     "GOLGB1"    "HDLBP"     "ZFP36L1"   "TCEB3"    
#>  [817] "KIF21A"    "SLC1A5"    "PDLIM7"    "RB1CC1"    "DST"       "NR2C2AP"  
#>  [823] "PJA2"      "UACA"      "NCOR2"     "NUMA1"     "EPS15"     "NOC2L"    
#>  [829] "PSIP1"     "SMARCC1"   "SFSWAP"    "ERF"       "KIAA1522"  "ACLY"     
#>  [835] "PPP6R3"    "SLC9A3R1"  "LUZP1"     "RBM7"      "KPNA3"     "EIF2S2"   
#>  [841] "SUPT6H"    "UBA2"      "NHSL1"     "HNF1B"     "TTI1"      "ACACA"    
#>  [847] "SLC38A2"   "GRAMD3"    "JAG1"      "PLCH1"     "PA2G4"     "TFEB"     
#>  [853] "NCOA3"     "TRMT1"     "PRKRA"     "PDIA6"     "KIAA1598"  "SLC9A6"   
#>  [859] "ANKRD17"   "BIRC6"     "RBL1"      "NECAP2"    "HCFC1"     "ZC3HAV1"  
#>  [865] "SPIRE2"    "PCBP1"     "GAPVD1"    "ADD3"      "TNS1"      "DUSP16"   
#>  [871] "UHRF1BP1L" "RAB11FIP5" "CTTN"      "VAMP8"     "RANBP3"    "TPX2"     
#>  [877] "RPL13"     "COBLL1"    "RPRD2"     "EDC4"      "CTTNBP2NL" "SBNO1"    
#>  [883] "FAM160B1"  "DGKQ"      "RFTN1"     "MTUS1"     "EIF4A3"    "WDR62"    
#>  [889] "APBB2"     "KLHL6"     "ARHGAP35"  "CIC"       "HNRNPA1"   "RTKN"     
#>  [895] "ARFGAP1"   "MINK1"     "MAGI3"     "ABI1"      "RBBP6"     "HMGA1"    
#>  [901] "FLRT1"     "BMI1"      "PTPN21"    "PALLD"     "CWC27"     "SLMAP"    
#>  [907] "NIPBL"     "ETV3"      "RBMX"      "SLC23A2"   "CASP8AP2"  "C8ORF33"  
#>  [913] "HDGF"      "WDR55"     "VTI1B"     "ARHGAP5"   "TPR"       "DDX1"     
#>  [919] "LRP4"      "PLEC"      "CHD2"      "CDCA2"     "ULK1"      "WASF2"    
#>  [925] "IVNS1ABP"  "LUC7L2"    "SSFA2"     "SKA3"      "SNX17"     "KLF16"    
#>  [931] "RSF1"      "HS1BP3"    "SPTAN1"    "R3HDM2"    "BIN1"      "PHAX"     
#>  [937] "C1ORF52"   "LRRFIP1"   "MFF"       "BRD7"      "ARFIP2"    "MFAP1"    
#>  [943] "UBE2J1"    "MTF1"      "YAP1"      "HNRNPA2B1" "MELK"      "PDZD8"    
#>  [949] "LRRFIP2"   "CHD1"      "ZC3H8"     "ETV6"      "HCK"       "ACIN1"    
#>  [955] "SLC7A7"    "PIKFYVE"   "TNS3"      "IRF2BP2"   "CXORF23"   "GRB7"     
#>  [961] "FAM195A"   "C10ORF88"  "KIAA1468"  "RANBP2"    "KIAA1715"  "RICTOR"   
#>  [967] "MAP3K3"    "RSL1D1"    "C12ORF10"  "SNX5"      "UBXN7"     "UBR4"     
#>  [973] "ARHGAP32"  "ERBB2IP"   "CCDC43"    "ATXN2L"    "MUS81"     "EPS8L2"   
#>  [979] "NEDD4L"    "NELFE"     "NVL"       "CLSPN"     "CBX5"      "CD2AP"    
#>  [985] "IFIH1"     "CTR9"      "BRWD1"     "TSC22D4"   "NOP2"      "MAP4"     
#>  [991] "ZC3H14"    "SLK"       "ZC3HC1"    "ARL6IP4"   "LEMD3"     "TP53BP2"  
#>  [997] "KANSL1"    "LIPE"      "SH3GL1"    "GATAD2B"   "GPN1"      "URI1"     
#> [1003] "RPTOR"     "FAM195B"   "ZDHHC5"    "FAM122A"   "KANK1"     "TJP2"     
#> [1009] "COL4A3BP"  "IRF2BPL"   "SF3B1"     "CHAMP1"    "EPHB4"     "ARFGEF1"  
#> [1015] "MARS"      "MED15"     "CFL2"      "STK24"     "ZNF608"    "HN1L"     
#> [1021] "NPAT"      "SRSF2"     "NEDD4"     "IBTK"      "HYPK"      "IQSEC1"   
#> [1027] "LMNA"      "MAPK10"    "SRRM2"     "LTBP4"     "ZRANB3"    "TOX4"     
#> [1033] "SAP30BP"   "HIRIP3"    "UGDH"      "NF1"       "RIPK1"     "LARP7"    
#> [1039] "CCNT1"     "PEA15"     "VPRBP"     "CRK"       "SPRY1"     "EIF3B"    
#> [1045] "GMIP"      "MTHFD1"    "ARHGEF40"  "STK11IP"   "RAB7A"     "TOP2A"    
#> [1051] "ZC3H11A"   "PEX19"     "PABPN1"    "EIF6"      "RAVER1"    "AHNAK"    
#> [1057] "NSUN2"     "TFAP4"     "SCAF4"     "AARSD1"    "PPP1R12A"  "WBP11"    
#> [1063] "SUGP1"     "GOLGA3"    "ARPC1B"    "SNIP1"     "ACTC1"     "SDC2"     
#> [1069] "MKL2"      "CASP3"     "CCDC88A"   "SMN1"      "PEX14"     "PCNP"     
#> [1075] "EXOC1"     "ADRBK1"    "UBR5"      "KDM1A"     "COIL"      "ADNP"     
#> [1081] "RBM25"     "FOSL2"     "AP3B1"     "SMTN"      "WDR75"     "MLLT6"    
#> [1087] "NUFIP1"    "PUM1"      "ZW10"      "CNOT3"     "THRAP3"    "UBAP2"    
#> [1093] "SGSM3"     "RFX7"      "SNTB1"     "MYH9"      "PLEKHM1"   "RBM14"    
#> [1099] "OTUD7B"    "RFC1"      "CD44"      "LMNB1"     "TCF4"      "TCF20"    
#> [1105] "MTUS2"     "MRPL23"    "HIST1H1C"  "DDX46"     "LUC7L"     "PAXBP1"   
#> [1111] "CLUAP1"    "CSNK1E"    "USP15"     "EIF1"      "NMT1"      "BET1"     
#> [1117] "LLPH"      "MYO9B"     "INTS12"    "RPS17"     "SPAG9"     "PRKAA1"   
#> [1123] "ALS2"      "HAUS6"     "PUS10"     "QARS"      "BCL2L13"   "NCAPD2"   
#> [1129] "FAF1"      "GPRC5C"    "EPB41L2"   "ARMC10"    "AMPD3"     "NUP50"    
#> [1135] "F11R"      "EIF4H"     "FBL"       "BCAR1"     "TCEAL5"    "TAF7"     
#> [1141] "PRR12"     "STXBP5"    "PURB"      "RAB3IP"    "RACGAP1"   "MAPK14"   
#> [1147] "PLEKHA5"   "RABEPK"    "STON1"     "IGHMBP2"   "HNRNPU"    "GOLM1"    
#> [1153] "SRSF11"    "SIK2"      "ARGLU1"    "PAN3"      "LSM14B"    "EEF2"     
#> [1159] "HSPA4"     "RPS10"     "GPSM2"     "TTLL12"    "ARHGAP21"  "USP39"    
#> [1165] "EPB41"     "RAB9A"     "MAST4"     "MIA3"      "NMT2"      "INO80C"   
#> [1171] "C19ORF47"  "CAMSAP2"   "SPRY4"     "CAMSAP1"   "KNOP1"     "EI24"     
#> [1177] "ZYX"       "PPIL4"     "SNRNP200"  "MCM4"      "CYLD"      "PLXNB3"
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
#> 1: 6.836135e-34 1.572311e-32 1.51610760  0.4545874  2.1234887 1049
#> 2: 8.603696e-01 8.603696e-01 0.05378728 -0.3858994 -0.6539699    3
#> 3: 8.603696e-01 8.603696e-01 0.05378728 -0.3858994 -0.6539699    3
#> 4: 4.494337e-12 2.584244e-11 0.88707499  0.4320662  1.9241252  441
#> 5: 5.847180e-04 1.222592e-03 0.47727082  0.4375812  1.6256207  104
#> 6: 6.157642e-03 9.441717e-03 0.40701792  0.4170298  1.5306224   88
#>                                 leadingEdge
#> 1:     LIPE,RPRD2,ZW10,LVRN,ARFGEF2,ZYX,...
#> 2:                        CTDSPL2,PTPN6,SYK
#> 3:                          PTPN6,COPS8,SYK
#> 4: MCM10,RRP7A,ZW10,KIDINS220,JAM2,RFX2,...
#> 5:   RPUSD2,PTRH1,TNK1,TTC25,PRKCB,SAFB,...
#> 6:    RPUSD2,PTRH1,PRKCB,RET,RCSD1,TNIK,...
```

### Gene set variation analysis

`GSVAHarmonizome()` wraps the `{GSVA}` package to perform the GSVA
algorithm (Hänzelmann, Castelo, and Guinney 2013; Hanzelmann, Castelo,
and Guinney 2013).

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

<div id="ref-GSVA" class="csl-entry">

Hanzelmann, Sonja, Robert Castelo, and Justin Guinney. 2013. “GSVA: Gene
Set Variation Analysis for Microarray and RNA-Seq Data” 14: 7.
<https://doi.org/10.1186/1471-2105-14-7>.

</div>

<div id="ref-Hänzelmann2013" class="csl-entry">

Hänzelmann, Sonja, Robert Castelo, and Justin Guinney. 2013. “GSVA: Gene
Set Variation Analysis for Microarray and RNA-Seq Data.” *BMC
Bioinformatics* 14 (1). <https://doi.org/10.1186/1471-2105-14-7>.

</div>

<div id="ref-fgsea" class="csl-entry">

Korotkevich, Gennady, Vladimir Sukhov, and Alexey Sergushichev. 2019.
“Fast Gene Set Enrichment Analysis.” <https://doi.org/10.1101/060012>.

</div>

<div id="ref-mootha2003" class="csl-entry">

Mootha, Vamsi K, Cecilia M Lindgren, Karl-Fredrik Eriksson, Aravind
Subramanian, Smita Sihag, Joseph Lehar, Pere Puigserver, et al. 2003.
“PGC-1α-Responsive Genes Involved in Oxidative Phosphorylation Are
Coordinately Downregulated in Human Diabetes.” *Nature Genetics* 34 (3):
267–73. <https://doi.org/10.1038/ng1180>.

</div>

<div id="ref-rouillard2016" class="csl-entry">

Rouillard, Andrew D., Gregory W. Gundersen, Nicolas F. Fernandez, Zichen
Wang, Caroline D. Monteiro, Michael G. McDermott, and Avi Ma’ayan. 2016.
“The Harmonizome: A Collection of Processed Datasets Gathered to Serve
and Mine Knowledge about Genes and Proteins.” *Database* 2016: baw100.
<https://doi.org/10.1093/database/baw100>.

</div>

<div id="ref-subramanian2005" class="csl-entry">

Subramanian, Aravind, Pablo Tamayo, Vamsi K. Mootha, Sayan Mukherjee,
Benjamin L. Ebert, Michael A. Gillette, Amanda Paulovich, et al. 2005.
“Gene Set Enrichment Analysis: A Knowledge-Based Approach for
Interpreting Genome-Wide Expression Profiles.” *Proceedings of the
National Academy of Sciences* 102 (43): 15545–50.
<https://doi.org/10.1073/pnas.0506580102>.

</div>

<div id="ref-clusterProfiler" class="csl-entry">

Wu, Tianzhi, Erqiang Hu, Shuangbin Xu, Meijun Chen, Pingfan Guo, Zehan
Dai, Tingze Feng, et al. 2021. “clusterProfiler 4.0: A Universal
Enrichment Tool for Interpreting Omics Data” 2: 100141.
<https://doi.org/10.1016/j.xinn.2021.100141>.

</div>

</div>
