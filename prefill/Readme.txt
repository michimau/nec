Each new envelope created under this reporting obligation will automatically be populated with a copy of the last report for the country (due to a custom CDR workflow step). 

The reports should then be put in CDR-test (http://cdrtest.eionet.europa.eu/xmlexports/mmr_pam/manage_main) and production (http://cdr.eionet.europa.eu/xmlexports/mmr_pam/manage_main) so they are found and can be use by the workflow. The upload URLs for CDR/CDR-test are http://.../xmlexports/mmr_pam/manage_addProduct/OFSP/manage_addFile.

The convention is the files are named by <country-code>_<obligation name>.xml, e.g. "ee_mmr-pam_report.xml". 
The country-code part is the significant one as it is what helps the CDR workflow determine which file to take for each envelope.

To run the generation of the pre-fill files, the following is needed:

* The FME job "Create_and_update_pre-fill_files.fmw"
* A list of the previous year's reports as input, e.g. "Reports_to_use.txt"

