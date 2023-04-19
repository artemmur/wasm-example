FROM golang:1.20-alpine AS build

WORKDIR /app
COPY ./cmd /app/cmd

# This line installs WasmEdge including the AOT compiler
RUN curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash

RUN GOOS=js GOARCH=wasm go build \
-o main.wasm \
./cmd/hello

# This line builds the AOT Wasm binary
RUN /root/.wasmedge/bin/wasmedgec /app/main.wasm build.wasm

FROM scratch
ENTRYPOINT [ "hello.wasm" ]
COPY --from=build /app/build.wasm /hello.wasm