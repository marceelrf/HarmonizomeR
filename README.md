
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
#> # A tibble: 130 x 2
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
#> # ... with 120 more rows
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
#> =>----------------------------- 4% | ETA: 44s ===>---------------------------
#> 9% | ETA: 26s ====>-------------------------- 13% | ETA: 21s
#> =====>------------------------- 17% | ETA: 21s =======>-----------------------
#> 22% | ETA: 18s ========>---------------------- 26% | ETA: 15s
#> =========>--------------------- 30% | ETA: 13s ==========>--------------------
#> 35% | ETA: 12s ============>------------------ 39% | ETA: 11s
#> =============>----------------- 43% | ETA: 11s ==============>----------------
#> 48% | ETA: 10s ================>-------------- 52% | ETA: 9s
#> =================>------------- 57% | ETA: 8s ==================>------------
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
#> 1 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ CEBPZ 
#> 2 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ CHD1  
#> 3 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ ZDHHC5
#> 4 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ PLCH1 
#> 5 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ SIK3  
#> 6 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ GRB7
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

length(pathways_list[[1]])
#> [1] 1182

pathways_list[1]
#> $`10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SILAC Phosphoproteomics Signatures of Differentially Phosphorylated Proteins for Drugs`
#>    [1] "CEBPZ"     "CHD1"      "ZDHHC5"    "PLCH1"     "SIK3"      "GRB7"     
#>    [7] "GIT1"      "NOC2L"     "NUP214"    "AFTPH"     "SUGP1"     "INTS12"   
#>   [13] "DKC1"      "CDC42EP5"  "TAF3"      "EHBP1L1"   "DDX1"      "CCNL2"    
#>   [19] "SMN1"      "SRSF10"    "RAB11FIP1" "YWHAZ"     "N4BP2L2"   "SORBS2"   
#>   [25] "FAM122A"   "CHEK1"     "EIF2S2"    "NUSAP1"    "KIF20B"    "KDM1A"    
#>   [31] "RFX7"      "IRF2BP1"   "STK3"      "EGFR"      "PRRC2A"    "VAPB"     
#>   [37] "EMD"       "RPL30"     "NFRKB"     "PFKFB3"    "MLX"       "RPLP2"    
#>   [43] "MFAP1"     "GBF1"      "HIST1H1C"  "NFX1"      "UBA52"     "TDP1"     
#>   [49] "EIF4ENIF1" "PPFIA1"    "FAM195B"   "NHSL1"     "IRF2BPL"   "PLXNB3"   
#>   [55] "G3BP1"     "TSC22D4"   "C12ORF45"  "TRIOBP"    "THRAP3"    "LIMD1"    
#>   [61] "PTPRJ"     "ATG16L1"   "CHTF18"    "CTNNA1"    "WDR55"     "TRIP10"   
#>   [67] "KAT7"      "MCM4"      "CYSRT1"    "UBE2J1"    "ESYT2"     "PCBP2"    
#>   [73] "IRS1"      "PLEC"      "EPB41L1"   "MTHFD1"    "SH3KBP1"   "CHAMP1"   
#>   [79] "MYH10"     "ARHGAP6"   "LUZP1"     "LBR"       "TAOK1"     "SIK2"     
#>   [85] "EPHA2"     "CTAGE5"    "PUM2"      "TMEM176B"  "SNX16"     "EAF1"     
#>   [91] "RANBP3"    "TCF4"      "C17ORF49"  "RPS2"      "RPL13"     "UTP15"    
#>   [97] "CGNL1"     "RANBP2"    "C7ORF43"   "RAB7A"     "HDAC4"     "SHC1"     
#>  [103] "FNBP1L"    "FAM208A"   "C5ORF30"   "C2CD5"     "CLASP1"    "TCIRG1"   
#>  [109] "DBNL"      "UHRF1BP1L" "GRASP"     "ZNF462"    "HDGFRP2"   "BCLAF1"   
#>  [115] "NMT2"      "MED24"     "INCENP"    "YBX3"      "ACTC1"     "HSP90AB1" 
#>  [121] "KIAA1522"  "YY1"       "ZWINT"     "CLUAP1"    "TWISTNB"   "BAG3"     
#>  [127] "BIN1"      "WNK1"      "TRAPPC8"   "CCDC92"    "PJA2"      "UBR4"     
#>  [133] "SPIDR"     "WASF2"     "GMEB2"     "AMPD2"     "HNRNPLL"   "SKA3"     
#>  [139] "MXRA8"     "ABI1"      "LARP1"     "RANBP9"    "ASAP1"     "CHFR"     
#>  [145] "SLC1A5"    "PSMD11"    "PLEKHG3"   "SAMD4B"    "MYBBP1A"   "ZNF569"   
#>  [151] "SGTA"      "CRIP2"     "RAB9A"     "CDK1"      "MTFR1L"    "EXOC1"    
#>  [157] "CDC42EP4"  "LIG3"      "EPHB4"     "ITPR3"     "DTD1"      "EIF3B"    
#>  [163] "YTHDF1"    "ADD1"      "CEP55"     "SPAG9"     "LTV1"      "BMS1"     
#>  [169] "EIF2B5"    "FAM160B1"  "ZNF598"    "BRWD1"     "KRT8"      "DOPEY1"   
#>  [175] "TLE6"      "FAM175A"   "SF3B2"     "PDS5B"     "UBE2T"     "STIM1"    
#>  [181] "IKBKB"     "RSRC2"     "AGAP1"     "TRAF3IP1"  "HN1L"      "ANP32B"   
#>  [187] "ERCC6L"    "HEATR3"    "ARGLU1"    "DOCK1"     "SPECC1L"   "GIGYF2"   
#>  [193] "ARL6IP4"   "RNF187"    "CKAP2"     "CYLD"      "UBAP2"     "CLUH"     
#>  [199] "BAIAP2L1"  "LSR"       "RACGAP1"   "YAP1"      "TRAM1"     "NELFE"    
#>  [205] "CDC37"     "PPP2R5D"   "KLC3"      "NEO1"      "HSP90AA1"  "ACIN1"    
#>  [211] "MBD5"      "USP15"     "PELP1"     "PA2G4"     "POLR2A"    "INPP5E"   
#>  [217] "TSC22D2"   "TMCC2"     "PRKRA"     "APRT"      "SPEN"      "CAMSAP1"  
#>  [223] "CFDP1"     "SMARCC1"   "OSBP"      "BRAF"      "CHD4"      "RIF1"     
#>  [229] "UBA1"      "QARS"      "MFF"       "PSIP1"     "HJURP"     "VPRBP"    
#>  [235] "STON1"     "REXO1"     "ACACA"     "TNKS1BP1"  "PAK2"      "RAPGEF3"  
#>  [241] "C8ORF33"   "GOLGA3"    "IFIH1"     "ALKBH5"    "EIF4G3"    "TRA2B"    
#>  [247] "GPHN"      "LMNB1"     "CDK18"     "DUSP16"    "WDR20"     "MARS"     
#>  [253] "IVNS1ABP"  "ITGB4"     "POLDIP3"   "KLF16"     "FAM193A"   "RBMX"     
#>  [259] "RFX1"      "GOLM1"     "XPO4"      "KIF3A"     "MTMR3"     "CHD2"     
#>  [265] "TPX2"      "ZNF330"    "PDIA6"     "ZNF503"    "ARHGAP32"  "RNASEH2A" 
#>  [271] "WHSC1"     "CBL"       "DGKQ"      "RBM7"      "PKN2"      "ARFIP1"   
#>  [277] "ATF2"      "TLK1"      "CDV3"      "LMO7"      "EIF3C"     "CACTIN"   
#>  [283] "ATXN2"     "PPP1R12A"  "HP1BP3"    "CBX4"      "GNL3"      "SSFA2"    
#>  [289] "CRTC2"     "SET"       "USP48"     "SSH3"      "RB1CC1"    "MAPK3"    
#>  [295] "BAZ2A"     "CAPZA2"    "NELFA"     "NT5C3A"    "TFE3"      "RPL24"    
#>  [301] "PPP1R12C"  "STMN1"     "LEMD3"     "BAD"       "ZCCHC9"    "MAP3K2"   
#>  [307] "WDR43"     "HLA-A"     "EML3"      "CASP8AP2"  "VIM"       "TOM1"     
#>  [313] "SIPA1L1"   "CRTC3"     "TMEM106B"  "MAP4"      "MATR3"     "SLC4A1AP" 
#>  [319] "ZCCHC6"    "BCL2L13"   "RPTOR"     "PIKFYVE"   "PWWP2B"    "HCFC1"    
#>  [325] "FKBP3"     "CCDC43"    "SLC4A4"    "VPS51"     "DOCK7"     "PAN3"     
#>  [331] "RAVER1"    "CFL2"      "HELLS"     "SPATS2"    "RHBDF2"    "PICK1"    
#>  [337] "SPATA13"   "NMNAT1"    "SALL1"     "MYC"       "TRIP6"     "F11R"     
#>  [343] "SNRNP200"  "RBM33"     "DNAJC5"    "KSR1"      "LVRN"      "DYNC1LI1" 
#>  [349] "PEX19"     "SGSM3"     "SAP30BP"   "KIF20A"    "RIPK1"     "SNAP23"   
#>  [355] "NEDD4"     "UBAP2L"    "LEMD2"     "DDX27"     "TFEB"      "CENPV"    
#>  [361] "CASC3"     "SLC7A7"    "HMGA1"     "DDX20"     "CSNK1E"    "ING4"     
#>  [367] "MTF1"      "SH3BP1"    "CSTF3"     "FAM104A"   "HMGXB4"    "CALM2"    
#>  [373] "TCEB3"     "ZC3HAV1"   "FAM92A1"   "EIF4H"     "LIMK2"     "ESF1"     
#>  [379] "PPP4R2"    "SMARCA4"   "ZC3H13"    "CXORF23"   "EPB41"     "SQSTM1"   
#>  [385] "WBP11"     "KDM3B"     "ARFGAP2"   "SLC26A2"   "NOP56"     "SPHK2"    
#>  [391] "ARHGDIA"   "ANAPC1"    "TRIM28"    "HSPA4"     "COL4A3BP"  "JADE3"    
#>  [397] "CD2BP2"    "EI24"      "NBN"       "POLA2"     "FAM63A"    "ARHGAP5"  
#>  [403] "LARP4"     "EIF4EBP1"  "OTUD7B"    "NOM1"      "SMAP2"     "CFL1"     
#>  [409] "DST"       "SLTM"      "C2ORF44"   "AMPD3"     "SETD2"     "GPRC5C"   
#>  [415] "CCNK"      "MIER3"     "CDKN2AIP"  "DNTTIP2"   "DPYSL2"    "CTTNBP2NL"
#>  [421] "IFITM3"    "DNM1L"     "UGDH"      "ITPKB"     "PEAK1"     "PARD3"    
#>  [427] "TRIP12"    "TOP2A"     "PRPF40A"   "PDCL3"     "SLC35C2"   "NCOA5"    
#>  [433] "TRMT1"     "IWS1"      "NUFIP2"    "CKAP5"     "SPRED1"    "RPS10"    
#>  [439] "LIPE"      "FAM160A2"  "CXADR"     "MAP2K4"    "ARRB1"     "NUDC"     
#>  [445] "TBC1D1"    "ZNF7"      "TBC1D4"    "ADD3"      "NF1"       "BET1"     
#>  [451] "IFI35"     "THUMPD1"   "ZNF687"    "SLC23A2"   "EPN3"      "ZMYM2"    
#>  [457] "MED1"      "EDC4"      "ETV3"      "RRP1"      "LTBP4"     "CASP7"    
#>  [463] "FOSL2"     "PVRL1"     "LMNA"      "SPTBN1"    "ABI2"      "PRKD2"    
#>  [469] "C11ORF58"  "ANKRD17"   "HN1"       "MLF2"      "PUS10"     "REEP3"    
#>  [475] "RRP9"      "CTR9"      "KANK2"     "SDC1"      "FBXW8"     "CLSPN"    
#>  [481] "BAIAP2"    "PBX2"      "GPSM2"     "MAPK1"     "SIK1"      "MAPK14"   
#>  [487] "HIRIP3"    "GIGYF1"    "AATF"      "PUM1"      "TTI1"      "PDCD4"    
#>  [493] "NUMA1"     "TCF20"     "RTKN"      "SSBP3"     "GORASP2"   "MAPK10"   
#>  [499] "RNF168"    "PSMF1"     "EIF2AK3"   "PRR12"     "MOB1B"     "C12ORF10" 
#>  [505] "LUC7L"     "TRAPPC10"  "BOD1L1"    "CRK"       "YBX1"      "SRSF11"   
#>  [511] "CAP1"      "DLGAP5"    "NIPBL"     "RBM3"      "IGHMBP2"   "PLEKHM1"  
#>  [517] "ZNF106"    "COBLL1"    "DTX2"      "TULP3"     "MDN1"      "ARID4A"   
#>  [523] "BIRC6"     "BSG"       "LLPH"      "STK4"      "NCL"       "PLEKHA5"  
#>  [529] "ERF"       "SNX5"      "SRPK2"     "CTDP1"     "KRT20"     "NOL9"     
#>  [535] "FBL"       "LMBRD2"    "PSMD4"     "FTSJ3"     "PEX1"      "RPL6"     
#>  [541] "KNOP1"     "EIF3D"     "DDX42"     "HSF1"      "TOP1"      "STRN4"    
#>  [547] "SLC16A10"  "SRGAP2"    "STAMBPL1"  "WIPF2"     "ZRANB3"    "HYPK"     
#>  [553] "LARP7"     "MAST4"     "ARPC1B"    "DIP2B"     "GAB1"      "PITPNB"   
#>  [559] "TPR"       "RPL7"      "RBM39"     "FBXO30"    "TNS2"      "PRKAB2"   
#>  [565] "SRP14"     "ETV6"      "CUX1"      "CDCA2"     "KIF2C"     "ARHGEF10L"
#>  [571] "MCM2"      "KIF23"     "NFIC"      "SIN3A"     "HNRNPAB"   "MELK"     
#>  [577] "SLC20A2"   "ZRANB2"    "NUP35"     "MAP4K4"    "STRN3"     "STRIP1"   
#>  [583] "FEZ2"      "RPL37"     "TAGLN2"    "MCM6"      "EPS15"     "KIF4A"    
#>  [589] "PABPN1"    "TSC2"      "RBM25"     "CDCA3"     "ENSA"      "MYH9"     
#>  [595] "SRRT"      "UBE2O"     "POLA1"     "LGR5"      "SUPT6H"    "C10ORF88" 
#>  [601] "TOR1AIP1"  "KIF5B"     "FLNA"      "HCK"       "SUN1"      "ZW10"     
#>  [607] "NPAT"      "HNRNPU"    "PLCB3"     "ARHGEF11"  "DENND5B"   "APBB2"    
#>  [613] "SNTB1"     "SCAF4"     "NCAPH"     "BCAR1"     "HNF1B"     "PCNP"     
#>  [619] "LRRFIP2"   "CBX8"      "SRSF2"     "RPS6KA4"   "PAPOLA"    "INO80C"   
#>  [625] "TSR3"      "PSD4"      "ARHGEF28"  "MAGI3"     "SDC2"      "KLC1"     
#>  [631] "RNF8"      "MINK1"     "CIC"       "PIGB"      "ZC3HC1"    "AARSD1"   
#>  [637] "R3HDM2"    "SNTB2"     "SHROOM3"   "GCFC2"     "SNX2"      "BCL9L"    
#>  [643] "RAB3GAP1"  "MUS81"     "NUP153"    "ALAD"      "NFKB1"     "RIN2"     
#>  [649] "TJAP1"     "BNIP2"     "NIFK"      "FARP1"     "KLC2"      "UTP18"    
#>  [655] "ZZZ3"      "FAF1"      "IQSEC1"    "BCR"       "ZFR"       "AKT1"     
#>  [661] "TUBA1B"    "ACLY"      "ARMC1"     "MEPCE"     "SCRIB"     "TMEM245"  
#>  [667] "DEPTOR"    "MORC3"     "NEDD4L"    "RBL1"      "AEBP2"     "ROCK2"    
#>  [673] "CDC26"     "PML"       "PEA15"     "UACA"      "SH3BP4"    "NUP133"   
#>  [679] "MKI67"     "RBM10"     "RNMT"      "AKIRIN2"   "SPRY4"     "AKAP13"   
#>  [685] "KIFAP3"    "TMEM63B"   "DMXL1"     "ARFIP2"    "MARK2"     "SMARCAD1" 
#>  [691] "RPRD2"     "HMHA1"     "VTI1B"     "LPP"       "NAV1"      "PRPF38A"  
#>  [697] "DCP2"      "TAB2"      "MTSS1"     "HTATSF1"   "TICRR"     "PRPF4B"   
#>  [703] "OTUD4"     "EPB41L2"   "DHX16"     "PARD6B"    "RBM17"     "RBM6"     
#>  [709] "MLLT6"     "SPTAN1"    "MPHOSPH10" "HNRNPA2B1" "ZZEF1"     "BRD8"     
#>  [715] "NCOA3"     "CGN"       "EPS8L2"    "MKL2"      "SYNE2"     "USP10"    
#>  [721] "RAB3IP"    "MED15"     "PCGF6"     "AAK1"      "KIAA1468"  "RBM15"    
#>  [727] "KIAA0430"  "FRA10AC1"  "ZBED9"     "EIF4B"     "LRRC8A"    "MRE11A"   
#>  [733] "KIAA1598"  "SNX17"     "HDGF"      "SF3A1"     "RSF1"      "REPS1"    
#>  [739] "TMOD3"     "CBX3"      "SLC9A6"    "PCIF1"     "AGFG1"     "PHAX"     
#>  [745] "ARHGAP1"   "SSB"       "SMEK1"     "RAD18"     "VAMP8"     "USP4"     
#>  [751] "SPIRE2"    "PAWR"      "ABL2"      "NOP2"      "MCRS1"     "RAB11FIP5"
#>  [757] "LASP1"     "STK24"     "SDPR"      "TNS1"      "PNISR"     "CASP3"    
#>  [763] "ZUFSP"     "FRMD4B"    "CNPY4"     "PHLDB2"    "DLGAP4"    "SLC4A7"   
#>  [769] "METAP2"    "NCOR1"     "HNRNPH1"   "IRF2BP2"   "TMEM230"   "URI1"     
#>  [775] "VCL"       "KMT2A"     "SUFU"      "CES5A"     "STXBP5"    "NUP205"   
#>  [781] "RABEP1"    "NCAPD2"    "RPS6KA1"   "BMI1"      "ZFC3H1"    "LRRC41"   
#>  [787] "USP39"     "GPN1"      "TCEAL5"    "JUN"       "MLLT4"     "NUCKS1"   
#>  [793] "FLNC"      "SH3PXD2B"  "NECAP2"    "MYO9B"     "ZC3H11A"   "NOL4L"    
#>  [799] "DENND4C"   "GAPVD1"    "TRIM24"    "ZNF608"    "HDAC6"     "COIL"     
#>  [805] "SORD"      "SLC33A1"   "DNMT1"     "FAM91A1"   "HNRNPC"    "FAM83H"   
#>  [811] "NPM3"      "CD44"      "SMCR8"     "GTF3C4"    "CTTN"      "CHAF1B"   
#>  [817] "VPS26B"    "TRIP11"    "TRA2A"     "PRUNE2"    "INTS6"     "NUFIP1"   
#>  [823] "C2ORF49"   "ZAK"       "CAMK2G"    "TRIO"      "SRRM2"     "RFTN1"    
#>  [829] "API5"      "SAV1"      "SEC22B"    "NPM1"      "OPTN"      "ALS2"     
#>  [835] "EEF2"      "APOBR"     "SRM"       "CTIF"      "PLEKHA6"   "NVL"      
#>  [841] "EIF1"      "HNRNPK"    "U2AF2"     "RRAD"      "SLC16A1"   "ZFHX3"    
#>  [847] "UBR5"      "DOCK5"     "CDC5L"     "ATAD2"     "KANK1"     "IRS2"     
#>  [853] "GOLGB1"    "TMSB10"    "FAM195A"   "ZC3H8"     "ZFP36L1"   "NDRG3"    
#>  [859] "MIA3"      "FHOD1"     "CAMSAP2"   "RFC1"      "BCKDHA"    "CPD"      
#>  [865] "TNS3"      "ATG2B"     "PPP1R18"   "UCK2"      "PHF14"     "CEP97"    
#>  [871] "MAVS"      "SMG9"      "CCT8"      "MAP1S"     "KANSL1"    "TJP2"     
#>  [877] "CBX5"      "TXLNA"     "ESAM"      "YWHAE"     "IRF3"      "PRPF3"    
#>  [883] "AKT1S1"    "PHACTR4"   "BICC1"     "PHC3"      "TTC7A"     "RNF20"    
#>  [889] "NUP188"    "ATRX"      "KIF21A"    "KIAA1715"  "IBTK"      "TOX4"     
#>  [895] "RPS20"     "PLEKHA7"   "EIF4G1"    "SUPT5H"    "BCL9"      "JAG1"     
#>  [901] "ZC3H14"    "PSRC1"     "CPEB4"     "UFL1"      "PRKD3"     "CDK17"    
#>  [907] "C1ORF52"   "ARMC10"    "RBBP6"     "RABEPK"    "MAST2"     "BRCA1"    
#>  [913] "FLRT1"     "DAXX"      "FAM76B"    "CCDC88A"   "DPF2"      "PDZD8"    
#>  [919] "PTPN12"    "SUB1"      "ATXN2L"    "SMARCC2"   "STK11IP"   "RANGAP1"  
#>  [925] "TLK2"      "NUP50"     "EML4"      "GRAMD3"    "UBAP1"     "NASP"     
#>  [931] "RBM8A"     "NOLC1"     "GINS2"     "STRN"      "EPS15L1"   "PTPRG"    
#>  [937] "LRRFIP1"   "NSFL1C"    "FXR1"      "SAFB2"     "DIDO1"     "MED14"    
#>  [943] "ULK1"      "ARHGAP21"  "MKL1"      "PPP1R10"   "PLEKHG2"   "CLIP1"    
#>  [949] "SYNRG"     "ZNF281"    "CDK12"     "ETHE1"     "ELF1"      "GOLGA5"   
#>  [955] "PTPN21"    "APLF"      "POF1B"     "TP53BP1"   "MDC1"      "SNX7"     
#>  [961] "LSM14B"    "PLEKHA1"   "TP53BP2"   "SF3B1"     "TMPO"      "PAXBP1"   
#>  [967] "SLMAP"     "LRP1"      "CD2AP"     "FKBP15"    "PEX14"     "CNPY2"    
#>  [973] "GATAD2B"   "DSP"       "EIF5B"     "NUCB1"     "ZCCHC11"   "OSBPL11"  
#>  [979] "RSL1D1"    "ARHGEF40"  "TMEM55A"   "METTL1"    "RPS6KA3"   "PHLDB1"   
#>  [985] "SYNPO"     "PDLIM7"    "BNIP3"     "RASA3"     "DNAJC2"    "SLIRP"    
#>  [991] "ARFGAP1"   "RAD51AP1"  "ZMYM4"     "MAP3K3"    "WIBG"      "CNOT3"    
#>  [997] "PPIL4"     "CTNND1"    "KPNA3"     "HNRNPUL2"  "NCBP1"     "DUSP7"    
#> [1003] "TRAF7"     "LYSMD2"    "FOXK1"     "SMTN"      "XRCC6"     "MYO18A"   
#> [1009] "MBD3"      "SBNO1"     "NEK9"      "ABCF1"     "PPFIBP1"   "HMGN1"    
#> [1015] "AKAP10"    "TRIM2"     "KRT18"     "TAB3"      "RICTOR"    "MDH1"     
#> [1021] "PRRC2C"    "RBM14"     "HNRNPA1"   "ARFGEF1"   "CKAP4"     "PNN"      
#> [1027] "CDK4"      "MRPL23"    "NME2"      "ASUN"      "HS1BP3"    "GMIP"     
#> [1033] "ZNRF2"     "BRD7"      "ZYX"       "SH2B1"     "PCM1"      "EIF6"     
#> [1039] "PRRC2B"    "DDX46"     "MYO1E"     "MTDH"      "PPIP5K2"   "SLC9A3R1" 
#> [1045] "SFR1"      "GTSE1"     "SERBP1"    "PRKAB1"    "CNOT2"     "PJA1"     
#> [1051] "RIN1"      "NR2C2AP"   "WDR62"     "CHERP"     "NAB2"      "ELMSAN1"  
#> [1057] "CTNNB1"    "CEP170"    "GFPT2"     "WDR70"     "SOS1"      "AHCTF1"   
#> [1063] "ARHGEF7"   "CCNT1"     "PPHLN1"    "MAPRE2"    "PCBP1"     "PXN"      
#> [1069] "UBA2"      "ETL4"      "ASPSCR1"   "MAP7D1"    "MARK3"     "ARFGEF2"  
#> [1075] "SRA1"      "SLAIN2"    "ADRBK1"    "NUP93"     "HSPB8"     "YTHDC2"   
#> [1081] "THUMPD3"   "SMG6"      "NMT1"      "UBXN7"     "TFIP11"    "AP3B1"    
#> [1087] "EMG1"      "NOL10"     "KLHL6"     "ADNP"      "DDX55"     "NCOR2"    
#> [1093] "CEP170B"   "PDAP1"     "HAUS6"     "TCOF1"     "LYSMD3"    "ZMYND8"   
#> [1099] "TRRAP"     "ERBB2IP"   "ATF7"      "ASAP2"     "CAST"      "RPS17"    
#> [1105] "PDXDC1"    "SRRM1"     "PPP1R13L"  "FAT1"      "HDLBP"     "NSUN2"    
#> [1111] "TTLL12"    "SPRY1"     "ERRFI1"    "PLCG1"     "MARCKS"    "CHD8"     
#> [1117] "PKP4"      "RAI14"     "CDK16"     "PRKAA1"    "PID1"      "TFAP4"    
#> [1123] "MTUS2"     "FAM207A"   "MTA3"      "RALGAPA2"  "IFITM2"    "SLC38A2"  
#> [1129] "PFAS"      "EIF4A3"    "CDC42EP1"  "NMD3"      "LRP4"      "PTPN1"    
#> [1135] "TJP1"      "TMEM115"   "TBC1D25"   "RTN4"      "CWC27"     "TXNL1"    
#> [1141] "NFATC2IP"  "SOD1"      "LEO1"      "ZCCHC8"    "CC2D1B"    "TPD52L2"  
#> [1147] "RPS3"      "FXR2"      "HNRNPA3"   "SVIL"      "C19ORF47"  "SLK"      
#> [1153] "ARHGAP35"  "FNBP4"     "MCM3"      "SNIP1"     "EIF3J"     "WDHD1"    
#> [1159] "RALY"      "DSTN"      "LATS1"     "CCNL1"     "TBX3"      "PALLD"    
#> [1165] "GTF2F1"    "PURB"      "WIZ"       "DDX51"     "WDR75"     "PPP6R3"   
#> [1171] "NUP98"     "RPRD1B"    "DMWD"      "AHNAK"     "SFSWAP"    "SH3GL1"   
#> [1177] "ABLIM1"    "MTUS1"     "PTMA"      "TAF7"      "PTPRC"     "LUC7L2"
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
#> 1: 5.617321e-34 1.291984e-32 1.51610760  0.4545874  2.1242699 1049
#> 2: 8.757515e-01 8.757515e-01 0.05184576 -0.3858994 -0.6638719    3
#> 3: 8.757515e-01 8.757515e-01 0.05184576 -0.3858994 -0.6638719    3
#> 4: 1.678465e-12 9.651174e-12 0.91011973  0.4320662  1.9209053  441
#> 5: 6.375163e-04 1.332989e-03 0.47727082  0.4375812  1.6539977  104
#> 6: 6.193414e-03 9.039041e-03 0.40701792  0.4170298  1.5294317   88
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
