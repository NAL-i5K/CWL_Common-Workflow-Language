#!usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: creating directory tree
requirements:
  - class: InlineJavascriptRequirement

baseCommand: [mkdir]
arguments:
  - prefix: -p
    position: 1
    valueFrom: 
      data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/$(inputs.in_tree[2].split(' ')[0])_Annotation_Release_$(inputs.in_tree[2].split(' ')[1])
  
  - position: 3
    valueFrom: data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/bigwig

  - position: 5
    valueFrom: data/other_species/$(inputs.in_tree[0])/$(inputs.in_tree[1])/jbrowse/data
  
  - position: 7
    valueFrom: data/working_files/$(inputs.in_tree[0])/$(inputs.in_tree[1])/scaffold/analyses/remap
  
  - position: 9
    valueFrom: data/scratch/remap/$(inputs.in_tree[0])

  - position: 11
    valueFrom: data/blat/db/$(inputs.in_tree[0])
      
inputs:
  in_tree:
    type: string[]

outputs:
  out_tree:
    type: Directory
    outputBinding:
      glob: '*'