indmiss<-read.table(file="data/plink.imiss", header=TRUE)
snpmiss<-read.table(file="data/plink.lmiss", header=TRUE)
# read data into R 

pdf("results/histimiss.pdf") #indicates pdf format and gives title to file
hist(indmiss[,6],main="Histogram individual missingness") #selects column 6, names header of file

pdf("results/histlmiss.pdf") 
hist(snpmiss[,5],main="Histogram SNP missingness")  
dev.off() # shuts down the current device
