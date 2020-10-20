<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="menu">
        <nav class="navbar navbar-dark bg-dark navbar navbar-expand-lg">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <xsl:call-template name="bootstrap-menu-subitems">
                        <xsl:with-param name="instance" select="@instance"/>
                    </xsl:call-template>
                </ul>
            </div>
        </nav>
    </xsl:template>

    <xsl:template match="*" mode="bootstrap-submenu">
        <xsl:param name="instance"/>
        <xsl:param name="depth"/>
        <!-- active item detect -->
        <xsl:variable name="active">
            <xsl:choose>
                <!-- no link -->
                <xsl:when test="@pseudoHref=''">
                    <xsl:text></xsl:text>
                </xsl:when>
                <!-- full match -->
                <xsl:when test="@pseudoHref=/root/@controllerUri">
                    <text> active</text>
                </xsl:when>
                <!-- partial match -->
                <xsl:when test="substring(/root/@controllerUri,1,string-length(@pseudoHref))=@pseudoHref">
                    <text> active</text>
                </xsl:when>
                <!-- no match -->
                <xsl:otherwise>
                    <xsl:text></xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!-- menu item text -->
        <xsl:variable name="title">
            <xsl:choose>
                <xsl:when test="@title">
                    <xsl:value-of select="@title"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:variable name="id" select="@id"/>
                    <xsl:choose>
                        <xsl:when test="$locale/menu/*[name()=$instance]/*[name()=$id]">
                            <xsl:value-of select="$locale/menu/*[name()=$instance]/*[name()=$id]"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="name()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$depth=1">
                <xsl:choose>
                    <xsl:when test="count(*)>0">
                        <li>
                            <xsl:attribute name="class">
                                <xsl:text>nav-item dropdown</xsl:text>
                                <xsl:value-of select="$active"/>
                            </xsl:attribute>
                            <a href="#" id="{@id}" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <xsl:attribute name="class">
                                    <xsl:text>nav-link dropdown-toggle</xsl:text>
                                    <xsl:value-of select="$active"/>
                                </xsl:attribute>
                                <xsl:value-of select="$title"/>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="{@id}">
                                <xsl:call-template name="bootstrap-menu-subitems">
                                    <xsl:with-param name="instance" select="$instance"/>
                                    <xsl:with-param name="depth" select="$depth"/>
                                </xsl:call-template>
                            </div>
                        </li>
                    </xsl:when>
                    <xsl:otherwise>
                        <li>
                            <xsl:attribute name="class">
                                <xsl:text>nav-item</xsl:text>
                                <xsl:value-of select="$active"/>
                            </xsl:attribute>
                            <a href="{@href}">
                                <xsl:attribute name="class">
                                    <xsl:text>nav-link</xsl:text>
                                    <xsl:value-of select="$active"/>
                                </xsl:attribute>
                                <xsl:value-of select="$title"/>
                            </a>
                        </li>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <a href="{@href}">
                    <xsl:attribute name="class">
                        <xsl:text>dropdown-item</xsl:text>
                        <xsl:value-of select="active"/>
                    </xsl:attribute>
                    <xsl:value-of select="$title"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="bootstrap-menu-subitems">
        <xsl:param name="instance"/>
        <xsl:param name="depth" select="0"/>
        <xsl:apply-templates select="*[not(@hidden=1) and (not(@href='') or ./*)]" mode="bootstrap-submenu">
            <xsl:sort select="@priority" order="descending" data-type="number"/>
            <xsl:with-param name="instance" select="$instance"/>
            <xsl:with-param name="depth" select="$depth + 1"/>
        </xsl:apply-templates>
    </xsl:template>
</xsl:stylesheet>