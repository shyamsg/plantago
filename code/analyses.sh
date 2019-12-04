#! /bin/bash

## this is the root directory of your project - change it to reflect that. 
PROJECT=/home/people/shygop/projects/plantago
## this folder is where you beagle file is located - change it to reflect that.
DATA=$PROJECT/data
## the next 2 folders are created by the script, so no worries if they are not there yet. 
ADMIX=$PROJECT/ngsadmix
MDS=$PROJECT/mds
# Do the admixture analysis
# Arguments:
#         -likes Beagle likelihood filename
#         -K Number of ancestral populations
# Optional:
#         -fname Ancestral population frequencies
#         -qname Admixture proportions
#         -outfiles Prefix for output files
#         -printInfo print ID and mean maf for the SNPs that were analysed
# Setup:
#         -seed Seed for initial guess in EM
#         -P Number of threads
#         -method If 0 no acceleration of EM algorithm
#         -misTol Tolerance for considering site as missing
# Stop chriteria:
#         -tolLike50 Loglikelihood difference in 50 iterations
#         -tol Tolerance for convergence
#         -dymBound Use dymamic boundaries (1: yes (default) 0: no)
#         -maxiter Maximum number of EM iterations
# Filtering
#         -minMaf Minimum minor allele frequency
#         -minLrt Minimum likelihood ratio value for maf>0
#         -minInd Minumum number of informative individuals

mkdir -p $ADMIX
cd $ADMIX
startrep=1
endrep=200
NIND=$(zcat $DATA/PmajorNoBlanks_6Discarded_c50.beagle.gz | head -1 | wc -w)
NIND=$((NIND/3 -1))
for K in {2..12}; do
  mkdir -p K$K && cd K$K
  echo "#! /bin/bash
    rep=\$SLURM_ARRAY_TASK_ID
    /groups/hologenomics/software/ngsTools/ngsAdmix/ngsAdmix -likes $DATA/PmajorNoBlanks_6Discarded_c50.beagle.gz -K $K -outfiles PmajorNoBlanks_6Discarded_c50.K$K.rep\$rep -seed \$RANDOM -P 4 -maxiter 10000 -minMaf 0.01 -minInd $((NIND*50/100)) 
" \| sbatch -D `pwd` --time=12:00:00 -c 4 --mem-per-cpu=3000 -J Ptago.K$K --array=${startrep}-${endrep}%5
  sleep 10
  cd $ADMIX
done

# ==> Input Arguments:
#         geno: (null)
#         probs: false
#         log_scale: false
#         n_ind: 0
#         n_sites: 0
#         tot_sites: 0
#         labels: (null) (WITHOUT header)
#         call_geno: false
#         N_thresh: 0.000000
#         call_thresh: 0.000000
#         pairwise_del: false
#         avg_nuc_dist: false
#         geno_indep: false
#         n_boot_rep: 0
#         boot_block_size: 1
#         out: (null)
#         n_threads: 1
#         version: false
#         verbose: 1
#         seed: 1502267049

mkdir -p $MDS
cd $MDS
while read line; do echo $(basename $line .plantago_20samples.realigned.bam); done < $DATA/PmajorNoBlanks_6Discarded.list > sampleLabels_6Discarded.txt
if [ ! -e PmajorNoBlanks_6Discarded_c50_minmaf10.dist ]; then
 echo "#! /bin/bash
  /groups/hologenomics/software/ngsTools/ngsDist/ngsDist --geno $DATA/PmajorNoBlanks_6Discarded_c50_minmaf10.glf --probs --log_scale --n_ind 385 --n_sites 2807 --labels sampleLabels_6Discarded.txt --pairwise_del --avg_nuc_dist --n_boot_rep 100 --out PmajorNoBlanks_6Discarded.dist --n_threads 4
" \| sbatch -D `pwd` --time=4:00:00 -c 4 --mem-per-cpu=10gb -J ptago.dist
fi
