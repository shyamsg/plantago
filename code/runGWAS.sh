#! /bin/bash 

PROJECT=$HOME/projects/plantago
GWAS=$PROJECT/gwas
DATA=$PROJECT/data

mkdir -p $GWAS && cd $GWAS
## make the dosage file
if [ ! -e PmajorNoBlanks_6Discarded_c50.dosages ]; then
   python $PROJECT/code/convertBeagleToDosages.py $DATA/PmajorNoBlanks_6Discarded_c50.beagle.gz PmajorNoBlanks_6Discarded_c50.dosages
fi
echo "Dosage file ready."

## convert the input file of phenotypes to match order of genotypes
if [ ! -e PmajorNoBlanks_6Discarded_phenotypes.tsv ]; then
   Rscript $PROJECT/code/subsetPhenotypeData.R genotypedSamples_renamedToMatchPhenotype.txt Global491_28062017_noFILL_zero_noPools.tsv PmajorNoBlanks_6Discarded_phenotypes.tsv
fi
echo "Phenotype file ready."


## Create the relatedness matrix
module load gemma 
if [ ! -e PmajorNoBlanks_6Discarded.cXX.txt ]; then
    numsamps=$(wc -l PmajorNoBlanks_6Discarded_phenotypes.tsv | cut -f1 -d " ")
    for i in `seq 1 $numsamps`; do echo 1; done > dummy.phenotypes
    gemma -g PmajorNoBlanks_6Discarded_c50.dosages -p dummy.phenotypes -gk 1 -o PmajorNoBlanks_6Discarded
    cp output/PmajorNoBlanks_6Discarded.cXX.txt .
    rm -f dummy.phenoypes
fi

## Now run gwas for all of the phenotypes
echo "#! /bin/bash

module load gemma

for phenotype in {9..1435}; do 
  gemma -g PmajorNoBlanks_6Discarded_c50.dosages -k PmajorNoBlanks_6Discarded.cXX.txt -p PmajorNoBlanks_6Discarded_phenotypes.tsv -n \$phenotype -lmm 2 -o PmajorNoBlanks_6Discarded.pheno\$phenotype
  echo Phenotype \$phenotype done.
done
" | sbatch -D `pwd` --time=1-00:00:00 -c 1 --mem-per-cpu=5000 -J ptago.gemma
