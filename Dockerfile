FROM --platform=$BUILDPLATFORM golang:1.20-alpine AS builder

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

ARG TARGETOS
ARG TARGETARCH

RUN CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH:-amd64} go build -o /app/belajar-cicd-pemula .

FROM alpine:3.20

WORKDIR /app

COPY --from=builder /app/belajar-cicd-pemula /app/belajar-cicd-pemula

COPY static ./static

EXPOSE 3000

CMD ["/app/belajar-cicd-pemula"]
