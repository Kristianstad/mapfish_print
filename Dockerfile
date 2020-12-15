# Secure and Minimal image of Mapfish Print.
# https://hub.docker.com/repository/docker/huggla/sam-mapfish_print

# =========================================================================
# Init
# =========================================================================
# ARGs (can be passed to Build/Final) <BEGIN>
ARG SaM_VERSION="2.0.4"
ARG IMAGETYPE="application"
ARG TOMCAT_VERSION="dev"
ARG BASEIMAGE="huggla/sam-tomcat:$TOMCAT_VERSION"
ARG DESTDIR="/webapps-nobind/print-servlet"
ARG BUILDDEPS="openjdk8"
ARG RUNDEPS="ghostscript freetype ttf-font-awesome"
ARG EXECUTABLES="/usr/bin/gs"
ARG DOWNLOADS="https://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz https://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64.tar.gz"
ARG BUILDCMDS=\
'   cd $DESTDIR '\
'&& /usr/lib/jvm/java-1.8-openjdk/bin/jar xf /print-servlet.war '\
'&& cp -a $DOWNLOADSDIR/jai-1_1_3/lib/*.jar $DOWNLOADSDIR/jai_imageio-1_1/lib/*.jar WEB-INF/lib/ '\
'&& mkdir -p /finalfs/usr/local/lib/amd64 '\
'&& cp -a $DOWNLOADSDIR/jai-1_1_3/lib/*.so $DOWNLOADSDIR/jai_imageio-1_1/lib/*.so /usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/libfontmanager.so /finalfs/usr/local/lib/amd64/'
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
