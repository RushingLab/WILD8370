## Color palette
WILD8370_colors <- data.frame(name = c("primary", "secondary", "success", "info", "warning", "danger", "light", "dark"),
                              value = c("#446E9B", "#999999", "#3CB521", "#3399F3", "#D47500", "#CD0200", "#eeeeee", "#333333"))
WILD8370_colors$value <- as.character(WILD8370_colors$value)

## Polar bear survival data
SurvPriorDat <- read.csv("data-raw/SurvAF_PublishedKnowledge.csv")

SurvPriorDat <- dplyr::filter(SurvPriorDat, !is.na(AFse))

SurvPriorDat <- dplyr::select(SurvPriorDat, AF, AFse, Reference)

SurvPriorData <- dplyr::rename(SurvPriorDat, phi = AF, se = AFse)

### Falcons ----

falcons <- read.table('data-raw/falcons.txt', header =  TRUE)


### Pelicans ----

pelicans <- read.csv("data-raw/colony_count_simple.csv")

### Sheep ----

ewe_counts <- read.csv("data-raw/EweMatrix_KSinclair.csv")
ewe_counts <- dplyr::select(ewe_counts, -X)


lamb_counts <- read.csv("data-raw/LambMatrix_KSinclair.csv")
lamb_counts <- dplyr::select(lamb_counts, -X)


### Salamanders ----

salamanders <- read.csv("data-raw/salamander.csv")

### jay data ----
jaydata <- read.csv("data-raw/jayData.csv")

usethis::use_data(WILD8370_colors, SurvPriorData, jaydata, falcons, pelicans, ewe_counts, lamb_counts, salamanders, overwrite = TRUE)

