#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [inputs.in_txt2, inputs.in_dir];
        return LIST;
      }
baseCommand: [cp]
arguments: 
  - position: 1
    valueFrom: $(inputs.in_txt2.basename)
  - position: 2
    valueFrom: $(inputs.in_dir.basename)/working_files/$(inputs.in_tree[0])/$(inputs.in_tree[1])/

inputs: 
  in_dir:
    type: Directory
  in_tree:
    type: string[]
  in_txt2:
    type: File
      
outputs:
  out_dir:
    type: Directory
    outputBinding:
      glob: $(inputs.in_dir.basename)
