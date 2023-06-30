# Use the official MySQL 8.0.29 image as the base image
FROM mysql:8.0.29

# Set the MySQL env
ENV MYSQL_ROOT_PASSWORD=admin
ENV MYSQL_DATABASE=qr_payments-docker
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=pass
ENV MYSQL_CHARSET=utf8mb4
ENV MYSQL_COLLATION=utf8mb4_unicode_ci

# Define the filename as a variable
ENV CREATION_FILE="createTables. v1.3 - table_codigosactividad and removed table_actividades.sql"

# Copy the specific SQL script to the container
COPY ./creationQueries/$CREATION_FILE /docker-entrypoint-initdb.d
COPY ./populationQueries/ /docker-entrypoint-initdb.d


# <------------------------------------------------------------------------

# NOTES:
# The scripts are copied to the /docker-scripts folder inside the container, 
# and the MySQL container's entrypoint mechanism will execute any SQL files 
# found in the /docker-entrypoint-initdb.d folder or its subdirectories.

# -------> Docker image creation commands in "commands.txt"



