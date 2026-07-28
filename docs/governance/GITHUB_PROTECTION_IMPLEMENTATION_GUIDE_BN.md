# GitHub Protection Ruleset — Implementation Guide (Bangla)

## উদ্দেশ্য

এই guide অনুসরণ করে `main`, `participant-review`, release branch, semantic-version tag এবং গুরুত্বপূর্ণ project files সুরক্ষিত করা যাবে।

---

## বর্তমান Governance Model

```text
Core project change
      ↓
Feature or documentation branch
      ↓
Pull request to main
      ↓
Required security and validation checks
      ↓
Maintainer-controlled merge

Participant solution
      ↓
submission/<username>/<challenge-id>
      ↓
Pull request to participant-review
      ↓
Participant governance and security checks
      ↓
Review and acceptance
      ↓
Separate maintainer PR for optional promotion to main
```

Participant submissions সরাসরি `main`-এ merge করা যাবে না।

---

## Ruleset Import করার ধাপ

1. Repository খুলুন।
2. **Settings** নির্বাচন করুন।
3. **Rules → Rulesets** খুলুন।
4. **New ruleset** অথবা **Import a ruleset** নির্বাচন করুন।
5. প্রয়োজন অনুযায়ী `governance/rulesets/` থেকে JSON নির্বাচন করুন।
6. Target branch বা tag pattern যাচাই করুন।
7. Enforcement `Active` আছে কিনা দেখুন।
8. Rules এবং bypass list পরীক্ষা করুন।
9. Ruleset তৈরি করুন।
10. Temporary branch এবং pull request দিয়ে আচরণ পরীক্ষা করুন।

---

## Recommended Activation Sequence

### 1. Default Branch Pull Request Governance

File:

```text
governance/rulesets/default_branch_pull_request_governance.json
```

Expected controls:

- `main` delete করা যাবে না;
- force push করা যাবে না;
- direct update গ্রহণ করা হবে না;
- pull request প্রয়োজন হবে;
- review thread resolve করতে হবে;
- squash বা rebase merge ব্যবহার করতে হবে।

### 2. Participant Review Branch Governance

File:

```text
governance/rulesets/participant_review_branch_governance.json
```

এই ruleset participant solution review branch-কে accidental deletion, force push এবং uncontrolled update থেকে রক্ষা করবে।

### 3. Semantic Version Tag Protection

File:

```text
governance/rulesets/semantic_version_tag_protection.json
```

এটি `v0.3.0`, `v1.0.0` ইত্যাদি published tag rewrite বা delete হওয়া বন্ধ করবে।

---

## Required Status Checks

`main` merge করার আগে repository-এর existing validation এবং security checks pass করতে হবে। নতুন required check যোগ করার আগে:

- check অন্তত একবার run করেছে কিনা নিশ্চিত করুন;
- GitHub UI-তে exact check name দেখুন;
- ভুল বা obsolete check name required করবেন না;
- workflow rename করলে ruleset-ও update করুন।

Participant submissions-এর জন্য workflow check:

```text
Participant submission target policy
```

এই check নিশ্চিত করে যে participant solution `main` নয়, `participant-review` target করছে।

---

## Critical File Ownership

`.github/CODEOWNERS` গুরুত্বপূর্ণ path-এর reviewer হিসেবে `@samusa099` নির্ধারণ করে।

Code-owner approval enforce করার আগে single-maintainer limitation বিবেচনা করুন। এমন rule enable করবেন না যাতে maintainer নিজের repository-তে প্রয়োজনীয় recovery change merge করতে না পারেন।

---

## Repository Settings Checklist

### General

- Default branch: `main`
- Squash merge: Enabled
- Rebase merge: Optional
- Merge commits: Disable করা উত্তম যখন linear history required
- Automatically delete head branches: Enabled

### Actions

- Default permissions: read-only যেখানে সম্ভব
- Write permission: কেবল প্রয়োজনীয় workflow-তে
- Third-party Actions: full commit SHA-তে pinned
- Secrets: workflow log-এ print করা নিষিদ্ধ

### Security

- Dependabot alerts: Enabled
- Secret scanning: Enabled যেখানে available
- Private vulnerability reporting: Enabled যেখানে available
- `SECURITY.md`: repository root-এ রাখা

### Releases and Tags

- Tag format: `vMAJOR.MINOR.PATCH`
- Published tag rewrite করবেন না
- একটিমাত্র current unified release asset রাখুন
- duplicate historical ZIP repository-তে রাখবেন না

---

## Recovery Procedure

Ruleset ভুল configuration-এর কারণে কাজ block হলে:

1. **Settings → Rules → Rulesets** খুলুন।
2. সংশ্লিষ্ট ruleset নির্বাচন করুন।
3. Enforcement সাময়িকভাবে `Disabled` করুন।
4. ভুল pattern, bypass actor বা status-check name ঠিক করুন।
5. Temporary branch দিয়ে পরীক্ষা করুন।
6. Validation সফল হলে পুনরায় `Active` করুন।

Ruleset সরাসরি delete করার আগে disable ও review করা নিরাপদ।

---

## Final Baseline

```text
Default branch protection      → Active
Required status checks         → Active
Participant target workflow    → Active
Participant review protection  → Import and activate
Semantic version tag protection→ Import and activate
Direct participant PR to main  → Prohibited
```
