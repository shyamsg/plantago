#! /usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

genotypedSamples = read.table(args[1], as.is=T)$V1

originalPhenotypes = read.table(args[2], as.is=T, header=T)
originalPhenotypes = replace(originalPhenotypes, originalPhenotypes==0, NA)
numphenotypes = ncol(originalPhenotypes)

### For each of the genoypted samples, see how many are there in phenotyped samples.
newPhenotypes = sapply(genotypedSamples, function(x) {
  indices = which(originalPhenotypes$SampleName == x)
  if (length(indices) == 0) {
     return (c(x,x, rep(NA, numphenotypes-2)))
  } else {
    if (length(indices) == 1) {
      return(originalPhenotypes[indices[1],])
    } else {
      nonzeros = sapply(indices, function(y){ sum(!is.na(originalPhenotypes[y,]))})
      superindex = indices[which.max(nonzeros)]
      return(originalPhenotypes[superindex,])
    }
  }
})

newPhenotypes = t(newPhenotypes)

write.table(newPhenotypes, file=args[3], sep="\t", quote=F, row.names=F, col.names=F)