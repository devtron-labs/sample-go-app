################################# Build Container ###############################

FROM golang:1.20  as builder

# Setup the working directory
RUN apt update
RUN apt install git gcc musl-dev make -y
RUN go install github.com/google/wire/cmd/wire@latest
WORKDIR /go/src/github.com/devtron-labs/smaple-go-app
ADD . /go/src/github.com/devtron-labs/smaple-go-app/


# Add source code
ADD . /app/

# Build the source
RUN  GOOS=linux make build


################################# Prod Container #################################






