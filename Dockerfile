FROM unblibraries/drupal:dockworker-2.x
MAINTAINER UNB Libraries <libsupport@unb.ca>

ENV DRUPAL_SITE_ID nblce
ENV DRUPAL_SITE_URI nblce.lib.unb.ca
ENV DRUPAL_SITE_UUID 842a4c70-3da8-41a9-8948-9dbec80be2bd

# Override upstream scripts with local.
COPY ./scripts/container /scripts

# Add additional OS packages.
ENV ADDITIONAL_OS_PACKAGES rsyslog postfix php7-ldap php7-xmlreader php7-zip php7-redis
RUN /scripts/addOsPackages.sh && \
  /scripts/initRsyslog.sh && \
  echo "TLS_REQCERT never" > /etc/openldap/ldap.conf

# Add package conf.
COPY ./package-conf /package-conf
RUN /scripts/setupStandardConf.sh

# Build the contrib Drupal tree.
ARG COMPOSER_DEPLOY_DEV=no-dev
ENV DRUPAL_BASE_PROFILE minimal
ENV DRUPAL_BUILD_TMPROOT ${TMP_DRUPAL_BUILD_DIR}/webroot

COPY ./build /build
RUN /scripts/build.sh ${COMPOSER_DEPLOY_DEV} ${DRUPAL_BASE_PROFILE}

# Deploy repo assets.
COPY ./config-yml ${DRUPAL_CONFIGURATION_DIR}
COPY ./custom/themes ${DRUPAL_ROOT}/themes/custom
COPY ./custom/modules ${DRUPAL_ROOT}/modules/custom
COPY ./tests/ ${DRUPAL_TESTING_ROOT}/

# Universal environment variables.
ENV DEPLOY_ENV prod

# Metadata
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL ca.unb.lib.generator="drupal8" \
      com.microscaling.docker.dockerfile="/Dockerfile" \
      com.microscaling.license="MIT" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.description="nblce.lib.unb.ca is the NBLCE application at UNB Libraries." \
      org.label-schema.name="nblce.lib.unb.ca" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url="https://nblce.lib.unb.ca" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/unb-libraries/nblce.lib.unb.ca" \
      org.label-schema.vendor="University of New Brunswick Libraries" \
      org.label-schema.version=$VERSION
