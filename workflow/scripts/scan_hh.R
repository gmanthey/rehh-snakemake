library(rehh)

hh <- data2haplohh(hap_file = snakemake@input[[1]],
                   polarize_vcf = FALSE,
                   min_maf = snakemake@config[["min_maf"]],
                   chr.name = snakemake@wildcards[["chromosome"]],
                   vcf_reader = "vcfR")

scan <- scan_hh(hh, polarized=FALSE)

save(scan, file=snakemake@output[[1]])

