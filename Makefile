.PHONY: help  # List phony targets
help:
	@cat "Makefile" | grep '^.PHONY:' | sed -e "s/^.PHONY:/- make/"

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
	git tag -a "$(VERSION)" -m "$(MESSAGE)" && \
	git push origin "$(VERSION)" && \
	echo "Tag $(VERSION) created and pushed successfully"
