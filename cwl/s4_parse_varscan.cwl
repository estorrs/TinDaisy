class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
id: s4_parse_varscan
baseCommand:
  - /usr/bin/perl
  - /usr/local/somaticwrapper/SomaticWrapper.pl
inputs:
  - id: varscan_indel_raw
    type: File
    inputBinding:
      position: 0
      prefix: '--varscan_indel_raw'
  - id: varscan_snv_raw
    type: File
    inputBinding:
      position: 0
      prefix: '--varscan_snv_raw'
  - id: dbsnp_db
    type: File
    inputBinding:
      position: 0
      prefix: '--dbsnp_db'
    secondaryFiles:
      - .tbi
  - id: varscan_config
    type: File
    inputBinding:
      position: 0
      prefix: '--varscan_config'
  - id: results_dir
    type: string?
    inputBinding:
      position: 0
      prefix: '--results_dir'
  - id: varscan_vcf_filter_config
    type: File
    inputBinding:
      position: 0
      prefix: '--varscan_vcf_filter_config'
    label: VCF filter config
    doc: 'Configuration file for VCF filtering (depth, VAF, read count)'
outputs:
  - id: varscan_snv_dbsnp
    doc: Final SNV output of parsing
    type: File
    outputBinding:
      glob: >-
        $(inputs.results_dir)/varscan/filter_out/varscan.out.som_snv.Somatic.hc.somfilter_pass.dbsnp_pass.filtered.vcf
  - id: varscan_indel_dbsnp
    doc: Final SNV output of parsing
    type: File
    outputBinding:
      glob: >-
        $(inputs.results_dir)/varscan/filter_out/varscan.out.som_indel.Somatic.hc.dbsnp_pass.filtered.vcf
label: s4_parse_varscan
arguments:
  - position: 99
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '4'
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'cgc-images.sbgenomics.com/m_wyczalkowski/somatic-wrapper:20180904'
  - class: InlineJavascriptRequirement
'sbg:job':
  inputs:
    dbsnp_db:
      basename: input.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: input
      path: /path/to/input.ext
      secondaryFiles: []
      size: 0
    varscan_indel_raw:
      basename: input.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: input
      path: /path/to/input.ext
      secondaryFiles: []
      size: 0
    varscan_snv_raw:
      basename: input.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: input
      path: /path/to/input.ext
      secondaryFiles: []
      size: 0
  runtime:
    cores: 1
    ram: 1000
