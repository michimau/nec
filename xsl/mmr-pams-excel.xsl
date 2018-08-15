<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" 
                xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
                xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
                xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
                xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
                xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
                xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0"
                xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
                version="2.0">
    <xsl:output method="xml" indent="yes"/> 
    
    <!-- Global Variables -->
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
    
    <!-- Office Document -->
    <xsl:template match="/">
        <office:document-content office:version="1.2" >
            <office:scripts/>
            <office:font-face-decls>
                <style:font-face style:name="F" svg:font-family="" style:font-family-generic="swiss"/>
                <style:font-face style:name="Calibri" svg:font-family="Calibri" style:font-family-generic="swiss"/>
                <style:font-face style:name="Calibri Light" svg:font-family="'Calibri Light'" style:font-family-generic="swiss"/>
                <style:font-face style:name="Liberation Sans" svg:font-family="'Liberation Sans'" style:font-family-generic="swiss" style:font-pitch="variable"/>
                <style:font-face style:name="DejaVu Sans" svg:font-family="'DejaVu Sans'" style:font-family-generic="system" style:font-pitch="variable"/>
                <style:font-face style:name="Droid Sans Fallback" svg:font-family="'Droid Sans Fallback'" style:font-family-generic="system" style:font-pitch="variable"/>
                <style:font-face style:name="FreeSans" svg:font-family="FreeSans" style:font-family-generic="system" style:font-pitch="variable"/>
            </office:font-face-decls>
            <office:automatic-styles>
                <style:style style:name="co1" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="1.5563in"/>
                </style:style>
                <style:style style:name="co2" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="1.639in"/>
                </style:style>
                <style:style style:name="co3" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="0.861in"/>
                </style:style>
                <style:style style:name="co4" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="3.0701in"/>
                </style:style>
                <style:style style:name="co5" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="1.1252in"/>
                </style:style>
                <style:style style:name="co6" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="1.5138in"/>
                </style:style>
                <style:style style:name="co7" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="2.111in"/>
                </style:style>
                <style:style style:name="co8" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="1.9862in"/>
                </style:style>
                <style:style style:name="co9" style:family="table-column">
                    <style:table-column-properties fo:break-before="auto" style:column-width="3.0425in"/>
                </style:style>
                <style:style style:name="gereralTitleRow" style:family="table-row">
                    <style:table-row-properties style:row-height="0.3228in" fo:break-before="auto" style:use-optimal-row-height="true"/>
                </style:style>
                <style:style style:name="emptyRow" style:family="table-row">
                    <style:table-row-properties style:row-height="0.2083in" fo:break-before="auto" style:use-optimal-row-height="true"/>
                </style:style>
                <style:style style:name="tableTitleRow" style:family="table-row">
                    <style:table-row-properties style:row-height="0.798in" fo:break-before="auto" style:use-optimal-row-height="false"/>
                </style:style>
                <style:style style:name="dataRow" style:family="table-row">
                    <style:table-row-properties style:row-height="1.041in" fo:break-before="auto" style:use-optimal-row-height="true"/>
                </style:style>
                <style:style style:name="firstHeading" style:family="table-cell">
                    <style:text-properties fo:color="#44546a" 
                                           style:text-outline="false" 
                                           style:font-name="Calibri Light" 
                                           fo:font-size="18pt" 
                                           fo:font-style="normal" 
                                           fo:text-shadow="none" 
                                           style:text-underline-style="none" 
                                           fo:font-weight="normal"/>
                </style:style>
                <style:style style:name="tableHeading" style:family="table-cell">
                    <style:text-properties fo:color="#44546a" 
                                           style:text-outline="false" 
                                           style:font-name="Calibri" 
                                           fo:font-size="11pt"
                                           fo:font-weight="bold" />
                    <style:table-cell-properties style:text-align-source="fix" 
                                                 fo:wrap-option="wrap" 
                                                 style:direction="ltr" 
                                                 style:shrink-to-fit="false" 
                                                 style:vertical-align="top" 
                                                 style:vertical-justify="auto"/>
                    <style:paragraph-properties fo:text-align="start" 
                                                style:writing-mode="page"/>
                </style:style>
                <style:style style:name="dataCell" style:family="table-cell">
                    <style:text-properties style:font-name="Calibri" 
                                           style:text-outline="false" 
                                           fo:font-size="11pt" 
                                           fo:font-style="normal"/>
                    <style:table-cell-properties style:text-align-source="fix" 
                                                 fo:wrap-option="wrap" 
                                                 style:direction="ltr" 
                                                 style:vertical-align="top" 
                                                 style:vertical-justify="auto"
                                                 style:shrink-to-fit="false"/>
                    <style:paragraph-properties fo:text-align="start" 
                                                style:writing-mode="page"/>
                </style:style>
               
            </office:automatic-styles>
            <office:body>
                <office:spreadsheet>
                    <table:table table:name="MMR_PAMs">
                        <table:table-column table:style-name="co1"/>
                        <table:table-column table:style-name="co2"/>
                        <table:table-column table:style-name="co3"/>
                        <table:table-column table:style-name="co4"/>
                        <table:table-column table:style-name="co5"/>
                        <table:table-column table:style-name="co6"/>
                        <table:table-column table:style-name="co7"/>
                        <table:table-column table:style-name="co6"/>
                        <table:table-column table:style-name="co8"/>
                        <table:table-column table:style-name="co9" table:number-columns-repeated="4"/>
                        
                        <!--Drow the header rows -->
                        <xsl:call-template name="drawHeadersRows"/>
                        
                        <!-- Darw the data rows -->
                        <xsl:call-template name="drawDataRows"/>
                    
                    </table:table>
                    <table:named-expressions/>
                </office:spreadsheet>
            </office:body>
        </office:document-content>
    </xsl:template>
    
    <!-- Creates all the headers of the table -->
    <xsl:template name="drawHeadersRows">
        <table:table-row table:style-name="gereralTitleRow">
            <table:table-cell table:style-name="firstHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Table 3: <text:span text:style-name="firstHeading">Progress in achievement of the quantified economy-wide emission reduction target: information on mitigation actions and their effects</text:span></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="Default" table:number-columns-repeated="1023"/>
        </table:table-row>
        <table:table-row table:style-name="emptyRow">
            <table:table-cell table:style-name="Default" table:number-columns-repeated="1024"/>
        </table:table-row>
        <table:table-row table:style-name="tableTitleRow">
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Name of mitigation action</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Sector(s)</text:p>
                <text:p>affected</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>GHG(s) affected</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Objective and/or <text:s/>activity affected</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Type of</text:p>
                <text:p>instrument</text:p>
                <text:p/>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Status of</text:p>
                <text:p>implementation</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Brief</text:p>
                <text:p>description</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Start year of implementation</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Implementing entity or entities</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Estimate of mitigation impact (not cumulative, in kt CO2 eq) 2020</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Estimate of mitigation impact (not cumulative, in kt CO2 eq) 2025</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Estimate of mitigation impact (not cumulative, in kt CO2 eq) 2030</text:p>
            </table:table-cell>
            <table:table-cell table:style-name="tableHeading" office:value-type="string" calcext:value-type="string">
                <text:p>Estimate of mitigation impact (not cumulative, in kt CO2 eq) 2035</text:p>
            </table:table-cell>
        </table:table-row>
    </xsl:template>
    
    
    <!-- Creates all the Data rows of the table -->
    <xsl:template name="drawDataRows">
        <xsl:for-each select="MMR_PAMs/MMR_PAM">
            <table:table-row table:style-name="dataRow">
                <!-- Title -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Title" />
                    </text:p>
                </table:table-cell>
                <!-- Sectors (UNFCCC Labels) -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:call-template name="getLabelsDuplicatesRemoved">
                            <xsl:with-param name="pathToLabelOccurence" select="Table1/Sectors"/>
                            <xsl:with-param name="pathToLabelMapping" select="$labels/Table1/Sectors/list"/>
                        </xsl:call-template>
                    </text:p>
                </table:table-cell>
                <!-- GreenHouseGases -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table1/GreenhouseGases">
                            <xsl:call-template name="getLabel">
                                <xsl:with-param name="labelPath" select="$labels/Table1/GreenhouseGases/list"/>
                                <xsl:with-param name="labelName" select="."/>
                            </xsl:call-template>
                            <xsl:choose>
                                <xsl:when test="position() != last()">, </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!-- Objective (Includes Other Objectives) -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:variable name="objectives">
                            <xsl:for-each select="Table1/Objective">
                                <xsl:variable name="objective">
                                    <xsl:call-template name="getLabel">
                                        <xsl:with-param name="labelPath" select="$labels/Table1/Objective/list_with_sectors"/>
                                        <xsl:with-param name="labelName" select="."/>
                                    </xsl:call-template>
                                </xsl:variable>
                                <xsl:if test="not(starts-with($objective, 'Other'))">
                                    <xsl:value-of select="$objective"/>
                                    <xsl:text>,</xsl:text>   
                                </xsl:if>           
                            </xsl:for-each>
                            <xsl:for-each select="Table1/ObjectiveOther/node()">
                                <xsl:if test="Name/text()">
                                    <xsl:value-of select="Name/text()"/>
                                    <xsl:variable name="sectorSmallCode" select="name()"/>
                                    <xsl:variable name="sectorCode">
                                        <xsl:value-of select="$labels/Table1/Sectors/shortcodes/*[text()=$sectorSmallCode]/name()" />
                                    </xsl:variable>
                                    <xsl:text> (</xsl:text>
                                    <xsl:call-template name="getLabel">
                                        <xsl:with-param name="labelPath" select="$labels/Table1/Sectors/shortlist"/>
                                        <xsl:with-param name="labelName" select="$sectorCode"/>
                                    </xsl:call-template>
                                    <xsl:text>),</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="tokenizedObjectives" select="tokenize($objectives, ',')"/>
                        <xsl:variable name = "objectivesNoNulls">
                            <xsl:for-each select="$tokenizedObjectives">
                                <xsl:if test="string-length(.) != 0">
                                    <xsl:value-of select="."/>
                                    <xsl:text>,</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="objectivesRemovedLastComma">
                            <xsl:choose>
                                <xsl:when test="ends-with($objectivesNoNulls, ',')">
                                    <xsl:value-of select="substring($objectivesNoNulls, 1, string-length($objectivesNoNulls) - 1)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$objectivesNoNulls"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="tokenizedObjectives2" select="tokenize($objectivesRemovedLastComma, ',')"/>
                        <xsl:for-each select="$tokenizedObjectives2">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">, </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!-- Policy Instrument -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:call-template name="getLabelsDuplicatesRemoved">
                            <xsl:with-param name="pathToLabelOccurence" select="Table1/PolicyInstrument"/>
                            <xsl:with-param name="pathToLabelMapping" select="$labels/Table1/PolicyInstrument/list"/>
                        </xsl:call-template>
                    </text:p>
                </table:table-cell>
                <!-- Implementation Status -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:call-template name="getLabel">
                            <xsl:with-param name="labelPath" select="$labels/Table1/ImplementationStatus/list"/>
                            <xsl:with-param name="labelName" select="Table1/Implementation/Status"/>
                        </xsl:call-template>
                    </text:p>
                </table:table-cell>
                <!-- Description -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table1/Description"/>
                    </text:p>
                </table:table-cell>
                <!-- Start Year of implementation-->
                <xsl:variable name="implstart">
                    <xsl:value-of select="Table1/Implementation/Start"/>
                </xsl:variable>
                <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$implstart}">
                    <text:p>
                        <xsl:value-of select="$implstart"/>
                    </text:p>
                </table:table-cell>
                <!-- Entities Types -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table1/Entities">
                            <xsl:value-of select="Type/text()"/>:<xsl:value-of select="Name/text()"/>
                            <xsl:choose>
                                <xsl:when test="position() != last()">, </xsl:when>
                            </xsl:choose>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!-- Exante Emissions 2020 -->
                <xsl:variable name="emissions1">
                    <xsl:value-of select="Table2/ExanteEmissions1/Total"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions1=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p>Mitigation impact not estimated</text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions1}">
                            <text:p>
                                <xsl:value-of select="$emissions1"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!-- Exante Emissions 2025 -->
                <xsl:variable name="emissions2">
                    <xsl:value-of select="Table2/ExanteEmissions2/Total"/>
                </xsl:variable>
               <xsl:choose>
                    <xsl:when test="$emissions2=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p>Mitigation impact not estimated</text:p>
                        </table:table-cell>
                    </xsl:when>    
                    <xsl:otherwise>
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions2}"/>                         
                    </xsl:otherwise>
                </xsl:choose>
                <!--Exante Emissions 2030 -->
                <xsl:variable name="emissions3">
                    <xsl:value-of select="Table2/ExanteEmissions3/Total"/>
                </xsl:variable>
               <xsl:choose>
                    <xsl:when test="$emissions3=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p>Mitigation impact not estimated</text:p>
                        </table:table-cell>
                    </xsl:when>    
                    <xsl:otherwise>
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions3}"/>                         
                    </xsl:otherwise>
                </xsl:choose>
                <!--Exante Emissions 2035 -->
                <xsl:variable name="emissions4">
                    <xsl:value-of select="Table2/ExanteEmissions4/Total"/>
                </xsl:variable>
               <xsl:choose>
                    <xsl:when test="$emissions4=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p>Mitigation impact not estimated</text:p>
                        </table:table-cell>
                    </xsl:when>    
                    <xsl:otherwise>
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions4}"/>                         
                    </xsl:otherwise>
                </xsl:choose>
            </table:table-row>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- Helper templates -->
    
    <xsl:template name="getLabel" >
        <xsl:param name="labelPath"/>
        <xsl:param name="labelName"/>
        <xsl:variable name="labelValue">
            <xsl:value-of select="$labelPath/*[name() = $labelName]/text()" />
        </xsl:variable>
        <xsl:if test="string-length($labelValue) &gt; 0">
            <xsl:value-of disable-output-escaping="yes" select="$labelValue"/>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="getLabelsDuplicatesRemoved">
        <xsl:param name="pathToLabelOccurence"/>
        <xsl:param name="pathToLabelMapping"/>
        <xsl:variable name="stringWithDuplicates">
            <xsl:for-each select="$pathToLabelOccurence">
                <xsl:call-template name="getLabel">
                    <xsl:with-param name="labelPath" select="$pathToLabelMapping"/>
                    <xsl:with-param name="labelName" select="."/>
                </xsl:call-template>
                <xsl:choose>
                    <xsl:when test="position() != last()">,</xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="distinct-values(tokenize($stringWithDuplicates, ','))">
            <xsl:variable name="currentToken" select="."/>
            <xsl:if test="$currentToken!=''">
                <xsl:value-of select="$currentToken"/>
                <xsl:choose>
                    <xsl:when test="position() != last()">, </xsl:when>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>

