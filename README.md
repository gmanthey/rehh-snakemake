# rehh-snakemake

## Installation

1. If you haven't yet, install [conda miniforge](https://github.com/conda-forge/miniforge?tab=readme-ov-file#install).

2. Clone this repository and cd into it:

    ```bash
    git clone https://github.com/gmanthey/rehh-snakemake.git
    cd rehh-snakemake
    ```

3. Create a new environment from the environment specs file: 
    ```bash
    conda env create -f environment.yml
    ```

    If the `rehh-snakemake` environment had been created previously, make sure 
    you update to the newest version using `conda env update --file environment.yml --prune`

4. Install rehh:
   ```bash
   conda activate rehh-snakemake
   ./post-deploy.sh
   ```

## Usage 

1. Copy the `config.yml.template` file to `config.yml` 
2. Adjust the paths to the vcf file in the `config.yml` file. 
3. Create the `resources/chromosomes.txt` file, which should contain one line per chromosome and just the name of the chromosome on the line. I've tested so far only with autosomes, sex chromosomes probably need additional adjusting or should be run seperately.
4. Create the resources/populations.txt file, which should contain one line per individual, with the first column containing a population identifier and the second column containing the individual identifier. If multiple populations are defined, both iHs and xpehh are calculated, whereas only iHs is calculated with a single population. 
5. Run the workflow:
   ```bash
   snakemake
   ```
   If you are on Uni Oldenburgs rosa cluster, you may use the `--profile profile/default` flag to set command line options to use the slurm system of that cluster.
