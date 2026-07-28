# Repository Ruleset Templates

These JSON files are reviewable templates for GitHub repository rulesets.

| Template | Purpose |
|---|---|
| `default_branch_pull_request_governance.json` | Protects the default branch from deletion, force push and direct update; requires pull requests and linear history |
| `participant_review_branch_governance.json` | Protects the participant review branch and requires reviewed pull requests |
| `semantic_version_tag_protection.json` | Prevents deletion or rewriting of `v*` release tags |

## Important

Storing a JSON ruleset in the repository does not activate it automatically. A repository administrator must import or recreate it through:

```text
Settings → Rules → Rulesets
```

The default branch is already configured to reject direct updates and require status checks. Participant submissions are additionally checked by `.github/workflows/participant-submission-governance.yml`.

Activation guidance: [`../../docs/governance/GITHUB_PROTECTION_IMPLEMENTATION_GUIDE_BN.md`](../../docs/governance/GITHUB_PROTECTION_IMPLEMENTATION_GUIDE_BN.md)
