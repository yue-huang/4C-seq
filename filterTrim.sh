# 1. Select reads with inverse PCR primers and trim primer sequences
for f in *_ce1*.fq; do
echo "Splitting: $f";
cat "$f" | /usr/local/bin/fastx_barcode_splitter.pl --bcfile /Users/daphnehuang/Downloads/primers_all_trim.txt --prefix "temp_" --suffix ".fq" --bol --partial 1 --mismatches 10
cat temp_CE_D.fq temp_CE_H.fq > temp.fq;
fastx_trimmer -f 19 -i temp.fq -o "$f"_trimmed;
rm temp*.fq;
echo;
done # On average 90-95% reads contain the expected two inverse PCR primers.
