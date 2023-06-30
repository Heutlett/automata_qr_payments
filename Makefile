.PHONY: build-db run-db run clean clean-db # clean-qr-api build-qr-api run-qr-api

# --------------------------------------------------- DOCKER COMPOSE
# Stop and remove the running database container
clean: clean-db
	docker-compose -p qr_payments down

# Run Docker Compose
run: build-db
	docker-compose -p qr_payments up


# --------------------------------------------------- DATABASE
DB_IMAGE_NAME := db-image
DB_CONTAINER_NAME := db
DB_PATH := db

# Build the Docker image for the database
build-db:
	docker build --pull -t $(DB_IMAGE_NAME):latest ./$(DB_PATH)

# Run the Docker container for the database
run-db: build-db
	docker run -p 3306:3306 --name $(DB_CONTAINER_NAME) $(DB_IMAGE_NAME):latest

# Clean up the Docker image for the database
clean-db:
	docker rmi $(DB_IMAGE_NAME):latest


# --------------------------------------------------- QR API
# QR_API_IMAGE_NAME := qr-api-image
# QR_API_CONTAINER_NAME := qr-api
# QR_API_PATH := api

# # Build the Docker image for the api
# build-qr-api:
#	docker build --pull -t $(QR_API_IMAGE_NAME):latest ./$(QR_API_PATH)

# # Run the Docker container for the api
# build-qr-api: build-db
# 	docker run -p 3306:3306 --name $(QR_API_CONTAINER_NAME) $(QR_API_IMAGE_NAME):latest

# # Clean up the Docker image for the api
# clean-qr_api:
# 	docker rmi $(QR_API_IMAGE_NAME):latest







