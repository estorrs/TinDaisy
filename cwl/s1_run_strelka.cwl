class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
id: s1_run_strelka
baseCommand:
  - /usr/bin/perl
  - /usr/local/somaticwrapper/SomaticWrapper.pl
inputs:
  - id: tumor_bam
    type: File
    inputBinding:
      position: 0
      prefix: '--tumor_bam'
    secondaryFiles:
      - ^.bai
  - id: normal_bam
    type: File
    inputBinding:
      position: 0
      prefix: '--normal_bam'
    secondaryFiles:
      - ^.bai
  - id: reference_fasta
    type: File
    inputBinding:
      position: 0
      prefix: '--reference_fasta'
    secondaryFiles:
      - ^.dict
      - .fai
  - id: strelka_config
    type: File
    inputBinding:
      position: 0
      prefix: '--strelka_config'
  - id: results_dir
    type: string
    inputBinding:
      position: 0
      prefix: '--results_dir'
    label: Results directory name
    doc: Apparently should not have '.' in it
  - id: is_strelka2
    type: boolean?
    inputBinding:
      position: 0
      prefix: '--is_strelka2'
    doc: 'If set, run strelka2 instead of strelka version 1'
outputs:
  - id: snvs_passed
    type: File
    outputBinding:
      glob: |-
        ${
            if(inputs.is_strelka2 == true)
                return  inputs.results_dir + '/strelka/strelka_out/results/variants/somatic.snvs.vcf.gz'
            else
                return  inputs.results_dir + '/strelka/strelka_out/results/passed.somatic.snvs.vcf'
        }
label: s1_run_strelka
arguments:
  - position: 99
    prefix: ''
    separate: false
    shellQuote: false
    valueFrom: '1'
requirements:
  - class: ShellCommandRequirement
  - class: DockerRequirement
    dockerPull: 'cgc-images.sbgenomics.com/m_wyczalkowski/somatic-wrapper:cwl'
  - class: InlineJavascriptRequirement
'sbg:job':
  inputs:
    normal_bam:
      basename: n.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: 'n'
      path: /path/to/n.ext
      secondaryFiles: []
      size: 0
    reference_fasta:
      basename: input.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: input
      path: /path/to/input.ext
      secondaryFiles: []
      size: 0
    strelka_config:
      basename: input.ext
      class: File
      contents: file contents
      nameext: .ext
      nameroot: input
      path: /path/to/input.ext
      secondaryFiles: []
      size: 0
    tumor_bam:
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
