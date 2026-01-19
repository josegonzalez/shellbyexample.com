.PHONY: build serve test clean \
        docker-build generate-output generate-all-outputs generate-category-outputs test-examples test-category \
        validate validate-numbering validate-category \
        renumber renumber-all \
        watch watch-outputs

# ==============================================================================
# Core targets
# ==============================================================================

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

# ==============================================================================
# Docker and output generation
# ==============================================================================

docker-build:
	docker build --progress=plain -t shellbyexample:latest tools/

generate-output: docker-build
	@if [ -z "$(SCRIPT)" ]; then echo "Usage: make generate-output SCRIPT=path/to/script.sh"; exit 1; fi
	go run tools/generate-output.go "$(SCRIPT)"

generate-all-outputs: docker-build
	go run tools/generate-output.go --all

generate-category-outputs: docker-build
	@if [ -z "$(CATEGORY)" ]; then echo "Usage: make generate-category-outputs CATEGORY=examples/hello-world"; exit 1; fi
	go run tools/generate-output.go --category "$(CATEGORY)"

test-examples: docker-build
	go run tools/test-examples.go --all

test-category: docker-build
	@if [ -z "$(CATEGORY)" ]; then echo "Usage: make test-category CATEGORY=examples/hello-world"; exit 1; fi
	go run tools/test-examples.go --category "$(CATEGORY)"

# ==============================================================================
# Validation
# ==============================================================================

validate: validate-numbering

validate-numbering:
	go run tools/validate.go

validate-category:
	@if [ -z "$(CATEGORY)" ]; then echo "Usage: make validate-category CATEGORY=examples/hello-world"; exit 1; fi
	go run tools/validate.go --category "$(CATEGORY)"

# ==============================================================================
# Renumbering
# ==============================================================================

renumber:
	@if [ -z "$(DIR)" ]; then echo "Usage: make renumber DIR=examples/command-line-arguments"; exit 1; fi
	go run tools/renumber.go "$(DIR)"

renumber-all:
	go run tools/renumber.go --all
	@echo ""
	@echo "Validating numbering..."
	go run tools/validate.go

# ==============================================================================
# Development
# ==============================================================================

watch:
	go run tools/watch.go

watch-outputs: docker-build
	go run tools/watch-outputs.go
