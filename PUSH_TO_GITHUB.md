# Push this folder to GitHub (without deleting the original monorepo)

**Target repo:** https://github.com/kmtaiwo/kmtaiwo-social-media-conflict-detector

## One-time setup

1. **Clone** your empty or existing repo (or create it on GitHub first):

   ```bash
   cd %USERPROFILE%\Documents\projects
   git clone https://github.com/kmtaiwo/kmtaiwo-social-media-conflict-detector.git
   ```

2. **Copy** the contents of this folder into the clone (overwrite if updating):

   ```text
   Source:  Social-Sphere-Project/submissions/team-members/kola-taiwo/kmtaiwo-social-media-conflict-detector/
   Dest:    your clone of kmtaiwo-social-media-conflict-detector/
   ```

   On Windows PowerShell (from the monorepo root), for example:

   ```powershell
   robocopy "submissions\team-members\kola-taiwo\kmtaiwo-social-media-conflict-detector" "$env:USERPROFILE\Documents\projects\kmtaiwo-social-media-conflict-detector" /E /XD .venv .git
   ```

   Then `cd` into the clone and **keep** the `.git` folder from the clone.

3. **Commit and push**

   ```bash
   cd kmtaiwo-social-media-conflict-detector
   git add -A
   git status
   git commit -m "Add conflict binary classification notebook and project layout"
   git push -u origin main
   ```

   Use `master` instead of `main` if that is your default branch.

## What stays untouched

- The **Social-Sphere-Project** repository and all files under `submissions/team-members/kola-taiwo/` **outside** this `kmtaiwo-social-media-conflict-detector/` package remain as-is.
- This is a **copy** for the standalone public (or private) repo.
