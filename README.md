
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HarmonizomeR

<!-- badges: start -->
<!-- badges: end -->

The goal of `{HarmonizomeR}` is to provide a fast interface to download
and perform functional and gene set enrichment analysis from the
[Harmonizome](https://maayanlab.cloud/Harmonizome/) database (Rouillard
et al. 2016).

## Installation

You can install the development version of `{HarmonizomeR}` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("marceelrf/HarmonizomeR")
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
#> =>----------------------------- 4% | ETA: 33s ===>---------------------------
#> 9% | ETA: 20s ====>-------------------------- 13% | ETA: 14s
#> =====>------------------------- 17% | ETA: 14s =======>-----------------------
#> 22% | ETA: 12s ========>---------------------- 26% | ETA: 10s
#> =========>--------------------- 30% | ETA: 9s ==========>--------------------
#> 35% | ETA: 8s ============>------------------ 39% | ETA: 7s
#> =============>----------------- 43% | ETA: 6s ==============>----------------
#> 48% | ETA: 6s ================>-------------- 52% | ETA: 5s
#> =================>------------- 57% | ETA: 4s ==================>------------
#> 61% | ETA: 4s ====================>---------- 65% | ETA: 3s
#> =====================>--------- 70% | ETA: 3s ======================>--------
#> 74% | ETA: 3s =======================>------- 78% | ETA: 2s
#> =========================>----- 83% | ETA: 2s ==========================>----
#> 87% | ETA: 1s ===========================>--- 91% | ETA: 1s
#> =============================>- 96% | ETA: 0s
```

``` r
head(silacdrug_ds)
#> # A tibble: 6 x 3
#>   Code      name                                                          symbol
#>   <chr>     <chr>                                                         <chr> 
#> 1 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ KLHL6 
#> 2 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ BMI1  
#> 3 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ PSD4  
#> 4 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ PHLDB1
#> 5 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ ATF2  
#> 6 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ BMS1
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
#>    [1] "KLHL6"     "BMI1"      "PSD4"      "PHLDB1"    "ATF2"      "BMS1"     
#>    [7] "GMIP"      "ZNF687"    "MCRS1"     "MAP4K4"    "IBTK"      "PLEKHM1"  
#>   [13] "ZYX"       "FNBP1L"    "HTATSF1"   "SRSF2"     "KMT2A"     "NF1"      
#>   [19] "C12ORF10"  "FAM92A1"   "NT5C3A"    "TMEM106B"  "DOCK5"     "MUS81"    
#>   [25] "MED24"     "JUN"       "RAB3IP"    "UBXN7"     "TSC22D2"   "SNTB2"    
#>   [31] "CUX1"      "ZMYM2"     "BCLAF1"    "GPRC5C"    "CDC5L"     "ASUN"     
#>   [37] "EIF2AK3"   "ZNF462"    "MFF"       "AEBP2"     "ESAM"      "CCDC88A"  
#>   [43] "NECAP2"    "IGHMBP2"   "LGR5"      "SLMAP"     "STRN4"     "URI1"     
#>   [49] "ENSA"      "ETV6"      "MCM2"      "NCOA3"     "SRA1"      "GTSE1"    
#>   [55] "RPS17"     "BRD7"      "ZNF503"    "FARP1"     "ZWINT"     "PPFIBP1"  
#>   [61] "HDGF"      "YY1"       "UGDH"      "DENND5B"   "KIF20B"    "TMSB10"   
#>   [67] "KRT18"     "CCNL2"     "LEMD3"     "C1ORF52"   "ALS2"      "SH3BP1"   
#>   [73] "TDP1"      "PXN"       "USP48"     "EPB41L1"   "RFC1"      "TULP3"    
#>   [79] "LIMK2"     "NUCKS1"    "SYNPO"     "LVRN"      "RBM14"     "HNRNPK"   
#>   [85] "RIF1"      "ZMYM4"     "WNK1"      "CKAP2"     "MEPCE"     "ETHE1"    
#>   [91] "NFIC"      "PWWP2B"    "CLUH"      "RBBP6"     "HJURP"     "MBD3"     
#>   [97] "WDR75"     "RRAD"      "TCEB3"     "XPO4"      "FAM76B"    "NR2C2AP"  
#>  [103] "EIF3J"     "TWISTNB"   "UBE2J1"    "UBE2O"     "MED14"     "ARHGAP1"  
#>  [109] "WDR55"     "STK24"     "PDS5B"     "HDAC6"     "CLASP1"    "CCNK"     
#>  [115] "LRP1"      "POLA1"     "SRM"       "PDIA6"     "OTUD7B"    "PJA1"     
#>  [121] "GMEB2"     "ROCK2"     "THUMPD3"   "ERBB2IP"   "HNRNPA2B1" "ADD1"     
#>  [127] "UBA2"      "IVNS1ABP"  "STXBP5"    "PPP4R2"    "TAF3"      "TOR1AIP1" 
#>  [133] "WDHD1"     "ARMC10"    "SUPT5H"    "UBR5"      "SALL1"     "C5ORF30"  
#>  [139] "C2ORF49"   "KLC2"      "UTP18"     "CPEB4"     "PRPF4B"    "PAXBP1"   
#>  [145] "TOX4"      "EPN3"      "CDK12"     "TTC7A"     "SOD1"      "LMNA"     
#>  [151] "RAB11FIP5" "NBN"       "SMARCAD1"  "NCAPH"     "F11R"      "PEAK1"    
#>  [157] "LMBRD2"    "ARHGEF10L" "KLF16"     "TRIM24"    "ELF1"      "ZNF598"   
#>  [163] "KAT7"      "PRR12"     "CDCA3"     "DENND4C"   "ANKRD17"   "MKL2"     
#>  [169] "PLEKHA7"   "DYNC1LI1"  "SORBS2"    "PIKFYVE"   "PNISR"     "SMARCC1"  
#>  [175] "CXORF23"   "MYH10"     "PTPN1"     "HN1L"      "ADRBK1"    "EHBP1L1"  
#>  [181] "ASPSCR1"   "PRKAB1"    "ARFGEF2"   "TRAM1"     "SPRY1"     "MAST4"    
#>  [187] "HSPB8"     "PPIP5K2"   "AGFG1"     "SF3B2"     "TSR3"      "KIF20A"   
#>  [193] "SIK3"      "NUP35"     "TTI1"      "SDC1"      "TMEM230"   "PLEC"     
#>  [199] "PHF14"     "CHERP"     "DDX1"      "DSTN"      "INTS12"    "ITGB4"    
#>  [205] "PHC3"      "BICC1"     "RSRC2"     "INTS6"     "USP4"      "TFEB"     
#>  [211] "CRIP2"     "GIGYF2"    "ALKBH5"    "ABCF1"     "BRWD1"     "MAP3K3"   
#>  [217] "PHACTR4"   "PML"       "AMPD2"     "TLE6"      "NUDC"      "CDC37"    
#>  [223] "CACTIN"    "BAIAP2L1"  "IFI35"     "MARCKS"    "STON1"     "IFIH1"    
#>  [229] "NUP188"    "PRKAB2"    "ITPKB"     "STIM1"     "SNX16"     "RPLP2"    
#>  [235] "BRAF"      "ZNF569"    "EGFR"      "CEP170B"   "BCL2L13"   "LTV1"     
#>  [241] "CCDC43"    "MAPK1"     "MTHFD1"    "FAM160A2"  "TTLL12"    "HSPA4"    
#>  [247] "BRD8"      "UBAP1"     "MAP1S"     "RNF8"      "PDAP1"     "MAP4"     
#>  [253] "REXO1"     "CNPY2"     "GAPVD1"    "RB1CC1"    "ABI1"      "SCAF4"    
#>  [259] "AHCTF1"    "APRT"      "DIDO1"     "LRRFIP1"   "UHRF1BP1L" "SET"      
#>  [265] "CFDP1"     "PVRL1"     "RNF187"    "RIN1"      "KIAA1598"  "LUC7L"    
#>  [271] "C11ORF58"  "AKAP13"    "LASP1"     "TSC22D4"   "RPL37"     "CTAGE5"   
#>  [277] "RRP1"      "ARHGAP32"  "FAM208A"   "CBX8"      "SHC1"      "HN1"      
#>  [283] "TCF4"      "RAD18"     "MYC"       "BAD"       "RALGAPA2"  "IRF3"     
#>  [289] "ULK1"      "SLTM"      "MAPK10"    "CXADR"     "NIFK"      "PRPF3"    
#>  [295] "INCENP"    "GRB7"      "RBL1"      "RBM8A"     "IRF2BPL"   "HSP90AB1" 
#>  [301] "HS1BP3"    "FXR2"      "CDKN2AIP"  "PBX2"      "SLC33A1"   "WHSC1"    
#>  [307] "MAPK14"    "PKN2"      "BNIP2"     "CRTC2"     "SRRM2"     "MARK2"    
#>  [313] "DNMT1"     "PSMD4"     "DNM1L"     "TOP2A"     "VPS26B"    "NCL"      
#>  [319] "MYO9B"     "PPFIA1"    "RABEPK"    "LATS1"     "CBX5"      "ETL4"     
#>  [325] "HDAC4"     "TJP2"      "HIRIP3"    "GCFC2"     "GORASP2"   "NUP98"    
#>  [331] "CENPV"     "SRGAP2"    "FLNA"      "ATG16L1"   "RAPGEF3"   "FHOD1"    
#>  [337] "MYBBP1A"   "MLF2"      "MTMR3"     "NUP93"     "TPD52L2"   "ZC3HC1"   
#>  [343] "DPF2"      "DKC1"      "FAM63A"    "APBB2"     "TLK1"      "TLK2"     
#>  [349] "TCIRG1"    "ERCC6L"    "RFTN1"     "VPS51"     "TRAF3IP1"  "ZCCHC8"   
#>  [355] "EIF4EBP1"  "TRAF7"     "MBD5"      "IRF2BP2"   "ERRFI1"    "MAP2K4"   
#>  [361] "MAST2"     "EIF3C"     "CCNT1"     "CAP1"      "SSBP3"     "TRIM2"    
#>  [367] "NELFE"     "HDGFRP2"   "STRN3"     "ZFR"       "PNN"       "FAM104A"  
#>  [373] "MRPL23"    "MTSS1"     "FNBP4"     "C17ORF49"  "UBE2T"     "SUN1"     
#>  [379] "KIF23"     "MAPRE2"    "ETV3"      "CD2AP"     "SORD"      "CEP97"    
#>  [385] "YAP1"      "KLC1"      "ARFIP1"    "RSF1"      "CEP170"    "LIMD1"    
#>  [391] "LYSMD2"    "SLC35C2"   "KANSL1"    "EPHA2"     "COIL"      "SMTN"     
#>  [397] "RPS10"     "VPRBP"     "SLC4A7"    "CHD8"      "SFSWAP"    "ZCCHC6"   
#>  [403] "RBM3"      "TNS1"      "MYH9"      "HMHA1"     "KDM1A"     "API5"     
#>  [409] "AP3B1"     "G3BP1"     "SLC38A2"   "CTNND1"    "CPD"       "PABPN1"   
#>  [415] "TRA2B"     "TMEM55A"   "PLEKHG3"   "PHAX"      "SLC4A4"    "SAP30BP"  
#>  [421] "GFPT2"     "CKAP5"     "ADNP"      "SMG6"      "DGKQ"      "AKT1S1"   
#>  [427] "UACA"      "RASA3"     "TFIP11"    "SFR1"      "GTF2F1"    "NOC2L"    
#>  [433] "FEZ2"      "MAGI3"     "DLGAP5"    "BCAR1"     "HCK"       "EIF5B"    
#>  [439] "VTI1B"     "BNIP3"     "GRASP"     "MKL1"      "SLC7A7"    "PPIL4"    
#>  [445] "CEBPZ"     "ESF1"      "PRPF38A"   "C8ORF33"   "KPNA3"     "SNX17"    
#>  [451] "FBXW8"     "CTNNB1"    "KSR1"      "EMD"       "PAN3"      "MDC1"     
#>  [457] "DSP"       "HNRNPA3"   "RBM15"     "RIPK1"     "ARHGAP35"  "SUB1"     
#>  [463] "RABEP1"    "HYPK"      "NCOR2"     "SPIRE2"    "DDX27"     "DAXX"     
#>  [469] "KIAA1468"  "CLSPN"     "TAB2"      "RANBP3"    "TUBA1B"    "SUPT6H"   
#>  [475] "GPN1"      "WIBG"      "TMEM115"   "CFL1"      "DOCK7"     "MKI67"    
#>  [481] "DLGAP4"    "RACGAP1"   "RPS2"      "SLC23A2"   "GOLM1"     "POLA2"    
#>  [487] "PCNP"      "APLF"      "PSMF1"     "LARP7"     "RANGAP1"   "KIF21A"   
#>  [493] "HIST1H1C"  "ARL6IP4"   "TRIP10"    "ZAK"       "ZNRF2"     "PPP2R5D"  
#>  [499] "FKBP15"    "ACTC1"     "SNX2"      "TRMT1"     "SPTBN1"    "TBC1D4"   
#>  [505] "LIG3"      "SPECC1L"   "DPYSL2"    "ZDHHC5"    "NIPBL"     "KRT8"     
#>  [511] "ARFGEF1"   "PTPRC"     "BCL9"      "SNTB1"     "ARMC1"     "SRPK2"    
#>  [517] "LYSMD3"    "TOM1"      "PIGB"      "PDXDC1"    "RPL7"      "RPL30"    
#>  [523] "FAT1"      "MTUS1"     "BSG"       "PRUNE2"    "INPP5E"    "FKBP3"    
#>  [529] "MTUS2"     "RICTOR"    "RPL13"     "DMXL1"     "THUMPD1"   "HSF1"     
#>  [535] "CRK"       "WBP11"     "HNRNPLL"   "TJP1"      "GTF3C4"    "ASAP1"    
#>  [541] "EPS15"     "ZRANB2"    "NUP50"     "MIA3"      "TRIM28"    "CAMK2G"   
#>  [547] "STRN"      "SIN3A"     "CBL"       "IFITM2"    "LARP1"     "PLCB3"    
#>  [553] "RFX1"      "POF1B"     "RANBP2"    "EIF4H"     "CLIP1"     "EIF2S2"   
#>  [559] "SBNO1"     "CASC3"     "DTD1"      "TAF7"      "STMN1"     "N4BP2L2"  
#>  [565] "NUP205"    "PUM1"      "DIP2B"     "NPM3"      "ADD3"      "ASAP2"    
#>  [571] "PCIF1"     "EMG1"      "CAMSAP2"   "TXLNA"     "TFE3"      "PKP4"     
#>  [577] "PFAS"      "RPRD2"     "TOP1"      "MYO18A"    "RPL6"      "GOLGB1"   
#>  [583] "ITPR3"     "JADE3"     "NSFL1C"    "ZBED9"     "CNPY4"     "DNTTIP2"  
#>  [589] "FAM195B"   "YWHAE"     "YTHDF1"    "NUP214"    "TMEM63B"   "TCEAL5"   
#>  [595] "CGNL1"     "PDLIM7"    "PRKD3"     "DNAJC5"    "GAB1"      "FAF1"     
#>  [601] "DMWD"      "PEX1"      "POLR2A"    "AKT1"      "NCBP1"     "KIAA0430" 
#>  [607] "SYNE2"     "RALY"      "PCM1"      "HNRNPC"    "PCBP2"     "BOD1L1"   
#>  [613] "HELLS"     "LIPE"      "PURB"      "PTPN21"    "PPP6R3"    "RBM39"    
#>  [619] "CFL2"      "TP53BP2"   "LSM14B"    "GATAD2B"   "EDC4"      "NFATC2IP" 
#>  [625] "VAPB"      "IKBKB"     "UFL1"      "NCOR1"     "MATR3"     "SSB"      
#>  [631] "HMGA1"     "ARHGEF40"  "WDR20"     "EIF4B"     "CTR9"      "RAB7A"    
#>  [637] "TPX2"      "SCRIB"     "UBA1"      "EPS8L2"    "CD44"      "BAG3"     
#>  [643] "SLC4A1AP"  "TPR"       "PEX19"     "GBF1"      "FAM83H"    "NOP2"     
#>  [649] "VAMP8"     "IRS2"      "PITPNB"    "CTTN"      "SMCR8"     "ARFIP2"   
#>  [655] "STAMBPL1"  "NOL10"     "NOLC1"     "NME2"      "SGTA"      "TRA2A"    
#>  [661] "HAUS6"     "PLEKHA1"   "MPHOSPH10" "KIF3A"     "SH3GL1"    "CASP3"    
#>  [667] "MIER3"     "ZC3HAV1"   "CAMSAP1"   "CNOT2"     "ZC3H11A"   "EML3"     
#>  [673] "PPP1R10"   "CCDC92"    "CYSRT1"    "SMARCC2"   "PICK1"     "NOP56"    
#>  [679] "MRE11A"    "SYNRG"     "TSC2"      "HCFC1"     "PLCG1"     "HNRNPU"   
#>  [685] "LTBP4"     "CRTC3"     "HNRNPH1"   "SSFA2"     "CHD4"      "ZC3H13"   
#>  [691] "SLIRP"     "ANAPC1"    "NASP"      "RRP9"      "RAVER1"    "SPRED1"   
#>  [697] "MAP7D1"    "NHSL1"     "SETD2"     "TP53BP1"   "MCM3"      "TRIP12"   
#>  [703] "CAST"      "NUFIP1"    "ALAD"      "CBX4"      "ZCCHC9"    "EIF4A3"   
#>  [709] "SVIL"      "SAMD4B"    "HMGXB4"    "RNF168"    "HSP90AA1"  "NDRG3"    
#>  [715] "GNL3"      "LRRC41"    "RBM33"     "AKIRIN2"   "ZC3H8"     "PCGF6"    
#>  [721] "PAPOLA"    "EIF4ENIF1" "PELP1"     "EIF1"      "KIAA1715"  "KANK2"    
#>  [727] "COL4A3BP"  "KDM3B"     "PRKAA1"    "NSUN2"     "MED15"     "MDH1"     
#>  [733] "TMEM176B"  "RBM25"     "NUFIP2"    "KIF2C"     "PCBP1"     "MDN1"     
#>  [739] "DOCK1"     "TRRAP"     "ACIN1"     "SGSM3"     "BRCA1"     "LRRC8A"   
#>  [745] "BIN1"      "SF3B1"     "ACACA"     "C12ORF45"  "EAF1"      "UTP15"    
#>  [751] "FXR1"      "ARHGAP21"  "POLDIP3"   "MYO1E"     "PALLD"     "MAP3K2"   
#>  [757] "USP39"     "MCM4"      "NFKB1"     "IRF2BP1"   "RBMX"      "ARHGDIA"  
#>  [763] "WASF2"     "METAP2"    "LEMD2"     "SERBP1"    "NUP153"    "ZC3H14"   
#>  [769] "HDLBP"     "FOXK1"     "RHBDF2"    "SUFU"      "CNOT3"     "NFRKB"    
#>  [775] "CHAMP1"    "ZUFSP"     "CTIF"      "HP1BP3"    "PPP1R12C"  "GPHN"     
#>  [781] "DBNL"      "R3HDM2"    "EXOC1"     "SH2B1"     "HEATR3"    "MFAP1"    
#>  [787] "KNOP1"     "UBR4"      "AAK1"      "RPRD1B"    "SF3A1"     "TICRR"    
#>  [793] "CDCA2"     "JAG1"      "SHROOM3"   "MTA3"      "ATF7"      "RSL1D1"   
#>  [799] "BIRC6"     "FRA10AC1"  "STK11IP"   "USP10"     "EPB41"     "NPAT"     
#>  [805] "TMPO"      "PLCH1"     "ZZZ3"      "PTMA"      "PJA2"      "CDK17"    
#>  [811] "DDX46"     "SDC2"      "METTL1"    "CTNNA1"    "NEO1"      "ZZEF1"    
#>  [817] "MTF1"      "OTUD4"     "NCAPD2"    "ATRX"      "SLK"       "ZNF330"   
#>  [823] "MTFR1L"    "PDCL3"     "GIT1"      "RBM6"      "TRIO"      "WDR43"    
#>  [829] "ARPC1B"    "BCR"       "TRIP11"    "CDC26"     "NUMA1"     "CSNK1E"   
#>  [835] "ING4"      "SEC22B"    "RPS6KA4"   "TRAPPC8"   "STRIP1"    "TCF20"    
#>  [841] "SPRY4"     "ARHGEF28"  "CASP8AP2"  "RAB3GAP1"  "PRKRA"     "PLEKHA6"  
#>  [847] "PHLDB2"    "PEX14"     "MORC3"     "KIAA1522"  "TRIP6"     "PSIP1"    
#>  [853] "PARD3"     "RTN4"      "UBA52"     "CDK16"     "PFKFB3"    "SMN1"     
#>  [859] "EPB41L2"   "LBR"       "DDX51"     "PAK2"      "KIF5B"     "CHD1"     
#>  [865] "CDC42EP1"  "ACLY"      "UBAP2"     "EIF4G3"    "SLC20A2"   "TBC1D25"  
#>  [871] "RANBP9"    "FRMD4B"    "GIGYF1"    "ARHGAP5"   "CDK4"      "LEO1"     
#>  [877] "GOLGA5"    "FBXO30"    "INO80C"    "ARFGAP1"   "VCL"       "PPP1R13L" 
#>  [883] "FAM160B1"  "STK3"      "SIK1"      "ELMSAN1"   "SRRT"      "MARK3"    
#>  [889] "RBM10"     "MLX"       "MLLT4"     "SPATA13"   "PTPRJ"     "TJAP1"    
#>  [895] "BAIAP2"    "SOS1"      "ARID4A"    "AGAP1"     "KANK1"     "ZNF7"     
#>  [901] "OPTN"      "MAPK3"     "SRRM1"     "PUM2"      "AFTPH"     "RBM17"    
#>  [907] "CASP7"     "HLA-A"     "CSTF3"     "CTTNBP2NL" "APOBR"     "CHFR"     
#>  [913] "CD2BP2"    "XRCC6"     "TMCC2"     "TBX3"      "PRRC2C"    "SMARCA4"  
#>  [919] "C7ORF43"   "RAI14"     "SLC9A3R1"  "NEDD4"     "CTDP1"     "PPP1R12A" 
#>  [925] "SNIP1"     "SPAG9"     "FAM91A1"   "SPHK2"     "PLEKHA5"   "NUCB1"    
#>  [931] "PLEKHG2"   "FOSL2"     "MXRA8"     "FTSJ3"     "LARP4"     "RAD51AP1" 
#>  [937] "ARHGAP6"   "YWHAZ"     "PRRC2B"    "NMT2"      "SQSTM1"    "CHTF18"   
#>  [943] "SRSF10"    "LLPH"      "CALM2"     "CDC42EP5"  "KRT20"     "ARRB1"    
#>  [949] "KIFAP3"    "DUSP16"    "NELFA"     "FAM122A"   "STK4"      "SLC16A1"  
#>  [955] "EIF2B5"    "ESYT2"     "CWC27"     "VIM"       "REPS1"     "EIF3B"    
#>  [961] "LMO7"      "SPIDR"     "EIF4G1"    "TRIOBP"    "WIPF2"     "C10ORF88" 
#>  [967] "FAM195A"   "USP15"     "SKA3"      "ZRANB3"    "ABI2"      "IFITM3"   
#>  [973] "NOL4L"     "NAV1"      "RAB9A"     "TAGLN2"    "NUSAP1"    "SH3KBP1"  
#>  [979] "SNX5"      "LMNB1"     "DNAJC2"    "SUGP1"     "SSH3"      "AMPD3"    
#>  [985] "EIF6"      "ATXN2L"    "DDX55"     "EIF3D"     "WIZ"       "SLC16A10" 
#>  [991] "SLC9A6"    "OSBP"      "OSBPL11"   "PLXNB3"    "HNF1B"     "ZMYND8"   
#>  [997] "CCNL1"     "SRSF11"    "RPS20"     "PA2G4"     "NOL9"      "FLNC"     
#> [1003] "DEPTOR"    "CBX3"      "EPS15L1"   "SDPR"      "ERF"       "NAB2"     
#> [1009] "SLAIN2"    "SPEN"      "SNAP23"    "MARS"      "DHX16"     "NFX1"     
#> [1015] "SMAP2"     "NOM1"      "SLC26A2"   "U2AF2"     "PAWR"      "NUP133"   
#> [1021] "SIPA1L1"   "RPS3"      "ZFC3H1"    "ARFGAP2"   "BET1"      "COBLL1"   
#> [1027] "ARGLU1"    "TRAPPC10"  "CHD2"      "AATF"      "LRRFIP2"   "PSRC1"    
#> [1033] "ZNF106"    "MTDH"      "ZNF281"    "SH3BP4"    "MINK1"     "RPS6KA3"  
#> [1039] "RAB11FIP1" "UCK2"      "YTHDC2"    "CIC"       "FAM175A"   "ARHGEF11" 
#> [1045] "EML4"      "BCL9L"     "GINS2"     "CDV3"      "TFAP4"     "PDCD4"    
#> [1051] "CDC42EP4"  "YBX3"      "CAPZA2"    "TNS3"      "THRAP3"    "TNKS1BP1" 
#> [1057] "GRAMD3"    "NMNAT1"    "DDX42"     "AHNAK"     "EEF2"      "SNRNP200" 
#> [1063] "SH3PXD2B"  "DTX2"      "C2CD5"     "MLLT6"     "PID1"      "SAFB2"    
#> [1069] "LPP"       "CES5A"     "NCOA5"     "CEP55"     "CKAP4"     "CHEK1"    
#> [1075] "ATXN2"     "TAB3"      "PSMD11"    "RBM7"      "CDK18"     "RIN2"     
#> [1081] "SAV1"      "GPSM2"     "ABL2"      "TMEM245"   "RNF20"     "SNX7"     
#> [1087] "PRRC2A"    "TCOF1"     "RPL24"     "PRPF40A"   "PDZD8"     "PTPRG"    
#> [1093] "KIF4A"     "GOLGA3"    "CDK1"      "TAOK1"     "NMT1"      "NVL"      
#> [1099] "SPTAN1"    "FLRT1"     "HNRNPAB"   "MAVS"      "C19ORF47"  "DST"      
#> [1105] "LUC7L2"    "TMOD3"     "HNRNPUL2"  "ZCCHC11"   "ATAD2"     "PUS10"    
#> [1111] "PTPN12"    "SMEK1"     "ATG2B"     "RNMT"      "MOB1B"     "LRP4"     
#> [1117] "IRS1"      "NEK9"      "BCKDHA"    "EI24"      "SRP14"     "SPATS2"   
#> [1123] "IQSEC1"    "SIK2"      "EPHB4"     "CHAF1B"    "RFX7"      "RTKN"     
#> [1129] "SLC1A5"    "KLC3"      "ABLIM1"    "UBAP2L"    "PPP1R18"   "PARD6B"   
#> [1135] "C2ORF44"   "MELK"      "RPTOR"     "AARSD1"    "ZFHX3"     "CYLD"     
#> [1141] "ARHGEF7"   "NEDD4L"    "HMGN1"     "FBL"       "WDR62"     "RNASEH2A" 
#> [1147] "QARS"      "DDX20"     "IWS1"      "ZW10"      "ZFP36L1"   "PEA15"    
#> [1153] "ZNF608"    "AKAP10"    "FAM193A"   "PPHLN1"    "HNRNPA1"   "LUZP1"    
#> [1159] "CLUAP1"    "RPS6KA1"   "YBX1"      "REEP3"     "CC2D1B"    "SMG9"     
#> [1165] "CCT8"      "DOPEY1"    "PRKD2"     "BAZ2A"     "TBC1D1"    "TNS2"     
#> [1171] "NPM1"      "WDR70"     "MCM6"      "TXNL1"     "NMD3"      "LSR"      
#> [1177] "DCP2"      "CGN"       "DUSP7"     "ANP32B"    "MED1"      "FAM207A"
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
#> 1: 3.617917e-34 8.321210e-33 1.52292160  0.4545874  2.1373141 1049
#> 2: 8.378378e-01 8.378378e-01 0.05559471 -0.3858994 -0.6561513    3
#> 3: 8.378378e-01 8.378378e-01 0.05559471 -0.3858994 -0.6561513    3
#> 4: 9.850690e-13 5.664147e-12 0.91011973  0.4320662  1.9306136  441
#> 5: 6.539635e-04 1.367378e-03 0.47727082  0.4375812  1.6701877  104
#> 6: 7.025335e-03 1.009892e-02 0.40701792  0.4170298  1.5566514   88
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
