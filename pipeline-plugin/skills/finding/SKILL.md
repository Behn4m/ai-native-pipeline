---
description: Record a design finding (gap, contradiction or wrong assumption) and stop work. Use whenever the system design is missing something, contradicts itself or is wrong, instead of coding around it. Usable at any step in any repo.
---

Never work around a design problem. Record it and stop.

1. Pick the next free ID from `.pipeline/findings/` (F-001, F-002, ...).
2. Fill `.pipeline/findings/F-xxx.md` from `${CLAUDE_PLUGIN_ROOT}/templates/finding.md`: the IDs involved, evidence, impact, options and one recommendation. Leave Decision empty.
3. Stop the current step. Do not edit code or docs further for this work item.
4. Tell the human: the finding ID, one-line summary, and that a decision is needed. The decision goes to the design session as a design change; this repo resumes at step 3 after the design branch is updated.
