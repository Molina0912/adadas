---
description: Verify code before delivery using zero-errors checklist
agent: build
---

Before delivering any code, perform a comprehensive verification using the ZERO ERRORS checklist.

## VERIFICATION CHECKLIST

Run through each item and verify:

### 1. Problem Understanding
- [ ] Can you explain the problem in 1-2 sentences?
- [ ] Are all inputs and outputs identified?
- [ ] Have edge cases been considered?

### 2. Code Quality
- [ ] Are variable names descriptive (no single letters)?
- [ ] Are there meaningful comments where needed?
- [ ] Are types strictly defined?
- [ ] Is error handling explicit and complete?

### 3. Edge Cases
- [ ] Empty inputs handled?
- [ ] Null/undefined handled?
- [ ] Boundary conditions handled?
- [ ] Invalid inputs handled gracefully?

### 4. Security
- [ ] No SQL injection vulnerabilities?
- [ ] No XSS vulnerabilities?
- [ ] No hardcoded credentials?
- [ ] User inputs validated and sanitized?

### 5. Testing
- [ ] Are there unit tests for this code?
- [ ] Do tests cover happy path?
- [ ] Do tests cover edge cases?
- [ ] Do tests cover error cases?
- [ ] Are there at least 3 tests per function?

### 6. Dependencies
- [ ] Are all dependencies necessary?
- [ ] Are versions specified?
- [ ] Are there security vulnerabilities in dependencies?

### 7. Documentation
- [ ] Is the code self-documenting?
- [ ] Are there necessary comments?
- [ ] Is usage example provided?

## OUTPUT FORMAT

After verification, respond with:

```json
{
  “status”: “PASS|FAIL|WARNING”,
  “checks_passed”: [list of passed checks],
  “checks_failed”: [list of failed checks],
  “action_required”: “specific action to fix failures”,
  “summary”: “brief summary of verification result”
}
```

If any check fails, DO NOT deliver the code. Fix the issues first.