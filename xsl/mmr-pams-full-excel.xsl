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
                <style:style style:name="small-column" style:family="table-column">
                    <style:table-column-properties style:column-width="115pt" style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="large-column" style:family="table-column">
                    <style:table-column-properties style:column-width="200pt" style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="super-small-column" style:family="table-column">
                    <style:table-column-properties style:column-width="65pt" style:use-optimal-column-width="true"/>
                </style:style>
                <style:style style:name="gereralTitleRow" style:family="table-row">
                    <style:table-row-properties style:row-height="15pt" fo:break-before="auto" style:use-optimal-row-height="false"/>
                </style:style>
                <style:style style:name="emptyRow" style:family="table-row">
                    <style:table-row-properties style:row-height="15pt" fo:break-before="auto" style:use-optimal-row-height="false"/>
                </style:style>
                <style:style style:name="tableTitleRow" style:family="table-row">
                    <style:table-row-properties style:row-height="15pt" fo:break-before="auto" style:use-optimal-row-height="false"/>
                </style:style>
                <style:style style:name="dataRow" style:family="table-row">
                    <style:table-row-properties style:row-height="15pt" fo:break-before="auto" style:use-optimal-row-height="false"/>
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
                <style:style style:name="ce1" style:family="table-cell" style:parent-style-name="Default">
                    <style:table-cell-properties fo:background-color="#99ccff"/>
                    <style:text-properties fo:color="#44546a" style:font-name="Calibri" fo:font-size="11pt" fo:font-weight="bold" style:font-name-asian="Lucida Sans Unicode" style:font-name-complex="Tahoma"/>
                </style:style>
                <style:style style:name="ce2" style:family="table-cell" style:parent-style-name="Default">
                    <style:table-cell-properties style:text-align-source="fix" style:repeat-content="false" fo:wrap-option="wrap" style:direction="ltr" style:shrink-to-fit="false" style:vertical-align="top" style:vertical-justify="auto"/>
                    <style:paragraph-properties fo:text-align="start" style:writing-mode="page"/>
                    <style:text-properties fo:color="#44546a" style:text-outline="false" style:font-name="Calibri" fo:font-size="11pt" fo:font-weight="bold"/>
                </style:style>
                <style:style style:name="ce3" style:family="table-cell" style:parent-style-name="Default">
                    <style:table-cell-properties style:text-align-source="fix" style:repeat-content="false" fo:wrap-option="wrap" style:direction="ltr" style:shrink-to-fit="false" style:vertical-align="top" style:vertical-justify="auto"/>
                    <style:paragraph-properties fo:text-align="start" style:writing-mode="page"/>
                    <style:text-properties style:text-outline="false" style:font-name="Calibri" fo:font-size="11pt" fo:font-style="normal"/>
                </style:style>
                <style:style style:name="ce4" style:family="table-cell" style:parent-style-name="Default">
                    <style:table-cell-properties fo:background-color="#ffcc00"/>
                    <style:text-properties fo:color="#44546a" style:font-name="Calibri" fo:font-size="11pt" fo:font-weight="bold" style:font-name-asian="Lucida Sans Unicode" style:font-name-complex="Tahoma"/>
                </style:style>
                <style:style style:name="ce5" style:family="table-cell" style:parent-style-name="Default">
                    <style:table-cell-properties fo:background-color="#ff9999"/>
                    <style:text-properties fo:color="#44546a" style:font-name="Calibri" fo:font-size="11pt" fo:font-weight="bold" style:font-name-asian="Lucida Sans Unicode" style:font-name-complex="Tahoma"/>
                </style:style>
                <style:style style:name="table1emptycell" style:family="table-cell">
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
                            style:vertical-justify="auto"
                            fo:background-color="#cccccc"/>
                    <style:paragraph-properties fo:text-align="center" 
                            style:writing-mode="page"/>
                </style:style>
                <style:style style:name="table1cell" style:family="table-cell">
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
                            style:vertical-justify="auto"
                            fo:border="0.06pt solid #000000"/>
                    <style:paragraph-properties fo:text-align="center" 
                            style:writing-mode="page"/>
                </style:style>
                <style:style style:name="table2emptycellb" style:family="table-cell">
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
                            style:vertical-justify="auto"
                            fo:border-left="0.06pt solid #000000"/>
                    <style:paragraph-properties fo:text-align="center" 
                            style:writing-mode="page"/>
                </style:style>
                <style:style style:name="table2emptycell" style:family="table-cell">
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
                    <style:paragraph-properties fo:text-align="center" 
                            style:writing-mode="page"/>
                </style:style>
                <style:style style:name="table2cell" style:family="table-cell">
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
                            style:vertical-justify="auto"
                            fo:border="0.06pt solid #000000"/>
                    <style:paragraph-properties fo:text-align="center" 
                            style:writing-mode="page"/>
                </style:style>
                <style:style style:name="table3emptycell" style:family="table-cell">
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
                    <style:paragraph-properties fo:text-align="center" 
                            style:writing-mode="page"/>
                </style:style>
                <style:style style:name="table3cell" style:family="table-cell">
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
                            style:vertical-justify="auto"
                            fo:border="0.06pt solid #000000"/>
                    <style:paragraph-properties fo:text-align="center" 
                            style:writing-mode="page"/>
                </style:style>
            </office:automatic-styles>
            <office:body>
                <office:spreadsheet>
                    <xsl:variable name="tabTitle">
                        <xsl:value-of select="$labels/Webform/FormTitle"/>
                    </xsl:variable>
                    <table:table>
                        <xsl:attribute name="table:name"><xsl:value-of select="$tabTitle"/></xsl:attribute>
                        <table:table-column table:style-name="super-small-column"/>
                        <table:table-column table:style-name="large-column" table:number-columns-repeated="2"/>
                        <table:table-column table:style-name="super-small-column"/>
                        <table:table-column table:style-name="small-column"/>
                        <table:table-column table:style-name="large-column"/>
                        <table:table-column table:style-name="small-column"/>
                        <table:table-column table:style-name="large-column"/>
                        <table:table-column table:style-name="small-column"/>
                        <table:table-column table:style-name="large-column" table:number-columns-repeated="2"/>
                        <table:table-column table:style-name="small-column"/>
                        <table:table-column table:style-name="small-column"/>
                        <table:table-column table:style-name="large-column"/>
                        <table:table-column table:style-name="small-column"/>
                        <table:table-column table:style-name="super-small-column" table:number-columns-repeated="3"/>
                        <table:table-column table:style-name="small-column"/>
                        <table:table-column table:style-name="large-column" table:number-columns-repeated="5"/>

                        <table:table-column table:style-name="large-column"/>
                        <table:table-column table:style-name="super-small-column" table:number-columns-repeated="12"/>
                        <table:table-column table:style-name="large-column" table:number-columns-repeated="2"/>
                        <table:table-column table:style-name="small-column" table:number-columns-repeated="2"/>
                        <table:table-column table:style-name="large-column" table:number-columns-repeated="4"/>

                        <table:table-column table:style-name="small-column" table:number-columns-repeated="8"/>
                        <table:table-column table:style-name="large-column" table:number-columns-repeated="3"/>
                        <table:table-column table:style-name="small-column" table:number-columns-repeated="8"/>
                        <table:table-column table:style-name="large-column" table:number-columns-repeated="3"/>

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

        <!-- Header Row 1 -->
        <table:table-row table:style-name="tableTitleRow" >
            <table:table-cell office:value-type="string" calcext:value-type="string" table:style-name="table1cell" table:number-columns-spanned="24" table:number-rows-spanned="2">
                <text:p> 
                    <xsl:value-of select="$labels/Webform/Table1"/>
                </text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="23"/>
            <table:table-cell office:value-type="string" calcext:value-type="string" table:style-name="table2cell" table:number-columns-spanned="21" table:number-rows-spanned="1">
                <text:p> 
                    <xsl:value-of select="$labels/Webform/Table2"/>
                </text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="20"/>
            <table:table-cell office:value-type="string" calcext:value-type="string" table:style-name="table3cell" table:number-columns-spanned="22" table:number-rows-spanned="1">
                <text:p> 
                    <xsl:value-of select="$labels/Webform/Table3"/>
                </text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="21"/>
            <table:table-cell table:number-columns-repeated="3"/>
        </table:table-row>

        <!-- Header Row 2 -->
        <table:table-row table:style-name="tableTitleRow" >
            <!--Table 1-->
            <table:table-cell table:style-name="table1emptycell" table:number-columns-spanned="24" table:number-rows-spanned="1"/>
            <table:covered-table-cell table:number-columns-repeated="23"/>
            <!--Table2-->
            <table:table-cell table:style-name="table2emptycellb"/>
            <table:table-cell office:value-type="string" table:style-name="table2cell" table:number-columns-spanned="14" table:number-rows-spanned="1">
                <text:p>
                    <xsl:value-of select="$labels/Table2/Exante/Title"/>
                </text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="13"/>
            <table:table-cell office:value-type="string" table:style-name="table2cell" table:number-columns-spanned="6" table:number-rows-spanned="1">
                <text:p>
                    <xsl:value-of select="$labels/Table2/Expost/Title"/>
                </text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="5"/>
            <!--Table 3-->
            <table:table-cell office:value-type="string" table:number-rows-spanned="1" table:style-name="table3cell" table:number-columns-spanned="11">
                <text:p><xsl:value-of select="$labels/Table3/Costs/Projected"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="10" table:style-name="table3emptycell"/>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1" table:style-name="table3cell" table:number-columns-spanned="11">
                <text:p><xsl:value-of select="$labels/Table3/Costs/Realised"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="10" table:style-name="table3emptycell"/>
        </table:table-row>

        <!--Header Row 3-->
        <table:table-row table:style-name="tableTitleRow" >
            <!--Table 1-->
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Webform/PamNumber"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/Title"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/TitleLocal"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/isGroup/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/PolicyGroup/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/Description/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/isEnvisaged/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/Sectors/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/GreenhouseGases/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/Objective/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/ObjectiveQuantified/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/PolicyInstrument/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/UnionPolicyRelated/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/UnionPolicy/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/ImplementationStatus/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="3" table:number-rows-spanned="1">
                <text:p><xsl:value-of select="$labels/Table1/ImplementationPeriod/label"/></text:p>                
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="2" table:style-name="table1emptycell"/>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/ProjectionsScenario/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/Entities/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/Indicators/label"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="2" table:number-rows-spanned="1">
                <text:p><xsl:value-of select="$labels/Table1/Reference/label"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1" table:style-name="table1emptycell"/>
            <table:table-cell table:style-name="table1cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table1/Comments/label"/></text:p>
            </table:table-cell>

            <!--Table 2-->
            <table:table-cell table:style-name="table2cell" office:value-type="string" table:number-columns-spanned="1" table:number-rows-spanned="2">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/label"/></text:p>
            </table:table-cell>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1" table:style-name="table2cell" table:number-columns-spanned="3">
                <text:p>GHG emissions reductions for year 2020 (kt CO2-equivalent per year)</text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="2"/>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1" table:style-name="table2cell" table:number-columns-spanned="3">
                <text:p>GHG emissions reductions for year 2025 (kt CO2-equivalent per year)</text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="2"/>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1" table:style-name="table2cell" table:number-columns-spanned="3">
                <text:p>GHG emissions reductions for year 2030 (kt CO2-equivalent per year)</text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="2"/>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1" table:style-name="table2cell" table:number-columns-spanned="3">
                <text:p>GHG emissions reductions for year 2035 (kt CO2-equivalent per year)</text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="2" table:style-name="table2emptycell"/>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1"  table:style-name="table2cell" table:number-columns-spanned="2">
                <text:p>
                    <xsl:value-of select="$labels/Table2/Documentation/label"/>
                </text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1"/>
            <table:table-cell office:value-type="string" table:number-rows-spanned="2" table:number-columns-spanned="1" table:style-name="table2cell">
                <text:p>
                    <xsl:value-of select="$labels/Table2/Expost/Year"/>
                </text:p>
            </table:table-cell>
            <table:table-cell office:value-type="string" table:number-rows-spanned="2" table:number-columns-spanned="1" table:style-name="table2cell">
                <text:p>
                    <xsl:value-of select="$labels/Table2/Expost/Average"/>
                </text:p>
            </table:table-cell>
            <table:table-cell office:value-type="string" table:number-rows-spanned="2" table:number-columns-spanned="1" table:style-name="table2cell">
                <text:p>
                    <xsl:value-of select="$labels/Table2/BasisExplanation"/>
                </text:p>
            </table:table-cell>
            <table:table-cell office:value-type="string" table:number-rows-spanned="2" table:number-columns-spanned="1" table:style-name="table2cell">
                <text:p>
                    <xsl:value-of select="$labels/Table2/AffectedFactors"/>
                </text:p>
            </table:table-cell>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1"  table:style-name="table2cell" table:number-columns-spanned="2">
                <text:p>
                    <xsl:value-of select="$labels/Table2/Documentation/label"/>
                </text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1" />

            <!--Table 3-->
            <table:table-cell office:value-type="string" table:number-columns-spanned="4" table:style-name="table3cell" table:number-rows-spanned="1">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostType"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="3" />
            <table:table-cell office:value-type="string" table:number-columns-spanned="2" table:style-name="table3cell" table:number-rows-spanned="1">
                <text:p><xsl:value-of select="$labels/Table3/Costs/BenefitType"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1" />
            <table:table-cell office:value-type="string" table:number-columns-spanned="2" table:style-name="table3cell" table:number-rows-spanned="1">
                <text:p><xsl:value-of select="$labels/Table3/Costs/NetCostType"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1" />
            <table:table-cell office:value-type="string" table:number-rows-spanned="2" table:style-name="table3cell" table:number-columns-spanned="1">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostDescription"/></text:p>
            </table:table-cell>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1"  table:style-name="table3cell" table:number-columns-spanned="2">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostDocumentation/label"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1"/>
            <table:table-cell office:value-type="string" table:number-columns-spanned="4" table:style-name="table3cell" table:number-rows-spanned="1">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostType"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="3" />
            <table:table-cell office:value-type="string" table:number-columns-spanned="2" table:number-rows-spanned="1" table:style-name="table3cell">
                <text:p><xsl:value-of select="$labels/Table3/Costs/BenefitType"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1" />
            <table:table-cell office:value-type="string" table:number-columns-spanned="2" table:style-name="table3cell" table:number-rows-spanned="1">
                <text:p><xsl:value-of select="$labels/Table3/Costs/NetCostType"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1" />
            <table:table-cell office:value-type="string" table:number-rows-spanned="2" table:style-name="table3cell" table:number-columns-spanned="1">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostDescription"/></text:p>
            </table:table-cell>
            <table:table-cell office:value-type="string" table:number-rows-spanned="1"  table:style-name="table3cell" table:number-columns-spanned="2">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostDocumentation/label"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="1"/>
        </table:table-row>

        <!--Header Row 4-->
        <table:table-row table:style-name="tableTitleRow">
            <!--Table 1-->
            <table:covered-table-cell table:number-columns-repeated="15"/>
            <table:table-cell table:style-name="table1cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table1/ImplementationPeriod/start"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table1/ImplementationPeriod/finish"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table1/ImplementationPeriod/comments"/></text:p>
            </table:table-cell>
            <table:covered-table-cell table:number-columns-repeated="3"/>
            <table:table-cell table:style-name="table1cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table1/Reference/Text"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table1cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table1/Reference/Url"/></text:p>
            </table:table-cell>
            <table:covered-table-cell/>

            <!--Table 2-->
            <table:covered-table-cell/>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/EU_ETS"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/ESD"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/Total"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/EU_ETS"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/ESD"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/Total"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/EU_ETS"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/ESD"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/Total"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/EU_ETS"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/ESD"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/PolicyImpact/Total"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/Documentation/Reference"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/Documentation/Weblink"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2emptycell" office:value-type="string" calcext:value-type="string"/>
            <table:table-cell table:style-name="table2emptycell" office:value-type="string" calcext:value-type="string"/>
            <table:table-cell table:style-name="table2emptycell" office:value-type="string" calcext:value-type="string"/>
            <table:table-cell table:style-name="table2emptycell" office:value-type="string" calcext:value-type="string"/>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/Documentation/Reference"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table2cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table2/Documentation/Weblink"/></text:p>
            </table:table-cell>

            <!--Table 3-->
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostReduced"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostPerYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostCalculatedYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostReferenceYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/Benefit"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/BenefitPerYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/NetCost"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/NetCostPerYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3emptycell"/>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostDocumentation/Reference"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostDocumentation/Weblink"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostReduced"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostPerYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostCalculatedYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/CostReferenceYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/Benefit"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/BenefitPerYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/NetCost"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/NetCostPerYear"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3emptycell"/>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/BenefitDocumentation/Reference"/></text:p>
            </table:table-cell>
            <table:table-cell table:style-name="table3cell" office:value-type="string" calcext:value-type="string">
                <text:p><xsl:value-of select="$labels/Table3/Costs/BenefitDocumentation/Weblink"/></text:p>
            </table:table-cell> 

        </table:table-row>
    </xsl:template>


    <!-- Creates all the Data rows of the table -->
    <xsl:template name="drawDataRows">
        <xsl:for-each select="MMR_PAMs/MMR_PAM">
            <table:table-row table:style-name="dataRow">
                <!-- ID -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="id" />
                    </text:p>
                </table:table-cell>
                <!-- Title -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Title" />
                    </text:p>
                </table:table-cell>
                <!-- Title local -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="TitleLocal" />
                    </text:p>
                </table:table-cell>
                <!--Single or group -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/isGroup = 'group'">Group</xsl:when>
                            <xsl:otherwise>Single</xsl:otherwise>
                        </xsl:choose>
                    </text:p>
                </table:table-cell>
                <!--Policies or measures included in the group -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <xsl:choose>
                        <xsl:when test="Table1/isGroup = 'group'">
                            <text:p>
                                <xsl:for-each select="Table1/PolicyGroup">
                                    <xsl:value-of select="text()"/>
                                    <xsl:if test="position() != last()">; </xsl:if>
                                </xsl:for-each>
                            </text:p>
                        </xsl:when>
                        <xsl:otherwise>
                            <text:p><xsl:value-of select="$labels/Table1/PolicyGroup/Single_PAM"/></text:p>
                        </xsl:otherwise>
                    </xsl:choose>
                </table:table-cell>
                <!--Description-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table1/Description"/>
                    </text:p>
                </table:table-cell>
                <!--isEnvisaged-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/isEnvisaged = 'yes'">
                                <xsl:value-of select="$labels/Webform/Yes"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$labels/Webform/No"/>
                            </xsl:otherwise>
                        </xsl:choose>
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
                <!--GreenHouseGases affected same-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table1/GreenhouseGases">
                            <xsl:value-of select="text()"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!-- Objective (Includes Other Objectives) Is not exactly as asked (parentheses vs :)-->
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
                                <xsl:if test="not(ends-with(., '_other'))">
                                    <xsl:value-of select="$objective"/>
                                    <xsl:text>;</xsl:text>   
                                </xsl:if>           
                            </xsl:for-each>
                            <xsl:for-each select="Table1/ObjectiveOther/node()">
                                <xsl:if test="Name/text()">
                                    <xsl:value-of select="Name/text()"/>
                                    <xsl:text> (</xsl:text>
                                    <xsl:if test="local-name() = 'ES'">
                                        <xsl:value-of select="$labels/Table1/Objective/list/ES_other"/>
                                    </xsl:if>
                                    <xsl:if test="local-name() = 'EC'">
                                        <xsl:value-of select="$labels/Table1/Objective/list/EC_other"/>
                                    </xsl:if>
                                    <xsl:if test="local-name() = 'TR'">
                                        <xsl:value-of select="$labels/Table1/Objective/list/TR_other"/>
                                    </xsl:if>
                                    <xsl:if test="local-name() = 'IP'">
                                        <xsl:value-of select="$labels/Table1/Objective/list/IP_other"/>
                                    </xsl:if>
                                    <xsl:if test="local-name() = 'AG'">
                                        <xsl:value-of select="$labels/Table1/Objective/list/AG_other"/>
                                    </xsl:if>                                  
                                    <xsl:if test="local-name() = 'LULUCF'">
                                        <xsl:value-of select="$labels/Table1/Objective/list/LULUCF_other"/>
                                    </xsl:if>
                                    <xsl:if test="local-name() = 'WA'">
                                        <xsl:value-of select="$labels/Table1/Objective/list/WA_other"/>
                                    </xsl:if>
                                    <xsl:if test="local-name() = 'CC'">
                                        <xsl:value-of select="$labels/Table1/Objective/list/CC_other"/>
                                    </xsl:if>                                  
                                    <xsl:text>);</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="tokenizedObjectives" select="tokenize($objectives, ';')"/>
                        <xsl:variable name = "objectivesNoNulls">
                            <xsl:for-each select="$tokenizedObjectives">
                                <xsl:if test="string-length(.) != 0">
                                    <xsl:value-of select="."/>
                                    <xsl:text>;</xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="objectivesRemovedLastComma">
                            <xsl:choose>
                                <xsl:when test="ends-with($objectivesNoNulls, ';')">
                                    <xsl:value-of select="substring($objectivesNoNulls, 1, string-length($objectivesNoNulls) - 1)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$objectivesNoNulls"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="tokenizedObjectives2" select="tokenize($objectivesRemovedLastComma, ';')"/>
                        <xsl:for-each select="$tokenizedObjectives2">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Quantified Objective-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table1/ObjectiveQuantified"/>
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
                <!-- Union Policy Related-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/UnionPolicyRelated/text() = 'yes'">Yes</xsl:when>
                            <xsl:otherwise>No</xsl:otherwise>
                        </xsl:choose>
                    </text:p>
                </table:table-cell>
                <!--Union policy which resulted in the implementation of the policy or measure-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <xsl:choose>
                        <xsl:when test="Table1/UnionPolicyRelated/text() = 'yes'">
                            <xsl:variable name="fixPolicies">
                                <xsl:for-each select="Table1/UnionPolicy">
                                    <xsl:if test="text() != 'Other_EU'">
                                        <xsl:call-template name="getLabel">
                                            <xsl:with-param name="labelPath" select="$labels/Table1/UnionPolicy/list"/>
                                            <xsl:with-param name="labelName" select="text()"/>
                                        </xsl:call-template>
                                        <xsl:if test="position() != last()">; </xsl:if>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:variable>
                            <xsl:variable name="otherPolicies">
                                <xsl:for-each select="Table1/UnionPolicyOther">
                                    <xsl:variable name="name">
                                        <xsl:value-of select="Name/text()"/>
                                    </xsl:variable>
                                    <xsl:if test="string-length($name) &gt; 0">Other EU:<xsl:value-of select="Name"/>
                                        <xsl:if test="position() != last()">; </xsl:if>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:variable>
                            <text:p>
                                <xsl:variable name="fixPoliciesLength" select="string-length($fixPolicies)"/>
                                <xsl:variable name="lengthMinusOne">
                                    <xsl:value-of select="$fixPoliciesLength - 1"/>
                                </xsl:variable>
                                <xsl:variable name="lengthMinusTwo">
                                    <xsl:value-of select="$fixPoliciesLength - 2"/>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="string-length($fixPolicies) &lt; 1">
                                        <xsl:value-of select="$otherPolicies"/>
                                    </xsl:when>
                                    <xsl:when test="substring($fixPolicies,$lengthMinusOne) = '; '">
                                        <xsl:choose>
                                            <xsl:when test="string-length($otherPolicies) &lt; 1">
                                                <xsl:value-of select="substring($fixPolicies, 0, $lengthMinusTwo)"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="$fixPolicies"/>
                                                <xsl:value-of select="$otherPolicies"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="string-length($otherPolicies) &lt; 1">
                                                <xsl:value-of select="$fixPolicies"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="$fixPolicies"/>; <xsl:value-of select="$otherPolicies"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise> 
                                </xsl:choose>
                            </text:p>
                        </xsl:when>
                        <xsl:otherwise>
                            <text:p>PaM not related to Union policies</text:p>
                        </xsl:otherwise>
                    </xsl:choose>
                </table:table-cell>
                <!-- Implementation Status -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/isGroup eq 'group'">
                                <xsl:value-of select="$labels/Webform/SeeIndividualPaMs"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="getLabel">
                                    <xsl:with-param name="labelPath" select="$labels/Table1/ImplementationStatus/list"/>
                                    <xsl:with-param name="labelName" select="Table1/Implementation/Status"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </text:p>
                </table:table-cell>
                <!--Implementation period start-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/isGroup eq 'group'">
                                <xsl:value-of select="$labels/Webform/SeeIndividualPaMs"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="Table1/Implementation/Start"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </text:p>
                </table:table-cell>
                <!--Implementation period finish-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/isGroup eq 'group'">
                                <xsl:value-of select="$labels/Webform/SeeIndividualPaMs"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="Table1/Implementation/Finish"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </text:p>
                </table:table-cell>
                <!--Implementation period comments-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/isGroup eq 'group'">
                                <xsl:value-of select="$labels/Webform/SeeIndividualPaMs"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="Table1/Implementation/Comments"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </text:p>
                </table:table-cell>
                <!--Projections scenario-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/isGroup eq 'group'">
                                <xsl:value-of select="$labels/Webform/SeeIndividualPaMs"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="Table1/ProjectionsScenario/Type"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </text:p>
                </table:table-cell>
                <!--Entities responsible for implementing the policy-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:choose>
                            <xsl:when test="Table1/isGroup eq 'group'">
                                <xsl:value-of select="$labels/Webform/SeeIndividualPaMs"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each select="Table1/Entities">
                                    <xsl:value-of select="Name"/> (<xsl:value-of select="Type"/>)
                                    <xsl:if test="position() != last()">; </xsl:if>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </text:p>
                </table:table-cell>
                <!--Indicator to monitor and evaluate progress-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table1/Indicators">
                            <xsl:variable name="yearValue1">
                                <xsl:value-of select="Year1"/> : <xsl:value-of select="Value1"/>
                            </xsl:variable>
                            <xsl:variable name="yearValue2">
                                <xsl:value-of select="Year2"/> : <xsl:value-of select="Value2"/>
                            </xsl:variable>
                            <xsl:variable name="yearValue3">
                                <xsl:value-of select="Year3"/> : <xsl:value-of select="Value3"/>
                            </xsl:variable>
                            <xsl:variable name="yearValue4">
                                <xsl:value-of select="Year4"/> : <xsl:value-of select="Value4"/>
                            </xsl:variable>
                            <xsl:variable name="description" select="Description"/>
                            <xsl:choose>
                                <xsl:when test="string-length($description) &lt; 1"></xsl:when>
                                <xsl:otherwise>
                                    <xsl:variable name="fullIndicators">
                                        <xsl:value-of select="Description"/> (<xsl:value-of select="Unit"/>) {<xsl:if test="$yearValue1 != ' : '">
                                            <xsl:value-of select="$yearValue1"/>, </xsl:if>
                                        <xsl:if test="$yearValue2 != ' : '">
                                            <xsl:value-of select="$yearValue2"/>, </xsl:if>
                                        <xsl:if test="$yearValue3 != ' : '">
                                            <xsl:value-of select="$yearValue3"/>, </xsl:if>
                                        <xsl:if test="$yearValue4 != ' : '">
                                            <xsl:value-of select="$yearValue4"/>
                                        </xsl:if>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="ends-with($fullIndicators, ', ')">
                                            <xsl:value-of select="substring($fullIndicators, 1, string-length($fullIndicators) - 2)"/>}</xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$fullIndicators"/>}</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!-- Main Reference(s)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table1/Reference">
                            <xsl:value-of select="./Text"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Main Reference Url(s)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table1/Reference">
                            <xsl:value-of select="./Url"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--General Comments-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table1/Comments"/>
                    </text:p>
                </table:table-cell>
                <!-- Impcact of policy or measure -->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table2/PolicyImpact">
                            <xsl:call-template name="getLabel">
                                <xsl:with-param name="labelPath" select="$labels/Table2/PolicyImpact"/>
                                <xsl:with-param name="labelName" select="text()"/>
                            </xsl:call-template>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--GHG emissions reductions in the EU ETS in 2020 (kt CO2-equivalent per year)-->
                <xsl:variable name="emissions5">
                    <xsl:value-of select="Table2/ExanteEmissions1/EU_ETS"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions5=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions5}">
                            <text:p>
                                <xsl:value-of select="$emissions5"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--GHG emissions reductions in the ESD in 2020 (kt CO2-equivalent per year)-->
                <xsl:variable name="emissions12">
                    <xsl:value-of select="Table2/ExanteEmissions1/ESD"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions12=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions12}">
                            <text:p>
                                <xsl:value-of select="$emissions12"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--Total GHG Reduction for 2020-SAME AS EXANTE EMISSIONS-->
                <xsl:variable name="emissions1">
                    <xsl:value-of select="Table2/ExanteEmissions1/Total"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions1=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
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
                <!--GHG emissions reductions in the EU ETS in 2025 (kt CO2-equivalent per year)-->
                <xsl:variable name="emissions6">
                    <xsl:value-of select="Table2/ExanteEmissions2/EU_ETS"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions6=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions6}">
                            <text:p>
                                <xsl:value-of select="$emissions6"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--GHG emissions reductions in the ESD in 2025 (kt CO2-equivalent per year)-->
                <xsl:variable name="emissions11">
                    <xsl:value-of select="Table2/ExanteEmissions2/ESD"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions11=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions11}">
                            <text:p>
                                <xsl:value-of select="$emissions11"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--Total GHG Reduction for 2025-SAME AS EXANTE EMISSIONS-->
                <xsl:variable name="emissions2">
                    <xsl:value-of select="Table2/ExanteEmissions2/Total"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions1=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions2}">
                            <text:p>
                                <xsl:value-of select="$emissions2"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--GHG emissions reductions in the EU ETS in 2030 (kt CO2-equivalent per year)-->
                <xsl:variable name="emissions7">
                    <xsl:value-of select="Table2/ExanteEmissions3/EU_ETS"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions7=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions7}">
                            <text:p>
                                <xsl:value-of select="$emissions7"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--GHG emissions reductions in the ESD in 2030 (kt CO2-equivalent per year)-->
                <xsl:variable name="emissions10">
                    <xsl:value-of select="Table2/ExanteEmissions3/ESD"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions10=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions10}">
                            <text:p>
                                <xsl:value-of select="$emissions10"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--Total GHG Reduction for 2030-SAME AS EXANTE EMISSIONS-->
                <xsl:variable name="emissions3">
                    <xsl:value-of select="Table2/ExanteEmissions3/Total"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions3=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions3}">
                            <text:p>
                                <xsl:value-of select="$emissions3"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--GHG emissions reductions in the EU ETS in 2035 (kt CO2-equivalent per year)-->
                <xsl:variable name="emissions8">
                    <xsl:value-of select="Table2/ExanteEmissions4/EU_ETS"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions8=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions8}">
                            <text:p>
                                <xsl:value-of select="$emissions8"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--GHG emissions reductions in the ESD in 2035 (kt CO2-equivalent per year)-->
                <xsl:variable name="emissions9">
                    <xsl:value-of select="Table2/ExanteEmissions4/ESD"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions9=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions9}">
                            <text:p>
                                <xsl:value-of select="$emissions9"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--Total GHG Reduction for 2035-SAME AS EXANTE EMISSIONS-->
                <xsl:variable name="emissions4">
                    <xsl:value-of select="Table2/ExanteEmissions4/Total"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$emissions4=''">
                        <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                            <text:p></text:p>
                        </table:table-cell>
                    </xsl:when>
                    <xsl:otherwise>   
                        <table:table-cell table:style-name="dataCell" office:value-type="float" office:value="{$emissions4}">
                            <text:p>
                                <xsl:value-of select="$emissions4"/>
                            </text:p>
                        </table:table-cell>
                    </xsl:otherwise>
                </xsl:choose>
                <!--Exante assessment Reference-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table2/ExanteDocumentation">
                            <xsl:value-of select="Reference"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Exante assessment Url-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table2/ExanteDocumentation">
                            <xsl:value-of select="Weblink"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Expost Year-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table2/Expost">
                            <xsl:value-of select="Year"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Expost Average-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table2/Expost">
                            <xsl:value-of select="Average"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Explanation of the basis for the mitigation estimates-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table2/BasisExplanation"/>
                    </text:p>
                </table:table-cell>
                <!--Factors affected by the policy or measure-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table2/AffectedFactors"/>
                    </text:p>
                </table:table-cell>
                <!--Reference for expost assessment-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table2/ExpostDocumentation">
                            <xsl:value-of select="Reference"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Reference for expost weblink-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table2/ExpostDocumentation">
                            <xsl:value-of select="Weblink"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>


                <!--Projected costs (EUR per tonne CO2eq reduced/ sequestered)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/CostReduced"/>
                    </text:p>
                </table:table-cell>
                <!--Projected absolute costs per year (EUR)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/CostPerYear"/>
                    </text:p>
                </table:table-cell>
                <!--Year projected cost has been calculated for-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/CostCalculatedYear"/>
                    </text:p>
                </table:table-cell>
                <!--Price reference year (projected costs)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/CostReferenceYear"/>
                    </text:p>
                </table:table-cell>
                <!--Projected benefits (EUR per tonne CO2eq reduced/ sequestered)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/BenefitReduced"/>
                    </text:p>
                </table:table-cell>
                <!--Projected absolute benefit per year (EUR)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/BenefitPerYear"/>
                    </text:p>
                </table:table-cell>
                <!--Projected net costs (EUR per tonne CO2eq reduced/ sequestered)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/NetCostReduced"/>
                    </text:p>
                </table:table-cell>
                <!--Projected net costs per year-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/NetCostPerYear"/>
                    </text:p>
                </table:table-cell>
                <!--Description of projected cost estimates (basis for cost estimate, what type of costs are included in the estimate, methodology)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Projected/CostDescription"/>
                    </text:p>
                </table:table-cell>
                <!--Reference for projected costs and benefits-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table3/Projected/CostDocumentation">
                            <xsl:value-of select="Reference"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Web link for projected costs and benefits)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table3/Projected/CostDocumentation">
                            <xsl:value-of select="Weblink"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Realised costs (EUR per tonne CO2eq reduced/ sequestered)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/CostReduced"/>
                    </text:p>
                </table:table-cell>
                <!--Realised absolute costs per year (EUR)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/CostPerYear"/>
                    </text:p>
                </table:table-cell>
                <!--Year realised cost has been calculated for-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/CostCalculatedYear"/>
                    </text:p>
                </table:table-cell>
                <!--Price reference year (realised costs)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/CostReferenceYear"/>
                    </text:p>
                </table:table-cell>
                <!--Realised benefits (EUR per tonne CO2eq reduced/ sequestered)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/BenefitReduced"/>
                    </text:p>
                </table:table-cell>
                <!--Realised absolute benefit per year (EUR)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/BenefitPerYear"/>
                    </text:p>
                </table:table-cell>
                <!--Realised net costs (EUR per tonne CO2eq reduced/ sequestered)-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/NetCostReduced"/>
                    </text:p>
                </table:table-cell>
                <!--Realised net costs per year-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/NetCostPerYear"/>
                    </text:p>
                </table:table-cell>
                <!--Description of realised cost estimates-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:value-of select="Table3/Realised/CostDescription"/>
                    </text:p>
                </table:table-cell>
                <!--Reference for realised costs and benefits-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table3/Realised/CostDocumentation">
                            <xsl:value-of select="Reference"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>
                <!--Web link for realised costs and benefits-->
                <table:table-cell table:style-name="dataCell" office:value-type="string" calcext:value-type="string">
                    <text:p>
                        <xsl:for-each select="Table3/Realised/CostDocumentation">
                            <xsl:value-of select="Weblink"/>
                            <xsl:if test="position() != last()">; </xsl:if>
                        </xsl:for-each>
                    </text:p>
                </table:table-cell>

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
                    <xsl:when test="position() != last()">;</xsl:when>
                </xsl:choose>
            </xsl:for-each>
        </xsl:variable>
        <xsl:for-each select="distinct-values(tokenize($stringWithDuplicates, ';'))">
            <xsl:variable name="currentToken" select="."/>
            <xsl:if test="$currentToken!=''">
                <xsl:value-of select="$currentToken"/>
                <xsl:choose>
                    <xsl:when test="position() != last()">; </xsl:when>
                </xsl:choose>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>

