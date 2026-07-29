# Security Policy

## Supported Scope

Security reports are accepted for the current default branch and the latest published release of BD HR Analytics.

This repository contains synthetic data, documentation, notebooks, spreadsheets, SQL, SQLite assets and automation workflows. All files should be treated as untrusted until validated.

## Reporting a Vulnerability

Do not open a public issue for:

- exposed credentials, tokens or secrets;
- private URLs or certificates;
- personal or confidential information;
- workflow-permission weaknesses;
- archive path-traversal risks;
- malicious notebook content;
- CSV formula-injection risks;
- unsafe spreadsheet content;
- dependency vulnerabilities with a credible exploit path.

Use GitHub private vulnerability reporting when available. Include:

- affected path or workflow;
- clear reproduction steps;
- expected and actual behaviour;
- potential impact;
- suggested remediation when possible;
- confirmation that no unnecessary sensitive data is included.

## Repository Security Controls

The project uses controls that may include:

- protected default-branch workflow;
- required validation and security checks;
- CodeQL analysis;
- secret scanning with Gitleaks;
- dependency review and dependency auditing;
- pinned GitHub Action references;
- least-privilege workflow permissions;
- repository path-containment checks;
- static XLSX archive validation;
- notebook structure and execution policy;
- CSV formula-injection detection;
- participant submission separation;
- human review for high-impact employment interpretations.

## Sensitive Data Policy

Do not commit:

- real employee records;
- payroll or medical records;
- national identifiers;
- private company exports;
- buyer credentials;
- passwords or API keys;
- access tokens;
- private certificates;
- confidential URLs;
- production-system secrets.

All public datasets in this project must remain synthetic or otherwise explicitly authorised for public redistribution.

## Participant Submission Security

Participant solutions must:

- target `participant-review`, not `main`;
- remain inside the approved contributor path;
- avoid executable or macro-enabled content unless specifically reviewed;
- exclude local environments, caches and temporary files;
- document external dependencies;
- include validation evidence;
- avoid automated hiring, termination, promotion, discipline or medical decisions.

## Disclosure and Response

The maintainer will review complete reports in good faith and will attempt to:

1. acknowledge the report;
2. reproduce the issue where possible;
3. assess severity and affected scope;
4. implement or document remediation;
5. publish an advisory or release note when appropriate.

Response timing depends on severity, reproducibility and maintainer availability. Public disclosure should wait until a reasonable remediation opportunity has been provided.

## Security Limitations

Automated checks reduce risk but cannot guarantee that every file is safe. Static validation does not replace manual review, secure local execution, privacy assessment or production security testing.

This portfolio is not a production HR information system and must not be deployed with real workforce data without additional legal, privacy, security and governance controls.
