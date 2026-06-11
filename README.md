# claude-config-team

**한국어** | [English](README.en.md)

팀 공유용 Claude Code 설정입니다. 개인 claude-config에서 실제 사용 빈도가 높은 핵심 스킬만 추려 구성했습니다.

## 구성

### 스킬 (skills/)

계획 → 구현 → 검증 → 리뷰 → 커밋으로 이어지는 핵심 개발 워크플로우입니다.

| 스킬 | 트리거 | 설명 |
|------|--------|------|
| `global-plan` | `/plan`, "설계 문서", "구현 계획" | 구현 전 아키텍처 설계 문서 작성. `.claude/plans/`에 저장 후 사용자 확인을 거쳐 구현 진행 |
| `global-implement` | `/implement`, "구현 시작" | 설계 문서 기반 단계별 구현. 작업 유형에 따라 architect / generator / logic-expert / ui-publisher 에이전트 활용, evaluator 자가 검증 루프 적용 |
| `global-check` | `/check`, "타입 검사" | typecheck + lint 순차 실행 후 결과 보고 |
| `global-code-review` | `/code-review`, "코드 리뷰" | code-reviewer 에이전트로 레이어 경계·통신 패턴·코드 품질 검사. 인자 없이 실행 시 현재 브랜치 변경 파일 자동 감지 |
| `global-git-flow` | "커밋", "git commit" | 커밋 메시지 컨벤션 강제, 사용자 승인 후 커밋, 커밋 후 버전업 제안 |

### 에이전트 (agents/)

스킬이 의존하는 전담 서브에이전트입니다.

| 에이전트 | 역할 |
|----------|------|
| `architect` | 시스템 아키텍처·레이어 분리·데이터 흐름 설계 |
| `generator` | 설계/명세 기반 코드 생성 |
| `logic-expert` | 비즈니스 로직·훅 구현, 리팩토링 |
| `ui-publisher` | 프레젠테이션 레이어(순수 UI 컴포넌트) 구현 |
| `evaluator` | 생성된 코드 검증, 자가 개선 루프 구동 |
| `code-reviewer` | 코드 품질·아키텍처 분석 |

## 설치

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

설치 스크립트는 `skills/`를 `~/.claude/skills/`로, `agents/`를 `~/.claude/agents/`로 복사합니다. 기존에 같은 이름의 스킬/에이전트가 있으면 덮어쓰므로 주의하세요.

### 슬래시 커맨드 등록 (권장)

`~/.claude/CLAUDE.md`에 아래 스니펫을 추가하면 슬래시 커맨드 트리거가 안정적으로 동작합니다.

```markdown
# 팀 공유 스킬
When the user types `/plan`, invoke the Skill tool with `skill: "global-plan"` before doing anything else.
When the user types `/implement`, invoke the Skill tool with `skill: "global-implement"` before doing anything else.
When the user types `/check`, invoke the Skill tool with `skill: "global-check"` before doing anything else.
When the user types `/code-review`, invoke the Skill tool with `skill: "global-code-review"` before doing anything else.
```

## plan-eng-review (gstack) — 별도 설치

엔지니어링 관점의 계획 리뷰 스킬 `/plan-eng-review`는 [gstack](https://github.com/garrytan/gstack) (MIT, Garry Tan)에 포함되어 있습니다. gstack 스킬은 자체 `bin/` 스크립트에 의존하므로 이 레포에 파일만 복사하면 동작하지 않습니다. 공식 인스톨러로 설치하세요.

Claude Code를 열고 아래를 붙여넣으면 됩니다 (요구사항: Git, Bun v1.0+, Windows는 Node.js 추가):

```bash
git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && cd ~/.claude/skills/gstack && ./setup
```

설치 후 `/plan-eng-review`로 계획 문서의 아키텍처·엣지 케이스·테스트 커버리지를 리뷰할 수 있습니다. `/review`, `/qa`, `/investigate` 등 다른 gstack 스킬도 함께 설치됩니다.

## 권장 워크플로우

```
/plan {기능명}            # 설계 문서 작성 → 사용자 확인
/plan-eng-review          # (선택) 엔지니어링 관점 계획 리뷰 — gstack
/implement {기능명}       # 설계 기반 단계별 구현 + 자가 검증
/check                    # typecheck + lint
/code-review              # 변경 파일 코드 리뷰
"커밋해줘"                # git-flow — 컨벤션 커밋 + 버전업 제안
```

## 라이선스

MIT
