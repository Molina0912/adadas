---
description: Perform code review with security focus and zero-errors checklist
agent: build
---

Perform a comprehensive code review following the ZERO ERRORS methodology.

## REVIEW CHECKLIST

### 1. CORRECTNESS
- [ ] Does the code solve the stated problem?
- [ ] Are all edge cases handled?
- [ ] Are inputs validated?
- [ ] Are errors handled properly?

### 2. SECURITY (OWASP Top 10)
- [ ] SQL Injection protection
- [ ] XSS protection
- [ ] Authentication/Authorization correct
- [ ] No hardcoded secrets
- [ ] Data sanitization in place

### 3. CODE QUALITY
- [ ] Descriptive variable/function names
- [ ] Proper type usage (no `any`)
- [ ] Clear comments where needed
- [ ] DRY (Don't Repeat Yourself)
- [ ] SOLID principles followed

### 4. TESTING
- [ ] Unit tests present
- [ ] Tests cover edge cases
- [ ] Tests are maintainable
- [ ] Coverage is adequate (80%+)

### 5. PERFORMANCE
- [ ] No obvious bottlenecks
- [ ] Appropriate data structures
- [ ] Proper indexing (if database)

## OUTPUT FORMAT

Report findings as:

```json
{
  “status”: “APPROVED|CHANGES_REQUESTED|BLOCKED”,
  “issues”: [
    {
      “severity”: “CRITICAL|HIGH|MEDIUM|LOW”,
      “file”: “path/to/file”,
      “line”: “line number”,
      “issue”: “description”,
      “suggestion”: “how to fix”
    }
  ],
  “summary”: “overall assessment”,
  “recommendations”: [“suggested improvements”]
}
```

Provide constructive feedback with specific actionable suggestions.