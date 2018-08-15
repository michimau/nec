<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="common.xsl"/>
  <xsl:output method="text" />


  <xsl:variable name="labelsLanguage">en</xsl:variable>

  <xsl:variable name="labelsUrl">
    <xsl:value-of select="concat('mmr-pams-labels-', $labelsLanguage ,'.xml')"/>
  </xsl:variable>
  <xsl:variable name="labels" select="document($labelsUrl)/Labels"/>

  <xsl:template match="/Labels/Table1/Sectors/shortlist/*">
    <xsl:text>INSERT INTO Labels (codepath, code, label) VALUES ('Table1.Sectors',</xsl:text>
    <xsl:text>'</xsl:text><xsl:value-of select="local-name()"/><xsl:text>'</xsl:text><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="/Labels/Table1/GreenhouseGases/list/*">
    <xsl:text>INSERT INTO Labels (codepath, code, label) VALUES ('Table1.GreenhouseGases',</xsl:text>
    <xsl:text>'</xsl:text><xsl:value-of select="local-name()"/><xsl:text>'</xsl:text><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="/Labels/Table1/Objective/list_with_sectors/*">
    <xsl:text>INSERT INTO Labels (codepath, code, label) VALUES ('Table1.Objective',</xsl:text>
    <xsl:text>'</xsl:text><xsl:value-of select="local-name()"/><xsl:text>'</xsl:text><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="/Labels/Table1/PolicyInstrument/list/*">
    <xsl:text>INSERT INTO Labels (codepath, code, label) VALUES ('Table1.PolicyInstrument',</xsl:text>
    <xsl:text>'</xsl:text><xsl:value-of select="local-name()"/><xsl:text>'</xsl:text><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <!-- TODO FIX bug for CAP REFORM Union Policies -->

  <xsl:template name="alterDuplicates">
    <xsl:param name="key"/>
    <xsl:choose>
      <xsl:when test="$key = 'CAP_Reform'">
        <xsl:value-of select="concat($key,2)" disable-output-escaping="yes"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$key"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/Labels/Table1/UnionPolicy/list/*">
    <xsl:text>INSERT INTO Labels (codepath, code, label) VALUES ('Table1.UnionPolicy','</xsl:text>
    <xsl:call-template name="alterDuplicates"><xsl:with-param name="key" select="local-name()"/></xsl:call-template><xsl:text>',</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="/Labels/Table1/ProjectionsScenario/list/*">
    <xsl:text>INSERT INTO Labels (codepath, code, label) VALUES ('Table1.ProjectionsScenario',</xsl:text>
    <xsl:text>'</xsl:text><xsl:value-of select="local-name()"/><xsl:text>'</xsl:text><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="/Labels/Table1/Entities/list/*">
    <xsl:text>INSERT INTO Labels (codepath, code, label) VALUES ('Table1.Entities',</xsl:text>
    <xsl:text>'</xsl:text><xsl:value-of select="local-name()"/><xsl:text>'</xsl:text><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="/Labels/Table2/PolicyImpact/list/*">
    <xsl:text>INSERT INTO Labels (codepath, code, label) VALUES ('Table2.PolicyImpact',</xsl:text>
    <xsl:text>'</xsl:text><xsl:value-of select="local-name()"/><xsl:text>'</xsl:text><xsl:text>,</xsl:text>
    <xsl:call-template name="string"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:text>);</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="text()"/>

</xsl:stylesheet>