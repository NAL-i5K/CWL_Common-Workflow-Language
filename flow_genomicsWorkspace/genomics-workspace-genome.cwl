#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  scientific_name: string[]
  type: string[]
  in_fasta: File

steps:
  #step 1
  addorganism:
    run: addorganism.cwl
    in: 
      scientific_name: scientific_name
    out: 
      [out_dummy]
  #step 2
  addblast:
    run: addblast-genome.cwl
    in:
      scientific_name: scientific_name
      type: type
      in_fasta: in_fasta
      in_dummy: addorganism/out_dummy
    out:
      [out_dummy] 
  #step 3
  makeblastdb:
    run: makeblastdb.cwl
    in:
      in_fasta: in_fasta
      in_dummy: addblast/out_dummy
    out:
      [out_dummy]
  #step 4
  populatesequence:
    run: populatesequence.cwl
    in:
      in_fasta: in_fasta
      in_dummy: makeblastdb/out_dummy
    out:
      [out_dummy]
  #step 5
  showblast:
    run: showblast.cwl
    in:
      in_fasta: in_fasta
      in_dummy: populatesequence/out_dummy
    out:
      [out_dummy]

outputs: []
 