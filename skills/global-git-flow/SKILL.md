---
name: git-flow
description: Git 커밋 관리 스킬. 커밋 메시지 컨벤션 강제, 사용자 확인 후 커밋 진행. Claude Code 저작권 표시 금지. 트리거: "커밋", "git commit", "변경사항 저장", "브랜치"
---

# Git Flow

## 개요

Git 버전 관리 스킬입니다. 커밋 메시지 컨벤션을 강제하고, 사용자 확인 후에만 커밋합니다.

## 핵심 규칙

### 규칙 1: 사용자 확인 없이 자동 커밋 금지

**필수 워크플로우:**
1. 기능 구현 완료
2. 변경 사항 표시 (`git status` + `git diff`)
3. **사용자에게 승인 요청**
4. 승인 후 커밋 메시지 작성
5. 로컬 저장소에만 커밋
6. **자동 push 금지**

### 규칙 2: Claude Code 저작권 표시 금지

**다음 내용 절대 추가 금지:**
- `🤖 Generated with [Claude Code](https://claude.com/claude-code)`
- `Co-Authored-By: Claude <noreply@anthropic.com>`

### 규칙 3: 제목 + 본문 커밋 메시지 필수

## 커밋 메시지 형식

```
<type>(<scope>): <제목 (50자 이내)>

- 핵심 변경사항 1
- 핵심 변경사항 2
- 핵심 변경사항 3
```

### 커밋 타입

| 타입 | 용도 | 예시 |
|------|------|------|
| `feat` | 새 기능 | `feat(auth): add OAuth login` |
| `fix` | 버그 수정 | `fix(api): correct response type` |
| `refactor` | 코드 구조 개선 | `refactor(store): extract domain logic` |
| `style` | 코드 포맷팅 | `style: apply prettier formatting` |
| `perf` | 성능 개선 | `perf(list): optimize rendering` |
| `docs` | 문서 | `docs: update README setup guide` |
| `test` | 테스트 추가/수정 | `test(service): add unit tests` |
| `chore` | 빌드/설정 | `chore: update dependencies` |

### 스코프

프로젝트 `CLAUDE.md`에 정의된 도메인/모듈을 스코프로 사용합니다.
정의되지 않은 경우 변경된 기능/모듈명을 사용합니다.

## 커밋 워크플로우

### Step 1: 변경 사항 확인

```bash
git status
git diff
```

### Step 2: 사용자에게 표시 후 승인 요청

```
"구현을 완료했습니다. 다음과 같이 변경되었습니다:

변경 파일:
- {파일 경로} (신규/수정/삭제)

주요 변경사항:
- {변경사항 요약}

커밋할까요?"
```

**사용자 승인 대기** — 승인 없이 진행 금지

### Step 3: 승인 후 커밋

```bash
git add {변경된 파일들}
git commit -m "feat(scope): implement feature

- 핵심 변경사항 1
- 핵심 변경사항 2
- 핵심 변경사항 3"
```

### Step 4: 커밋 완료 후 버전업 제안 (필수)

커밋이 완료되면 **반드시** 버전업을 이어서 제안합니다.

**커밋 타입별 권장 버전 타입:**

| 커밋 타입 | 권장 버전 | 이유 |
|-----------|-----------|------|
| `fix` | `patch` | 버그 수정 |
| `refactor`, `style`, `perf`, `docs`, `chore` | `patch` | 소규모 변경 |
| `feat` | `minor` | 새 기능 추가 |
| Breaking change | `major` | 하위 호환 불가 변경 |

**사용자에게 표시할 메시지:**

```
"커밋이 완료되었습니다.

현재 버전: v{현재버전}
권장 버전업: {타입} → v{다음버전}

버전업 후 push할까요? (patch / minor / major / 건너뛰기)"
```

**사용자 승인 대기** — 승인 없이 진행 금지

### Step 5: 승인 후 버전업 및 push

프로젝트 `package.json`의 release 스크립트를 사용합니다:

```bash
# package.json에 release 스크립트가 있는 경우
pnpm release:patch   # 또는 npm run / yarn

# 없는 경우
npm version patch --no-git-tag-version
git add package.json
git commit -m "chore: release v{버전}"
git tag v{버전}
git push origin {브랜치} --follow-tags
```

**사용자가 "건너뛰기"를 선택한 경우:** push 없이 종료.

---

## 버전업 선택 기준

| 타입 | 기준 |
|------|------|
| `patch` | 버그 수정, 소규모 fix, 리팩토링 |
| `minor` | 새 기능 추가, 하위 호환 변경 |
| `major` | Breaking change, 대규모 개편 |

## 체크리스트

### 커밋 전
- [ ] typecheck 성공
- [ ] lint 오류 없음
- [ ] 사용자에게 변경 사항 표시
- [ ] **사용자 승인 완료**
- [ ] 커밋 메시지에 제목 + 본문 포함
- [ ] 본문에 3~5개 bullet point
- [ ] **Claude Code 저작권 표시 없음**

### 커밋 후 (버전업)
- [ ] 커밋 타입 기준으로 버전 타입(patch/minor/major) 추천
- [ ] 현재 버전 및 다음 버전 사용자에게 표시
- [ ] **사용자 승인 완료**
- [ ] release 스크립트 실행 또는 건너뛰기
