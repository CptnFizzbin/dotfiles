---
featureTickets:
  - XXXXXXX: "Description of the feature ticket"
date: "[Creation date]"
lastUpdated: "[Date]"
status: "[Draft | In Progress | Complete]"
authors:
  - "Developer 1 [domain] (eg. Stephen Wilson [swilson2])"
  - "Copilot"
---

# Design Document: [Feature Title]

## Dependency Tree

```
╔═ PREREQUISITES
║  └─── [001] Directly prerequisite feature
║       └─── Item in prerequisite feature that's needed              | (U-05)
║
╠═ [002] Feature title
║  ├─── User story that is part of the feature                       | (U-01)
║  ├─C─ User story that is part of the critical path                 | (U-02)
║  ├─▶─ In Progress user story                                       | (U-03)
║  ├─✓─ Completed user story                                         | (U-04)
║  ├─── User story that is a blocker for 1 or more tickets           | (U-05)
║  │    └─── Subtask blocked by the above user story                 | (U-06)
║  │         ├─── Tickets further blocked by the above subtask       | (U-07)
║  │         └─── Another example                                    | (U-08)
║  └─C─ Ticket that logically follows the above work                 | (U-09)
║       └─C─ Subtask that is part of the above ticket                | (U-10)
║            └─C─ Another subtask that is part of the above ticket   | (U-11)
║
╚═ DEPENDENTS
   └─── [003] Feature that depends on this one
```
---

## Feature Overview

Describe the problem or pain point that this feature addresses. Explain why this matters and what impact it has on the
system or users.

- Bullet point 1
- Bullet point 2
- Bullet point 3

### Goals

List the primary goals this feature should accomplish.

1. Goal 1
2. Goal 2
3. Goal 3

### Implementation Progress

> **Last Updated:** [Date]

- [VE:XXXXXXX][]: ✓ Completed item 1
- [VE:XXXXXXX][]: ✓ Completed item 2
- [VE:XXXXXXX][]: ▶️ In progress item 1
- [VE:XXXXXXX][]: ▶️ In progress item 2
- [VE:XXXXXXX][]: X Pending item 1 (reason/impact)
- [VE:XXXXXXX][]: X Pending item 2 (reason/impact)

---

## Implementation Details

### 1. Subfeature Component A

**Requirements:**

- Requirement 1
- Requirement 2
- Requirement 3

**Implementation Status:** ✓ Complete | ▶️ In Progress | X Pending

**What's Missing:**

- X Item not yet done
- X Another item pending

### 2. Subfeature Component B

**Requirements:**

- Requirement 1
- Requirement 2

**Implementation Status:** ✓ Complete | ▶️ In Progress | X Pending

**What's Missing:**

- X Item not yet done

---

## References

- [Link to related ticket or documentation]
- [Link to external documentation]
- [Link to related ADR or design document]

[VE:XXXXXXX]: https://internal.almoctane.com/ui/entity-navigation?p=58001/2001&entityType=work_item&id=XXXXXXX

