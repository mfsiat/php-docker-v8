# PHP Docker v8 (Custom PHP 8.5 Image) 🐘🐳

This repository provides a **customized PHP 8.5 Docker image** based on `php:8.5-fpm-alpine`, preconfigured with commonly used PHP extensions and tools for modern PHP application development.

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
* Runs as a non-root `www` user (UID/GID 1000)

---

## 📂 Repository Structure

```
.
├── Dockerfile          # Custom PHP 8.5 Docker image
├── .github
│   └── workflows
│       └── deploy.yml  # GitHub Actions workflow (optional CI/CD)
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

---

## 🛠 Dockerfile Overview

The Dockerfile performs the following steps:

1. Uses PHP 8.5 FPM Alpine as base image
2. Installs runtime packages (`zip`, `libzip`) and temporary build dependencies (`libzip-dev`)
3. Enables and installs PHP extensions:

   * `zip`
   * `pdo`
   * `pdo_mysql`
4. Removes temporary build dependencies to keep the image small
5. Copies the **Composer 2** binary from the official Composer image
6. Creates a non-root `www` user and runs the container as that user

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

Example command to run the container:

```
docker run -d \
  --name php85 \
  -v $(pwd):/var/www/html \
  -p 9000:9000 \
  php-docker-v8:8.5
```

This exposes PHP-FPM on port **9000**.

---

## 🧪 Verify Installed Extensions

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
* Application dependencies (including PHPUnit) should be installed per project via Composer

---

## 📦 Possible Enhancements

* Add Redis / GD / Intl extensions
* Multi-stage build for production
* Separate dev and prod images

---

## 👤 Author

**Nasirul Islam**
GitHub: [https://github.com/mfsiat](https://github.com/mfsiat)

---

⭐ If you find this image useful, consider starring the repository!

