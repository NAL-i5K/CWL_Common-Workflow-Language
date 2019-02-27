#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_tree: string[]
  in_wget_genomic: string[]
  in_wget_others: string[]

steps:
  setup_tree:
    run: tree.cwl
    in:
      in_tree: in_tree 
    out:
      [out_tree]
  download_genomic:
    run: flow_download_genomic/workflow.cwl
    in:
      in_wget_genomic: in_wget_genomic
    out:
      [OUT_genomic_fasta,
       OUT_genomic_gff,
       OUT_txt,
       OUT_txt2,
       OUT_check_log]
#  download_others:
#    run: flow_download_others/workflow.cwl
    
  copy2data:
    run: flow_copy2data/workflow.cwl  
    in:
      in_dir: setup_tree/out_tree
      in_tree: in_tree
      #To other_species
      in_fasta: download_genomic/OUT_genomic_fasta
      in_gff: download_genomic/OUT_genomic_gff
      #To working_files
      in_txt: download_genomic/OUT_txt
      in_txt2: download_genomic/OUT_txt2
      in_check_log: download_genomic/OUT_check_log
    out: []
#  apollo2:
#    run: flow_apollo2/workflow.cwl
#    in: 
#      in_tree: in_tree
#      in_dir: setup/OUT_tree
#      in_gff: setup/OUT_genomic_gff
#      in_fasta: setup/OUT_genomic_fasta
#    out:
#      []

outputs:
  final_dir:
    type: Directory
    outputSource: setup_tree/out_tree