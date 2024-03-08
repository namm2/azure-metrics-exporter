FROM golang:1.11 as builder
WORKDIR /go/src/github.com/namm2/azure-metrics-exporter
COPY . .
RUN make build

FROM quay.io/prometheus/busybox:latest AS app

COPY --from=builder /go/src/github.com/namm2/azure-metrics-exporter/azure-metrics-exporter /bin/azure-metrics-exporter

EXPOSE 9276
ENTRYPOINT ["/bin/azure-metrics-exporter"]
