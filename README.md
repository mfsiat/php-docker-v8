# PHP Docker v8 (Custom PHP 8.2 Image) 🐘🐳

This repository provides a **customized PHP 8.2 Docker image** based on `php:8.2-fpm-alpine`, preconfigured with commonly used PHP extensions and tools for modern PHP application development.

The image is lightweight, fast, and suitable for **Laravel**, **Symfony**, or any PHP application that requires database connectivity and Composer support.

---

## 📌 Features

This Docker image comes with the following pre-installed:

* **PHP 8.2 (FPM)**
* **Alpine Linux** (small image size)
* PHP Extensions:

  * `zip`
  * `pdo`
  * `pdo_mysql`
* System Libraries:

  * `libzip-dev`
* Tools:

  * **Composer** (latest)
  * **PHPUnit** (installed via Composer)

---

## 📂 Repository Structure

```
.
├── Dockerfile          # Custom PHP 8.2 Docker image
├── .github
│   └── workflows
│       └── deploy.yml  # GitHub Actions workflow (optional CI/CD)
└── README.md
```

---

## 🧱 Base Image

```
php:8.2-fpm-alpine
```

Why Alpine?

* Smaller image size
* Faster pull and build times
* Reduced attack surface

---

## 🛠 Dockerfile Overview

The Dockerfile performs the following steps:

1. Uses PHP 8.2 FPM Alpine as base image
2. Installs required system packages (`zip`, `libzip-dev`)
3. Enables and installs PHP extensions:

   * `zip`
   * `pdo`
   * `pdo_mysql`
4. Installs **Composer** globally
5. Installs **PHPUnit** using Composer

---

## 🚀 Build the Image

Clone the repository:

```
git clone https://github.com/<your-username>/php-docker-v8.git
cd php-docker-v8
```

Build the Docker image:

```
docker build -t php-docker-v8:8.2 .
```

---

## ▶️ Run the Container

Example command to run the container:

```
docker run -d \
  --name php82 \
  -v $(pwd):/var/www/html \
  -p 9000:9000 \
  php-docker-v8:8.2
```

This exposes PHP-FPM on port **9000**.

---

## 🧪 Verify Installed Extensions

Check PHP version:

```
docker exec -it php82 php -v
```

Check installed extensions:

```
docker exec -it php82 php -m
```

Verify Composer:

```
docker exec -it php82 composer --version
```

Verify PHPUnit:

```
docker exec -it php82 ./vendor/bin/phpunit --version
```

---

## 🧩 Use with Nginx (Recommended)

This image is designed to work with **Nginx + PHP-FPM**.

Typical setup:

* Nginx container (port 80)
* PHP-FPM container (this image)
* Shared volume for application code

---

## ⚠️ Notes

* This image is intended for **development and testing**
* Additional PHP extensions can be added as needed
* PHPUnit is installed globally via Composer (can be adjusted)

---

## 📦 Possible Enhancements

* Add Redis / GD / Intl extensions
* Multi-stage build for production
* Non-root user for security
* Separate dev and prod images

---

## 👤 Author

**Nasirul Islam**
GitHub: [https://github.com/mfsiat](https://github.com/mfsiat)

---

⭐ If you find this image useful, consider starring the repository!

