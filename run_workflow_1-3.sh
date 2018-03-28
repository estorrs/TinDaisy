
# Remember, need to login first.  Read the README, 
# Be sure docker is running
# docker login cgc-images.sbgenomics.com
# Username: m_wyczalkowski
# Password: this is a token obtained from https://cgc.sbgenomics.com/developer#token, which requies login via ERA Commons

RABIX="/Users/mwyczalk/src/rabix-cli-1.0.4/rabix"
CWL="workflow-1-3.cwl"
source demo_paths.sh

# try to have all output go to output_dir
OUTD="results"
mkdir -p $OUTD
RABIX_ARGS="--basedir $OUTD"

$RABIX $RABIX_ARGS $CWL -- " \
--tumor_bam $TUMOR_BAM \
--normal_bam $NORMAL_BAM \
--reference_fasta $REFERENCE_FASTA \
--strelka_config $STRELKA_CONFIG \
--dbsnp_db $DBSNP_DB "
