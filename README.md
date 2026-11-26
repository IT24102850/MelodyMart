# MelodyMart

An online musical instrument store: customers browse and buy instruments, request repairs and
track deliveries; sellers manage stock and orders; admins manage users.

**Stack:** Java 11+ servlets and JSP, Apache Tomcat 9, Microsoft SQL Server, Maven, Docker.

## Project layout

```
MelodyMart/            Maven project (pom.xml, src/main/java, src/main/webapp, src/test)
database/              schema.sql for a fresh database (see database/README.md)
docker/                Tomcat config used by the container image
Dockerfile             Multi-stage build: Maven -> Tomcat 9 / JRE 17
docker-compose.yml     Local app + SQL Server
render.yaml            Render deployment blueprint
.github/workflows/     CI: build, unit tests, Docker image smoke test
```

## Configuration

The app reads its database settings from environment variables:

| Variable      | Example                                                                                       |
|---------------|-----------------------------------------------------------------------------------------------|
| `DB_URL`      | `jdbc:sqlserver://myserver.database.windows.net:1433;databaseName=MelodyMartDB;encrypt=true` |
| `DB_USER`     | `melodymart_app`                                                                              |
| `DB_PASSWORD` | *(secret)*                                                                                    |
| `PORT`        | Port Tomcat listens on (default `8080`, set automatically by most hosts)                       |

For local runs without Docker you may put the same values in
`MelodyMart/src/main/resources/db.properties` (`db.url`, `db.username`, `db.password`).
Do not commit real credentials.

## Run locally

With Docker:

```bash
cp .env.example .env          # set a strong MSSQL_SA_PASSWORD
docker compose up --build
# first time only, load the schema:
docker compose exec db /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P "$MSSQL_SA_PASSWORD" \
  -Q "CREATE DATABASE MelodyMartDB"
docker compose exec db /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P "$MSSQL_SA_PASSWORD" \
  -d MelodyMartDB -i /schema/schema.sql
```

Open http://localhost:8080.

Without Docker: `cd MelodyMart && mvn package`, then deploy `target/MelodyMart.war` to Tomcat 9.

## Health check

* `GET /health` returns `{"status":"UP"}` when the app is running.
* `GET /health?db=true` also checks the database and returns 503 if it is unreachable.

## Deploy

1. Create the database (Azure SQL Database free offer works) and load `database/schema.sql`.
2. On [Render](https://render.com), choose **New → Blueprint**, pick this repository and fill
   in `DB_URL`, `DB_USER` and `DB_PASSWORD`. Render builds the Dockerfile and serves the site over HTTPS.
3. Every push to `main` redeploys automatically.
