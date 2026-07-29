# Contributing to BD HR Analytics

Thank you for contributing to the synthetic KAS Ltd. HR Business Partnership and Analytics project.

This repository accepts documentation improvements, analytical corrections, security improvements and original participant solutions that follow the project’s governance and responsible-use requirements.

## Contribution Principles

All contributions must:

- use only synthetic or properly authorised data;
- preserve canonical raw files;
- document transformations and assumptions;
- remain reproducible;
- avoid unsupported causal claims;
- protect privacy, credentials and confidential information;
- retain accountable human review for employment-related decisions;
- follow the branch and pull-request workflow.

## Contribution Types

### Core repository contributions

Examples include:

- documentation corrections;
- data-dictionary improvements;
- validation enhancements;
- SQL, Python or workflow fixes;
- accessibility improvements;
- security hardening;
- reproducibility improvements.

Core repository contributions should use a focused branch and open a pull request against `main`.

### Participant solutions

Participant solutions must use:

```text
submission/<github-username>/<challenge-id>
```

Store work under:

```text
participant-submissions/solutions/<github-username>/<challenge-id>/
```

Open the pull request against:

```text
participant-review
```

Participant solutions must not target `main` directly.

## Required Participant Structure

```text
participant-submissions/solutions/<github-username>/<challenge-id>/
├── README.md
├── src/
├── outputs/
├── screenshots/
└── validation/
```

Only folders containing relevant work are required.

## Before Opening a Pull Request

1. Review `CODE_OF_CONDUCT.md`.
2. Review `docs/ETHICS_AND_LIMITATIONS.md`.
3. Review `docs/PARTICIPANT_SUBMISSION_GOVERNANCE.md` when submitting a participant solution.
4. Confirm that no real employee data, secrets or private URLs are included.
5. Keep notebook outputs and execution counts cleared where required by repository policy.
6. Validate repository files locally when applicable:

```bash
python scripts/security/validate_repository.py
```

7. Use repository-relative paths.
8. Remove temporary files, caches and duplicate archives.
9. Document limitations and unresolved issues.

## Pull Request Requirements

A pull request should explain:

- what changed;
- why the change is necessary;
- affected files or workstreams;
- validation performed;
- assumptions and limitations;
- security, privacy or ethical implications;
- rollback considerations when relevant.

Use the repository pull-request template and keep each pull request focused.

## Data Rules

Contributors must not silently modify canonical raw data.

When a source-data issue is identified:

1. document the issue;
2. preserve the original file;
3. place corrected or derived output in an appropriate processed or contributor-controlled location;
4. explain the transformation;
5. submit evidence for maintainer review.

## Binary Files

Large `.xlsx`, `.pbix` or similar files may require additional review.

When submitting a large binary file, include:

- screenshots;
- build notes;
- source-data paths;
- refresh instructions;
- a smaller specification or export where practical.

The maintainer may request that large assets be published through GitHub Releases rather than committed directly.

## Review Outcomes

A contribution may be:

- accepted;
- accepted with documented limitations;
- returned for revision;
- selected as a showcase contribution;
- declined for quality, scope, security, licensing or ethical reasons.

## Licence and Attribution

By contributing, you agree that accepted code may be distributed under the repository’s MIT licence and accepted synthetic data or documentation may be distributed under the stated project licence terms.

Always attribute third-party material and confirm that it may legally be redistributed.

## Maintainer Authority

The maintainer may request changes, reorganise accepted files, reject oversized or unsafe content, remove exposed secrets or personal data, close abandoned submissions and withdraw content when a later security, licensing or ethical concern is identified.
