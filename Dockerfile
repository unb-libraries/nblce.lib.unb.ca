FROM ghcr.io/unb-libraries/drupal:10.x-1.x-unblib
MAINTAINER UNB Libraries <libsupport@unb.ca>

# Install additional OS packages.
ENV ADDITIONAL_OS_PACKAGES="postfix php-ldap php-xmlreader php-zip php81-pecl-redis"
ENV DRUPAL_SITE_ID="nblce"
ENV DRUPAL_SITE_URI="nblce.lib.unb.ca"
ENV DRUPAL_SITE_UUID="842a4c70-3da8-41a9-8948-9dbec80be2bd"

# Build application.
COPY ./build/ /build/
RUN ${RSYNC_MOVE} /build/scripts/container/ /scripts/ && \
  /scripts/addOsPackages.sh && \
  /scripts/initOpenLdap.sh && \
  /scripts/setupStandardConf.sh && \
  /scripts/build.sh

# Deploy configuration.
COPY ./configuration ${DRUPAL_CONFIGURATION_DIR}
RUN /scripts/pre-init.d/72_secure_config_sync_dir.sh

# Deploy custom modules, themes.
COPY ./custom/themes ${DRUPAL_ROOT}/themes/custom
COPY ./custom/modules ${DRUPAL_ROOT}/modules/custom

# Container metadata.
LABEL ca.unb.lib.generator="drupal9" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="MIT" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.description="New Brunswick Literature Curriculum in English is a guided reading tool for those who want to know more about New Brunswick literature" \
  org.label-schema.name="nblce.lib.unb.ca" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.url="https://nblce.lib.unb.ca" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/unb-libraries/nblce.lib.unb.ca" \
  org.label-schema.vendor="University of New Brunswick Libraries" \
  org.label-schema.version=$VERSION \
  org.opencontainers.image.source="https://github.com/unb-libraries/nblce.lib.unb.ca"
