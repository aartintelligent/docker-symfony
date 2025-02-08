#!/bin/sh
set -e

if [ "$APP_INSTALL" = 'YES' ]; then

  until bin/console doctrine:query:sql "select 1" >/dev/null 2>&1; do

    (echo >&2 "Waiting for database to be ready...")

    sleep 5

  done

  if ls /var/www/migrations/*.php >/dev/null 2>&1; then

      bin/console doctrine:migrations:migrate -q --no-interaction

      (>&2 echo ">>> Bootstrap Symfony migration completed")

  fi

fi

bin/console cache:warmup -q

(>&2 echo ">>> Bootstrap Symfony cache warmup completed")

(>&2 echo "[#] Bootstrap Symfony successfully")
