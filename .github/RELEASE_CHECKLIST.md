# ✅ Release Checklist

Use this checklist before publishing a GitHub release or updating the Kaggle dataset.

## Version and documentation

- [ ] `VERSION` contains the intended release tag.
- [ ] `CHANGELOG.md` includes the new version.
- [ ] `RELEASE_NOTES.md` matches the release contents.
- [ ] README links are valid.
- [ ] Project usage, ethics and promotion guides are updated.

## Data and files

- [ ] All core datasets are available in `data/csv/`.
- [ ] CSV files open as UTF-8 and have stable headers.
- [ ] No real employee or confidential company data is included.
- [ ] Excel workbook opens without repair warnings.
- [ ] Notebooks and SQL paths are valid.
- [ ] Dashboard images are readable at normal zoom.

## Power BI

- [ ] Data model follows the documented star schema.
- [ ] DAX measures are validated against source data.
- [ ] All six report pages are reviewed.
- [ ] Synthetic-data labels are visible.
- [ ] Employee-risk outputs require human review.
- [ ] Final `.pbix` file uses the approved filename.

## Packaging

- [ ] The ZIP contains only the clean project structure.
- [ ] The ZIP extracts into one top-level project folder.
- [ ] No duplicate historical release ZIPs are stored under `releases/`.
- [ ] The final asset is named `bd-hr-analytics-unified-project.zip`.
- [ ] The ZIP is attached to the GitHub Release.

## GitHub release

- [ ] Tag: `v0.3.0`
- [ ] Target branch: `main`
- [ ] Release title: `Bangladesh SME HR Strategy Transformation v0.3.0`
- [ ] Set as latest release.
- [ ] Do not mark as pre-release.
- [ ] Paste the approved release notes.
- [ ] Attach the unified project ZIP.

## Kaggle publication

- [ ] Use the same unified project package.
- [ ] Confirm `metadata/dataset-metadata.json` is valid.
- [ ] Mark the dataset as synthetic.
- [ ] Include the ethics and limitations statement.
- [ ] Verify CSV previews and column descriptions.

## Final approval

| Approval area | Owner | Status |
|---|---|---|
| Data validation | Musa | Pending final check |
| Dashboard QA | Musa | Pending native Power BI build |
| Ethics review | Musa | Ready for review |
| Documentation | Musa | Complete |
| Release packaging | Musa | Ready |
