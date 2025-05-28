# avoir dans le dossier :
# monjeu_de_donnees.bed
# monjeu_de_donnees.bim
# monjeu_de_donnees.fam
# 
# Puis lance simplement :
# bash $ make
# Tu obtiendras dans verif_sexe/ :
# *_sex_corrige.* → sexes corrigés
# *_sans_sex_errors.* → individus à problème exclus

# ========================
# Makefile : Vérif Sexe GWAS
# ========================

# Configuration
AUTOSOMES := autosomes
CHR_X := chromosomeX
OUTDIR := verif_sexe
PLINK19 := plink
PLINK2 := plink2
MERGED := $(OUTDIR)/merged_with_chrX

# Liste de fusion à créer
$(OUTDIR)/merge_list.txt:
	mkdir -p $(OUTDIR)
	echo "$(CHR_X)" > $@

# Fusion autosomes + chrX
$(MERGED).bed: $(AUTOSOMES).bed $(CHR_X).bed $(OUTDIR)/merge_list.txt
	$(PLINK19) --bfile $(AUTOSOMES) \
	           --merge-list $(OUTDIR)/merge_list.txt \
	           --make-bed \
	           --out $(MERGED)

# Vérification sexe
$(OUTDIR)/sex_check.sexcheck: $(MERGED).bed
	$(PLINK19) --bfile $(MERGED) --check-sex --out $(OUTDIR)/sex_check

# Le reste ne change pas, sauf qu'on fait référence à $(AUTOSOMES) pour les données finales corrigées
$(OUTDIR)/sex_discordants.txt: $(OUTDIR)/sex_check.sexcheck
	awk '$$6 == "PROBLEM" {print $$1, $$2}' $< > $@

$(OUTDIR)/sexe_corrige.txt: $(OUTDIR)/sex_check.sexcheck
	awk '$$6 == "PROBLEM" {print $$1, $$2, $$5}' $< > $@

# Correction ou exclusion à partir des AUTOSOMES
$(OUTDIR)/$(AUTOSOMES)_sex_corrige.bed: $(OUTDIR)/sexe_corrige.txt
	$(PLINK2) --bfile $(AUTOSOMES) \
	          --update-sex $< \
	          --make-bed \
	          --out $(OUTDIR)/$(AUTOSOMES)_sex_corrige

$(OUTDIR)/$(AUTOSOMES)_sans_sex_errors.bed: $(OUTDIR)/sex_discordants.txt
	$(PLINK2) --bfile $(AUTOSOMES) \
	          --remove $< \
	          --make-bed \
	          --out $(OUTDIR)/$(AUTOSOMES)_sans_sex_errors

