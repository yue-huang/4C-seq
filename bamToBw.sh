# 3. convert bam to bw to visualize in UCSC GB
for f in *_sorted.bam; do
genomeCoverageBed -split -bg -ibam "$f" > temp.bedgraph;
sort -k1,1 -k2,2n temp.bedgraph > temp_sorted.bedgraph;
perl /Users/oltzlab/UCSC_tools/Bedgraphprep.pl temp_sorted.bedgraph temp_accepted_hits_sorted_clear.bedgraph;
bedGraphToBigWig temp_accepted_hits_sorted_clear.bedgraph /Users/oltzlab/UCSC_tools/hg19.chrom.sizes "$f".bw;
rm temp.bedgraph; rm temp_sorted.bedgraph; rm temp_accepted_hits_sorted_clear.bedgraph;
echo;
done
