FROM golang:1.17 as build
WORKDIR /project
COPY go.mod .
RUN go mod download
COPY . /project
RUN make build

FROM golang:1.17 as service-build
WORKDIR /project
COPY go.mod .
RUN go mod download
COPY . /project
RUN make build service

FROM ubuntu:latest as service
RUN apt update && apt install ca-certificates -y && rm -rf /var/cache/apt/*
COPY --from=service-build /project/bin/service /
CMD ["./service"]

FROM postgres:13 as database
RUN apt update && \
    apt install myspell-ru -y
WORKDIR /usr/share/postgresql/13/tsearch_data
ENV DICT=/usr/share/hunspell/ru_RU
ENV POSTGRES_HOST_AUTH_METHOD=trust
RUN iconv -f koi8-r -t utf-8 -o russian.affix $DICT.aff && \
    iconv -f koi8-r -t utf-8 -o russian.dict $DICT.dic