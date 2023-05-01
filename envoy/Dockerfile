FROM --platform=linux/amd64 envoyproxy/envoy:v1.25.1

COPY envoy.yaml /etc/envoy/envoy.yaml
RUN chmod go+r /etc/envoy/envoy.yaml