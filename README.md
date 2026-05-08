# 🚀 Automated Two-Tier Web Application Deployment

A full-stack Flask application with a MySQL backend, fully automated using **Jenkins**, **Docker**, and **Docker Compose**. This project demonstrates a robust CI/CD pipeline, infrastructure-as-code, and persistent data management.

## 🏗️ Architecture Overview

The setup utilizes a **Docker-inside-Docker (Socket Mounting)** approach to allow Jenkins to manage the deployment of the application stack.

*   **App Tier:** Flask (Python 3.12-slim)
*   **Data Tier:** MySQL 5.7
*   **Automation:** Jenkins (LTS)
*   **Orchestration:** Docker Compose



---

## 🛠️ Key Technical Features

### 1. Docker-inside-Docker (Socket Mounting)
To keep the infrastructure lightweight, the Jenkins container is mounted to the host machine's Docker socket (`/var/run/docker.sock`). This allows the Jenkins container to send commands to the host machine's Docker engine.
*   **Benefit:** Jenkins doesn't need to run its own heavy Docker daemon; it "borrows" the host's engine to build and run containers.

### 2. Persistent Storage (Docker Volumes)
To prevent data loss during container refreshes or Jenkins builds, the MySQL database utilizes **Named Volumes**.
*   **Persistence:** Even when the `db` container is deleted and recreated during a Jenkins build, the data remains safely stored in the `db_data` volume on the host hard drive.
*   **Configuration:**
    ```yaml
    db:
      volumes:
        - db_data:/var/lib/mysql
### 3. Resilience & Self-Healing
Healthchecks: The database service includes a healthcheck to ensure the MySQL engine is fully initialized before the Flask app attempts to connect.

Retry Logic: The Flask application includes a Python-based retry loop to handle transient network delays during startup, preventing "Race Condition" crashes.

git clone https://github.com/Nishant-S-Bhardwaj/two_tier_web-application_deployment.git
    cd two_tier_web-application_deployment
    ```
2.  **Jenkins Configuration:**
    *   Create a **Pipeline** job.
    *   Set the Definition to **Pipeline script from SCM**.
    *   Select **Git** and provide the repository URL.
    *   Set the branch to `*/main`.
3.  **Run the Build:**
    *   Click **Build Now** in Jenkins.
    *   Jenkins will read the `Jenkinsfile`, build the Docker images, and deploy the stack.

---

## 🚦 Pipeline Stages
*   **Checkout:** Pulls the latest code from the `main` branch.
*   **Docker Build:** Builds the Flask application image using the `Dockerfile`.
*   **Deploy App:** Uses `docker compose up -d` to spin up the 2-tier architecture.
*   **Verify:** Confirms the containers are running and the mapping is correct.



---

## 📊 Database Management
The MySQL database is configured with the following credentials (internal use only):
*   **Database:** `#`
*   **User:** `#`
*   **Password:** `#`

> **Note:** Data is preserved across builds due to the `db_data` volume. To completely wipe the database, run `docker compose down -v`.

---

## 👤 Author
**Nishant Bhardwaj**   
*DevOps & Cloud Infrastructure Enthusiast*
