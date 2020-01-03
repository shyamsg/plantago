# plot mds 
setwd("~/Work/natalie/mds")
distMatrix = read.table("PmajorNoBlanks.dist", skip = 2, nrows = 391, as.is=T)
sampNames=distMatrix[,1]
distMatrix = distMatrix[,-1]

mdsFit = cmdscale(d=distMatrix, k=6, eig=TRUE)
mds1 = mdsFit$points[,1]
mds2 = mdsFit$points[,2]
mds3 = mdsFit$points[,3]
mds4 = mdsFit$points[,4]
mds5 = mdsFit$points[,5]
mds6 = mdsFit$points[,6]
pdf(file="PmajorNoBlanks.MDS.6coords.pdf")
par(mar=c(5,4,4,2)+0.1, oma=c(0,0,0,0))
layout(1)
plot(mds1, mds2, type="n", xlab="Coordinate 1", ylab="Coordinate 2")
text(mds1, mds2, label=sampNames, cex=0.7)
plot(mds3, mds4, type="n", xlab="Coordinate 3", ylab="Coordinate 4")
text(mds3, mds4, label=sampNames, cex=0.7)
plot(mds5, mds6, type="n", xlab="Coordinate 5", ylab="Coordinate 6")
text(mds5, mds6, label=sampNames, cex=0.7)
dev.off()

## Mds with 6 discarded
setwd("~/Work/natalie/mds")
distMatrix = read.table("PmajorNoBlanks_6Discarded.dist", skip = 2, nrows = 385, as.is=T)
sampNames=distMatrix[,1]
distMatrix = distMatrix[,-1]

mdsFit = cmdscale(d=distMatrix, k=12, eig=TRUE)
mds = mdsFit$points
colorcode = read.table("PmajorNoBlanks_6Discarded.list", as.is=T)
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
pdf(file="PmajorNoBlanks_6Discarded.MDS.6coords.pdf")
par(mar=c(5,4,4,2)+0.1, oma=c(0,0,0,0))
layout(1)
plot(mds[,1], mds[,2], type="n", xlab="Coordinate 1", ylab="Coordinate 2")
text(mds[,1], mds[,2], label=colorcode$V1, cex=0.8, col=colorback, font=1)
#points(tapply(mds[,1], popn, mean), tapply(mds[,2], popn, mean), pch=21, cex=1.5, bg=colorpop, col="black")
text(tapply(mds[,1], popn, mean), tapply(mds[,2], popn, mean), label=names(colorpop), 
     cex=1.1, col=colorpop, font=2)
dev.off()
plot(mds[,3], mds[,4], type="n", xlab="Coordinate 3", ylab="Coordinate 4")
text(mds[,3], mds[,4], label=sampNames, cex=1, col=colorcode$V2)
plot(mds5, mds6, type="n", xlab="Coordinate 5", ylab="Coordinate 6")
text(mds5, mds6, label=sampNames, cex=0.7)
plot(mdsFit$points[,7], mdsFit$points[,8], type="n", xlab="Coordinate 7", ylab="Coordinate 8")
text(mdsFit$points[,7], mdsFit$points[,8], label=sampNames, cex=0.7)
plot(mdsFit$points[,9], mdsFit$points[,10], type="n", xlab="Coordinate 9", ylab="Coordinate 10")
text(mdsFit$points[,9], mdsFit$points[,10], label=sampNames, cex=0.7)
dev.off()

