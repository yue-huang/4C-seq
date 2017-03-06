# 5. Generate RPM per H3 for UCSC GB, and raw reads per H3 for sliding window using r3Cseq.
setwd("/Users/yue/Desktop/4Cseq_mac/g6")
library(BSgenome.Hsapiens.UCSC.hg19.masked)
library(r3Cseq)

myBatch_obj<-new("r3CseqInBatch",organismName='hg19',restrictionEnzyme='HindIII',
                      isControlInvolved=TRUE,bamFilesDirectory="/Users/yue/Desktop/4Cseq_mac/qc",viewpoint_chromosome='chr9',
                      viewpoint_primer_forward='CCGAGGATGATGGAAGCTT',
                      viewpoint_primer_reverse='TTGTTTGTTTTGAGAAAGGATC',
                      BamExpFiles=c("10_qc63_2_ce1_TCAACTG.fq_trimmed_sorted.bam_filtered.bam",
                                    "11_qc56-1_ce1_ACCCACT_trimmed.fq_sorted.bam_filtered.bam",
                                    "1_gm_ce1_GAGGCGT.fq_trimmed.fq_sorted.bam_filtered.bam",
                                    "2_13_qc13-2_ce1_GGGTCAA.fq_trimmed_sorted.bam_filtered.bam",
                                    "4_qc16_ce1_GTCTGAT.fq_trimmed_sorted.bam_filtered.bam"),
                                    expBatchLabel=c("10_qc63_2_ce1",
                                                    "11_qc56-1_ce1",
                                                    "1_gm_ce1",
                                                       "2_13_qc13-2_ce1",
                                                       "4_qc16_ce1"),
                     BamContrFiles="7_qc13_1_ce1_ACGTCTG.fq_trimmed_sorted.bam_filtered.bam",
                     contrBatchLabel="7_qc13_1_ce1")

getBatchRawReads(myBatch_obj)
getBatchReadCountPerRestrictionFragment(myBatch_obj) #slow

# Export reads table
rawreads=as.data.frame(myBatch_obj@readCountTable)

totalreads=colSums(rawreads[-c(1:4)])
temp=apply(rawreads,1,function(x) as.numeric(x[-c(1:4)])/as.numeric(totalreads)*1000000)
rawreads_RPM=cbind(rawreads,t(temp))

# Export RPM bedgraph files for UCSC GB
for (i in 1:((ncol(rawreads_RPM)-4)/2))
{filename=paste(names(rawreads_RPM[i+4]),"bedgraph",sep=".");
partial=rawreads_RPM[c(1:3,i+4+((ncol(rawreads_RPM)-4)/2))]
write.table(partial,file=filename,quote=FALSE,sep="\t",row.names=FALSE,col.names=FALSE)
}

# Export 4 gene raw reads for DESeq2
for (i in 1:((ncol(rawreads_RPM)-4)/2))
{filename=paste(names(rawreads_RPM[i+4]),"4gene","txt",sep=".");
partial=rawreads_RPM[rawreads_RPM$space=="chr9" & rawreads_RPM$start>126130000 & rawreads_RPM$end<127200000, c(2:3,i+4)]
write.table(partial,file=filename,quote=FALSE,sep="\t",row.names=FALSE,col.names=FALSE)
}
