# 6.2 Allocate reads in each sliding window
# Usage: python3 overlap_1kb.py *4gene.txt
# paste outputs of overlap_1kb.py and sliding_window_center_1kb.py, as input for sigTest.r
import sys
inputFileName = sys.argv[1]
linelist=[]
currentlist=[]
end=126142000
sliding_window=[]
print(inputFileName)
with open(inputFileName) as bg:
    for line in bg:
        line = line.strip()
        if len(line) == 0:
            continue
        linelist=line.split("\t")
        linelist[0]=round(int(linelist[0])/1000)*1000
        linelist[1]=round(int(linelist[1])/1000)*1000
        if linelist[0]==linelist[1]:
            continue
        if linelist[0]>end:
            currentlist.extend([0]*int((linelist[0]-end)/1000))
        n=int((linelist[1]-linelist[0])/1000)
        signal=int(linelist[2])/n
        currentlist.extend([signal]*n)
        while len(currentlist)>=1:
            print((round(currentlist[0])))
            del currentlist[:1]
        end=linelist[1]
