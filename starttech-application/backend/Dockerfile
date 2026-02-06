# =========================
# Stage 1: Builder
# =========================
FROM golang:1.25-alpine AS builder

RUN apk add --no-cache git ca-certificates

WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o app ./cmd/api/main.go

# =========================
# Stage 2: Runtime
# =========================
FROM alpine:3.20

RUN apk add --no-cache ca-certificates curl

WORKDIR /app

COPY --from=builder /app/app .

EXPOSE 8080

CMD ["./app"]
