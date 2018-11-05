//basic configuration settings used to create the webform-project-export.metadata-file

module.exports = {
  "production" : {
    "title" : "NEC-PAM (NECD)",
    "file" : {
      "name" : "index.html"
    },
    "newXmlFileName" : "necd.xml",
    "emptyInstanceUrl" : "https://webq2test.eionet.europa.eu/download/project/nec-pam/file/instance-empty.json",
    "description" : "National Emission Ceiling Directive (NECD) web questionnaire",
    "xmlSchema" : "http://dd.eionet.europa.eu/schemas/mmr-pams/MMR_PAMs.xsd",
    "active" : true,
    "localForm" : true,
    "remoteForm" : true,
    "fileType" : "WEBFORM"
  },
  "development" : {
    "title" : "National Emission Ceiling Directive (NECD) TEST",
    "file" : {
      "name" : "index.html"
    },
    "newXmlFileName" : "necd.xml",
    "emptyInstanceUrl" : "https://webq2test.eionet.europa.eu/download/project/nec-pam/file/instance-empty.xml",
    "description" : "National Emission Ceiling Directive (NECD) TEST web questionnaire",
    "xmlSchema" : "https://webq2test.eionet.europa.eu/download/project/nec-pam/file/NEC_PAMs.xsd",
    "active" : true,
    "localForm" : true,
    "remoteForm" : true,
    "fileType" : "WEBFORM"
  }
}
