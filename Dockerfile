FROM golang:1.21 as builder
WORKDIR /go/src/github.com/namm2/azure-metrics-exporter
COPY . .
RUN make build

FROM gcr.io/distroless/static AS app

COPY --from=builder /go/src/github.com/namm2/azure-metrics-exporter/azure-metrics-exporter /bin/azure-metrics-exporter

USER 1000:1000
ENTRYPOINT ["/bin/azure-metrics-exporter"]
