# 4. filter CS2-4 deletion subclone bam files for r3Cseq counting
for f in *.bam; do
echo "Filtering: $f";
samtools view "$f" -b -o output_inRegions.bam -U "$f"_filtered.bam -L deletion_region.bed;
rm output_inRegions.bam;
done
