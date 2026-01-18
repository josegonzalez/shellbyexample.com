.PHONY: build serve test clean

# Default target
build:
	go mod tidy
	go run tools/generate.go

serve: build
	@echo "Serving at http://localhost:8000"
	@cd public && python3 -m http.server 8000

test:
	go test -v ./tools/...

clean:
	rm -rf public/
