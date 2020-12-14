# Secure and Minimal image of Mapfish Print.
# https://hub.docker.com/repository/docker/huggla/sam-mapfish_print

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.4"
ARG IMAGETYPE="application"
ARG TOMCAT_VERSION="9.0.41"
ARG MAPFISH_PRINT_VERSION="3.26.0"
ARG BASEIMAGE="huggla/sam-tomcat:$TOMCAT_VERSION"
ARG DESTDIR="/webapps-nobind/print-servlet"
ARG BUILDDEPS="openjdk8"
ARG RUNDEPS="ghostscript"
ARG EXECUTABLES="/usr/bin/gs"
ARG DOWNLOADS="https://github.com/mapfish/mapfish-print/releases/download/release%2F$MAPFISH_PRINT_VERSION/print-servlet-$MAPFISH_PRINT_VERSION.war"
ARG BUILDCMDS=\
'   cd $DESTDIR '\
'&& /usr/lib/jvm/java-1.8-openjdk/bin/jar xf $DOWNLOADSDIR/print-servlet*.war'
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${INITIMAGE:-${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base}} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-build} as build
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as final
COPY --from=build /finalfs /
# Generic template (don't edit) </END>

# =========================================================================
# Final
# =========================================================================
ENV VAR_MAPFISH_CONFIG_DIR="/etc/mapfish"

# Generic template (don't edit) <BEGIN>
USER starter
ONBUILD USER root
# Generic template (don't edit) </END>
