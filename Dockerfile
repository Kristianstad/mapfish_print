# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_REPO=${SaM_REPO:-ghcr.io/kristianstad/secure_and_minimal}
ARG ALPINE_VERSION=${ALPINE_VERSION:-3.17}
ARG IMAGETYPE="application"
ARG TOMCAT_VERSION="8.0"
ARG BASEIMAGE="ghcr.io/kristianstad/tomcat:$TOMCAT_VERSION"
ARG DESTDIR="/webapps-nobind/print-servlet"
ARG BUILDDEPS="openjdk17-jdk fontconfig msttcorefonts-installer"
ARG MAKEDIRS="/usr/share"
ARG BUILDCMDS=\
'   cd $DESTDIR '\
'&& /usr/lib/jvm/java-17-openjdk/bin/jar xf /print-servlet.war '\
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
FROM ${BASEIMAGE:-$SaM_REPO:base-$ALPINE_VERSION} as base
FROM ${INITIMAGE:-scratch} as init
# Generic template (don't edit) </END>

# =========================================================================
# Build
# =========================================================================
# Generic template (don't edit) <BEGIN>
FROM ${BUILDIMAGE:-$SaM_REPO:build-$ALPINE_VERSION} as build
FROM ${BASEIMAGE:-$SaM_REPO:base-$ALPINE_VERSION} as final
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
