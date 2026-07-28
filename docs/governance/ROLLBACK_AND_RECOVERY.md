# Rollback and Recovery Procedure

## Ruleset Blocks a Required Operation

1. Open **Settings → Rules → Rulesets**.
2. Identify the rule and target reference causing the block.
3. Change enforcement to `Disabled` only when recovery is genuinely required.
4. Record the affected operation and reason.
5. Correct the reference pattern, bypass actor or required-check name.
6. Test the revised configuration on a temporary branch.
7. Restore enforcement to `Active` after validation.

Disable and review a ruleset before deleting it.

## Participant Submission Targets `main`

Do not merge it.

1. Ask the contributor to change the base branch to `participant-review`.
2. Confirm all changed files remain inside the participant solution folder.
3. Re-run participant governance and security checks.
4. Review the solution on `participant-review`.
5. Use a separate maintainer-controlled pull request for any approved promotion to `main`.

## Incorrect Version Tag

Do not rewrite a protected published tag casually.

1. Mark the incorrect release as superseded.
2. Correct the project content.
3. publish a new semantic version.
4. document the correction in `CHANGELOG.md` and release notes.

## Default Branch Recovery

- Identify the last valid commit from repository history.
- Create a recovery branch from that commit.
- Reapply or revert changes through a pull request.
- Run all required checks.
- Avoid force pushing over shared history.

## Exposed Secret or Personal Data

1. Revoke or rotate the credential immediately.
2. Remove public access to the affected material where possible.
3. Follow the security reporting process.
4. Review Git history and release assets.
5. Document remediation without reproducing the secret or personal data.
