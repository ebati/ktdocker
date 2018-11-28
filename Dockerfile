FROM golang:1.11.2-alpine3.8 AS builder

WORKDIR /src

ENV GIT_HASH=05fbd0c03dca2aa927ada5365fab18064c162e5c

RUN wget https://github.com/fgeller/kt/archive/${GIT_HASH}.zip && \
    unzip ${GIT_HASH}.zip && \
    mv kt-${GIT_HASH} kt && \
    cd kt && \
    CGO_ENABLED=0 go build -mod vendor


FROM alpine:3.8

COPY --from=builder /src/kt/kt /bin/kt
