# # Use the official Golang image to build the app
# FROM golang:1.18 as builder

# # Set the working directory inside the container
# WORKDIR /app

# # Copy go mod and sum files
# #COPY go.mod go.sum ./

# # Download all dependencies
# #RUN go mod download

# # Copy the source code
# COPY . .

# # Build the application
# RUN go build -o my-go-app1 main.go

# # Expose the port the app runs on
# EXPOSE 8080

# # Command to run the executable
# CMD ["./my-go-app1"]
# Use the official Golang image to build the app
FROM golang:1.18 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the source code
COPY . .

# Build the applications
RUN go build -o my-go-app main.go

# Use a minimal base image to run the application
FROM alpine:latest

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/my-go-app .

# Expose the port the app runs on
EXPOSE 8002

# Command to run the executable
CMD ["./my-go-app"]
