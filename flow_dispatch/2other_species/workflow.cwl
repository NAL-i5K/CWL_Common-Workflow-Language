#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: SubworkflowFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  in_dummy: File
  PATH: string[]
  in_tree: string[]
  deepPATH_genomic_fasta: string[]
  in_genomic_fasta: File
  deepPATH_genomic_gff: string[]
  in_genomic_gff: File
  #in_others: File[]
  #in_apollo2: Directory

steps:
  cp_genomic_fasta:
    run: cp_single.cwl
    in:
      PATH: PATH
      in_tree: in_tree
      deepPATH: deepPATH_genomic_fasta
      in_data: in_genomic_fasta
    out: []
  cp_genomic_gff:
    run: cp_single.cwl
    in:
      PATH: PATH
      in_tree: in_tree
      deepPATH: deepPATH_genomic_gff
      in_data: in_genomic_gff
    out: []
  #cp_others:
   # run: cp_others.cwl
  #  in:
  #    HOME: HOME
  #    in_tree: in_tree
  #    in_others: in_others
  #  out: []
  #cp_apollo2:
  #  run: cp_apollo2.cwl
  #  in:
  #    HOME: HOME
  #    in_tree: in_tree
  #    in_apollo2: in_apollo2
  #  out: []

outputs: []
