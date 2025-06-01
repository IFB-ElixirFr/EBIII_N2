maf_freq <- read.table("results/MAF_check.frq", header =TRUE, as.is=T)
pdf("results/MAF_distribution.pdf")
hist(maf_freq[,5],main = "MAF distribution", xlab = "MAF")
dev.off()


