#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: [ln]
arguments:
  - prefix: -s
    #transcript fasta file
    position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/$(inputs.tree[2])/$(inputs.transcript_fasta_name[0])
    #cds fasta file
  - position: 2
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/$(inputs.tree[2])/$(inputs.cds_fasta_name[0])
    #gff file
  - position: 3
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.deepPATH_analyses[0])/$(inputs.tree[2])/$(inputs.genome_fasta_name[0].slice(0,-3))gff
    #target directory
  - position: 4
    valueFrom: $(inputs.MAIN_PATH)/$(inputs.LINK_DIR)/2.Official or Primary Gene Set/.

inputs:
  in_dummy: 
    type: File
  PATH:
    type: string[]
  tree:
    type: string[]
  transcript_fasta_name:
    type: string[]
  cds_fasta_name:
    type: string[]
  genome_fasta_name:
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  deepPATH_analyses:
    type: string[]
  MAIN_PATH:
    type: string
  LINK_DIR:
    type: string

outputs: []
