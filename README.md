# Docker Symfony

---

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

---

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

---