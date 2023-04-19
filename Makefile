.PHONY: browser
browser:
	GOOS=js GOARCH=wasm go build \
		 -o public/main.wasm \
		./cmd/hello

.PHONY: server
server:
	docker build -t hello-wasm .
