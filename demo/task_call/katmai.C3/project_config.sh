# Project Config file
#
# This file is common to all steps in project
# Contains all per-system configuration
# Contains only definitions, no execution code

# Root directory of SomaticSV
TD_ROOT="/Users/mwyczalk/Projects/TinDaisy/TinDaisy"

# List of cases to analyze
CASES="dat/cases.dat"

# Path to BamMap, which is a file which defines sequence data path and other metadata
# BamMap format is defined here: https://github.com/ding-lab/importGDC/blob/master/make_bam_map.sh
BAMMAP="/home/mwyczalk_test/Projects/CPTAC3/CPTAC3.catalog/katmai.BamMap.dat"

# Workflow output directory - this is where intermediate and final files generated by workflow scripts go
RABIXD="/diskmnt/Projects/cptac_scratch/Rabix"

# Output of task manager
LOGD="./logs"

# This path below is for CPTAC3-standard GRCh38 reference
REF="/diskmnt/Datasets/Reference/GRCh38.d1.vd1/GRCh38.d1.vd1.fa"

YAMLD="./yaml"

CWL="$TD_ROOT/cwl/workflows/tindaisy.cwl"

PRE_SUMMARY="dat/analysis_pre-summary.dat"
SUMMARY="dat/analysis_summary.dat"

# See README.md for discussion of dbSnP references
DBSNP_DB="/diskmnt/Datasets/dbSNP/SomaticWrapper/B_Filter/dbsnp.noCOSMIC.GRCh38.vcf.gz"

# VEP Cache is used for VEP annotation and vcf_2_maf.
# If not defined, online lookups will be used by VEP annotation. These are slower and do not include allele frequency info (MAX_AF) needed by AF filter.
# For performance reasons, defining vep_cache_gz is suggested for production systems
VEP_CACHE_GZ="/diskmnt/Datasets/VEP/vep-cache.90_GRCh37.tar.gz"


