source("https://bioconductor.org/biocLite.R")
biocLite(c("AnnotationDbi", "impute","GO.db", "preprocessCore"))
site="https://mirrors.tuna.tsinghua.edu.cn/CRAN"
install.packages(c("WGCNA", "stringr", "reshape2"), repos=site)



library(WGCNA)
library(reshape2)
library(stringr)

fpkm=read.csv("/home/lirz/pra2/fpkm.csv",header = T)
datTraits=read.csv("/home/lirz/pra2/datTraits.csv",header = T)
row.names(fpkm)=fpkm[,1]
fpkm=fpkm[,-1]
row.names(datTraits)=datTraits[,1]
datTraits=datTraits[,-1]


RNAseq_voom <- fpkm
WGCNA_matrix = t(RNAseq_voom[order(apply(RNAseq_voom,1,mad), decreasing = T)[1:5000],])
datExpr0 <- WGCNA_matrix 
datExpr <- datExpr0 


library(GEOquery)
a=getGEO('GSE48213')
metadata=pData(a[[1]])[,c(2,10,12)]
datTraits = data.frame(gsm=metadata[,1],
                       cellline=trimws(sapply(as.character(metadata$characteristics_ch1),function(x) strsplit(x,":")[[1]][2])),
                       subtype=trimws(sapply(as.character(metadata$characteristics_ch1.2),function(x) strsplit(x,":")[[1]][2]))
)



powers = c(c(1:10), seq(from = 12, to=20, by=2))
sft = pickSoftThreshold(datExpr, powerVector = powers, verbose = 5)
par(mfrow = c(1,2))
cex1 = 0.9

plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     xlab="Soft Threshold (power)",ylab="Scale Free Topology Model Fit,signed R^2",type="n",
     main = paste("Scale independence"))
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
     labels=powers,cex=cex1,col="red")
abline(h=0.90,col="red")
plot(sft$fitIndices[,1], sft$fitIndices[,5],
     xlab="Soft Threshold (power)",ylab="Mean Connectivity", type="n",
     main = paste("Mean connectivity"))
text(sft$fitIndices[,1], sft$fitIndices[,5], labels=powers, cex=cex1,col="red")


net = blockwiseModules(
  datExpr,
  power = sft$powerEstimate,
  maxBlockSize = 6000,
  TOMType = "unsigned", minModuleSize = 30,
  reassignThreshold = 0, mergeCutHeight = 0.25,
  numericLabels = TRUE, pamRespectsDendro = FALSE,
  saveTOMs = TRUE,
  saveTOMFileBase = "AS-green-FPKM-TOM",
  verbose = 3
)
table(net$colors)
