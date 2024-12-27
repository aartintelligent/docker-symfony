# Docker Symfony

### Composer usage

```shell
docker run -it --rm \
  --name composer \
  -v $(pwd)/symfony:/var/www \
  -w /var/www \
  aartintelligent/php:8.4-composer install
```

```shell
docker run -it --rm \
  --name composer \
  -v $(pwd)/symfony:/var/www \
  -w /var/www \
  aartintelligent/php:8.4-composer update
```

### Webpack usage

```shell
docker run -it --rm \
  --name nodejs \
  -v $(pwd)/symfony:/var/www \
  -w /var/www \
  node:lts-bookworm npm install
```

```shell
docker run -it --rm \
  --name nodejs \
  -v $(pwd)/symfony:/var/www \
  -w /var/www \
  node:lts-bookworm npm run build
```

```shell
docker run -it --rm \
  --name nodejs \
  -v $(pwd)/symfony:/var/www \
  -w /var/www \
  node:lts-bookworm npm run dev
```

```shell
docker run -it --rm \
  --name nodejs \
  -v $(pwd)/symfony:/var/www \
  -w /var/www \
  node:lts-bookworm npm run watch
```

### Usage Docker

```shell
docker build . -t aartintelligent/symfony:latest
```

```shell
docker push aartintelligent/symfony:latest
```

### Usage Docker Compose

```shell
docker compose build
```

```shell
docker compose up -d
```

```shell
docker compose down -v
```

### Compose

```yaml
services:

  database:
    image: postgres:17
    user: root
    environment:
      - POSTGRES_DB=postgres
      - POSTGRES_USER=app
      - POSTGRES_PASSWORD=password
      - PGDATA=/var/lib/postgresql/data/pgdata
    volumes:
      - database-volume:/var/lib/postgresql/data
      # - /opt/postgres/data:/var/lib/postgresql/data
    ports:
      - '5432:5432'

  webapp:
    build:
      context: .
      target: webapp
    environment:
      PHP_OPCACHE__ENABLE: 0
      PHP_OPCACHE__ENABLE_CLI: 0
      PHP_XDEBUG__MODE: debug
    volumes:
      - ./symfony:/var/www:rw,delegated
    ports:
      - '8080:8080'

volumes:
  database-volume:
```