hwe<-read.table (file="results/plink.hwe", header=TRUE)
pdf("results/histhwe.pdf")
hist(hwe[,9],main="Histogram HWE")
dev.off()

hwe_zoom<-read.table (file="results/plinkzoomhwe.hwe", header=TRUE)
pdf("results/histhwe_below_theshold.pdf")
hist(hwe_zoom[,9],main="Histogram HWE: strongly deviating SNPs only")
dev.off()
