## Changer le répertoire de travail
setwd("LE_CHEMIN")

## Copie des données
file.copy(
  from = "/shared/projects/2514_ebiii_n2/integration",
  to = ".",
  recursive = TRUE)

## Import des données dans l'environnement
cgh <- read.delim("data/pHGG_CGH.tsv")
gex <- read.delim("data/pHGG_GE.tsv")
loc <- read.delim("data/pHGG_loc.tsv")

## Check des rownames
rownames(cgh)
rownames(gex)
rownames(loc)

## Sont-ils les mêmes ?
rownames(cgh) == rownames(gex)
rownames(loc) == rownames(gex)
all(rownames(cgh) == rownames(gex))
all(rownames(loc) == rownames(gex))

## Création de la liste pour RGCCA
pHGG <- list(GE = ge, CGH = cgh, LOC= loc)

