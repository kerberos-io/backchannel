FROM golang:1.21-bookworm as builder

# Create and change to the app directory.
WORKDIR /app

# Install gstreamer
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    gstreamer1.0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad

# Retrieve application dependencies.
# This allows the container build to reuse cached dependencies.
# Expecting to copy go.mod and if present go.sum.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY . ./

# Build the binary.
#RUN go build -tags timetzdata,netgo,osusergo --ldflags '-s -w -extldflags "-static -latomic"' -o server
RUN go build -o server

# Run the web service on container startup.
CMD ["/app/server"]