
! DEPRECATED !
See: https://taskman.eionet.europa.eu/issues/82087



MMR PAMs data aggregation tool

Aggregation process:
 1. Downloads valid XML files from released envelopes in CDRtest
 2. Converts the XML files into SQL INSERT statements using XSLT
 3. Executes SQL INSERT statements in MS Access database, using HXTT jdbc driver and sjsql.class

How-to run the tool: 
 1. Copy accounts.conf-dist to accounts.conf and configure CDR account
 2. Run "mmr-pams-run.sh" bash script.
