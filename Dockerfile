FROM registry.cn-beijing.aliyuncs.com/baxiang/golang:1.14 as build
ENV GOPROXY=https://goproxy.io,direct
ENV GOBUILDPATH=github.com/baxiang/hello-jenkins
RUN mkdir -p /go/src/${GOBUILDPATH}&&mkdir -p /go/bin/
COPY ./ /go/src/${GOBUILDPATH}
RUN cd /go/src/${GOBUILDPATH} && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go/bin/hello

FROM alpine
WORKDIR /hello
COPY --from=build /go/bin/hello /usr/local/bin/
EXPOSE 8088
CMD ["hello"]