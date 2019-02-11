#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: 
      ${
        var LIST = [(inputs.in_md5checksums_txt)];
        return LIST;
      }

baseCommand: [egrep]
arguments: 
  - position: 1
    valueFrom: 
      ${
        var A = inputs.in_gz;
        var B = [];
        for (var i = 0; i < A.length; i++) {
          B = B + A[i].basename;
          if(i != A.length-1) {
            B = B + '|';
          }
        }
        return B;
      }
  - position: 2
    valueFrom: $(inputs.in_md5checksums_txt.basename)
    
inputs: 
  in_md5checksums_txt:
    type: File
  in_gz:
    type: File[]

outputs: 
  out_txt2:
    type: stdout
stdout: md5checksums.txt2 
