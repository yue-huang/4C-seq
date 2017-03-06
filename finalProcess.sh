# 8. Finally process the files for visualization in genome browser
for f in *_padj.bedgraph; do
echo "track name=$f" > temp.bedgraph;
bedtools merge -i "$f" >> temp.bedgraph;
mv temp.bedgraph "$f".bed;
rm $f;
done

for f in *_wt.bedgraph; do
echo "track name=$f type=bedGraph visibility=full color=200,0,0 maxHeightPixels=50:100:11" > temp.bedgraph;
cat $f >> temp.bedgraph;
mv temp.bedgraph $f;
done

for f in *_del.bedgraph; do
echo "track name=$f type=bedGraph visibility=full color=0,100,0 maxHeightPixels=50:100:11" > temp.bedgraph;
cat $f >> temp.bedgraph;
mv temp.bedgraph $f;
done

for f in *_del-wt_pos.bedgraph; do
echo "track name=$f type=bedGraph visibility=full color=0,180,0 maxHeightPixels=50:100:11" > temp.bedgraph;
cat $f >> temp.bedgraph;
mv temp.bedgraph $f;
done

for f in *_del-wt_neg.bedgraph; do
echo "track name=$f type=bedGraph visibility=full color=200,0,0 maxHeightPixels=50:100:11" > temp.bedgraph;
cat $f >> temp.bedgraph;
mv temp.bedgraph $f;
done
