#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [scp]
arguments:
  - position: 1
    valueFrom: $(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/$(inputs.genome_fasta_name[0])
  - position: 2
    valueFrom: $(inputs.Gmod_account):$(inputs.PATH[0])/$(inputs.tree[0])/$(inputs.tree[1])/$(inputs.deepPATH_genomic_fasta[0])/

inputs:
  Gmod_account:
    type: string
  PATH: 
    type: string[]
  tree:
    type: string[]
  genome_fasta_name:
    type: string[]
  deepPATH_genomic_fasta:
    type: string[]
  in_dummy:
    type: File
outputs: []
