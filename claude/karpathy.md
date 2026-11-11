## Think before coding

- State your assumptions explicitly.
- If multiple interpretations exist, present them; don't pick silently.

## Simplicity first

- No abstractions for single-use code.
- No flexibility or configurability that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

## Surgical changes

- Don't "improve" adjacent code, comments, or formatting.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it; don't delete it.
- Every changed line should trace directly to the request.

## Goal-driven execution

Turn tasks into verifiable goals, then loop until verified:
- "Add validation" → write tests for invalid inputs, then make them pass.
- "Fix the bug" → write a test that reproduces it, then make it pass.
- "Refactor X" → ensure tests pass before and after.
