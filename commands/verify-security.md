---
description: Run security audit and OWASP vulnerability scan
agent: build
model: opencode/claude-sonnet-5
---

Perform a comprehensive security audit on the codebase. Check for:

1. **OWASP Top 10 Vulnerabilities:**
   - SQL Injection (parameterized queries?)
   - XSS (input sanitization, output encoding)
   - Broken Authentication (session handling, password storage)
   - Sensitive Data Exposure (secrets in code, logging)
   - XML External Entities (if parsing XML)

2. **Code Quality Security Issues:**
   - Hardcoded credentials or API keys
   - Insecure random number generation
   - Unsafe deserialization
   - Using eval() or similar dangerous functions
   - Insecure file operations

3. **Dependency Vulnerabilities:**
   - Run `npm audit` or `yarn audit` or `bun pm audit`
   - Check for known CVEs in dependencies
   - Verify package versions are up to date

4. **Configuration Issues:**
   - CORS settings
   - Rate limiting
   - Security headers
   - Environment variable handling

Report findings in this format:
```json
{
  “severity”: “CRITICAL|HIGH|MEDIUM|LOW”,
  “type”: “vulnerability type”,
  “location”: “file:line”,
  “description”: “what the issue is”,
  “recommendation”: “how to fix it”
}
```

Sort by severity (CRITICAL first) and provide specific fix recommendations.