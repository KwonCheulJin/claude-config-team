# claude-config-team

[한국어](README.md) | **English**

Team-shared Claude Code configuration. A curated subset of a personal claude-config, containing only the skills with the highest real-world usage frequency.

## What's included

### Skills (skills/)

The core development workflow: plan → implement → verify → review → commit.

| Skill | Trigger | Description |
|------|--------|------|
| `global-plan` | `/plan`, "design doc", "implementation plan" | Writes an architecture design document before implementation. Saved to `.claude/plans/`, then waits for user approval before coding |
| `global-implement` | `/implement`, "start implementation" | Step-by-step implementation based on the design document. Delegates to architect / generator / logic-expert / ui-publisher agents by task type, with an evaluator self-verification loop |
| `global-check` | `/check`, "typecheck" | Runs typecheck + lint sequentially and reports the results |
| `global-code-review` | `/code-review`, "code review" | Inspects layer boundaries, communication patterns, and code quality via the code-reviewer agent. With no arguments, auto-detects files changed on the current branch |
| `global-git-flow` | "commit", "git commit" | Enforces commit message conventions, commits only after user approval, then suggests a version bump |

### Agents (agents/)

Dedicated subagents the skills depend on.

| Agent | Role |
|----------|------|
| `architect` | System architecture, layer separation, data flow design |
| `generator` | Code generation from designs/specifications |
| `logic-expert` | Business logic and hooks, refactoring |
| `ui-publisher` | Presentation layer (pure UI components) |
| `evaluator` | Verifies generated code, drives the self-improvement loop |
| `code-reviewer` | Code quality and architecture analysis |

## Installation

### Windows (PowerShell)

```powershell
git clone https://github.com/KwonCheulJin/claude-config-team.git
cd claude-config-team
./install.ps1
```

### macOS / Linux

```bash
git clone https://github.com/KwonCheulJin/claude-config-team.git
cd claude-config-team
./install.sh
```

The install script copies `skills/` to `~/.claude/skills/` and `agents/` to `~/.claude/agents/`. Existing skills/agents with the same names will be overwritten.

### Registering slash commands (recommended)

Add the snippet below to `~/.claude/CLAUDE.md` so the slash command triggers fire reliably.

```markdown
# Team-shared skills
When the user types `/plan`, invoke the Skill tool with `skill: "global-plan"` before doing anything else.
When the user types `/implement`, invoke the Skill tool with `skill: "global-implement"` before doing anything else.
When the user types `/check`, invoke the Skill tool with `skill: "global-check"` before doing anything else.
When the user types `/code-review`, invoke the Skill tool with `skill: "global-code-review"` before doing anything else.
```

## plan-eng-review (gstack) — install separately

The engineering-manager-mode plan review skill `/plan-eng-review` is part of [gstack](https://github.com/garrytan/gstack) (MIT, Garry Tan). gstack skills depend on their own `bin/` scripts, so copying the files into this repo would not work. Install it with the official installer instead.

Open Claude Code and paste the following (requirements: Git, Bun v1.0+, plus Node.js on Windows):

```bash
git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && cd ~/.claude/skills/gstack && ./setup
```

After installation, use `/plan-eng-review` to review your plan's architecture, edge cases, and test coverage. Other gstack skills such as `/review`, `/qa`, and `/investigate` are installed alongside it.

## Recommended workflow

```
/plan {feature}           # Write design doc → user approval
/plan-eng-review          # (optional) Engineering review of the plan — gstack
/implement {feature}      # Step-by-step implementation + self-verification
/check                    # typecheck + lint
/code-review              # Review changed files
"commit this"             # git-flow — conventional commit + version bump suggestion
```

## License

MIT
