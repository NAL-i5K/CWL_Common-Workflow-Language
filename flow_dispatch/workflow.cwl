#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  PATH: string[]
  in_tree: string[]
  deepPATH_genomic_fasta: string[]
  in_genomic_fasta: File
  deepPATH_genomic_gff: string[]
  in_genomic_gff: File
#  in_others: File[]
#  in_apollo2: Directory
#  in_md5checksums: File
#  in_extract: File
#  in_check: File

steps:
  setup_folder:
    run: setup_folder.cwl
    in:
      PATH: PATH
      in_tree: in_tree
    out: [out_dummy]  
  #To other_species
  2other_species: 
    run: 2other_species/workflow.cwl
    in:
      in_dummy: setup_folder/out_dummy
      PATH: PATH
      in_tree: in_tree
      deepPATH_genomic_fasta: deepPATH_genomic_fasta
      in_genomic_fasta: in_genomic_fasta
      deepPATH_genomic_gff: deepPATH_genomic_gff
      in_genomic_gff: in_genomic_gff    
#      in_others: in_others
#      in_apollo2: in_apollo2
    out: []
  #To working_files
#  2working_files:
#    run: 2working_files/workflow.cwl
#    in:
#     PATH: PATH
#      in_tree: in_tree
#      in_md5checksums: in_md5checksums
#      in_extract: in_extract
#      in_check: in_check
#    out: [] 
  #To blat/db/
  #2blat:
  
outputs: []
#  OUT_dir:
#    type: Directory
#    outputSource: others/out_dir
