# 6.1 Generate coordinates of the 1kb center for each window
print("1kb_center")
# start is 126133000+window/2, end is 127195000-window/2+1000,
# cos the right end is not included.
for i in range(126133500,127195500,1000):
    print('chr9:',i-500,':',i+500,sep='')
