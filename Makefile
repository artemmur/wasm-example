.PHONY: browser
browser:
	GOOS=js GOARCH=wasm go build \
		-o public/main.wasm \
		./cmd/hello

.PHONY: server
server:
	docker buildx build --platform wasi/wasm -t hello-wasm .

.PHONY: runb
runb: browser
	goexec 'http.ListenAndServe(`:5555`, http.FileServer(http.Dir(`./public`)))'

.PHONY: runs
runs: server
	docker run --rm --runtime=io.containerd.wasmedge.v1 --platform=wasi/wasm hello-wasm:latest