
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Harmonizome

<!-- badges: start -->
<!-- badges: end -->

The goal of Harmonizome is to provide a fast interface to download and
perform functional and gene set enrichment analysis.

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
#> =>----------------------------- 4% | ETA: 45s ===>---------------------------
#> 9% | ETA: 26s ====>-------------------------- 13% | ETA: 19s
#> =====>------------------------- 17% | ETA: 19s =======>-----------------------
#> 22% | ETA: 16s ========>---------------------- 26% | ETA: 13s
#> =========>--------------------- 30% | ETA: 11s ==========>--------------------
#> 35% | ETA: 10s ============>------------------ 39% | ETA: 9s
#> =============>----------------- 43% | ETA: 8s ==============>----------------
#> 48% | ETA: 7s ================>-------------- 52% | ETA: 6s
#> =================>------------- 57% | ETA: 5s ==================>------------
#> 61% | ETA: 5s ====================>---------- 65% | ETA: 4s
#> =====================>--------- 70% | ETA: 4s ======================>--------
#> 74% | ETA: 3s =======================>------- 78% | ETA: 2s
#> =========================>----- 83% | ETA: 2s ==========================>----
#> 87% | ETA: 2s ===========================>--- 91% | ETA: 1s
#> =============================>- 96% | ETA: 1s
```

``` r
head(silacdrug_ds)
#> # A tibble: 6 x 3
#>   Code      name                                                          symbol
#>   <chr>     <chr>                                                         <chr> 
#> 1 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ NPAT  
#> 2 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ SYNE2 
#> 3 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ TCEB3 
#> 4 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ MAPRE2
#> 5 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ SMARC~
#> 6 silacdrug 10min_PPase_inhibitors vs ctrl_Hepa1-6 (Mouse) [18846507]/SI~ SH3GL1
```
