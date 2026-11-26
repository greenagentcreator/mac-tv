# This repository is a fork

Upstream (original Mac TV): https://github.com/Arunprakaash/mac-tv

This fork ships a small set of extras while they are proposed upstream as **one pull request per feature**. It is not the official project.

## Currently included

- **Steam Top Shelf heroes** — full-bleed store / library art behind a focused Steam game ([upstream](https://github.com/Arunprakaash/mac-tv/pull/18), in v0.18+)
- **Pairing at launch** — opt out of the startup QR sheet; opening Settings no longer forces pairing ([upstream](https://github.com/Arunprakaash/mac-tv/pull/19), in v0.18+)
- **YouTube ad blocking** — optional “Block YouTube ads” for the built-in player (YouTube / Music only; default on) ([upstream PR](https://github.com/Arunprakaash/mac-tv/pull/20) still open)
- **Add App › Suggested** — stay/toggle On TV; Included / Suggested for you / More by region ([upstream](https://github.com/Arunprakaash/mac-tv/pull/28), in v0.21+)
- **Home layout Scroll vs Pages** — Settings › Apps › Home screen; Scroll default; Down stops at the last app ([upstream](https://github.com/Arunprakaash/mac-tv/pull/34), in v0.24)
- **Launch cover** — shared Starting overlay for built-in web, Steam, Mac apps, and external Chromium browsers ([upstream](https://github.com/Arunprakaash/mac-tv/pull/32), in v0.23+)
- **Mac app Top Shelf TileArt** — user-added Mac apps fill the Top Shelf with dock-style 5:3 art above the dock ([upstream](https://github.com/Arunprakaash/mac-tv/pull/33), in v0.23+)
- **Steam Big Picture chart reel** — Best of Year › Controller library heroes on the Top Shelf ([upstream](https://github.com/Arunprakaash/mac-tv/pull/35), in v0.24)
- **Dev builds outside iCloud** — if the repo lives under Documents, `./build.sh` writes the app to `~/Library/Developer/MacTV/` so Accessibility survives rebuilds (fork-only for now; no upstream PR)

## How changes move

1. Feature branch from current `upstream/main`
2. Merge into this fork’s `main` when ready to use
3. Open / keep a focused PR to upstream (skip for fork-only fixes)
4. When upstream accepts, sync `upstream/main` back into this `main`

Independent features may have several upstream PRs open at once. Dependent features wait for their base to land (or declare the dependency in the PR).
