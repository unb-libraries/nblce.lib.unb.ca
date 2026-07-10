FROM ghcr.io/unb-libraries/drupal:11.x-1.x-unblib

# Install additional OS packages.
ENV ADDITIONAL_OS_PACKAGES="postfix php84-ldap php-xmlreader php84-zip php84-pecl-redis"
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
LABEL org.opencontainers.image.title="nblce.lib.unb.ca" \
  org.opencontainers.image.description="New Brunswick Literature Curriculum in English is a guided reading tool for those who want to know more about New Brunswick literature" \
  org.opencontainers.image.vendor="University of New Brunswick Libraries" \
  org.opencontainers.image.authors="UNB Libraries <libsupport@unb.ca>" \
  org.opencontainers.image.url="https://nblce.lib.unb.ca" \
  org.opencontainers.image.source="https://github.com/unb-libraries/nblce.lib.unb.ca" \
  org.opencontainers.image.version="$VERSION" \
  org.opencontainers.image.revision="$VCS_REF" \
  org.opencontainers.image.created="$BUILD_DATE" \
  ca.unb.lib.generator="drupal11"
