library(rehh)

load(snakemake@input[[1]])
ihh_pop1 <- scan
load(snakemake@input[[2]])
ihh_pop2 <- scan

xpehh <- ies2xpehh(scan_pop1 = ihh_pop1, 
                   scan_pop2 = ihh_pop2,
                   popname1 = snakemake@wildcards[["pop1"]],
                   popname2 = snakemake@wildcards[["pop2"]])

write.csv(xpehh, snakemake@output[[1]])
