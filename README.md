# <img src="docs/TinDaisy.v1.2.png" width="64"/> TinDaisy

[TinDaisy](https://github.com/ding-lab/tin-daisy) is a modular software package
designed for detection of somatic variants from tumor and normal exome data.
[TinDaisy-Core](https://github.com/ding-lab/TinDaisy-Core) obtains variant
calls from four callers, merges them, and applies various filters.

Callers used:

* [Strelka2](https://github.com/Illumina/strelka.git)
* [VarScan.v2.3.8](http://varscan.sourceforge.net/)
* [Pindel](https://github.com/ding-lab/pindel.git)
* [mutect-1.1.7](https://github.com/broadinstitute/mutect)

SNV calls from Strelka2, Varscan, Mutect. Indel calls from Stralka2, Varscan, and Pindel.
[CWL Mutect Tool](https://github.com/mwyczalkowski/mutect-tool) is used for CWL Mutect calls

Filters applied (details in VCF output)
* For indels, require length < 100
* Require normal VAF <= 0.020000, tumor VAF >= 0.050000 for all variants
* Require read depth in tumor > 14 and normal > 8 for all variants
* All variants must be called by 2 or more callers
* Require Allele Frequency < 0.005000 (as determined by vep)
* Retain exonic calls
* Exclude calls which are in dbSnP but not in COSMIC

TinDaisy and TinDaisy-Core were developed from [SomaticWrapper](https://github.com/ding-lab/somaticwrapper) and [GenomeVIP](https://genomevip.readthedocs.io/).

The current CWL implementation is visualized below using [Rabix Composer](http://docs.rabix.io/rabix-composer-home)

![TinDaisy CWL implementation](docs/TinDaisy.CWL.png)


# Getting Started

Some information below is dated.  **TODO** improve 

## Installation
TinDaisy requires several packages to run.  It has been tested with `cwltool`, `rabix composer`, and `cromwell` CWL engines.
Description below specific to Rabix

### [Docker](https://www.docker.com/community-edition)

### [Rabix Executor](https://github.com/rabix/bunny)
```
wget https://github.com/rabix/bunny/releases/download/v1.0.5-1/rabix-1.0.5.tar.gz -O rabix-1.0.5.tar.gz && tar -xvf rabix-1.0.5.tar.gz
```

Test Rabix Executor with,
```
cd rabix-cli-1.0.5
./rabix examples/dna2protein/dna2protein.cwl.json examples/dna2protein/inputs.json
```
This should run for a few seconds and then produce output like,
```
[2018-04-20 14:38:24.655] [INFO] Job root.Translate has completed
{
  "output_protein" : {
    "basename" : "protein.txt",
    "checksum" : "sha1$55adf0ec2ecc6aee57a774d48216ac5a97d6e5ba",
    "class" : "File",
    "contents" : null,
    "dirname" : "/Users/mwyczalk/tmp/tin-daisy/rabix-cli-1.0.5/examples/dna2protein/dna2protein.cwl-2018-04-20-143817.231/root/Translate",
    "format" : null,
    "location" : "file:///Users/mwyczalk/tmp/tin-daisy/rabix-cli-1.0.5/examples/dna2protein/dna2protein.cwl-2018-04-20-143817.231/root/Translate/protein.txt",
    "metadata" : null,
    "nameext" : ".txt",
    "nameroot" : "protein",
    "path" : "/Users/mwyczalk/tmp/tin-daisy/rabix-cli-1.0.5/examples/dna2protein/dna2protein.cwl-2018-04-20-143817.231/root/Translate/protein.txt",
    "secondaryFiles" : [ ],
    "size" : 9
  }
}
```

### [TinDaisy](https://github.com/ding-lab/tin-daisy)
```
git clone https://github.com/ding-lab/tin-daisy
```

### Other

The following packages are also required for the simple task manager:
* [`jq`](https://stedolan.github.io/jq/download/)
* [`GNU Parallel`](https://www.gnu.org/software/parallel/)

Optionally [TinDaisy-Core](https://github.com/ding-lab/TinDaisy-Core). This contains the 
algorithmic contents of the somaitic caller workflow, but is generally distributed
as a docker image, `mwyczalkowski/tindaisy-core:mutect` 

``` 
git clone https://github.com/ding-lab/TinDaisy-Core
```

## Running CPTAC3 analyses on katmai in a Rabix environment

Example of CPTAC3 analyses is in `demo/task_call/katmai.C3`.  Scripts in this directory can be modified in place, or copied and modified in another directory.

### 1. Edit `project_config.sh`
The `project_config.sh` file has all paths and other definitions specific to a given system (e.g., katmai) and project (e.g., GRCh38 CPTAC3 data).  In particular,
need to specify path to BamMap file and other details described there.

### 2. Create `dat/cases.dat` file
This file has list of all case names which will be analyzed as part of this project.  Case names (e.g., C3L-00001) must be unique in this file, and must
match the case names in the BamMap file.

### 3. Run `1_make_yaml.sh`
This generates a series of YAML files, which provide inputs to Rabix (and Cromwell) CWL workflow managers, one per case.  This script also
creates file `dat/analysis_pre-summary.dat`, which is used to report analysis results once they are complete.

### 4. Run `2_run_tasks.sh`
This launches the SomaticSV workflow using Rabix, either one at a time (default) or several at a time using `GNU parallel`.  For the latter,
invoke as,
```
2_run_tasks.sh -J 4
```
if you wish to run four at a time.  The dry run flag (`-d`) is useful for testing of configuration.

This step will write results to two places specified in `project_config.sh`: `LOGD` and `RABIXD`.  Watch `LOGD/CASE.err` for execution progress

### 5. Run `3_make_analysis_summary.sh`
When analysis completes, this step will create an analysis summary file which reports on the path to the output VCF file per case, and the
input files which were used to generate it.

## Running CPTAC3 analyses on MGI in Cromwell environment

See analyses in `./demo/task_call/cromwell`.  Significant development is taking place here, with a simple execution manager implemented with
the following tools in `./src`: `runplan`, `rungo`, `runtidy`, `datatidy`.  TODO: improve documentation


# Development notes

This needs to be updated.  Demo directory layout and logic are based on [SomaticSV](https://github.com/mwyczalkowski/somatic_sv_workflow)
and [BICSEQ2](https://github.com/mwyczalkowski/BICSEQ2)



## Running StrelkaDemo data

To run the entire TinDaisy workflow on a test dataset (named "StrelkaDemo"),
```
cd testing
bash run_workflow.StrelkaDemo.sh
```
This should run for a minute or so and produce a lot of output ending in something like,
```
[2018-11-26 13:18:28.681] [INFO] Job root.vcf_2_maf has completed
{
  "output_maf" : null,
  "output_vcf" : {
    "basename" : "vep_filtered.vcf",
...
    "size" : 11009
  }
}
```

You will be able to find output for each of the steps of the TinDaisy workflow in the `./results` directory.

Details of the StrelkaDemo test dataset are found below.


# Development and testing

There are four levels of code development.

1. Direct command line invocation of TinDaisy-Core
2. Executing TinDaisy-Core from within a docker container
3. Executing CWL-wrapped TinDaisy tool using Rabix Executor (or Cromwell)
4. Executing a number of TinDaisy tasks using Rabix Executor and a simple task manager

For development and debugging, make sure all prior steps work.  Note that can also run workflows
directly from Rabix Composer.

## Running SomaticWrapper directly

For development and testing, the `testing/test.rabix` directory has scripts
which will run individual steps of TinDaisy-Core directly (i.e., `perl SomaticWrapper.pl ...`)
from within docker container.  See [documentation](testing/README.md) for details.


## Rabix Composer invocation

Individual steps of the SomaticWrapper workflow are defined as CWL tools in the `./cwl` directory and can
be viewed and modified with [Rabix Composer](https://github.com/rabix/composer).

Individual tools can be executed either from within Composer, or as individual shell scripts in `testing/test.rabix`. For instance,
```
bash run_cwl_S1.sh
```
will run the `run_strelka` (step 1) of the Somatic Wrapper workflow.

As mentioned above, entire pipeline can be executed using the StrelkaDemo test dataset with,
```
cd testing
bash run_workflow.StrelkaDemo.sh
```
This will read configuration file in `testing/StrelkaDemo.dat/project_config.StrelkaDemo.yaml` to drive the analysis.

## Beyond StrelkaDemo

Use `testing/run_workflow.StrelkaDemo.sh` and `testing/test.C3N-01649/project_config.C3N-01649.yaml` as basis for 
additional work.  Note that production runs are best with a somewhat different parameters, including an installed VEP cache 
and deletion of intermediate files.

# Development details

## Configuration files

YAML files supercede `project_config.sh` files to define variables for runs, since YAML can be used for both
Cromwell and Rabix executions.

Currently, `--vep_cache_dir` is not supported as a way to share VEP cache with `vep_annotation` and `vcf_2_maf` steps
because Rabix does not stage directories.  VEP cache must be passed as a `.tar.gz` file and defined with `vep_cache_gz`


## StrelkaDemo details

`StrelkaDemo` data consists of two small (50Kb) tumor and normal BAM files.  These are [distributed with
Strelka](https://github.com/Illumina/strelka/tree/master/src/demo/data) (hence the name), as well as
in the `./StrelkaDemo.dat` directory.


