FROM --platform=$BUILDPLATFORM tinygo/tinygo AS build
WORKDIR /app
COPY . .
RUN tinygo build -o hello.wasm -target wasi ./cmd/hello/main.go

# syntax=docker/dockerfile:1
FROM scratch
ENTRYPOINT [ "hello.wasm" ]
COPY --from=build --link /app/hello.wasm /hello.wasm
