# Dependency Tree Examples

## Standalone feature (no prerequisites, no dependents)

```
╠═ [005] Standalone feature
   ├─── User story                                                   | (U-01)
   └─── Another user story                                           | (U-02)
```

---

## Feature with prerequisites, no dependents

```
╔═ PREREQUISITES
║  └─── [001] Prerequisite feature
║       └─── Item in prerequisite feature that's needed              | (U-03)
║
╠═ [005] Current feature
   ├─── User story                                                   | (U-01)
   └─── Another user story                                           | (U-02)
```

---

## Feature with dependents, no prerequisites

```
╠═ [005] Current feature
║  ├─── User story                                                   | (U-01)
║  └─── User story that dependents need complete first               | (U-02)
║
╚═ DEPENDENTS
   ├─── [006] Dependent feature
   └─── [007] Another dependent feature
```

---

## Full example (prerequisites and dependents)

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
   ├─── [003] Feature that depends on the above feature
   │    ├─── User story that is part of the dependent feature        | (U-12)
   │    └─── Another user story in the dependent feature             | (U-13)
   └─── [004] 2nd directly dependent feature
```

---

## Legend

| Symbol             | Meaning                      |
|--------------------|------------------------------|
| `╔═ PREREQUISITES` | Prerequisites section header |
| `╠═ [NNN]`         | The current feature          |
| `╚═ DEPENDENTS`    | Dependents section header    |
| `║`                | Spine — connects sections    |
| `─C─`              | Critical path item           |
| `─▶─`              | In progress                  |
| `─✓─`              | Complete                     |
| `───`              | Pending / not started        |

