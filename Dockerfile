FROM golang:1.20-alpine AS build
ADD . /src
WORKDIR /src
RUN go get -d -v -t
RUN GOOS=linux GOARCH=amd64 go build -v -o demo-go-backend-with-db 

FROM alpine:3.17.3
EXPOSE 8080
CMD ["demo-go-backend-with-db"]
ENV VERSION 1.1.4
COPY --from=build /src/demo-go-backend-with-db /usr/local/bin/demo-go-backend-with-db
RUN chmod +x /usr/local/bin/demo-go-backend-with-db
