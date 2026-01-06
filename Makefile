.PHONY: help  # List phony targets
help:
	@cat "Makefile" | grep '^.PHONY:' | sed -e "s/^.PHONY:/- make/"

.PHONY: lint  # Lint and test the Helm chart (as in GitHub Actions)
lint:
	@echo "Running Helm lint..."
	@helm lint .
	@echo "✓ Helm lint passed"
	@echo "Running Helm template test..."
	@helm template test . --namespace test > /dev/null
	@echo "✓ Helm template test passed"

.PHONY: release  # Create and push a git tag (usage: make release VERSION=1.0.0 MESSAGE="my release message")
release:
	@if [ -z "$(VERSION)" ]; then \
		echo "Error: VERSION is required. Usage: make release VERSION=1.0.0 MESSAGE=\"my release message\""; \
		exit 1; \
	fi; \
	if [ -z "$(MESSAGE)" ]; then \
		echo "Error: MESSAGE is required. Usage: make release VERSION=1.0.0 MESSAGE=\"my release message\""; \
		exit 1; \
	fi; \
	if git rev-parse "$(VERSION)" >/dev/null 2>&1; then \
		echo "Error: Tag $(VERSION) already exists"; \
		exit 1; \
	fi; \
	echo "Updating Chart.yaml version to $(VERSION)..."; \
	sed -i "s/^version: .*/version: $(VERSION)/" Chart.yaml && \
	git add Chart.yaml && \
	git commit -m "chore: Bump version to $(VERSION)" && \
	git tag -a "$(VERSION)" -m "$(MESSAGE)" && \
	git push origin main && \
	git push origin "$(VERSION)" && \
	echo "Chart version updated, tag $(VERSION) created and pushed successfully"
