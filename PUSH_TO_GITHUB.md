# Push this package to GitHub

**Target repo:** https://github.com/kmtaiwo/kmtaiwo-social-media-conflict-detector

---

## Why nothing appeared on GitHub before

1. **The copy step never ran.** The docs said to use `robocopy`, but pasting lines like `Source:` / `Dest:` into PowerShell runs them as **commands** and they **fail** — so the notebook and other files never reached your clone.

2. **`git status` was clean** because the clone still only had GitHub’s initial `README.md` — **no new files** were added, so there was **nothing to commit**.

3. **Typos:** `it push` is not `git push` (PowerShell may treat `it` oddly). Always type **`git`** explicitly.

4. **Wrong `cd` in PowerShell:** Use `$env:USERPROFILE\Documents\projects`, **not** `%USERPROFILE%\...` (that is **cmd.exe** syntax).

---

## Option A — One script (recommended)

From **PowerShell**, run this **once** after adjusting `$CloneDir` if your clone lives elsewhere:

```powershell
# Path to THIS standalone package (folder containing notebooks/, README.md, etc.)
$Package = "C:\Users\kola_\Documents\projects\Social-Sphere-Project\submissions\team-members\kola-taiwo\kmtaiwo-social-media-conflict-detector"

# Path to your LOCAL clone of kmtaiwo-social-media-conflict-detector (must contain .git)
$CloneDir = "C:\Users\kola_\Documents\projects\Social-Sphere-Project\kmtaiwo-social-media-conflict-detector"

robocopy $Package $CloneDir /E /XD ".venv" "venv" "__pycache__" ".ipynb_checkpoints" /NFL /NDL /NJH /NJS
# Exit codes 0–7 = success for robocopy

Set-Location $CloneDir
git add -A
git status
git commit -m "Sync standalone conflict-detector package"
git push -u origin main
```

If `git commit` says “nothing to commit”, the copy did not update files — check `$Package` and `$CloneDir` paths.

---

## Option B — Manual steps

1. **Clone** (if you do not have a local clone yet):

   ```powershell
   Set-Location $env:USERPROFILE\Documents\projects
   git clone https://github.com/kmtaiwo/kmtaiwo-social-media-conflict-detector.git
   ```

2. **Copy** the package into the clone using **robocopy** (not by pasting “Source:” text):

   ```powershell
   $src = "...\Social-Sphere-Project\submissions\team-members\kola-taiwo\kmtaiwo-social-media-conflict-detector"
   $dst = "...\kmtaiwo-social-media-conflict-detector"
   robocopy $src $dst /E /XD ".venv" "venv" "__pycache__" ".ipynb_checkpoints"
   ```

3. **Commit and push:**

   ```powershell
   Set-Location $dst
   git add -A
   git commit -m "Add conflict classifier notebook and project layout"
   git push -u origin main
   ```

---

## What stays untouched

The **Social-Sphere-Project** monorepo is **not** deleted or replaced. This flow only **copies** into your GitHub clone.

---

## Verify on GitHub

After a successful `git push`, open:

https://github.com/kmtaiwo/kmtaiwo-social-media-conflict-detector

You should see **`notebooks/`**, **`requirements.txt`**, **`.gitignore`**, and the updated **`README.md`**.
