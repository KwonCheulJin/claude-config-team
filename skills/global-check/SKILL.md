---
name: check
description: 프로젝트 빌드 및 린트 검증 스킬. typecheck + lint 순차 실행 후 결과 보고. 작업 완료 후 PR 전 최종 검증, 여러 파일 수정 후 전체 영향도 확인, 타입 오류 의심 시 사용. 트리거: "/check", "빌드 확인", "린트 확인", "타입 검사", "typecheck", "lint"
---

# /check — 타입 체크 + 린트 검증

현재 프로젝트 상태를 빠르게 검증합니다.

## 실행 전 확인

프로젝트 루트의 `CLAUDE.md` 또는 `package.json`에서 검증 명령어를 확인합니다:

- `typecheck` 스크립트 존재 여부
- `lint` 스크립트 존재 여부
- 없는 경우 `tsc --noEmit`, `eslint .` 등 직접 실행

## 실행 절차

1. **타입 체크**
   - TypeScript 컴파일 오류 확인
   - 타입 불일치 감지

2. **린트 검사**
   - ESLint 규칙 위반 확인
   - 미사용 import/변수 확인

## 실행

```bash
# pnpm 프로젝트
pnpm typecheck && pnpm lint

# npm 프로젝트
npm run typecheck && npm run lint

# yarn 프로젝트
yarn typecheck && yarn lint
```

패키지 매니저는 프로젝트 루트의 `package.json` 또는 lock 파일로 판단합니다.

두 명령을 순차 실행하고 결과를 요약하여 보고합니다.

## 보고 형식

성공 시:
```
✅ typecheck: 오류 없음
✅ lint: 경고/오류 없음
```

오류 발생 시:
```
❌ typecheck 오류:
[오류 내용 요약]

❌ lint 오류:
[규칙 위반 목록]
```
