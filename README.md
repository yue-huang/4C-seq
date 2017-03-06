# 4Cseq
Analysis of circular chromosome conformation capture-sequencing

## Step 1. Filter and trim reads
```
filterTrim.sh
```

## Step 2. Align reads to genome
```
align.sh
```

## Step 3. Convert for visualization in genome browser
```
bamToBw.sh
```

## Step 4. Discard reads in deleted region for subsequent counting
```
filter.sh
```

## Step 5. Generate reads per fragment using r3CSeq package
```
readsPerFragment.r
```

## Step 6. Generate reads per sliding window (optional)
```
sliding_window_center_1kb.py
overlap_1kb.py
```

## Step 7. Significance test using DESeq2 package
```
sigTest.r
```

## Step 8. Final processing
```
finalProcess.sh
```



