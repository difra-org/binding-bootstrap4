<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template name="bootstrap-headers">
        <xsl:choose>
            <xsl:when test="/root/@debug='1'">
                <link rel="stylesheet" href="/bootstrap4/css/bootstrap.css"/>
                <script src="/bootstrap4/js/bootstrap.js"/>
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" href="/bootstrap4/js/bootstrap.min.css"/>
                <script src="/bootstrap4/js/bootstrap.min.js"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
