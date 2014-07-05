### Calculate mean RF distance between intra-gene trees ###

##  Direct R to data file location
#setwd("C:/Users/a1201221/ASW/dat/R/exome_rf_test")  # Acer
#setwd("C:/Users/Turbo/Documents/dat/R/exome_rf_test")  # Vaio
library(tools)
setwd("~/temp/exome_rf_test") #TB -debug
filenames=dir(pattern="*.rf")

n=3     # Number of genes (rows) in final file
GENE <- matrix(0, nrow=n, ncol=5)     # Creating empty table for output

for (b in 1:length(filenames)) {
	## Load data matrices from HashRF analysis
	file <- filenames[b]
	T <- as.matrix(read.table(file))
	gene <- paste("GENE",b,sep="")
	
  # Discard diagonal and lower triangle of symmetrical matrix
	T[lower.tri(T, diag=TRUE)] <- NA
	#print(T) ## just to check has done the replacement by NA
	
  row_name<-file_path_sans_ext(file)
  # Calculate mean of upper triangle of symmetrical matrix
	GENE[b,] <- c(mean(T, na.rm=TRUE), sd(T, na.rm=TRUE), median(T, na.rm=TRUE), max(T, na.rm=TRUE), min(T, na.rm=TRUE))

}

tot <- colSums(GENE)
GENE_tot <- as.matrix(GENE[,1]/tot[1])
colnames(GENE_tot) <- c("Norm_Mean")
colnames(GENE) <- c("Mean", "StdDev", "Median", "Max", "Min")
Total <- cbind(GENE, GENE_tot)
Total

pdf("Scatterplot_mean_std_dev.pdf")
plot(Total[,1], Total[,2], main="Plot of Mean vs. Std deviation of Robinson-Foulds gene test across all genes", xlab="Mean", ylab="Std deviation",col="blue",pch=19,cex=1)
text(Total[,1], Total[,2], labels=1:n, pos=2)
dev.off()

pdf("Scatterplot_norm_mean_std_dev.pdf")
plot(Total[,6], Total[,2], main="Plot of Normalised mean vs. Std deviation of Robinson-Foulds gene test across all genes", xlab="Normalised mean", ylab="Std deviation",col="red",pch=19,cex=1)
text(Total[,6], Total[,2], labels=1:n, pos=2)
dev.off()

