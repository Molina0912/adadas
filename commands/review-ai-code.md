---
description: Code review specifically for AI-generated code, checking for LLM-specific code smells, prompt logic, bias risks, and duplication issues
agent: build
---

Perform a comprehensive code review specifically designed for AI-generated code.

## REVIEW CONTEXT

AI-generated code has different failure modes than human-written code:
- **+15% duplication** compared to human code
- **+8% cyclomatic complexity** compared to human code
- Tendency to replicate "bad smells" from training data
- New class of "AI-specific bad smells"

## REVIEW CHECKLIST FOR AI-GENERATED CODE

### 1. FUNCTIONAL CORRECTNESS
- [ ] Does the code solve the stated problem exactly?
- [ ] Are all edge cases handled?
- [ ] Are inputs validated?
- [ ] Are errors handled properly?
- [ ] No regression in existing functionality?

### 2. AI-SPECIFIC QUALITY ISSUES
- [ ] **Duplication**: Is there code that's duplicated (15% more likely in LLM code)?
- [ ] **Complexity**: Is the cyclomatic complexity reasonable (8% higher in LLM code)?
- [ ] **Context Awareness**: Does code fit the broader problem context?
- [ ] **Assumptions**: Are there unstated assumptions that could fail?

### 3. PROMPT/LOGIC ROBUSTNESS
- [ ] If prompt-related: Is the prompt logic clear and maintainable?
- [ ] If inference-related: Does the inference pipeline match training pipeline?
- [ ] Feedback handling: How does the AI handle correction feedback?
- [ ] Bias risk: Could the code introduce or amplify bias?

### 4. SECURITY (OWASP Top 10)
- [ ] SQL Injection protection (parameterized queries)
- [ ] XSS protection (input sanitization, output encoding)
- [ ] No hardcoded secrets or credentials
- [ ] Authentication/Authorization correctly implemented
- [ ] Data sanitization in place

### 5. CODE QUALITY
- [ ] Descriptive variable/function names (no single letters)
- [ ] Strict type usage (no `any`滥用)
- [ ] DRY principle followed (watch for LLM duplication)
- [ ] Single responsibility per function/module
- [ ] MAX 30 lines per function respected
- [ ] MAX 150 lines per file respected

### 6. ARCHITECTURE FOR AI SYSTEMS
- [ ] Desacoplamiento: Are components loosely coupled?
- [ ] Abstracción: Are interfaces stable and well-defined?
- [ ] If ML code: Training pipeline = Inference pipeline?
- [ ] If ML code: Input features registered and consistent?

### 7. TESTING
- [ ] Unit tests present and maintainable
- [ ] Tests cover edge cases
- [ ] Tests cover error cases
- [ ] Coverage adequate (80%+)

### 8. DEPENDENCIES
- [ ] All dependencies necessary?
- [ ] Versions specified?
- [ ] Security vulnerabilities checked (`npm audit`, `bandit`)?

## OUTPUT FORMAT

Report findings as structured JSON:

```json
{
  "status": "APPROVED|CHANGES_REQUESTED|BLOCKED",
  "ai_specific_issues": [
    {
      "type": "DUPLICATION|COMPLEXITY|BIAS|ASSUMPTION",
      "severity": "CRITICAL|HIGH|MEDIUM|LOW",
      "location": "file:line",
      "description": "what the issue is",
      "llm_impact": "why this is particularly important for AI-generated code",
      "suggestion": "how to fix"
    }
  ],
  "standard_issues": [
    {
      "severity": "CRITICAL|HIGH|MEDIUM|LOW",
      "file": "path/to/file",
      "line": "line number",
      "issue": "description",
      "suggestion": "how to fix"
    }
  ],
  "ml_ops_checks": {
    "pipeline_consistency": "PASS|FAIL|N/A",
    "feature_registration": "PASS|FAIL|N/A",
    "reproducibility": "PASS|FAIL|N/A"
  },
  "summary": "overall assessment",
  "recommendations": ["suggested improvements"]
}
```

## PRIORITY ORDER

1. **CRITICAL issues** - Security vulnerabilities, hardcoded secrets
2. **AI-specific issues** - Duplication, complexity, bias risks
3. **Architecture issues** - Coupling, abstraction violations
4. **Standard quality issues** - Style, naming, testing

If any CRITICAL issue exists, status must be BLOCKED. If AI-specific issues exist, recommend thorough refactoring before approval.

---

**References:**
- LLM-generated code shows +15% duplication and +8% complexity
- AI-specific "bad smells" are an emerging research area
- Training-production parity is critical for ML systems