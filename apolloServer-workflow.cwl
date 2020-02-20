#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  - class: MultipleInputFeatureRequirement
  - class: InlineJavascriptRequirement

inputs:
  PATH: string[]
  tree: string[]
  scientific_name: string[]
  genome_fasta_name: string[]
  deepPATH_apollo2_data: string[]
  deepPATH_bigwig: string[]
  host_production: string[]
  login_apollo2_production: string[]
  Apollo_account: string
  

steps:
  #step 1
  createFolder:
    run: files_4_Apollo2Server/createFolder.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      deepPATH_bigwig: deepPATH_bigwig
    out: [out_dummy]
  #step 2
  dataTransfer-bigwig:
    run: files_4_Apollo2Server/dataTransfer-bigwig.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      deepPATH_bigwig: deepPATH_bigwig
      in_dummy: createFolder/out_dummy
    out: [out_dummy]
  #step 3
  dataTransfer-jbrowse:
    run: files_4_Apollo2Server/dataTransfer-jbrowse.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      in_dummy: dataTransfer-bigwig/out_dummy
    out: [out_dummy]
  #step 3
  dataTransfer-blat:
    run: files_4_Apollo2Server/dataTransfer-blat.cwl
    in:
      Apollo_account: Apollo_account
      PATH: PATH
      tree: tree
      in_dummy: dataTransfer-jbrowse/out_dummy
    out: [out_dummy]
  #step 4
  apollo2_create_Organism:
    run: files_4_Apollo2Server/createOrganism-production.cwl
    in:
      in_dummy: dataTransfer-blat/out_dummy
      host: host_production
      scientific_name: scientific_name
      genome_fasta_name: genome_fasta_name
      PATH: PATH
      tree: tree
      deepPATH_apollo2_data: deepPATH_apollo2_data
      login_apollo2: login_apollo2_production
    out:
      [out_createOrganism_log]
outputs: []
