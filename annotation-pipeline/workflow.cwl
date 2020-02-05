#! /usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
#requirements:

inputs:
  inputFile_Path: string
  #Kobas
  K_input_Species: string
  K_inputFile_Type: string
  K_output_Name: string
  K_database_Dir: string
  #Goanna
  G_blast: string
  G_output_Name: string 
  G_NCBI_Def: string
  G_identity_Percentage: int
  G_bitscore: int
  G_databaseQuery_ID: string
  G_name_OnOutput: string
  G_NCBI_taxonID: string 
  I_output_Name: string
  I_output_fileFormat: string
  I_name_OnOutput: string
  I_taxonID: string
  I_database: string

steps:
  #step 1
  create-Shell_Script:
    run: create-Shell_Script.cwl
    in: []
    out:
      [Script_file]  
  #step 2
  writeFirstLine:
    run: writeFirstLine.cwl
    in:
      scriptFile: create-Shell_Script/Script_file
    out:
      [Script_file]
  #step 3
  writeGoanna:
    run: writeGoanna.cwl
    in: 
      scriptFile: writeFirstLine/Script_file
      inputFile_Path: inputFile_Path
      G_blast: G_blast
      G_output_Name: G_output_Name
      G_NCBI_Def: G_NCBI_Def
      G_identity_Percentage: G_identity_Percentage
      G_bitscore: G_bitscore
      G_databaseQuery_ID: G_databaseQuery_ID
      G_name_OnOutput: G_name_OnOutput
      G_NCBI_taxonID: G_NCBI_taxonID
    out:
      [Script_file]
  #step 4
  writeFinishMessage_Goanna:
    run: writeFinishMessage.cwl
    in:
      scriptFile: writeGoanna/Script_file
    out:
      [Script_file]
  #step 5
  writeKobas:
    run: writeKobas.cwl
    in:
      scriptFile: writeFinishMessage_Goanna/Script_file
      inputFile_Path: inputFile_Path
      K_input_Species: K_input_Species
      K_inputFile_Type: K_inputFile_Type
      K_output_Name: K_output_Name
      K_database_Dir: K_database_Dir
    out:
      [Script_file]
  #step 6
  writeFinishMessage_Kobas:
    run: writeFinishMessage.cwl
    in:
      scriptFile: writeKobas/Script_file
    out:
      [Script_file]
  #step 7
  writeInterproscan:
    run: writeInter.cwl
    in: 
      scriptFile: writeFinishMessage_Kobas/Script_file
      inputFile_Path: inputFile_Path
      I_output_Name: I_output_Name
      I_output_fileFormat: I_output_fileFormat
      I_name_OnOutput: I_name_OnOutput
      I_taxonID: I_taxonID
      I_database: I_database
    out: 
      [Script_file]
  #step 8
  writeFinishMessage_Inter:
    run: writeFinishMessage.cwl
    in:
      scriptFile: writeInterproscan/Script_file
    out:
      [Script_file]

outputs: 
  Script_file: 
    type: File
    outputSource: create-Shell_Script/Script_file
