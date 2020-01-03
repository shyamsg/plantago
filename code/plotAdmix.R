## set directory
setwd("/home/shyam/Work/natalie/ngsadmix/")
sampnames = read.table("sampleNames.txt", as.is=T)
popOrder = c("Japan","SouthKorea","Yukon","Alaska","California","Iran1","Russia","Ukraine","Iran2","Turkey",
             "Colorado","Alberta","Ontario","Vancouver","Chicago","Newfoundland","Italy",
             "Netherlands","France2","England","Estonia","Finland","Norway","VisbySweden","Greenland",
             "Denmark","Iceland","Ireland","France1","NorthDakota","NewBrunswick","Washington",
             "NewZealand","Egypt","SouthAfrica","Morocco","Florida","Portugal","Spain1","Spain4",
             "TenerifeSouth","Gibraltar","Greece","GranCanaria","Chile","Peru","Brazil","Hawaii",
             "Melbourne","Perth")

samporder = sapply(popOrder,function(x) {
  which(sampnames$V1 == x)
})
samporder = unlist(samporder)
#sampnames = sampnames[samporder,]

poplens = sapply(popOrder, function(x) {sum(sampnames$V1 == x)})
labpos = poplens/2 + c(0,cumsum(poplens)[1:(length(poplens)-1)])

getMemberSizeOrder = function(Q, sampNames, popOrder) {
  newWorldOrder = c()
  pops = popOrder
  for (pop in pops) {
    members = which(sampnames$V1 == pop)
    membersizeOrder = order(Q[1, members]*10+Q[2,members], decreasing=TRUE)
    newWorldOrder = c(newWorldOrder, members[membersizeOrder])
  }
  return(newWorldOrder)
}

colorscrambles = list()
colorscrambles[[2]] = c(1,2)
colorscrambles[[3]] = c(3,2,1)
colorscrambles[[4]] = c(1,2,4,3)
colorscrambles[[5]] = c(1,3,4,5,2)
colorscrambles[[6]] = c(5,6,3,2,4,1)
colorscrambles[[7]] = c(2,7,4,3,6,1,5)
colorscrambles[[8]] = c(3,5,6,1,8,7,4,2)
colorscrambles[[9]] = c(6,2,4,3,7,9,5,8,1)
colorscrambles[[10]] = c(9,7,8,1,4,2,10,3,5,6)
colorscrambles[[11]] = c(2,8,6,9,10,1,3,5,7,4,11)
colorscrambles[[12]] = c(5,12,9,6,4,2,1,8,3,10,11,7)

colors=c("papayawhip","lightsteelblue2","indianred3","lavender",
         "darkseagreen","lightsalmon","thistle2","salmon",
         "darkslategray4","burlywood2","bisque","dodgerblue",
         "lightskyblue2","peachpuff","mistyrose")

## Plot the shit
Q = t(as.matrix(read.table(paste0("bests/PmajorNoBlanks_c50.K6.qopt"))))[colorscrambles[[6]],]
memberSizeOrder = getMemberSizeOrder(Q,sampnames,popOrder)
par(mar=c(0.75,0,0,0),oma=c(1.2,0,0,0),xpd=TRUE)
layout(c(1:12))
for (k in 2:12) {
  cols = colors[1:k]
  Q = t(as.matrix(read.table(paste0("bests/PmajorNoBlanks_c50.K", k, ".qopt"))))[colorscrambles[[k]],]
#  memberSizeOrder = getMemberSizeOrder(Q,sampnames,popOrder)
  Q = Q[,memberSizeOrder]
  barplot(Q, col=cols, width=1, border=cols, space=0, axes=F)
  mtext(paste("K=",k), side=2, line=-2, font=2)
  sapply(cumsum(poplens), function(x) lines(x=c(x,x), y=c(0,1), lty=1, col="gray60"))
}
plot(c(0,sum(poplens)),c(0,1), axes=F, type="n", xaxs="r", xpd=TRUE)
sapply(1:length(labpos), function(x){ text(labpos[x],0.95, popOrder[x], srt=90, cex=1.1, adj=c(1,NA))})

