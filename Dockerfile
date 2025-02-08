FROM aartintelligent/php:8.4-composer AS composer

USER root

COPY symfony /symfony

WORKDIR /symfony

RUN set -eux; \
    composer install \
        --prefer-dist \
        --no-autoloader \
        --no-interaction \
        --no-scripts \
        --no-progress \
        --no-dev; \
    composer dump-autoload \
        --optimize

FROM node:lts-bookworm AS webpack

COPY symfony /symfony

COPY --chown=rootless:rootless --from=composer /symfony/vendor /symfony/vendor

WORKDIR /symfony

RUN npm install && npm run build

FROM aartintelligent/php:8.4-nginx AS webapp

USER root

COPY system /

RUN chmod +x /docker/d-*.sh

RUN echo "/docker/d-bootstrap-symfony.sh" | tee -a "/docker/d-bootstrap.list"

COPY --chown=rootless:rootless symfony /var/www

COPY --chown=rootless:rootless --from=composer /symfony/vendor /var/www/vendor

COPY --chown=rootless:rootless --from=webpack /symfony/public/build /var/www/public/build

USER rootless
