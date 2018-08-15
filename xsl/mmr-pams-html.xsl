<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
   
  <xsl:output method="xhtml" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" omit-xml-declaration="yes" />

  <xsl:param name="envelopeurl" />
  <xsl:param name="filename" />
  <xsl:param name="envelopepath" />

  <xsl:variable name="labelsLanguage">
    <xsl:choose>
      <xsl:when test="MMR_PAMs/@labelLanguage">
        <xsl:value-of select="MMR_PAMs/@labelLanguage"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'en'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="xmlPath" select="'https://svn.eionet.europa.eu/repositories/Reportnet/Dataflows/MMR-PAMs/translations/xml/'"/>
  <xsl:variable name="countryCode">
    <xsl:choose>
      <xsl:when test="doc-available(concat($envelopeurl, '/xml'))">
        <xsl:value-of select="doc(concat($envelopeurl, '/xml'))//countrycode/string()"/>
      </xsl:when>
      <xsl:otherwise>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


  <xsl:variable name="countries">
    <entry key="AU">Austria</entry>
    <entry key="BE">Belgium</entry>
    <entry key="BG">Bulgaria</entry>
    <entry key="HR">Croatia</entry>
    <entry key="CY">Cyprus</entry>
    <entry key="CZ">Czech Republic</entry>
    <entry key="DK">Denmark</entry>
    <entry key="EE">Estonia</entry>
    <entry key="FI">Finland</entry>
    <entry key="FR">France</entry>
    <entry key="DE">Germany</entry>
    <entry key="GR">Greece</entry>
    <entry key="HU">Hungary</entry>
    <entry key="IS">Iceland</entry>
    <entry key="IT">Italy</entry>
    <entry key="LV">Latvia</entry>
    <entry key="LI">Liechtenstein</entry>
    <entry key="LT">Lithuania</entry>
    <entry key="LU">Luxembourg</entry>
    <entry key="MT">Malta</entry>
    <entry key="NL">Netherlands</entry>
    <entry key="NO">Norway</entry>
    <entry key="PL">Poland</entry>
    <entry key="PT">Portugal</entry>
    <entry key="RO">Romania</entry>
    <entry key="SK">Slovakia</entry>
    <entry key="ES">Spain</entry>
    <entry key="SE">Sweden</entry>
    <entry key="CH">Switzerland</entry>
    <entry key="TR">Turkey</entry>
    <entry key="GB">United Kingdom</entry>
  </xsl:variable>

  <xsl:variable name="labelsUrl">
    <xsl:choose>
      <xsl:when test="doc-available(concat($xmlPath, 'mmr-pams-labels-', $labelsLanguage ,'.xml'))">
        <xsl:value-of select="concat($xmlPath, 'mmr-pams-labels-', $labelsLanguage ,'.xml')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('../../../../eea/webforms/MMR-PAMs/translations/xml/mmr-pams-labels-', $labelsLanguage ,'.xml')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="labels" select="document($labelsUrl)/Labels"/>

  <xsl:template name="renderIndicator">
    <xsl:param name="indicatorNode"/>
    <xsl:if test="not(*[$indicatorNode=''])">
      <table class="table table-condensed table-responsive" xmlns="http://www.w3.org/1999/xhtml">
        <thead>
          <tr>
            <th colspan="4">
              <xsl:value-of select="$indicatorNode/Description"/>
              (<xsl:value-of select="$labels/Table1/Indicators/unit"/>: <xsl:value-of select="$indicatorNode/Unit"/>)
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><xsl:value-of select="replace($labels/Table1/Indicators/Year,'\{\{num\}\}','1')" /></td>
            <td><xsl:value-of select="$indicatorNode/Year1"/></td>
            <td><xsl:value-of select="replace($labels/Table1/Indicators/Value,'\{\{num\}\}','1')" /></td>
            <td><xsl:value-of select="$indicatorNode/Value1"/></td>
          </tr>
          <tr>
            <td><xsl:value-of select="replace($labels/Table1/Indicators/Year,'\{\{num\}\}','2')" /></td>
            <td><xsl:value-of select="$indicatorNode/Year2"/></td>
            <td><xsl:value-of select="replace($labels/Table1/Indicators/Value,'\{\{num\}\}','2')" /></td>
            <td><xsl:value-of select="$indicatorNode/Value2"/></td>
          </tr>
          <tr>
            <td><xsl:value-of select="replace($labels/Table1/Indicators/Year,'\{\{num\}\}','3')" /></td>
            <td><xsl:value-of select="$indicatorNode/Year3"/></td>
            <td><xsl:value-of select="replace($labels/Table1/Indicators/Value,'\{\{num\}\}','3')" /></td>
            <td><xsl:value-of select="$indicatorNode/Value3"/></td>
          </tr>
          <tr>
            <td><xsl:value-of select="replace($labels/Table1/Indicators/Year,'\{\{num\}\}','4')" /></td>
            <td><xsl:value-of select="$indicatorNode/Year4"/></td>
            <td><xsl:value-of select="replace($labels/Table1/Indicators/Value,'\{\{num\}\}','4')" /></td>
            <td><xsl:value-of select="$indicatorNode/Value4"/></td>
          </tr>
        </tbody>
      </table>                           
    </xsl:if>
  </xsl:template>

  
  <xsl:template match="/">
    <html lang="en" xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />   
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title><xsl:value-of select="$labels/Webform/FormTitle"/></title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
        <style type="text/css">
          #header {
            background: #a5ced1 url(http://www.eionet.europa.eu/styles/eionet2007/top_01.png) repeat-y; /* #015385; #018174; #a5ced1;  */
            border-bottom: 1px solid #999;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 9999;
          }
          #header select {
            margin-top: 6px;
          }
          #site-title {
             font-size: 29px;
             font-weight: bold;
             font-variant: small-caps;
             color: #fff;
          }
          #site-subtitle {
             font-size: 17px;
             font-weight: bold;
             color: #fff;
          }
          a.anchor {
              display: block;
              position: relative;
              visibility: hidden;
          }
          .item-title {
            margin-top: 2em;
          }
          .table-title {
            margin-top: 1em;
            margin-bottom: 1em;
          }
          .table-col-title {
              font-weight: bold;
              color: #666;
          }
          .table-row {
            border-bottom: 1px solid #ddd;
            padding: 5px 0 5px 0;
          }
          .table-row-last {
            border-bottom: 0px solid #ddd;
            margin-bottom: 1.5em;
          }
          .table-row ul {
            padding-left: 15px;
          }
          .table-row th {
            font-weight: normal;
            font-style: italic;
          }
          @media print {
            body {
              zoom: 80%;
            }
            #header {
              background: none;
              position: relative;
            }
            h1 {
              margin-top: 0.5em;
            }
          }
        </style>
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
           <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
           <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
      </head>
      <body>
        <div class="container-fluid">
          <div class="row">
            <div id="header" class="col-xs-12">
              <span id="site-title">Eionet</span>
              <span id="site-subtitle"> - <xsl:value-of select="$labels/Webform/FormTitle"/>, <xsl:value-of select="$countries/entry[@key=$countryCode]"/></span>
              <div class="pull-right">
                <select class="form-control input-sm vertical-middle hidden-print" onchange="self.location.href = '#' + options[selectedIndex].value;">
                  <option value="pam1">Jump to PAM...</option>
                  <xsl:for-each select="MMR_PAMs/MMR_PAM">
                    <xsl:element name="option">
                      <xsl:attribute name="value">
                        <xsl:value-of select="concat('pam', id)"/>
                      </xsl:attribute>
                      <xsl:value-of select="id"/>. <xsl:value-of select="substring(Title, 1, 30)"/>
                      <xsl:if test="string-length(Title) &gt; 30">
                        <xsl:text>...</xsl:text>
                      </xsl:if>
                    </xsl:element>
                  </xsl:for-each>
                </select>
              </div>
            </div>
          </div>
        
          <!--<h1><xsl:value-of select="$labels/Webform/FormTitle"/></h1>-->
         
          <xsl:for-each select="MMR_PAMs/MMR_PAM">
            
            <!-- title -->
            <div class="row">
              <div class="col-xs-12">
                <a class="anchor"><xsl:attribute name="id"><xsl:value-of select="concat('pam', id)"/></xsl:attribute></a>
                <h2 class="item-title"><xsl:value-of select="id"/>. <xsl:value-of select="Title"/> 
                  <xsl:if test="not(TitleLocal eq '')">
                    <small><br />(<xsl:value-of select="TitleLocal"/>)</small>
                  </xsl:if>
                </h2>
              </div>
            </div>
            
            <!-- table 1 -->
            <div class="row">
              <div class="col-xs-12">
                <h3 class="table-title"><xsl:value-of select="$labels/Overview/Table1" /></h3>
              </div>
            </div>
            
            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/isGroup/label" />
                </div>
                <div class="col-xs-3">
                  <xsl:call-template name="getLabel">
                    <xsl:with-param name="labelPath" select="$labels/Table1/isGroup/list"/>
                    <xsl:with-param name="labelName" select="Table1/isGroup"/>
                  </xsl:call-template>
                </div>
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/PolicyGroup/label"/>
                </div>
                <div class="col-xs-3">
                  <ul class="list-inline">
                    <xsl:for-each select="Table1/PolicyGroup">
                      <xsl:if test="not(. eq '')">
                        <li>
                          <a>
                            <xsl:attribute name="href">#pam<xsl:value-of select="."/></xsl:attribute>
                            #<xsl:value-of select="."/>
                          </a>
                        </li>
                      </xsl:if>
                    </xsl:for-each>
                  </ul>
                </div>
              </div>
            </div>
            
            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/Description/label" />
                </div>
                <div class="col-xs-9">
                  <xsl:value-of select="Table1/Description"/>
                </div>
              </div>
            </div>

            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/isEnvisaged/label" />
                </div>
                <div class="col-xs-3">
                  <xsl:choose>
                    <xsl:when test="not(Table1/isEnvisaged eq '')">
                      <xsl:call-template name="getLabel">
                        <xsl:with-param name="labelPath" select="$labels/Table1/isEnvisaged/list"/>
                        <xsl:with-param name="labelName" select="Table1/isEnvisaged"/>
                      </xsl:call-template>
                    </xsl:when>
                  </xsl:choose>
                </div>
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/Sectors/label" />
                </div>
                <div class="col-xs-3">
                  <ul>
                    <xsl:for-each select="Table1/Sectors">
                      <xsl:choose>
                        <xsl:when test="not(. eq '')">
                          <li>
                            <xsl:call-template name="getLabel">
                              <xsl:with-param name="labelPath" select="$labels/Table1/Sectors/shortlist"/>
                              <xsl:with-param name="labelName" select="."/>
                            </xsl:call-template>
                          </li>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:for-each>
                  </ul>
                </div>                
              </div>
            </div>

            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/GreenhouseGases/label" />
                </div>
                <div class="col-xs-3">
                  <ul>
                    <xsl:for-each select="Table1/GreenhouseGases">
                      <xsl:choose>
                        <xsl:when test="not(. eq '')">
                          <li>
                            <xsl:call-template name="getLabel">
                              <xsl:with-param name="labelPath" select="$labels/Table1/GreenhouseGases/list"/>
                              <xsl:with-param name="labelName" select="."/>
                            </xsl:call-template>
                          </li>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:for-each>
                  </ul>
                </div>
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/Objective/label" />
                </div>
                <div class="col-xs-3">
                  <ul>
                    <xsl:for-each select="Table1/Objective">
                      <xsl:choose>
                        <xsl:when test="not(. eq '')">
                          <li>
                            <xsl:call-template name="getLabel">
                              <xsl:with-param name="labelPath" select="$labels/Table1/Objective/list"/>
                              <xsl:with-param name="labelName" select="."/>
                            </xsl:call-template>
                          </li>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:for-each> 
                  </ul>
                </div>                
              </div>
            </div>
            
            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/ObjectiveOther/label" />
                </div>
                <div class="col-xs-3">
                  <ul>
                    <xsl:choose>
                      <xsl:when test="Table1/ObjectiveOther//ES/descendant::*/text()">
                        <li>
                          <xsl:value-of select="$labels/Table1/Sectors/shortlist/Energy_Supply"/>
                          <ul>
                            <xsl:for-each select="Table1/ObjectiveOther/ES">
                              <li>
                                <xsl:value-of select="Name"/>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="Table1/ObjectiveOther//EC/descendant::*/text()">
                        <li>
                          <xsl:value-of select="$labels/Table1/Sectors/shortlist/Energy_Consumption"/>
                          <ul>
                            <xsl:for-each select="Table1/ObjectiveOther/EC">
                              <li>
                                <xsl:value-of select="Name"/>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="Table1/ObjectiveOther//TR/descendant::*/text()">
                        <li>
                          <xsl:value-of select="$labels/Table1/Sectors/shortlist/Transport"/>
                          <ul>
                            <xsl:for-each select="Table1/ObjectiveOther/TR">
                              <li>
                                <xsl:value-of select="Name"/>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="Table1/ObjectiveOther//IP/descendant::*/text()">
                        <li>
                          <xsl:value-of select="$labels/Table1/Sectors/shortlist/Industrial_Processes"/>
                          <ul>
                            <xsl:for-each select="Table1/ObjectiveOther/IP">
                              <li>
                                <xsl:value-of select="Name"/>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="Table1/ObjectiveOther//AG/descendant::*/text()">
                        <li>
                          <xsl:value-of select="$labels/Table1/Sectors/shortlist/Agriculture"/>
                          <ul>
                            <xsl:for-each select="Table1/ObjectiveOther/AG">
                              <li>
                                <xsl:value-of select="Name"/>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="Table1/ObjectiveOther//LULUCF/descendant::*/text()">
                        <li>
                          <xsl:value-of select="$labels/Table1/Sectors/shortlist/LULUCF"/>
                          <ul>
                            <xsl:for-each select="Table1/ObjectiveOther/LULUCF">
                              <li>
                                <xsl:value-of select="Name"/>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="Table1/ObjectiveOther//WA/descendant::*/text()">
                        <li>
                          <xsl:value-of select="$labels/Table1/Sectors/shortlist/Waste"/>
                          <ul>
                            <xsl:for-each select="Table1/ObjectiveOther/WA">
                              <li>
                                <xsl:value-of select="Name"/>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:when>
                    </xsl:choose>
                    <xsl:choose>
                      <xsl:when test="Table1/ObjectiveOther//CC/descendant::*/text()">
                        <li>
                          <xsl:value-of select="$labels/Table1/Sectors/shortlist/Cross-cutting"/>
                          <ul>
                            <xsl:for-each select="Table1/ObjectiveOther/CC">
                              <li>
                                <xsl:value-of select="Name"/>
                              </li>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:when>
                    </xsl:choose>
                  </ul>
                </div>
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/ObjectiveQuantified/label" />
                </div>
                <div class="col-xs-3">
                  <xsl:value-of select="Table1/ObjectiveQuantified"/>
                </div>                
              </div>
            </div>
            
            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/PolicyInstrument/label" />
                </div>
                <div class="col-xs-3">
                  <ul>
                    <xsl:for-each select="Table1/PolicyInstrument">
                      <xsl:if test="not(. eq '')">
                        <li>
                          <xsl:call-template name="getLabel">
                            <xsl:with-param name="labelPath" select="$labels/Table1/PolicyInstrument/list"/>
                            <xsl:with-param name="labelName" select="."/>
                          </xsl:call-template>
                        </li>
                      </xsl:if>
                    </xsl:for-each>
                  </ul>
                </div>
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/UnionPolicy/label" />
                </div>
                <div class="col-xs-3">
                  <ul>
                    <xsl:choose>
                      <xsl:when test="Table1/UnionPolicyRelated = 'no'">
                        <li>
                          <xsl:value-of select="$labels/Table1/UnionPolicy/not_related" />
                        </li>
                      </xsl:when>
                      <xsl:otherwise>
                        <li>
                          <xsl:value-of select="$labels/Table1/UnionPolicy/related" />:
                          <ul>
                            <xsl:for-each select="Table1/UnionPolicy">
                              <xsl:if test="not(. eq '')">
                                <li>
                                  <xsl:call-template name="getLabel">
                                    <xsl:with-param name="labelPath" select="$labels/Table1/UnionPolicy/list"/>
                                    <xsl:with-param name="labelName" select="."/>
                                  </xsl:call-template>
                                </li>
                              </xsl:if>
                            </xsl:for-each>
                          </ul>
                        </li>
                        <li>
                          <xsl:value-of select="$labels/Table1/UnionPolicy/other" />:
                          <ul>
                            <xsl:for-each select="Table1/UnionPolicyOther">
                              <xsl:choose>
                                <xsl:when test="not(Name eq '')">
                                  <li>
                                    <xsl:value-of select="Name"/>
                                  </li>
                                </xsl:when>
                              </xsl:choose>
                            </xsl:for-each>
                          </ul>
                        </li>
                      </xsl:otherwise>
                    </xsl:choose>
                  </ul>
                </div>                 
              </div>
            </div>
            
            <div class="table-row">
              <div class="row">               
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/ImplementationStatus/label" />
                </div>
                <div class="col-xs-9">
                  <table class="table table-condensed table-responsive">
                    <thead>
                      <tr>
                        <xsl:if test="Table1/isGroup eq 'group'">
                          <th>#</th>
                        </xsl:if>
                        <th>
                          <xsl:value-of select="$labels/Table1/ImplementationStatus/label" />
                        </th>
                        <th>
                          <xsl:value-of select="$labels/Table1/ImplementationPeriod/start"/>
                        </th>
                        <th>
                          <xsl:value-of select="$labels/Table1/ImplementationPeriod/finish"/>
                        </th>
                        <th>
                          <xsl:value-of select="$labels/Table1/ImplementationPeriod/comments"/>
                        </th>                          
                      </tr>
                    </thead>
                    <tbody>
                      <xsl:for-each select="Table1/Implementation">
                        <tr>
                          <xsl:choose>
                            <xsl:when test="../isGroup eq 'group'">
                              <td>
                                <a>
                                  <xsl:attribute name="href">#pam<xsl:value-of select="./id"/></xsl:attribute>
                                  #<xsl:value-of select="./id"/>
                                </a>
                              </td>
                            </xsl:when>
                          </xsl:choose>
                          <td>
                            <xsl:choose>
                              <xsl:when test="not(Status eq '')">
                                <xsl:call-template name="getLabel">
                                  <xsl:with-param name="labelPath" select="$labels/Table1/ImplementationStatus/shortlist"/>
                                  <xsl:with-param name="labelName" select="Status"/>
                                </xsl:call-template>
                              </xsl:when>
                            </xsl:choose>
                          </td>
                          <td>
                            <xsl:value-of select="Start"/>
                          </td>
                          <td>
                            <xsl:value-of select="Finish"/>
                          </td>
                          <td>
                            <xsl:value-of select="Comments"/>
                          </td>                            
                        </tr>
                      </xsl:for-each>
                    </tbody>
                  </table>                
                </div>
              </div>
            </div>    
            
            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/ProjectionsScenario/label" />
                </div>
                <div class="col-xs-3">
                  <ul>
                    <xsl:for-each select="Table1/ProjectionsScenario">
                      <li>
                        <xsl:if test="not(Type eq '')">
                          <xsl:call-template name="getLabel">
                            <xsl:with-param name="labelPath" select="$labels/Table1/ProjectionsScenario/list"/>
                            <xsl:with-param name="labelName" select="Type"/>
                          </xsl:call-template>
                          <xsl:if test="../isGroup eq 'group'">
                            (<a><xsl:attribute name="href">#pam<xsl:value-of select="./id"/></xsl:attribute>#<xsl:value-of select="./id"/></a>)
                          </xsl:if>
                        </xsl:if>
                      </li>
                    </xsl:for-each>
                   </ul>
                </div>
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/Entities/label" />
                </div>
                <div class="col-xs-3">
                  <ul>
                    <xsl:for-each select="Table1/Entities">
                      <li>
                        <xsl:value-of select="Name"/> (<xsl:value-of select="Type"/>)
                      </li>
                    </xsl:for-each>
                  </ul>
                </div>
              </div>
            </div>

            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/Indicators/label" />
                </div>
                <div class="col-xs-9">
                  <xsl:for-each select="Table1/Indicators [position() mod 2 = 1]">
                    <div class="row">
                      <div class="col-xs-6">
                        <xsl:if test="not(. eq '')">
                          <xsl:call-template name="renderIndicator">
                            <xsl:with-param name="indicatorNode" select="." />
                          </xsl:call-template>
                        </xsl:if>  
                      </div>
                      <div class="col-xs-6">
                        <xsl:if test="not((following-sibling::Indicators)[1] eq '')">
                          <xsl:call-template name="renderIndicator">
                            <xsl:with-param name="indicatorNode" select="(following-sibling::Indicators)[1]" />
                          </xsl:call-template>
                        </xsl:if>
                      </div>
                    </div>
                  </xsl:for-each>
                </div>
              </div>
            </div>            
            
            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/Reference/label" />
                </div>
                <div class="col-xs-9">
                  <xsl:for-each select="Table1/Reference">
                    <div class="row">
                      <div class="col-xs-12">
                        <xsl:value-of select="./Text"/>
                        <xsl:if test="not(./Url eq '')">
                          (<a>
                            <xsl:attribute name="href">
                              <xsl:value-of select="./Url"/>
                            </xsl:attribute>
                            <xsl:value-of select="./Url"/>
                          </a>)
                        </xsl:if>
                      </div>
                    </div>
                  </xsl:for-each>
                </div>
              </div>
            </div>

            <div class="table-row table-row-last">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table1/Comments/label" />
                </div>
                <div class="col-xs-9">
                  <xsl:value-of select="Table1/Comments"/>
                </div>
              </div>
            </div>

            
            <!-- table 2 -->
            <div class="row">
              <div class="col-xs-12">
                <h3 class="table-title"><xsl:value-of select="$labels/Overview/Table2" /></h3>
              </div>
            </div>

            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table2/PolicyImpact/label" />
                </div>
                <div class="col-xs-9">
                  <ul>
                    <xsl:for-each select="Table2/PolicyImpact">
                      <xsl:if test="not(. eq '') ">
                        <li>
                          <xsl:call-template name="getLabel">
                            <xsl:with-param name="labelPath" select="$labels/Table2/PolicyImpact"/>
                            <xsl:with-param name="labelName" select="."/>
                          </xsl:call-template>
                        </li>
                      </xsl:if>
                    </xsl:for-each>
                  </ul>
                </div>
              </div>
            </div>

            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table2/Exante"/>
                </div>
                <div class="col-xs-9">
                  <div class="table-row">
                    <div class="row">
                      <div class="col-xs-12">
                        <table class="table table-condensed table-responsive">
                          <thead>
                            <tr>
                              <th></th>
                              <th><xsl:value-of select="$labels/Table2/PolicyImpact/EU_ETS" /></th>
                              <th><xsl:value-of select="$labels/Table2/PolicyImpact/ESD" /></th>
                              <th><xsl:value-of select="$labels/Table2/PolicyImpact/Total" /></th>
                            </tr>
                           </thead>
                           <tbody>
                              <tr>
                                 <td><xsl:value-of select="replace($labels/Table2/ExanteEmissions/label,'\{\{year\}\}','2020')" /></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions1/EU_ETS"/></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions1/ESD"/></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions1/Total"/></td>
                              </tr>
                              <tr>
                                 <td><xsl:value-of select="replace($labels/Table2/ExanteEmissions/label,'\{\{year\}\}','2025')" /></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions2/EU_ETS"/></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions2/ESD"/></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions2/Total"/></td>
                              </tr>
                              <tr>
                                 <td><xsl:value-of select="replace($labels/Table2/ExanteEmissions/label,'\{\{year\}\}','2030')" /></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions3/EU_ETS"/></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions3/ESD"/></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions3/Total"/></td>
                              </tr>
                              <tr>
                                 <td><xsl:value-of select="replace($labels/Table2/ExanteEmissions/label,'\{\{year\}\}','2035')" /></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions4/EU_ETS"/></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions4/ESD"/></td>
                                 <td><xsl:value-of select="Table2/ExanteEmissions4/Total"/></td>
                              </tr>
                           </tbody>
                        </table>      
                      </div>
                    </div>
                  </div>
                  <div class="table-row table-row-last">
                    <div class="row ">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table2/Documentation/Reference" /></em>
                      </div>
                      <div class="col-xs-9">
                        <ul>
                          <xsl:for-each select="Table2/ExanteDocumentation">
                            <xsl:if test="not(./Reference eq '') ">
                              <li>
                                <xsl:value-of select="./Reference"/>
                                <xsl:if test="not(./Weblink eq '')">
                                  (<a>
                                    <xsl:attribute name="href">
                                      <xsl:value-of select="./Weblink"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./Weblink"/>
                                  </a>)
                                </xsl:if>
                              </li>
                            </xsl:if>
                          </xsl:for-each>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>            

            <div class="table-row table-row-last">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table2/Expost/Title" />
                </div>
                <div class="col-xs-9">
                  <div class="table-row">
                    <div class="row">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table2/ExpostEmissions/label" /></em>
                      </div>
                      <div class="col-xs-9">
                        <table class="table table-condensed table-responsive">
                          <thead>
                            <tr>
                              <th><xsl:value-of select="$labels/Table2/Expost/Year" /></th>
                              <th><xsl:value-of select="$labels/Table2/Expost/Average" /></th>
                            </tr>
                          </thead>
                          <tbody>
                            <xsl:for-each select="Table2/Expost">
                              <tr>
                                <td><xsl:value-of select="Year"/></td>
                                <td><xsl:value-of select="Average"/></td>
                              </tr>
                            </xsl:for-each>
                          </tbody>
                        </table> 
                      </div>
                    </div>
                  </div>
                  <div class="table-row">
                    <div class="row">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table2/BasisExplanation/label" /></em>
                      </div>
                      <div class="col-xs-9">
                        <xsl:value-of select="Table2/BasisExplanation"/><br />
                      </div>
                    </div>
                  </div>
                  <div class="table-row">
                    <div class="row">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table2/AffectedFactors/label" /></em>
                        </div>
                      <div class="col-xs-9">
                        <xsl:value-of select="Table2/AffectedFactors"/><br />
                      </div>
                    </div>
                  </div>
                  <div class="table-row table-row-last">
                    <div class="row">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table2/Documentation/Reference" /></em>
                      </div>
                      <div class="col-xs-9">                      
                        <ul>
                          <xsl:for-each select="Table2/ExpostDocumentation">
                            <xsl:if test="not(./Reference eq '') ">
                              <li>
                                <xsl:value-of select="./Reference"/>
                                <xsl:if test="not(./Weblink eq '')">
                                  (<xsl:element name="a">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="./Weblink"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./Weblink"/>
                                  </xsl:element>)
                                </xsl:if>
                              </li>
                            </xsl:if>
                          </xsl:for-each>
                        </ul>
                      </div>  
                    </div>
                  </div>
                </div>
              </div>
            </div>                

            <!-- table 3 -->
            <h3 class="table-title"><xsl:value-of select="$labels/Overview/Table3" /></h3>
            
            <div class="table-row">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table3/Costs/Projected" />
                </div>
                <div class="col-xs-9">
                  <div class="table-row table-row-last">
                    <div class="row">
                      <div class="col-xs-12">
                        <table class="table table-condensed table-responsive">
                          <thead>
                            <tr>
                              <th><xsl:value-of select="$labels/Table3/Costs/CostType" /></th>
                              <th>&#160;</th>
                              <th><xsl:value-of select="$labels/Table3/Costs/BenefitType" /></th>
                              <th>&#160;</th>
                              <th><xsl:value-of select="$labels/Table3/Costs/NetCostType" /></th>
                              <th>&#160;</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td><xsl:value-of select="$labels/Table3/Costs/CostReduced" /></td>
                              <td><xsl:value-of select="Table3/Projected/CostReduced"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/Benefit" /></td>
                              <td><xsl:value-of select="Table3/Projected/BenefitReduced"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/NetCost" /></td>
                              <td><xsl:value-of select="Table3/Projected/NetCostReduced"/></td>
                            </tr>
                            <tr>
                              <td><xsl:value-of select="$labels/Table3/Costs/CostPerYear" /></td>
                              <td><xsl:value-of select="Table3/Projected/CostPerYear"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/BenefitPerYear" /></td>
                              <td><xsl:value-of select="Table3/Projected/BenefitPerYear"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/NetCostPerYear" /></td>
                              <td><xsl:value-of select="Table3/Projected/NetCostPerYear"/></td>                              
                            </tr>
                            <tr>
                              <td><xsl:value-of select="$labels/Table3/Costs/CostCalculatedYear" /></td>
                              <td><xsl:value-of select="Table3/Projected/CostCalculatedYear"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/BenefitCalculatedYear" /></td>
                              <td><xsl:value-of select="Table3/Projected/CostCalculatedYear"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/NetCostCalculatedYear" /></td>
                              <td><xsl:value-of select="Table3/Projected/CostCalculatedYear"/></td>
                            </tr>
                          </tbody>
                        </table> 
                      </div>
                    </div>
                  </div>
                  <div class="table-row">
                    <div class="row">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table3/Costs/CostReferenceYear" /></em>
                      </div>
                      <div class="col-xs-9">
                        <xsl:value-of select="Table3/Projected/CostReferenceYear"/>
                      </div>
                    </div>
                  </div>
                  <div class="table-row">
                    <div class="row">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table3/Costs/CostDescription" /></em>
                      </div>
                      <div class="col-xs-9">
                        <xsl:value-of select="Table3/Projected/CostDescription"/>
                      </div>
                    </div>
                  </div>
                  <div class="table-row table-row-last">
                    <div class="row">
                      <div class="col-xs-3">
                        <xsl:value-of select="$labels/Table3/Costs/CostDocumentation/Reference" />
                      </div>
                      <div class="col-xs-9">
                        <ul>
                          <xsl:for-each select="Table3/Projected/CostDocumentation">
                            <xsl:if test="not(./Reference eq '') ">
                              <li>
                                <xsl:value-of select="./Reference"/>
                                <xsl:if test="not(./Weblink eq '')">
                                  (<xsl:element name="a">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="./Weblink"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./Weblink"/>
                                  </xsl:element>)
                                </xsl:if>
                              </li>
                            </xsl:if>
                          </xsl:for-each>
                        </ul>                  
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="table-row table-row-last">
              <div class="row">
                <div class="col-xs-3 table-col-title">
                  <xsl:value-of select="$labels/Table3/Costs/Realised" />
                </div>
                <div class="col-xs-9">
                  <div class="table-row table-row-last">
                    <div class="row">
                      <div class="col-xs-12">
                        <table class="table table-condensed table-responsive">
                          <thead>
                            <tr>
                              <th><xsl:value-of select="$labels/Table3/Costs/CostType" /></th>
                              <th>&#160;</th>
                              <th><xsl:value-of select="$labels/Table3/Costs/BenefitType" /></th>
                              <th>&#160;</th>
                              <th><xsl:value-of select="$labels/Table3/Costs/NetCostType" /></th>
                              <th>&#160;</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td><xsl:value-of select="$labels/Table3/Costs/CostReduced" /></td>
                              <td><xsl:value-of select="Table3/Realised/CostReduced"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/Benefit" /></td>
                              <td><xsl:value-of select="Table3/Realised/BenefitReduced"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/NetCost" /></td>
                              <td><xsl:value-of select="Table3/Realised/NetCostReduced"/></td>
                            </tr>
                            <tr>
                              <td><xsl:value-of select="$labels/Table3/Costs/CostPerYear" /></td>
                              <td><xsl:value-of select="Table3/Realised/CostPerYear"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/BenefitPerYear" /></td>
                              <td><xsl:value-of select="Table3/Realised/BenefitPerYear"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/NetCostPerYear" /></td>
                              <td><xsl:value-of select="Table3/Realised/NetCostPerYear"/></td>                              
                            </tr>
                            <tr>
                              <td><xsl:value-of select="$labels/Table3/Costs/CostCalculatedYear" /></td>
                              <td><xsl:value-of select="Table3/Realised/CostCalculatedYear"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/BenefitCalculatedYear" /></td>
                              <td><xsl:value-of select="Table3/Realised/CostCalculatedYear"/></td>
                              <td><xsl:value-of select="$labels/Table3/Costs/NetCostCalculatedYear" /></td>
                              <td><xsl:value-of select="Table3/Realised/CostCalculatedYear"/></td>
                            </tr>
                          </tbody>
                        </table> 
                      </div>
                    </div>
                  </div>
                  <div class="table-row">
                    <div class="row">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table3/Costs/CostReferenceYear" /></em>
                      </div>
                      <div class="col-xs-9">
                        <xsl:value-of select="Table3/Realised/CostReferenceYear"/>
                      </div>
                    </div>
                  </div>
                  <div class="table-row">
                    <div class="row">
                      <div class="col-xs-3">
                        <em><xsl:value-of select="$labels/Table3/Costs/CostDescription" /></em>
                      </div>
                      <div class="col-xs-9">
                        <xsl:value-of select="Table3/Realised/CostDescription"/>
                      </div>
                    </div>
                  </div>
                  <div class="table-row table-row-last">
                    <div class="row">
                      <div class="col-xs-3">
                        <xsl:value-of select="$labels/Table3/Costs/CostDocumentation/Reference" />
                      </div>
                      <div class="col-xs-9">
                        <ul>
                          <xsl:for-each select="Table3/Realised/CostDocumentation">
                            <xsl:if test="not(./Reference eq '') ">
                              <li>
                                <xsl:value-of select="./Reference"/>
                                <xsl:if test="not(./Weblink eq '')">
                                  (<xsl:element name="a">
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="./Weblink"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./Weblink"/>
                                  </xsl:element>)
                                </xsl:if>
                              </li>
                            </xsl:if>
                          </xsl:for-each>
                        </ul>                  
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

          </xsl:for-each>
        </div>
        <!--
        <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
        -->
      </body>
    </html>
  </xsl:template>

  <xsl:template name="getLabel" >
    <xsl:param name="labelPath"/>
    <xsl:param name="labelName"/>
    <!--<xsl:param name="lang" select="'en'"/>-->
    <xsl:variable name="labelValue">
      <xsl:value-of select="$labelPath/*[name() = $labelName]/text()" />
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($labelValue) &gt; 0">
        <xsl:value-of disable-output-escaping="yes" select="$labelValue"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of disable-output-escaping="yes" select="concat($labelPath,$labelName)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>