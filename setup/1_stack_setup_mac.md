# 1 — Mac Setup

## What you need
- Mac (Intel or Apple Silicon)
- 10 GB free disk space
- Internet connection

---

## Step 1 — Git

```bash
git --version
```

Already installed → move to Step 2.

Not installed → a popup appears, click **Install**, wait, then re-run `git --version`.

**Checkpoint:** `git version 2.x.x`

---

## Step 2 — Docker Desktop

```bash
docker --version
```

Already installed → confirm 🐳 whale is in your menu bar → move to Step 3.

Not installed:
1. Go to [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2. Click **Download for Mac**
   - Apple M1/M2/M3 → choose **Apple Silicon**
   - Intel → choose **Intel Chip**
3. Open the `.dmg` → drag Docker to Applications
4. Open Docker → enter password if asked
5. Wait for 🐳 whale in menu bar to stop animating
6. Re-run `docker --version`

**Checkpoint:** `Docker version 29.x.x` and 🐳 whale in menu bar

---

## Step 3 — VS Code

```bash
code --version
```

Already installed → move to Step 4.

Not installed:
1. Go to [code.visualstudio.com](https://code.visualstudio.com)
2. Click **Download for Mac**
3. Open the `.zip` → drag VS Code to Applications
4. Open VS Code → press `⌘ + Shift + P` → type `shell command` → click **Install 'code' command in PATH**
5. Close and reopen Terminal → re-run `code --version`

**Checkpoint:** `1.9x.x`

Install VS Code extensions — open VS Code, click the Extensions icon (four squares), search and install:
- **dbt Power User** by Altimate AI
- **Python** by Microsoft
- **Docker** by Microsoft
- **Remote - SSH** by Microsoft
- **Claude Code** by Anthropic

---

## Step 4 — GitHub CLI

```bash
gh --version
```

Already installed → move to Step 5.

Not installed:
```bash
brew install gh
```

**Checkpoint:** `gh version 2.x.x`

Log in to GitHub:
```bash
gh auth login
```

Choose: `GitHub.com → HTTPS → Login with a web browser` → follow the prompts.

**Checkpoint:** `✓ Logged in to github.com account yourname`

---

## Step 5 — uv

```bash
uv --version
```

Already installed → move to Step 6.

Not installed:
```bash
brew install uv
```

**Checkpoint:** `uv 0.x.x`

---

## Step 6 — dbt

```bash
cd ~
uv venv .dbt-venv
source .dbt-venv/bin/activate
uv pip install dbt-core dbt-postgres
dbt --version
```

**Checkpoint:** `Core: 1.x.x`

Make the virtual environment activate automatically on every new terminal:
```bash
echo 'source ~/.dbt-venv/bin/activate' >> ~/.zshrc
source ~/.zshrc
```

---

## Step 7 — Configure Git

```bash
git config --global init.defaultBranch main
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

---

## Done — verify all tools

```bash
git --version
docker --version
code --version
gh --version
uv --version
dbt --version
```

Continue to **2 — Project Setup** in your chosen environment repo.
