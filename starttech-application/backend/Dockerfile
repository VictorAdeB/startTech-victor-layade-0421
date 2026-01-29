# Stage 1: Builder
FROM golang:1.25-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git ca-certificates

# Set working directory
WORKDIR /app

# Copy go mod and sum files first for caching
COPY backend/go.mod backend/go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the source code
COPY backend/. .

# Build the binary with optimizations
RUN CGO_ENABLED=0 GOOS=linux go build -o backend ./cmd/main.go

# Stage 2: Runtime
FROM alpine:3.18

# Install runtime dependencies (curl for healthcheck)
RUN apk add --no-cache ca-certificates curl

# Create non-root user
RUN adduser -D appuser
USER appuser

# Set working directory
WORKDIR /app

# Copy binary from builder
COPY --from=builder /app/backend .

# Expose port (match your Go app)
EXPOSE 8080

# Run the binary
CMD ["./backend"]
