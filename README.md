# geo-merged-gse198861-gse198862
# Batch-aware merged RNA-seq practice (mouse): merged matrix + DESeq2 (~ batch + condition)

This repository documents a learning-focused workflow where two sets of RNA-seq samples were combined into a single expression matrix and analysed with **DESeq2** using an explicit **batch-aware design** (`~ batch + condition`). The emphasis here is clarity and reproducibility of the code path (how the merge was done and how batch was handled), rather than claiming a definitive biological conclusion.

---

## How the merge was done
Before merging, gene identifiers were harmonized to `external_gene_name` (gene symbols). Two matrices were then merged **by gene (intersection)**: only genes present in both inputs were kept, and sample columns from the two matrices were concatenated.

A simple Perl script was used for the merge step:
- `merge/01.merge.pl`

---

## Differential expression (DESeq2)
### Model
DESeq2 was run with a batch-aware design:
- `design = ~ batch + condition`

This estimates the effect of `condition` while controlling for `batch`.


### Output
- `scripts/merge23_results.csv`  

---

## How to run
1) Place the merged matrix here:
- `merge/merge23.txt`

2) Ensure metadata exists:
- `merge/metadata_merged.tsv`

3) Run the main script:
```r
source("scripts/Run.R")
