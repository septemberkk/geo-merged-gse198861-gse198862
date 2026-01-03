rm(list = ls())
library(DESeq2)
path <- ""PATH_TO_REPO_ROOT"  # <-- change this locally if needed "
setwd(path)
getwd()

#####  data #####
rt <- read.table("merge23.txt", sep = "\t",header = T,check.names = F)
rt <- rt[-52124,] 
rt <- rt[-1,]
# rownames(rt) 
# save_original_rownames 
original_rownames <- rownames(rt)
rownames(rt) <- rt$external_gene_name
rt <- rt[, -1]

#######  normalize#####
sample_info <- data.frame(
  condition = c("Treatment", "Treatment","Treatment","Treatment",
                "Control","Control","Control","Control",
                "Treatment", "Treatment","Treatment","Treatment",
                "Control","Control","Control","Control"), 
  batch = c(rep(1,8),rep(2,8))
  # other_variable = c("GM2091_avg",     "GM2092_avg"  ,    "GM2093_avg"  ,    "GM2094_avg" ,    
  #                    "GM2095_avg" ,     "GM2096_avg",      "GM2097_avg"  ,    "GM2100_avg" ,    
  #                    "SEK00_74272_avg","SEK00_74275_avg","SEK00_74281_avg","SEK00_74286_avg",
  #                    "SEK00_74250_avg","SEK00_74271_avg","SEK00_74274_avg","SEK00_74290_avg")
  )
# as_factor
sample_info$batch <- factor(sample_info$batch)
sample_info$condition <- factor(sample_info$condition)
rownames(sample_info) <- colnames(rt)
# as_int 
rt_int <- as.data.frame(lapply(rt, function(x) as.integer(round(x))))
# rename
rownames(rt_int) <- original_rownames
print(head(rownames(rt_int)))

# DESeqDataSet  dds
dds <- DESeqDataSetFromMatrix(countData = rt_int, 
                              colData = sample_info, 
                              design = ~batch+condition)
print(head(rownames(dds)))
dds <- DESeq(dds, betaPrior = FALSE)

counts_normalized <- counts(dds, normalized = TRUE)


res <- results(dds, contrast=c("condition", "Control","Treatment"))


resultsNames(dds)


res <- lfcShrink(dds, coef=3, type="apeglm")


rownames(res) <- rownames(dds)


head(res)


write.csv(as.data.frame(res), file="merge23_results.csv")
