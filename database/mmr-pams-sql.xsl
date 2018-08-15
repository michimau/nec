<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="common.xsl"/>

<xsl:output method="text" />

<xsl:param name="envelopeurl" />
<xsl:param name="releasetime"/>
<xsl:param name="filename" />
<xsl:param name="isreleased" select="'1'"/>
<xsl:param name="country" />

<xsl:variable name="reportid" select="concat($envelopeurl, '/', $filename , '#', $releasetime)"/>
<xsl:template match="MMR_PAMs">
  <xsl:text></xsl:text>
  <xsl:text>INSERT INTO data_report (report_id, country, report_year, report_submission_date, envelope_url, filename, is_released, language) VALUES (</xsl:text>
  <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
  <xsl:call-template name="string"><xsl:with-param name="value" select="$country"/></xsl:call-template><xsl:text>,</xsl:text>
  <xsl:call-template name="number"><xsl:with-param name="value" select="@year"/></xsl:call-template><xsl:text>,</xsl:text>
  <xsl:call-template name="datetime"><xsl:with-param name="value" select="$releasetime"/></xsl:call-template><xsl:text>,</xsl:text>
  <xsl:call-template name="string"><xsl:with-param name="value" select="$envelopeurl"/></xsl:call-template><xsl:text>,</xsl:text>
  <xsl:call-template name="string"><xsl:with-param name="value" select="$filename"/></xsl:call-template><xsl:text>,</xsl:text>
  <xsl:call-template name="string"><xsl:with-param name="value" select="$isreleased"/></xsl:call-template><xsl:text>,</xsl:text>
  <xsl:call-template name="string"><xsl:with-param name="value" select="@xml:lang"/></xsl:call-template>
  <xsl:text>);</xsl:text>
  <xsl:text>&#xa;</xsl:text>

  <xsl:text>UPDATE data_report SET most_recent_report = 1 WHERE country='</xsl:text>
  <xsl:value-of select="$country"/>
  <xsl:text>' and report_submission_date IN (SELECT TOP 1 report_submission_date FROM data_report WHERE country='</xsl:text>
  <xsl:value-of select="$country"/>
  <xsl:text>' order by report_submission_date DESC);</xsl:text>
  <xsl:text>&#xa;</xsl:text>

  <xsl:text>UPDATE data_report SET most_recent_report = 0 WHERE country='</xsl:text>
  <xsl:value-of select="$country"/>
  <xsl:text>' and report_submission_date NOT IN (SELECT TOP 1 report_submission_date FROM data_report WHERE country='</xsl:text>
  <xsl:value-of select="$country"/>
  <xsl:text>' order by report_submission_date DESC);</xsl:text>
  <xsl:text>&#xa;</xsl:text>

  <xsl:for-each select="MMR_PAM">
    <xsl:variable name="id" select="id"/>
    <!-- Table1 Start -->
    <xsl:text>INSERT INTO table1 (report_id, id, Title, isGroup,ObjectiveQuantified,Description,isEnvisaged,UnionPolicyRelated,Reference_Text,Reference_Url,Comments) VALUES (</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="id"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Title"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table1/isGroup"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table1/ObjectiveQuantified"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table1/Description"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table1/isEnvisaged"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table1/UnionPolicyRelated"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table1/Reference/Text"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table1/Reference/Url"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table1/Comments"/></xsl:call-template>
    <xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <xsl:for-each select="Table1/PolicyGroup">
      <xsl:text>INSERT INTO table1_PolicyGroup (report_id, id, policyGroupId) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/Sectors">
      <xsl:text>INSERT INTO table1_Sectors (report_id, id, sectorCode) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/GreenhouseGases">
      <xsl:text>INSERT INTO table1_GreenhouseGases (report_id, id, greenhouseGasCode) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/Objective">
      <xsl:text>INSERT INTO table1_Objective (report_id, id, objectiveCode) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ObjectiveOther/ES">
      <xsl:text>INSERT INTO table1_ObjectiveOther (report_id, id, shortSectorCode, objectiveOther) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:text>'ES',</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ObjectiveOther/EC">
      <xsl:text>INSERT INTO table1_ObjectiveOther (report_id, id, shortSectorCode, objectiveOther) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:text>'EC',</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ObjectiveOther/TR">
      <xsl:text>INSERT INTO table1_ObjectiveOther (report_id, id, shortSectorCode, objectiveOther) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:text>'TR',</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ObjectiveOther/IP">
      <xsl:text>INSERT INTO table1_ObjectiveOther (report_id, id, shortSectorCode, objectiveOther) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:text>'IP',</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ObjectiveOther/AG">
      <xsl:text>INSERT INTO table1_ObjectiveOther (report_id, id, shortSectorCode, objectiveOther) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:text>'AG',</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ObjectiveOther/LULUCF">
      <xsl:text>INSERT INTO table1_ObjectiveOther (report_id, id, shortSectorCode, objectiveOther) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:text>'LULUCF',</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ObjectiveOther/WA">
      <xsl:text>INSERT INTO table1_ObjectiveOther (report_id, id, shortSectorCode, objectiveOther) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:text>'WA',</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ObjectiveOther/CC">
      <xsl:text>INSERT INTO table1_ObjectiveOther (report_id, id, shortSectorCode, objectiveOther) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:text>'CC',</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/PolicyInstrument">
      <xsl:text>INSERT INTO table1_PolicyInstrument (report_id, id, policyInstrumentCode) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/UnionPolicy">
      <xsl:text>INSERT INTO table1_UnionPolicy (report_id, id, unionPolicyCode) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="alterDuplicates"><xsl:with-param name="key" select="."/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/UnionPolicyOther">
      <xsl:text>INSERT INTO table1_UnionPolicyOther (report_id, id, unionPolicyOther, unionPolicyOtherMemo) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="substring(Name,1,50)"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/Implementation">
      <xsl:text>INSERT INTO table1_Implementation (report_id, id, pamNumber, status, start, finish) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:choose>
        <xsl:when test="not(id = '')"><xsl:call-template name="number"><xsl:with-param name="value" select="id"/></xsl:call-template></xsl:when>
        <xsl:otherwise>null</xsl:otherwise>
      </xsl:choose><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Status"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Start"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Finish"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/ProjectionsScenario">
      <xsl:text>INSERT INTO table1_ProjectionsScenario (report_id, id, pamNumber, projectionsScenarioCode) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:choose>
        <xsl:when test="not(id = '')"><xsl:call-template name="number"><xsl:with-param name="value" select="id"/></xsl:call-template></xsl:when>
        <xsl:otherwise>null</xsl:otherwise>
      </xsl:choose><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Type"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/Entities">
      <xsl:text>INSERT INTO table1_Entities (report_id, id, type, name) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Type"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Name"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table1/Indicators">
      <xsl:text>INSERT INTO table1_Indicators (report_id, id, description, unit, year1, year2, year3, year4, value1_text, value1, value2_text, value2, value3_text, value3, value4_text, value4) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Description"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Unit"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Year1"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Year2"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Year3"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Year4"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Value1"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Value1"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Value2"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Value2"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Value3"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Value3"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Value4"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Value4"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>

    <!-- Table2 Start -->
    <xsl:for-each select="Table2">
      <xsl:text>INSERT INTO table2 (report_id, id, ExpostExplanation, ExpostFactors) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="BasisExplanation"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="AffectedFactors"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>

    <xsl:for-each select="Table2/PolicyImpact">
      <xsl:text>INSERT INTO table2_PolicyImpact (report_id, id, policyImpactCode) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>

    <xsl:text>INSERT INTO table2_ExanteEmissions (report_id, id, ghgYear, eu_ets_text, eu_ets, esd_text, esd, total_text, total) VALUES (</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:text>2020,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions1/EU_ETS"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions1/EU_ETS"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions1/ESD"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions1/ESD"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions1/Total"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions1/Total"/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <xsl:text>INSERT INTO table2_ExanteEmissions (report_id, id, ghgYear, eu_ets_text, eu_ets, esd_text, esd, total_text, total) VALUES (</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:text>2025,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions2/EU_ETS"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions2/EU_ETS"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions2/ESD"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions2/ESD"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions2/Total"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions2/Total"/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <xsl:text>INSERT INTO table2_ExanteEmissions (report_id, id, ghgYear, eu_ets_text, eu_ets, esd_text, esd, total_text, total) VALUES (</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:text>2030,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions3/EU_ETS"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions3/EU_ETS"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions3/ESD"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions3/ESD"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions3/Total"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions3/Total"/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <xsl:text>INSERT INTO table2_ExanteEmissions (report_id, id, ghgYear, eu_ets_text, eu_ets, esd_text, esd, total_text, total) VALUES (</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:text>2035,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions4/EU_ETS"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions4/EU_ETS"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions4/ESD"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions4/ESD"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table2/ExanteEmissions4/Total"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table2/ExanteEmissions4/Total"/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <xsl:for-each select="Table2/ExanteDocumentation">
      <xsl:text>INSERT INTO table2_ExanteDocumentation (report_id, id, reference, weblink) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Reference"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Weblink"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table2/Expost">
      <xsl:text>INSERT INTO table2_ExpostEmissions (report_id, id, ghgYear, average_text, average) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Year"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Average"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="Average"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table2/ExpostDocumentation">
      <xsl:text>INSERT INTO table2_ExpostDocumentation (report_id, id, reference, weblink) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Reference"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Weblink"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>

    <!-- Table3 Start -->
    <xsl:text>INSERT INTO table3 (report_id, id, Projected_costReduced_text, Projected_costReduced, Projected_benefitReduced_text, Projected_benefitReduced, Projected_netcostReduced_text, Projected_netcostReduced, Projected_costAbsolute_text, Projected_costAbsolute, Projected_benefitAbsolute_text, Projected_benefitAbsolute, Projected_netcostAbsolute_text, Projected_netcostAbsolute, Projected_costYear_text, Projected_costYear, Projected_priceReferenceYear, Projected_description, Realised_costReduced_text, Realised_costReduced, Realised_benefitReduced_text, Realised_benefitReduced, Realised_netcostReduced_text, Realised_netcostReduced, Realised_costAbsolute_text, Realised_costAbsolute, Realised_benefitAbsolute_text, Realised_benefitAbsolute, Realised_netcostAbsolute_text, Realised_netcostAbsolute, Realised_costYear_text, Realised_costYear, Realised_priceReferenceYear, Realised_description) VALUES (</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Projected/CostReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Projected/CostReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Projected/BenefitReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Projected/BenefitReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Projected/NetCostReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Projected/NetCostReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Projected/CostPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Projected/CostPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Projected/BenefitPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Projected/BenefitPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Projected/NetCostPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Projected/NetCostPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Projected/CostCalculatedYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Projected/CostCalculatedYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Projected/CostReferenceYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Projected/CostDescription"/></xsl:call-template><xsl:text>,</xsl:text>

    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Realised/CostReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Realised/CostReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Realised/BenefitReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Realised/BenefitReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Realised/NetCostReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Realised/NetCostReduced"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Realised/CostPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Realised/CostPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Realised/BenefitPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Realised/BenefitPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Realised/NetCostPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Realised/NetCostPerYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Realised/CostCalculatedYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Realised/CostCalculatedYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="number"><xsl:with-param name="value" select="Table3/Realised/CostReferenceYear"/></xsl:call-template><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="Table3/Realised/CostDescription"/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>

    <xsl:for-each select="Table3/Projected/CostDocumentation">
      <xsl:text>INSERT INTO table3_ProjectedDocumentation (report_id, id, reference, weblink) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Reference"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Weblink"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:for-each select="Table3/Realised/CostDocumentation">
      <xsl:text>INSERT INTO table3_RealisedDocumentation (report_id, id, reference, weblink) VALUES (</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="$reportid"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="number"><xsl:with-param name="value" select="$id"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Reference"/></xsl:call-template><xsl:text>,</xsl:text>
      <xsl:call-template name="string"><xsl:with-param name="value" select="Weblink"/></xsl:call-template><xsl:text>);</xsl:text>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:for-each>
  <xsl:apply-templates/>
</xsl:template>
  <!-- TODO FIX BUG For Union Policies -->
  <xsl:template name="alterDuplicates">
    <xsl:param name="key"/>
    <xsl:choose>
      <xsl:when test="$key = 'CAP_Reform'">
        <xsl:text>'</xsl:text>
        <xsl:value-of select="concat($key,2)" disable-output-escaping="yes"/>
        <xsl:text>'</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>'</xsl:text>
        <xsl:value-of disable-output-escaping="yes" select="$key"/>
        <xsl:text>'</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
<xsl:template match="text()"/>
</xsl:stylesheet>
