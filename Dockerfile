# syntax=docker/dockerfile:1

# ---- Build stage ----
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY MelodyMart/pom.xml .
RUN mvn -B -q dependency:go-offline
COPY MelodyMart/src ./src
RUN mvn -B -q package

# ---- Runtime stage ----
FROM tomcat:9.0-jre17-temurin
ENV CATALINA_OPTS="-XX:MaxRAMPercentage=75 -Djava.security.egd=file:/dev/./urandom" \
    PORT=8080

# Remove default apps and deploy MelodyMart at the site root
RUN rm -rf /usr/local/tomcat/webapps/* \
 && useradd --system --uid 10001 --home /usr/local/tomcat melody
COPY docker/server.xml /usr/local/tomcat/conf/server.xml
COPY docker/logging.properties /usr/local/tomcat/conf/logging.properties
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --from=build /app/target/MelodyMart.war /usr/local/tomcat/webapps/ROOT.war
RUN chmod +x /usr/local/bin/entrypoint.sh \
 && chown -R melody:melody /usr/local/tomcat

USER melody
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD curl -fsS "http://localhost:${PORT}/health" || exit 1
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
