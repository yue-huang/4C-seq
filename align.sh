# 2. align files
for f in *_trimmed.fq; do
echo "Aligning: $f";
bowtie2 -x hg19 "$f" -S temp.sam;
samtools view -S -b temp.sam > temp.bam;
samtools sort -o "$f"_sorted.bam temp.bam;
rm temp.sam; rm temp.bam;
done
