# Claude Code Guidelines for Plone Helm Chart

## Code Style
- Write short and comprehensible Helm templates
- Keep templates readable and well-structured
- Use clear naming conventions for variables and helpers

## Testing Requirements
- Write tests for all new functionality
- Tests should be placed in the `tests/` directory
- Follow the existing `helm unittest` format (see existing `*_test.yaml` files)
- Run tests with `helm unittest .` or via `make test`
