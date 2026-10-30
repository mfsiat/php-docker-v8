# PHP Docker v8 (Custom PHP 8.5 Image) 🐘🐳

This repository provides a **customized PHP 8.5 Docker image** based on `php:8.5-fpm-alpine`, preconfigured with commonly used PHP extensions, security defaults, and tools for modern PHP application development.

The image is lightweight, fast, and suitable for **Laravel**, **Symfony**, or any PHP application that requires database connectivity and Composer support.

---

## 📌 Features

This Docker image comes with the following pre-installed:

* **PHP 8.5 (FPM)**
* **Alpine Linux** (small image size)
* PHP Extensions:

  * `zip`
  * `pdo`
  * `pdo_mysql`
* System Libraries:

  * `libzip` (runtime)
* Tools:

  * **Composer 2** (latest)
* Security defaults:

  * Runs as a non-root `www` user (UID/GID 1000)
  * Hardened `php.ini` defaults in `conf/security.ini`
  * `EXPOSE 9000` and a container healthcheck
  * Alpine packages upgraded at build time to pick up security patches

---

## 📂 Repository Structure

```
.
├── Dockerfile                  # Custom PHP 8.5 Docker image
├── conf
│   └── security.ini            # Hardened PHP settings
├── .dockerignore               # Keeps the build context small
├── .hadolint.yaml              # Dockerfile lint configuration
├── .github
│   ├── dependabot.yml          # Automated dependency updates
│   └── workflows
│       ├── ci.yml              # PR validation: lint, build, test, scan
│       └── deploy.yml          # Build, scan and publish to Docker Hub
└── README.md
```

---

## 🧱 Base Image

```
php:8.5-fpm-alpine
```

Why Alpine?

* Smaller image size
* Faster pull and build times
* Reduced attack surface

Alpine packages are upgraded during the build so that security fixes are included even when the base image tag has not moved yet.

---

## 🛠 Dockerfile Overview

The Dockerfile performs the following steps:

1. Uses PHP 8.5 FPM Alpine as base image
2. Upgrades Alpine packages and installs runtime packages (`zip`, `libzip`)
3. Installs temporary build dependencies (`libzip-dev`) and enables:

   * `zip`
   * `pdo`
   * `pdo_mysql`
4. Removes temporary build dependencies to keep the image small
5. Copies the **Composer 2** binary from the official Composer image
6. Copies the hardened PHP settings from `conf/security.ini`
7. Creates a non-root `www` user and runs the container as that user
8. Exposes port `9000` and defines a healthcheck

---

## 🚀 Build the Image

Clone the repository:

```
git clone https://github.com/<your-username>/php-docker-v8.git
cd php-docker-v8
```

Build the Docker image:

```
docker build -t php-docker-v8:8.5 .
```

---

## ▶️ Run the Container

Simple example:

```
docker run -d \
  --name php85 \
  -v $(pwd):/var/www/html \
  -p 9000:9000 \
  php-docker-v8:8.5
```

Hardened example (recommended):

```
docker run -d \
  --name php85 \
  --read-only \
  --tmpfs /tmp \
  --tmpfs /run \
  --cap-drop ALL \
  --security-opt no-new-privileges:true \
  -v $(pwd):/var/www/html:ro \
  -p 9000:9000 \
  php-docker-v8:8.5
```

This exposes PHP-FPM on port **9000**.

---

## 🧪 Verify the Image

Check PHP version:

```
docker exec -it php85 php -v
```

Check installed extensions:

```
docker exec -it php85 php -m
```

Verify Composer:

```
docker exec -it php85 composer --version
```

Verify the container runs as non-root:

```
docker exec -it php85 id
```

Check the health status:

```
docker inspect --format '{{json .State.Health}}' php85
```

---

## 🧩 Use with Nginx (Recommended)

This image is designed to work with **Nginx + PHP-FPM**.

Typical setup:

* Nginx container (port 80)
* PHP-FPM container (this image)
* Shared volume for application code

---

## 🔐 Security Automation

### Pull request validation

`.github/workflows/ci.yml` runs on every pull request and:

1. Lints the Dockerfile with **Hadolint**
2. Builds the image
3. Runs smoke tests (PHP version, extensions, Composer, non-root user, hardened settings)
4. Scans the image with **Trivy**
5. Fails on `HIGH` or `CRITICAL` vulnerabilities with a fix available
6. Uploads results to the GitHub Security tab

### Daily builds and scans

`.github/workflows/deploy.yml` runs on:

* Pushes to `master`
* A daily schedule (`03:17 UTC`)
* Manual dispatch

Before pushing, it builds and scans the image. The push is skipped if a `HIGH` or `CRITICAL` vulnerability with a fix is found. Images are published with `latest`, `8.5`, and commit-SHA tags, plus SBOM and provenance attestations.

### Dependency updates

Dependabot checks GitHub Actions weekly and the Docker base image daily.

---

## ⚠️ Notes

* This image is intended for **development and testing**
* Application dependencies (including PHPUnit) should be installed per project via Composer
* `conf/security.ini` is a set of defaults; override them per project with a mounted `.ini` file or `PHP_INI_SCAN_DIR`
* Enable `session.cookie_secure = 1` when the application is served over HTTPS
* Additional hardening such as `open_basedir` and `disable_functions` is application-specific; test before enabling
* For production, consider separate dev and runtime images and disabling Composer at runtime

---

## 📦 Possible Enhancements

* Add Redis / GD / Intl extensions
* Multi-stage build for production
* Separate dev and prod images
* Sign published images with Cosign
* Pin deployments to immutable image digests

---

## 👤 Author

**Nasirul Islam**
GitHub: [https://github.com/mfsiat](https://github.com/mfsiat)

---

⭐ If you find this image useful, consider starring the repository!
