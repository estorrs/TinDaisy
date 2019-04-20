# TinDaisy Project Config file
#
# This file is common to all steps in project
# Contains all per-system configuration
# Contains only definitions, no execution code

# **TODO** Remove PRE_SUMMARY and SUMMARY filenames here, and make these be the defaults in the 
#   respective processing scripts

# System: MGI

# Root directory.  Where TinDaisy is installed
TD_ROOT="/gscuser/mwyczalk/projects/TinDaisy/TinDaisy"

# List of cases to analyze.  This has to be created
CASES_LIST="dat/cases.dat"

# Path to BamMap, which is a file which defines sequence data path and other metadata
# BamMap format is defined here: https://github.com/ding-lab/importGDC/blob/master/make_bam_map.sh
BAMMAP="/gscuser/mwyczalk/projects/CPTAC3/CPTAC3.catalog/MGI.BamMap.dat"

# This path below is for CPTAC3-standard GRCh38 reference
REF="/gscmnt/gc2521/dinglab/mwyczalk/somatic-wrapper-data/image.data/A_Reference/GRCh38.d1.vd1.fa"

# See katmai:/home/mwyczalk_test/Projects/TinDaisy/sw1.3-compare/README.dbsnp.md for discussion of dbSnP references
# Updating to dbSnP-COSMIC version 20190416
DBSNP_DB="/gscmnt/gc2521/dinglab/mwyczalk/somatic-wrapper-data/image.data/B_Filter/dbSnP-COSMIC.GRCh38.d1.vd1.20190416.vcf.gz"

# VEP Cache is used for VEP annotation and vcf_2_maf.
# If not defined, online lookups will be used by VEP annotation. These are slower and do not include allele frequency info (MAX_AF) needed by AF filter.
# For performance reasons, defining vep_cache_gz is suggested for production systems
VEP_CACHE_GZ="/gscmnt/gc2521/dinglab/mwyczalk/somatic-wrapper-data/image.data/D_VEP/vep-cache.90_GRCh38.tar.gz"

#
# The following are not system-specific
#

# Output of task manager
LOGD="./logs"

YAMLD="./yaml"

PRE_SUMMARY="dat/analysis_pre-summary.dat"
SUMMARY="dat/analysis_summary.dat"


