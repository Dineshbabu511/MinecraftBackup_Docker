# 📦 MinecraftBackup_Docker

*A robust, automated Minecraft backup system powered by Docker and GitHub.*

This repository — **[danieltorquatof/MinecraftBackup_Docker](https://github.com/danieltorquatof/MinecraftBackup_Docker)** — provides a fully automated backup workflow for Minecraft Java Edition servers running inside Docker.
It integrates Git versioning, GitHub remote storage, periodic world saves, structured logging, and graceful shutdown procedures.

The solution is built on top of the official `itzg/minecraft-server` image (tested with `java21` / `LATEST`) and enhances it with a custom entrypoint that triggers backup routines at startup, shutdown, and at periodic intervals.

---

## ✨ Key Features

* **Automated World Backups**
  Saves your Minecraft world at regular intervals using Git commits.

* **GitHub Integrated Storage**
  Pushes backups to a private or public GitHub repository.

* **Graceful Shutdown Protection**
  Ensures a complete world save whenever the container stops.

* **Fully Compatible with Official Image Environment Variables**
  You can configure the server using any variables supported by the original Docker image.

* **Extensible & Maintainable**
  Scripts are modular and can be easily customised.

---

## 📁 Project Structure

```bash
.
├── docker-compose.yml
├── Dockerfile
├── entrypoint.sh
├── .env.example
├── .gitignore
├── README.md
├── scripts
│   ├── autosave.sh
│   ├── init.sh
│   ├── shutdown.sh
├── utils
│   ├── log.sh
│   ├── saveWorld.sh
```

---

## 🚀 How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/danieltorquatof/MinecraftBackup_Docker.git
cd MinecraftBackup_Docker
```

### 2. Create your `.env` file

Use the provided `.env.example`:

```bash
cp .env.example .env
```

Then edit `.env` and fill in all required environment variables (see next section).

### 3. Build and start the container

```bash
docker compose up -d --build
```

The Minecraft server will start, periodic backups will be scheduled, and logs will be written to `./logs`.

---

## 📝 Required Pre-Execution Steps

### ✅ 1. Create a GitHub *Personal Access Token*

This token is used for pushing commits from inside the container to your GitHub repository.

Follow the official GitHub documentation:
🔗 [Managing your personal access tokens](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)

The scopes typically required are:

* `repo` (full repository access)

Add the token to your `.env`:

```Dotenv
GITHUB_TOKEN=your_token_here
```

---

## ✅ 2. Create a new (empty) GitHub repository

This repository will store your automatic world backups.

Official Guide:
🔗 [Creating a new repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)

Then put the repository **name only** (not the full URL) in your `.env`:

```Dotenv
REPO_NAME=MyMinecraftWorld
```

---

## ✅ 3. Fill in remaining environment variables

These must also be configured:

| Variable            | Description                                            |
| ------------------- | ------------------------------------------------------ |
| `GITHUB_USER`       | Your GitHub username (owner of the token).             |
| `SEED`              | (Optional) Minecraft world seed. Can be commented out. |
| `RCON_PASSWORD`     | Password for remote console access. Preferably random. |
| `PERIODIC_INTERVAL` | Automatic backup interval in minutes (default: 15).    |

### 🔐 Generating a secure password

You can generate a secure `RCON_PASSWORD` here:
[Password Generator](https://www.lastpass.com/pt/features/password-generator)

---

## 🐳 Docker Image Documentation

This project is based on the official image:

🔗 [Minecraft Server on Docker (Java Edition) [latest]](https://docker-minecraft-server.readthedocs.io/en/latest/)

All official environment variables of the `itzg/minecraft-server` image remain fully functional and compatible.

Example customisations such as:

```Dotenv
EULA=TRUE
TYPE=VANILLA
VERSION=LATEST
MEMORY=4G
ENABLE_RCON=true
```

…are available as usual through `docker-compose.yml` or your `.env`.

---

## 🧪 Image Version Used (Tested)

This project was built and tested against:

* **Base image:** `itzg/minecraft-server:java21`
* **Minecraft version:** `LATEST` at the time of development

Future versions *should* remain compatible, but behaviour may vary.

---

## ▶️ How the System Works

### 🔹 On Startup

* The container initialises the backup repository.
* If the repo exists, it pulls updates.
* If empty or missing, it prepares everything automatically.

### 🔹 During Gameplay

* Backups occur every **N minutes** (`PERIODIC_INTERVAL`).
* World is saved → committed → pushed to GitHub.

### 🔹 On Shutdown

* A final world save is triggered.
* Final commit is pushed.
* Logs are stored for auditing.

---

## 🧰 Useful Directories

| Directory | Purpose                                                   |
| --------- | --------------------------------------------------------- |
| `data/`   | Global Minecraft server data + backup Git repository.     |
| `logs/`   | Logs for entrypoint, autosave, shutdown and init scripts. |

---

## 🤝 Contributing

Contributions, issues, and pull requests are welcome.
Before submitting PRs, ensure your changes follow good Bash practices and maintain compatibility with the official server image.

---

## 📄 Licence

This project is available under the MIT licence.
