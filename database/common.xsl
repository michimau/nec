<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" />

<xsl:template name="boolean">
  <xsl:param name="value"/>

  <xsl:choose>
    <xsl:when test="$value = 'true' or $value = '1'">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="number">
  <xsl:param name="value"/>
  <xsl:choose>
    <xsl:when test="$value != '' and string(number($value)) != 'NaN'"><xsl:value-of select="$value"/></xsl:when>
    <xsl:otherwise>NULL</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="string">
  <xsl:param name="value"/>
  <xsl:choose>
    <xsl:when test="$value != ''">
      <xsl:text>'</xsl:text>
        <xsl:call-template name="globalReplace">
          <xsl:with-param name="text" select='$value'/>
        </xsl:call-template>
      <xsl:text>'</xsl:text></xsl:when>
    <xsl:otherwise><xsl:text>NULL</xsl:text></xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Fixes quotes in database input strings -->
<xsl:template name="globalReplace">
  <xsl:param name="text"/>
  <xsl:call-template name="string-replace-all">
    <xsl:with-param name="text">
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select="$text"/>
        <xsl:with-param name="replace" select='"&apos;"'/>
        <xsl:with-param name="by" select='"&apos;&apos;"'/>
      </xsl:call-template>
	</xsl:with-param>
    <xsl:with-param name="replace" select='"&#xA;"'/>
    <xsl:with-param name="by" select='"&apos; + Chr(10) + Chr(13) + &apos;"'/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="string-replace-all">
  <xsl:param name="text"/>
  <xsl:param name="replace"/>
  <xsl:param name="by"/>

  <xsl:choose>
    <xsl:when test='contains($text, $replace)'>
      <xsl:value-of select='concat(substring-before($text, $replace), $by)'/>
      <xsl:call-template name="string-replace-all">
        <xsl:with-param name="text" select='substring-after($text, $replace)'/>
        <xsl:with-param name="replace" select='$replace'/>
        <xsl:with-param name="by" select='$by'/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$text"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- format datetime for MS Access -->
<xsl:template name="datetime">
  <xsl:param name="value"/>
  <xsl:choose>
    <xsl:when test="$value != ''">
      <xsl:text>'</xsl:text>
		<xsl:value-of select="translate($value, 'TZ', ' ')"/>
      <xsl:text>'</xsl:text></xsl:when>
    <xsl:otherwise>NULL</xsl:otherwise>
  </xsl:choose>
</xsl:template>



</xsl:stylesheet>
