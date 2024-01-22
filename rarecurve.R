library(vegan)
library(dplyr)
library(iNEXT)
library(ggplot2)

counts <- read.table("/Users/angela/Documents/delwiche_rotation/delwiche_rotation/counts.tsv", header=FALSE, sep=' ', col.names=c("kmer", "count"))

#counts <- as.matrix(counts)

data(spider)
str(spider)

ct <- t(counts)

colnames(ct) <- ct[1,]

ct <- ct[-1,]

ct <- as.data.frame(ct)

ct <- t(ct)

ct_numeric <- as.data.frame(apply(ct, 2, as.numeric))


out <- iNEXT(ct_numeric, q=0, datatype="abundance")

ggiNEXT(out, type=1, facet.var="Assemblage")

colnames(ct_numeric) = c("count")

ggplot(ct_numeric, aes(x=count)) +
  geom_histogram() +
  scale_x_log10()

