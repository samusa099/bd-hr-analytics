# Participant Submission Governance

<p align="center">
  <strong>Professional rules for contributing reproducible solutions to the synthetic KAS Ltd. analytics case.</strong>
</p>

> Participant work is treated as an analytical proposal. It is not an official company decision, employment assessment or production-ready system.

---

## 1. Submission Destination

Participant solutions must be stored under:

```text
participant-submissions/solutions/<github-username>/<challenge-id>/
```

Participant pull requests must target:

```text
participant-review
```

They must **not** target `main` directly.

Accepted work may be promoted to `main` only through a separate maintainer-controlled pull request after review, validation and security checks.

---

## 2. Contribution Workflow

1. Read [`CASE_STUDY.md`](CASE_STUDY.md), [`KAS_LTD_INTEGRATED_CHALLENGE_BRIEF.md`](KAS_LTD_INTEGRATED_CHALLENGE_BRIEF.md) and [`ETHICS_AND_LIMITATIONS.md`](ETHICS_AND_LIMITATIONS.md).
2. Open a **Participant Solution Proposal** issue.
3. Fork the repository.
4. Create a branch:

```text
submission/<github-username>/<challenge-id>
```

5. Work only inside:

```text
participant-submissions/solutions/<github-username>/<challenge-id>/
```

6. Run local validation.
7. Open a pull request using:

```text
[Participant Solution] <challenge-id> — <github-username>
```

8. Set the base branch to `participant-review`.
9. Respond to review comments.
10. Do not merge the pull request yourself.

---

## 3. Required Evidence

Every submission must contain a `README.md` explaining:

- challenge interpretation;
- selected scope;
- source files;
- tools and method;
- transformations;
- assumptions;
- findings;
- management implications;
- limitations;
- ethics statement;
- reproduction steps.

Technical outputs must include at least one validation artefact, such as:

- data-quality summary;
- query reconciliation;
- formula check;
- refresh log;
- screenshot;
- model diagram.

---

## 4. Canonical Data Protection

Participants must not modify canonical raw files.

Derived files belong inside the participant’s own solution folder. A suspected error in canonical data must be raised through a focused issue with evidence. Silent correction is not acceptable.

---

## 5. Permitted Content

- original analysis and code;
- synthetic derived data;
- documented cleaning rules;
- SQL and Python files;
- genuine Excel and Power BI work;
- Looker Studio specifications;
- dashboard screenshots;
- model diagrams;
- management recommendations;
- alternative KPI definitions with justification.

---

## 6. Prohibited Content

- real employee, employer or buyer data;
- names, contact details or identifiers belonging to real people;
- passwords, tokens, private certificates or private URLs;
- copied work without attribution;
- executable or macro content without prior review;
- automated hiring, termination, promotion or disciplinary decisions;
- modification of canonical raw data;
- claims that KAS Ltd., XYZ Export Processing Zone or its fictional awards are real;
- claims that simulated outcomes establish causality;
- virtual environments, caches, temporary exports or unrelated files.

---

## 7. Binary File Policy

Large `.pbix` and `.xlsx` files may be accepted only when accompanied by:

- a high-resolution screenshot;
- a build note;
- source-data paths;
- refresh instructions;
- a smaller export or specification where practical.

The maintainer may request that a large binary be attached to a release rather than committed directly.

---

## 8. Review Outcomes

- **Accepted:** complete and suitable for the participant review branch.
- **Accepted with limitations:** useful with documented constraints.
- **Revision required:** correctable gaps remain.
- **Showcase candidate:** particularly clear, reusable or original.
- **Declined:** material quality, security, ethics, licensing or originality issue.

Acceptance into `participant-review` does not automatically authorise promotion to `main`.

---

## 9. Maintainer Authority

The maintainer may:

- request changes;
- decline oversized or unsafe files;
- close abandoned submissions;
- remove exposed secrets or personal data immediately;
- reorganise accepted files for repository consistency;
- withdraw a contribution if a later security, licensing or ethical issue is identified.

---

## 10. Pull Request Checklist

```markdown
- [ ] I used only synthetic project data.
- [ ] I did not modify canonical raw files.
- [ ] My work is inside my participant solution folder.
- [ ] My pull request targets `participant-review`, not `main`.
- [ ] I documented transformations and assumptions.
- [ ] I included reproduction steps and validation evidence.
- [ ] I removed secrets, personal data and absolute local paths.
- [ ] I did not automate employment decisions.
- [ ] I did not present correlation as proven causation.
- [ ] I accept maintainer review and revision requests.
```
