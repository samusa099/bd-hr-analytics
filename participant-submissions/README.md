# Participant Submissions

<p align="center">
  <strong>A controlled workspace for original solutions to the synthetic KAS Ltd. HR analytics case.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Data-100%25%20Synthetic-F97316?style=for-the-badge" alt="Synthetic data" />
  <img src="https://img.shields.io/badge/Review-Required-2563EB?style=for-the-badge" alt="Review required" />
  <img src="https://img.shields.io/badge/Base%20Branch-participant--review-14B8A6?style=for-the-badge" alt="Participant review branch" />
  <img src="https://img.shields.io/badge/Main-Restricted-DC2626?style=for-the-badge" alt="Main restricted" />
</p>

---

## Purpose

This folder allows participants to submit data-cleaning, SQL, Excel, Power BI, Looker Studio, automation and HRBP recommendation solutions without changing the authoritative project files.

## Required Path

```text
participant-submissions/solutions/<github-username>/<challenge-id>/
```

Each solution should contain:

```text
README.md
src/
outputs/
screenshots/
validation/
```

Only folders that contain relevant work are required.

## Submission Branch

Use:

```text
submission/<github-username>/<challenge-id>
```

Open the pull request against:

```text
participant-review
```

Do not open participant submissions directly against `main`.

## Start Here

1. Read the [professional case study](../docs/CASE_STUDY.md).
2. Select a task from the [integrated challenge brief](../docs/KAS_LTD_INTEGRATED_CHALLENGE_BRIEF.md).
3. Read the [participant governance rules](../docs/PARTICIPANT_SUBMISSION_GOVERNANCE.md).
4. Copy the [solution README template](templates/SOLUTION_README_TEMPLATE.md).
5. Review the [assessment rubric](REVIEW_RUBRIC.md).
6. Submit through a pull request to `participant-review`.

## Review Boundary

Acceptance into `participant-review` means the solution is available for structured review. It does not automatically mean the work will be promoted to the protected `main` branch.
