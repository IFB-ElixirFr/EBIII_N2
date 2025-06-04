## Chargement des librairies
library(RGCCA)

## SGCCA
res.sgcca_1 <- rgcca(
  blocks = pHGG,
  response = 3,
  ncomp = c(2, 2, 1),
  sparsity = c(0.05, 0.05, 1))

res.sgcca_2 <- rgcca(
  blocks = pHGG,
  response = 3,
  ncomp = c(2, 2, 1),
  sparsity = c(0.3, 0.3, 1))

res.sgcca_3 <- rgcca(
  blocks = pHGG,
  response = 3,
  ncomp = c(2, 2, 1),
  sparsity = c(0.8, 0.8, 1))

## AVE
plot(res.sgcca_1, "AVE")
plot(res.sgcca_2, "AVE")
plot(res.sgcca_3, "AVE")

## Carte des individus
plot(res.sgcca_1, "samples")
plot(res.sgcca_2, "samples")
plot(res.sgcca_3, "samples")

## Coefficients des variables
plot(res.sgcca_1, "weights", comp = 1, block = 1:2)
plot(res.sgcca_1, "weights", comp = 2, block = 1:2)
plot(res.sgcca_2, "weights", comp = 1, block = 1:2)
plot(res.sgcca_2, "weights", comp = 2, block = 1:2)
plot(res.sgcca_3, "weights", comp = 1, block = 1:2)
plot(res.sgcca_3, "weights", comp = 2, block = 1:2)

## Cercle des corrélations
plot(res.sgcca_1, "cor_circle", block = 1)
plot(res.sgcca_1, "cor_circle", block = 2)
plot(res.sgcca_2, "cor_circle", block = 1)
plot(res.sgcca_2, "cor_circle", block = 2)
plot(res.sgcca_3, "cor_circle", block = 1)
plot(res.sgcca_3, "cor_circle", block = 2)

## Validation croisée
res.sgcca.cv <- rgcca_cv(
  blocks = pHGG,
  ncomp = 2,
  par_type = "sparsity",
  response = 3)

## Les meilleurs paramètres
res.sgcca.cv$best_params

## Le modèle avec les meilleurs paramètres
res.opt <- rgcca(res.sgcca.cv)

## AVE - meilleur modèle
plot(res.opt, "AVE")
## Carte des individus - meilleur modèle
plot(res.opt, "samples")
## Coefficients des variables - meilleur modèle
plot(res.opt, "weights", comp = 1, block = 1:2)
plot(res.opt, "weights", comp = 2, block = 1:2)
## Cercles des corrélations - meilleur modèle
plot(res.opt, "cor_circle", block = 1)
plot(res.opt, "cor_circle", block = 2)


