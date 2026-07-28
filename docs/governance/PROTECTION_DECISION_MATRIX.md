# Repository Protection Decision Matrix

| Protection Control | Status | Rationale |
|---|---|---|
| Prevent deletion of `main` | Required | Protect the authoritative default branch |
| Block force pushes to `main` | Required | Preserve reviewable and recoverable history |
| Require pull requests for `main` | Required | Prevent uncontrolled direct updates |
| Require status checks | Required | Ensure security and repository validation pass before merge |
| Require linear history | Recommended | Simplify audit, rollback and release review |
| Require external approval | Not required for current single-maintainer model | Avoid an approval deadlock while retaining automated checks and review-thread resolution |
| Require code-owner review | Optional | Enable when an independent reviewer is available |
| Protect `participant-review` | Required before public submissions | Prevent deletion, force push and uncontrolled acceptance |
| Reject participant PRs targeting `main` | Required | Separate learning submissions from the authoritative project |
| Protect `v*` tags | Required for formal releases | Prevent published release references from being rewritten |
| Protect every feature branch | Not required | Contributors may need to update or rebase their own branches |
| Store multiple historical ZIP files | Prohibited | Use a single current release asset and GitHub Releases |

## Operating Principle

Participant acceptance and core-project publication are separate decisions:

```text
Participant PR → participant-review → review outcome
                                      ↓
                     separate maintainer-controlled PR
                                      ↓
                                    main
```

No participant submission should be promoted to `main` solely because it passed technical checks.
