# Secure and Minimal image of Mapfish Print.
# https://hub.docker.com/repository/docker/huggla/sam-mapfish_print

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.6-3.16"
ARG IMAGETYPE="application"
ARG TOMCAT_VERSION="8.0.53-20220823"
ARG BASEIMAGE="huggla/sam-tomcat:$TOMCAT_VERSION"
ARG DESTDIR="/webapps-nobind/print-servlet"
ARG BUILDDEPS="openjdk8 fontconfig msttcorefonts-installer"
ARG MAKEDIRS="/usr/share"
ARG BUILDCMDS=\
'   cd $DESTDIR '\
'&& /usr/lib/jvm/java-1.8-openjdk/bin/jar xf /print-servlet.war '\
'&& update-ms-fonts '\
'&& fc-cache -f '\
'&& cp -a /etc/fonts /finalfs/etc/ '\
'&& cp -a /usr/share/xml /usr/share/font* /finalfs/usr/share/'
# ARGs (can be passed to Build/Final) </END>

# Generic template (don't edit) <BEGIN>
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${CONTENTIMAGE3:-scratch} as content3
FROM ${CONTENTIMAGE4:-scratch} as content4
FROM ${CONTENTIMAGE5:-scratch} as content5
FROM ${BASEIMAGE:-huggla/secure_and_minimal:$SaM_VERSION-base} as base
FROM ${INITIMAGE:-scratch} as init
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
