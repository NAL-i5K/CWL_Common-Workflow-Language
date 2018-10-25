# Usage
```
cwl-runner --debug md5sum_check.cwl md5sum_check-job.yml
```

# Equivalent command: 
```
md5sum -c md5checksums.txt &> check.log
md5sum -c md5checksums-fake.txt &> check-fake.log
```
The next block after **block_check_checksum**:
```
grep 'checksums did NOT match' check.log
grep 'checksums did NOT match' check-fake.log
```

## Structure:
**md5checksums.txt**: the file form "Download the RefSeq assembly" on NCBI website  
**md5checksums-fake.txt**: the file modify from md5checksums.txt, which purposely edit the hash value of existing file.
**check.log**: a output file after running "md5sum -c" command.  
*check-fake.log*: We expect 'checksums did NOT match' in this log file.
