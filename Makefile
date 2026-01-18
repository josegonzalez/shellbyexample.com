.PHONY: build serve test clean \
        docker-build generate-output generate-all-outputs test-examples \
        validate validate-numbering \
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
	docker build -t shellbyexample:latest tools/

generate-output: docker-build
	@if [ -z "$(SCRIPT)" ]; then echo "Usage: make generate-output SCRIPT=path/to/script.sh"; exit 1; fi
	go run tools/generate-output.go "$(SCRIPT)"

generate-all-outputs: docker-build
	go run tools/generate-output.go --all

test-examples: docker-build
	@failed=0; \
	for script in examples/*/*.sh examples/*/*.bash; do \
		[ -f "$$script" ] || continue; \
		if echo "$$script" | grep -qE '/[0-9]{2}-'; then \
			echo -n "Testing $$script... "; \
			if ./tools/run-in-docker.sh "$$script" > /dev/null 2>&1; then \
				echo "OK"; \
			else \
				echo "FAILED"; \
				failed=$$((failed + 1)); \
			fi; \
		fi; \
	done; \
	if [ $$failed -gt 0 ]; then \
		echo "$$failed script(s) failed"; \
		exit 1; \
	fi

# ==============================================================================
# Validation
# ==============================================================================

validate: validate-numbering

validate-numbering:
	go run tools/validate.go

# ==============================================================================
# Renumbering
# ==============================================================================

renumber:
	@if [ -z "$(DIR)" ]; then echo "Usage: make renumber DIR=examples/command-line-arguments"; exit 1; fi
	go run tools/renumber.go "$(DIR)"

renumber-all:
	@for dir in examples/*/; do \
		go run tools/renumber.go "$$dir"; \
	done
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
