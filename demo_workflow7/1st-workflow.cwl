#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement

inputs:
  in_files: File[]

steps:
  step_fasta_diff:
    run: fasta_diff.cwl
    in:
      in_files: in_files
    out: 
      [out_fasta_diff_match] 
  step_gff3_sort:
    run: gff3_sort.cwl
    in:
      in_files: in_files
    out: 
      [out_gff3_sort] 
  step_update_gff:
    run: update_gff.cwl
    in:
      in_update_gff_from_fasta_diff: step_fasta_diff/out_fasta_diff_match
      in_update_gff_from_gff3_sort: step_gff3_sort/out_gff3_sort
    out: 
      [out_update_gff_updated]
  step_gff3_QC:
    run: gff3_QC.cwl
    in:
      in_gff3_QC_from_update_gff: step_update_gff/out_update_gff_updated
      in_files: in_files
    out: 
      [out_gff3_QC]
  
outputs:
  final_update_gff_updated:
    type: File
    outputSource: step_update_gff/out_update_gff_updated
  final_gff3_QC:
    type: File
    outputSource: step_gff3_QC/out_gff3_QC