.PHONY: build serve test clean docker-pull generate-output generate-all-outputs test-examples validate-safety migrate watch watch-outputs renumber

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

# Pull the bash Docker image
docker-pull:
	docker pull bash:5.3

# Test all scripts (verify they run without error)
test-examples: docker-pull
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

# Validate scripts don't write outside /tmp (static analysis)
validate-safety:
	@echo "Checking for unsafe file operations..."
	@failed=0; \
	for script in examples/*/*.sh examples/*/*.bash; do \
		[ -f "$$script" ] || continue; \
		if echo "$$script" | grep -qE '/[0-9]{2}-'; then \
			if grep -qE '(>|>>)\s*[^/$$]|>\s*/[^t]|>\s*/t[^m]|>\s*/tm[^p]' "$$script" 2>/dev/null; then \
				echo "WARNING: $$script may write outside /tmp"; \
				failed=$$((failed + 1)); \
			fi; \
		fi; \
	done; \
	if [ $$failed -gt 0 ]; then \
		echo "Found $$failed potentially unsafe script(s)"; \
		exit 1; \
	fi; \
	echo "All scripts appear safe"

# Run migration from old format to new format
migrate:
	go run tools/migrate.go

# Watch for changes and rebuild automatically
watch:
	go run tools/watch.go

# Watch for script changes and regenerate outputs
watch-outputs: docker-pull
	go run tools/watch-outputs.go

# Renumber sub-example files in an example directory
renumber:
	@if [ -z "$(DIR)" ]; then echo "Usage: make renumber DIR=examples/command-line-arguments"; exit 1; fi
	go run tools/renumber.go "$(DIR)"
