# ================================
# Stage 1: Build
# ================================
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests -B

# ================================
# Stage 2: Runtime
# ================================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/target/demo-0.0.1.jar app.jar

# Crear el directorio de datos y asignar permisos ANTES de cambiar de usuario
RUN mkdir -p /app/data && chown -R appuser:appgroup /app

USER appuser

ENV PORT=8000 \
    NAME_DB=jdbc:h2:file:/app/data/testdb \
    USERNAME_DB=user \
    PASSWORD_DB=password

EXPOSE 8000

ENTRYPOINT ["java", "-jar", "app.jar"]