## 6 discarded
## set directory
setwd("/home/shyam/Work/natalie/ngsadmix/")
sampnames = read.table("sampleNames_6Discarded.txt", as.is=T)
popOrder = c("Japan","SouthKorea","Yukon","Alaska","California","Iran1","Russia","Ukraine","Iran2","Turkey",
             "Colorado","Alberta","Ontario","Vancouver","Chicago","Newfoundland","Italy",
             "Netherlands","France2","England","Estonia","Finland","Norway","VisbySweden","Greenland",
             "Denmark","Iceland","Ireland","France1","NorthDakota","NewBrunswick","Washington",
             "NewZealand","Egypt","SouthAfrica","Morocco","Florida","Portugal","Spain1","Spain4",
             "TenerifeSouth","Gibraltar","Greece","GranCanaria","Chile","Peru","Brazil","Hawaii",
             "Melbourne","Perth")

samporder = sapply(popOrder,function(x) {
  which(sampnames$V1 == x)
})
samporder = unlist(samporder)
#sampnames = sampnames[samporder,]

poplens = sapply(popOrder, function(x) {sum(sampnames$V1 == x)})
labpos = poplens/2 + c(0,cumsum(poplens)[1:(length(poplens)-1)])

getMemberSizeOrder = function(Q, sampNames, popOrder) {
  newWorldOrder = c()
  pops = popOrder
  for (pop in pops) {
    members = which(sampnames$V1 == pop)
    membersizeOrder = order(Q[1, members]*10+Q[2,members], decreasing=TRUE)
    newWorldOrder = c(newWorldOrder, members[membersizeOrder])
  }
  return(newWorldOrder)
}

colorscrambles = list()
colorscrambles[[2]] = c(2,1)
colorscrambles[[3]] = c(3,1,2)
colorscrambles[[4]] = c(1,3,2,4)
colorscrambles[[5]] = c(1,5,2,3,4)
colorscrambles[[6]] = c(4,1,2,5,3,6)
colorscrambles[[7]] = c(2,7,1,5,4,3,6)
colorscrambles[[8]] = c(7,3,2,5,4,8,1,6)
colorscrambles[[9]] = c(1,5,4,3,7,8,6,2,9)
colorscrambles[[10]] = c(10,1,6,3,2,5,8,9,7,4)
colorscrambles[[11]] = c(1,5,7,2,4,6,8,9,11,3,10)
colorscrambles[[12]] = c(9,11,2,4,12,1,3,5,6,7,8,10)

colors=c("papayawhip","lightsteelblue2","indianred3","lavender",
         "darkseagreen","lightsalmon","thistle2","salmon",
         "darkslategray4","burlywood2","bisque","dodgerblue",
         "lightskyblue2","peachpuff","mistyrose")

## Plot the shit
Q = t(as.matrix(read.table(paste0("bests/PmajorNoBlanks_6Discarded_c50.K6.qopt"))))[colorscrambles[[6]],]
memberSizeOrder = getMemberSizeOrder(Q,sampnames,popOrder)
par(mar=c(0.75,0,0,0),oma=c(1.2,0,0,0),xpd=TRUE)
layout(c(1:12))
for (k in 2:12) {
  cols = colors[1:k]
  Q = t(as.matrix(read.table(paste0("bests/PmajorNoBlanks_6Discarded_c50.K", k, ".qopt"))))[colorscrambles[[k]],]
  #  memberSizeOrder = getMemberSizeOrder(Q,sampnames,popOrder)
  Q = Q[,memberSizeOrder]
  barplot(Q, col=cols, width=1, border=cols, space=0, axes=F)
  mtext(paste("K=",k), side=2, line=-2, font=2)
  sapply(cumsum(poplens), function(x) lines(x=c(x,x), y=c(0,1), lty=1, col="gray60"))
}
plot(c(0,sum(poplens)),c(0,1), axes=F, type="n", xaxs="r", xpd=TRUE)
sapply(1:length(labpos), function(x){ text(labpos[x],0.95, popOrder[x], srt=90, cex=1.1, adj=c(1,NA))})
