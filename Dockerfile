################################# Build Container ###############################
FROM --platform=$BUILDPLATFORM golang:1.22 AS builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /app
COPY . /app/

# Compiler runs natively; output targets the requested platform
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o main app.go

################################# Prod Container #################################
FROM alpine:3.20
RUN apk add --no-cache ca-certificates python3
WORKDIR /root
COPY --from=builder /app/. .
CMD ["./main"]
