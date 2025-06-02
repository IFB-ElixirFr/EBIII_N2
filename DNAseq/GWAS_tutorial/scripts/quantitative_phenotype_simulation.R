# Charger les bibliothèques
library(dplyr)
library(data.table)

# 1. Charger les données génétiques au format .raw
raw_file <- "data/HapMap_3_r3_13_thinned.raw"  # fichier réduit à ~50 000 SNPs
geno <- fread(raw_file)

# 2. Extraire uniquement la matrice génotypique (sans les 6 premières colonnes : FID, IID, etc.)
geno_snps <- as.matrix(geno[, -(1:6)])

# 3. Choisir 100 SNPs causals aléatoirement
set.seed(123)  # reproductibilité
n_causal <- 100
causal_idx <- sample(ncol(geno_snps), n_causal)

# 4. Générer les effets additifs aléatoires pour chaque SNP causal
beta <- rnorm(n_causal, mean = 0, sd = 1)

# 5. Calculer le phénotype : somme pondérée des génotypes causals + bruit
X_causal <- geno_snps[, causal_idx]
pheno <- X_causal %*% beta + rnorm(nrow(geno_snps), mean = 0, sd = 1)
pheno[is.na(pheno)] <- -9

# 6. Ajouter le phénotype à la table d'origine
geno$PHENO_SIM <- as.numeric(pheno)

# 7. Sauvegarder le phénotype simulé
fwrite(geno[, .(FID, IID, PHENO_SIM)], file = "data/simulated_pheno.txt", sep = "\t")

cat("✅ Phenotype simulated and saved to simulated_pheno.txt\n")