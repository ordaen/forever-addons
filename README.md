# forever-addons

World of Warcraft addons for the **WoW Forever** flavor (interface `16001`).

| Addon | Description |
|---|---|
| [MinimapCompartment](addons/MinimapCompartment) | Collects minimap buttons and addon compartment entries into one drawer. |

## Development

Requirements: Git, Node.js (only for commit linting).

```powershell
npm install              # installs commitlint + the git commit-msg hook (husky)
./scripts/link.ps1       # junction every addon into the Forever AddOns folder
```

Edit the code, then `/reload` in game. Changes to a `.toc` file or new files need a client restart.
Install BugSack + BugGrabber in game to see Lua errors.

`./scripts/link.ps1 -Unlink` removes the junctions (the files in the repo are not touched).

### Commits

[Conventional Commits](https://www.conventionalcommits.org/), checked by a git hook and in CI:

```
feat(MinimapCompartment): add grow direction option
fix(MinimapCompartment): keep drawer on screen after scale change
chore(ci): cache luarocks
```

- Scope is an addon folder name, or one of `repo`, `ci`, `deps`, `scripts`, `tests`, `docs`.
- `feat` = minor bump, `fix`/`perf` = patch, `feat!:` or a `BREAKING CHANGE:` footer = major.
  While an addon is `0.x`, breaking changes bump minor instead of major.
- PRs are squash-merged, so the **PR title** is the commit that counts.
- Which addon a commit releases is decided by the files it changes, not by the scope.

### Releases

Handled by [release-please](https://github.com/googleapis/release-please):

1. Merging to `main` opens/updates a release PR with version bumps and `CHANGELOG.md` per addon.
2. Merging the release PR tags `<Addon>-vX.Y.Z` and creates a GitHub release.
3. The release workflow packages the addon with the
   [BigWigs packager](https://github.com/BigWigsMods/packager) (`scripts/package.sh`),
   uploads to CurseForge/Wago when configured, and attaches the zip to the GitHub release.

Never edit `## Version` in a `.toc` by hand; release-please owns it.

Local package build (Git Bash): `scripts/package.sh MinimapCompartment` → `.release/`.

### Adding an addon

1. Create `addons/<Name>/` with `<Name>.toc` (copy the version block markers), `.pkgmeta`, Lua files.
2. Add it to `release-please-config.json` (`packages`, with `"initial-version": "0.1.0"`) and `.release-please-manifest.json` (`"0.0.0"`).
3. Rerun `./scripts/link.ps1`.

## Repository secrets

| Secret | Needed for |
|---|---|
| `RELEASE_APP_PRIVATE_KEY` (+ variable `RELEASE_APP_CLIENT_ID`) | Org GitHub App that release-please acts as (Contents + Pull requests: read/write). |
| `CF_API_KEY` | CurseForge uploads (plus `## X-Curse-Project-ID` in the TOC). |
| `WAGO_API_TOKEN` | Wago uploads (plus `## X-Wago-ID` in the TOC). |
