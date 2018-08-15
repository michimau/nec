<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes"/>
    <xsl:param name="secondFile"/>

    <xsl:template match="/">
        <MMR_PAMs xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <xsl:attribute name="xsi:noNamespaceSchemaLocation">
                <xsl:value-of select="MMR_PAMs/@xsi:noNamespaceSchemaLocation"/>
            </xsl:attribute>
            <xsl:attribute name="labelLanguage">
                <xsl:value-of select="MMR_PAMs/@labelLanguage"/>
            </xsl:attribute>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="MMR_PAMs/@xml:lang"/>
            </xsl:attribute>

            <xsl:copy-of select="MMR_PAMs/MMR_PAM"/>
            <xsl:copy-of select="document($secondFile)/MMR_PAMs/MMR_PAM"/>
        </MMR_PAMs>
    </xsl:template>
    
</xsl:stylesheet>