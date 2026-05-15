---
description: Run comprehensive tests with coverage and failure analysis
agent: build
model: opencode/claude-sonnet-5
---

Run the full test suite with coverage report and analyze any failures.

When tests fail:
1. Show the specific test failures with error messages
2. Identify the root cause of each failure
3. Provide specific fix suggestions for each failing test
4. If there are multiple failures, prioritize them by severity

Focus on:
- Unit tests for new functions
- Integration tests for API endpoints
- Edge cases that might have been missed
- Any security-related test failures (HIGH PRIORITY)

Run the following commands and analyze results:
```bash
# Run tests with coverage
npm test -- --coverage 2>&1 || yarn test --coverage 2>&1 || bun test --coverage 2>&1

# Show coverage report
npm test -- --coverage --report 2>&1 || yarn test --coverage --report 2>&1 || bun test --coverage --report 2>&1
```

If coverage drops below 80%, flag this as a concern and suggest specific areas needing more tests.