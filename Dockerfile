# syntax=docker/dockerfile:1

# Build stage
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o discord-bot

# Final stage
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/discord-bot .

EXPOSE 8000

CMD ["./discord-bot"]