# plot mds 

setwd("/Users/cvb871/Dropbox/Plantago/GBS/MDS/")
distMatrix = read.table("PmajorNoBlanks_6Discarded.dist", skip = 2, nrows = 385, as.is=T)
sampNames=distMatrix[,1]
distMatrix = distMatrix[,-1]

mdsFit = cmdscale(d=distMatrix, k=12, eig=TRUE)
mds = mdsFit$points
colorcode = read.table("PmajorNoBlanks_6Discarded_mismatches5_coloursk6.list", as.is=T)
colors = colorcode$V2
popn = colorcode$V1
makeTransparent<-function(someColor, alpha=100)
{
  newColor<-col2rgb(someColor)
  apply(newColor, 2, function(curcoldata){rgb(red=curcoldata[1], green=curcoldata[2],
                                              blue=curcoldata[3],alpha=alpha, maxColorValue=255)})
}
colorback = makeTransparent(colors, 120)
colorpop = tapply(colors, popn, function(x) {unique(x)})
pdf(file="PmajorNoBlanks_20REF_6Discarded.MDS.6coordsK6.pdf")
par(mar=c(5,4,4,2)+0.1, oma=c(0,0,0,0))
layout(1)
plot(mds[,1], mds[,2], type="n", xlab="Coordinate 1", ylab="Coordinate 2")
text(mds[,1], mds[,2], label=colorcode$V1, cex=0.8, col=colorback, font=1)
text(tapply(mds[,1], popn, mean), tapply(mds[,2], popn, mean), label=names(colorpop), 
     cex=1.1, col=colorpop, font=2)
#points(tapply(mds[,1], popn, mean), tapply(mds[,2], popn, mean), pch=21, cex=1.5, bg=colorpop, col="black")
plot(mds[,3], mds[,4], type="n", xlab="Coordinate 3", ylab="Coordinate 4")
text(mds[,3], mds[,4], label=colorcode$V1, cex=0.8, col=colorback, font=1)
text(tapply(mds[,3], popn, mean), tapply(mds[,4], popn, mean), label=names(colorpop), 
     cex=1.1, col=colorpop, font=2)
plot(mds[,5], mds[,6], type="n", xlab="Coordinate 5", ylab="Coordinate 6")
text(mds[,5], mds[,6], label=colorcode$V1, cex=0.8, col=colorback, font=1)
text(tapply(mds[,5], popn, mean), tapply(mds[,6], popn, mean), label=names(colorpop), 
     cex=1.1, col=colorpop, font=2)
plot(mds[,2], mds[,3], type="n", xlab="Coordinate 2", ylab="Coordinate 3")
text(mds[,2], mds[,3], label=colorcode$V1, cex=0.8, col=colorback, font=1)
text(tapply(mds[,2], popn, mean), tapply(mds[,3], popn, mean), label=names(colorpop), 
     cex=1.1, col=colorpop, font=2)
plot(mds[,1], mds[,3], type="n", xlab="Coordinate 1", ylab="Coordinate 3")
text(mds[,1], mds[,3], label=colorcode$V1, cex=0.8, col=colorback, font=1)
text(tapply(mds[,1], popn, mean), tapply(mds[,3], popn, mean), label=names(colorpop), 
     cex=1.1, col=colorpop, font=2)

dev.off()


