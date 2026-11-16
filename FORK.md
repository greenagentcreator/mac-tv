# This repository is a fork

Upstream (original Mac TV): https://github.com/Arunprakaash/mac-tv

This fork ships a small set of extras while they are proposed upstream as **one pull request per feature**. It is not the official project.

## Currently included

- **Steam Top Shelf heroes** — full-bleed store / library art behind a focused Steam game ([upstream PR](https://github.com/Arunprakaash/mac-tv/pull/18))
- **Pairing at launch** — opt out of the startup QR sheet; opening Settings no longer forces pairing ([upstream PR](https://github.com/Arunprakaash/mac-tv/pull/19))
- **Dev builds outside iCloud** — if the repo lives under Documents, `./build.sh` writes the app to `~/Library/Developer/MacTV/` so Accessibility survives rebuilds (fork-only for now; no upstream PR)

## How changes move

1. Feature branch from current `upstream/main`
2. Merge into this fork’s `main` when ready to use
3. Open / keep a focused PR to upstream (skip for fork-only fixes)
4. When upstream accepts, sync `upstream/main` back into this `main`

Independent features may have several upstream PRs open at once. Dependent features wait for their base to land (or declare the dependency in the PR).
