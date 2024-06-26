# Use the official Golang image to build the app
FROM golang:1.18 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy go mod and sum files
#COPY go.mod go.sum ./

# Download all dependencies
#RUN go mod download

# Copy the source code
COPY . .

# Build the application
RUN go build  main.go

# Use a minimal image for the final build
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/my-go-app1 .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the executable
CMD ["./my-go-app1"]
