import pandas as pd
from snakemake.script import snakemake

data = pd.concat([pd.read_csv(file) for file in snakemake.input])
    
data.to_csv(snakemake.output[0], index=False)