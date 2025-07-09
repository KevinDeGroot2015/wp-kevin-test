# WordPress + MariaDB Docker Setup (without VS Code DevContainers)

This project provides a simple local WordPress development environment based on **Docker** and **MariaDB**, completely via the terminal — **without Docker Desktop GUI or VS Code DevContainers**.

!TODO!: change correct repo

## To start (move this repository in your project to install Wordpress)
```git
git remote add origin https://github.com/thisrepo.git
git add .
git commit -m "Install Wordpress default site"
```
---

## Prerequisites

Make sure you have the following installed:
- Node.js: https://nodejs.org/en/download
- Docker Engine (docker desktop): https://www.docker.com/products/docker-desktop/
- Unix-like shell (Linux, macOS, or Git Bash on Windows)

---

## Installation and Startup
1. Execute `npm install`
2. Make post-start.sh executable
```git
chmod +x post-start.sh
```
3. Make sure Docker desktop is opened and active.
4. Build and start the containers:
```git
docker compose up --build
```
Please note: The first time will take a bit longer because WordPress, MariaDB, and dependencies are downloaded.

---

## View WordPress in your browser

Once the containers are running, open in your browser:

http://localhost:8080

If everything is fine, you will immediately see your WordPress site with dummy content from FakerPress.

---

## Restart or stop

Stop containers:
```git
docker compose down
```
Restart containers (without rebuilding):
```git
docker compose up
```
---

## Extra useful commands

View all active containers:
```git
docker ps
```
Log in to WordPress container:
```git
docker exec -it wp_site bash
```
Open database CLI:
```git
docker exec -it wp_db mysql -u root -p
```
# Password: root

---

## Persistent data

The database data is stored in a Docker volume (`db_data`), so that data is retained when the container is restarted.

Do you want to remove everything, including the database?
```git
docker compose down -v
```
---

## What is done automatically?

With `docker compose up`:

- WordPress is downloaded (if not present)
- Connection to the MariaDB container
- `wp-config.php` is created based on env vars
- WordPress is automatically installed with:
- User: admin
- Password: admin
- Email: admin@example.com
- FakerPress is installed
- Dummy content generated

---

## Troubleshooting

set: -: invalid option

Convert `.devcontainer/post-start.sh` to Unix-based entries:

dos2unix .devcontainer/post-start.sh

---

## Login details

- URL: http://localhost:8080/wp-admin
- Username: admin
- Password: admin

### !remove after complete installation (prevents complete reinstallation)

- .devcontainer/post-start.sh