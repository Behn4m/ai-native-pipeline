---
subsystem: <subsystem>
design_branch: <design/project>
design_sha: <design submodule commit>
linear_project: <link>
---

# Subsystem spec: <subsystem>

What this subsystem must do, derived from the system design. Cite IDs; do not restate design content.

## Scope

- **Owns:** <CMP IDs>
- **Out of scope (owned elsewhere):** <CMP IDs and their subsystem>

## Responsibilities

| User flow step | This subsystem provides |
|---|---|
| UF-xxx step n | <behaviour> |

## Interfaces

| DF ID | Role | Notes |
|---|---|---|
| DF-xxx | produces / consumes | <what this subsystem relies on; no redefinition> |

## Constraints

- <CON IDs that apply, with how they bind this subsystem>

## Acceptance criteria

| AC ID | Verified by |
|---|---|
| AC-xxx | sim / real / both |

## Design diff impact

<What changed on the design branch vs design main and how it affects this subsystem. "None" if nothing.>
