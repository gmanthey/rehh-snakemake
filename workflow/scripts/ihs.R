library(rehh)

all_scan <- data.frame()

for (file in snakemake@input) {
    load(file)
    all_scan <- rbind(all_scan, scan)
}

ihs <- ihh2ihs(all_scan)

write.csv(ihs$ihs, snakemake@output[[1]])
write.csv(ihs$frequency.class, snakemake@output[[2]])