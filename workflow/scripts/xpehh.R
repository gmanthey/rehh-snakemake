library(rehh)

num_inp = length(snakemake@input)

ihh_pop1 <- data.frame()
for (i in 1:(num_inp / 2)) {
    load(snakemake@input[[i]])
    ihh_pop1 <- rbind(ihh_pop1, scan)
}

ihh_pop2 <- data.frame()
for (i in (num_inp / 2 + 1):num_inp) {
    load(snakemake@input[[i]])
    ihh_pop2 <- rbind(ihh_pop2, scan)
}

print(median(ihh_pop1$IES, na.rm=T))
print(median(ihh_pop2$IES, na.rm=T))

xpehh <- ies2xpehh(scan_pop1 = ihh_pop1, 
                   scan_pop2 = ihh_pop2,
                   popname1 = snakemake@wildcards[["pop1"]],
                   popname2 = snakemake@wildcards[["pop2"]])

xpehh$pval <- 10**(-1*xpehh$LOGPVALUE)
xpehh$pfdr <- p.adjust(xpehh$pval, method="fdr")
xpehh$fdrlog <- -log10(xpehh$pfdr)
xpehh$uncorrected_pval <- xpehh$logpvalue
xpehh$LOGPVALUE <- xpehh$fdrlog

write.csv(xpehh, snakemake@output[[1]])

candidates <- calc_candidate_regions(xpehh,
                                 threshold = -log10(0.05),
                                 pval = TRUE,
                                 window_size = 1E5,
                                 overlap = 1E4,
                                 min_n_extr_mrk = 2)

write.csv(candidates, snakemake@output[[2]])

ihh_pop1$IES <- ihh_pop1$IES / sd(ihh_pop1$IES, na.rm=T)
ihh_pop2$IES <- ihh_pop2$IES / sd(ihh_pop2$IES, na.rm=T)

median1 <- median(ihh_pop1$IES, na.rm=T)
median2 <- median(ihh_pop2$IES, na.rm=T)

if (median1 > median2) {
    ihh_pop2$IES = ihh_pop2$IES + (median1 - median2)
} else {
    ihh_pop1$IES = ihh_pop1$IES + (median2 - median1)
}

xpehh <- ies2xpehh(scan_pop1 = ihh_pop1,
                   scan_pop2 = ihh_pop2,
                   popname1 = snakemake@wildcards[["pop1"]],
                   popname2 = snakemake@wildcards[["pop2"]])

xpehh$pval <- 10**(-1*xpehh$LOGPVALUE)
xpehh$pfdr <- p.adjust(xpehh$pval, method="fdr")
xpehh$fdrlog <- -log10(xpehh$pfdr)
xpehh$uncorrected_pval <- xpehh$logpvalue
xpehh$LOGPVALUE <- xpehh$fdrlog

write.csv(xpehh, snakemake@output[[3]])
