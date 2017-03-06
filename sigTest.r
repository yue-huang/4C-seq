# 7. Generate DESeq2 normalized signals and pvalues using DESeq2.
library(DESeq2)
library(stringr)

# Raw reads per H3
raw=read.table(file="total.txt",sep="\t",header=TRUE)
rawnames=apply(raw,1,function(x) paste("chr9",x[1],x[2],sep=":"))
countData <-data.frame(raw[c(-1,-2)],row.names=rawnames)
colData=data.frame(condition=c("deletion","wt","wt","deletion","wt","deletion"),row.names=names(countData))

# construct a DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = colData,
                              design = ~ condition)
dds <- dds[ rowSums(counts(dds)) > 1, ] #prefiltering
# dds <- dds[ rowSums(counts(dds)) > 30, ] #prefiltering v2, didn't use

dds$condition <- relevel(dds$condition, ref="wt") #change the factor level
dds <- DESeq(dds) #DE analysis
res <- results(dds) #result table
summary(res)
sum(res$padj < 0.05, na.rm=TRUE)

# Generate DESeq2 normalized signal bedgraph
dds.normalized=as.data.frame(counts(dds, normalized=T)) # Normalized counts
mean.wt=apply(dds.normalized,1,function(x) mean(as.numeric(x[which(colData$condition=="wt")])))
mean.del=apply(dds.normalized,1,function(x) mean(as.numeric(x[which(colData$condition=="deletion")])))
ave_del=t(rbind(mean.wt,mean.del,mean.del-mean.wt))
a=str_split_fixed(rownames(ave_del), ":", 3)
ave_del=cbind(a,ave_del)

# Customized export
write.table(ave_del[,c(1:3,4)],file="ce1_g6_h3_wt.bedgraph",sep="\t",quote=FALSE,row.names=FALSE,col.names=FALSE)
write.table(ave_del[,c(1:3,5)],file="ce1_g6_h3_del.bedgraph",sep="\t",quote=FALSE,row.names=FALSE,col.names=FALSE)
write.table(ave_del[ave_del[,6]>0,c(1:3,6)],file="ce1_g6_h3_del-wt_pos.bedgraph",sep="\t",quote=FALSE,row.names=FALSE,col.names=FALSE)
write.table(ave_del[ave_del[,6]<0,c(1:3,6)],file="ce1_g6_h3_del-wt_neg.bedgraph",sep="\t",quote=FALSE,row.names=FALSE,col.names=FALSE)

# Generate regions with adjp-value<0.05
test=as.data.frame(res)
test=test[complete.cases(test),]
a=str_split_fixed(rownames(test), ":", 3)
test2=cbind(test,a)
test3=test2[c(7,8,9,6)]
test4=test3[test3$padj<0.05,]
test5=test4[1:3]

# Customized export
write.table(test5,file="ce1_g6_h3_padj.bedgraph",sep="\t",row.names=FALSE,col.names=FALSE,quote=FALSE)
rm(list=ls())
