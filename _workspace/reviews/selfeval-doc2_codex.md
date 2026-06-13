Reading additional input from stdin...
OpenAI Codex v0.139.0
--------
workdir: /Users/junghojang/Developments/myProject/myHarness
model: gpt-5.5
provider: openai
approval: never
sandbox: read-only
reasoning effort: medium
reasoning summaries: none
session id: 019ec010-dc65-7e43-a657-85c32337a219
--------
user
리뷰 대상(설계 문서): docs/self-evaluation-system.md — 하네스 팩토리 자체 평가 시스템 설계.
2차 — **성능/속도 및 안정성** 중심 리뷰. 이슈 모두 보고:
- 평가 비용·지연(smoke/full·golden domain 10~20개·baseline A/B·외부 리뷰)의 폭증·통제
- scorecard 산출·누적 오버헤드, 컨텍스트 부하, 파일 동시성
- full 게이트 트리거의 안정성(오발화·과빈발), 반복실패 임계 노이즈
- 미구현 스크립트 의존·실패 전파(측정 실패가 생성 루프를 막나)
- 대규모(에이전트 7+·도메인 20) 확장 시 병목, 단순화·우선순위
<이슈 작성 방법>
1. [레벨] 제목
- 현황: / - 이슈: / - 권고:
</이슈 작성 방법>
hook: SessionStart
hook: SessionStart Completed
hook: UserPromptSubmit
hook: UserPromptSubmit Completed
codex
`context-mode` 사용. 설계 문서 리뷰라 원문은 인덱싱/검색으로 좁혀 보고, 필요한 쟁점만 꺼내겠습니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '1,220p' /Users/junghojang/.codex/skills/context-mode/SKILL.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
---
name: context-mode
description: Use the context-mode MCP server and routing hooks when tasks involve large context, many files, or repeated analysis that should be indexed instead of pasted.
---

# context-mode

Use this skill when a task benefits from the context-mode MCP server installed from `mksglu/context-mode`.

## What it does

- Routes Codex tool use through context-mode hooks.
- Pushes large or repeated context into indexed memory instead of flooding the chat.
- Provides `ctx_*` commands for search, batch execution, indexing, and maintenance.

## How to use

- Keep `context-mode` installed on PATH.
- Ensure `~/.codex/config.toml` contains the `context-mode` MCP server entry.
- Ensure `~/.codex/hooks.json` points Codex hook events at `context-mode hook codex ...`.
- Keep `~/.codex/AGENTS.md` loaded as the routing policy for Codex sessions.

## When to prefer it

- Large repo analysis.
- Repeated file exploration.
- Multi-file search or transform work.
- Tasks that need a local indexed memory instead of raw transcript growth.

## Operational rule

- Prefer indexed search and batch execution over raw context dumps.
- Prefer code that reads, indexes, and summarizes over manual copy/paste.

hook: PostToolUse
hook: PostToolUse Completed
mcp: context-mode/ctx_index started
mcp: context-mode/ctx_index (failed)
user cancelled MCP tool call
codex
인덱스 호출이 취소되어, 파일 단위 샌드박스 분석으로 전환합니다. 원문 전체를 대화창에 붓지 않고 제목/핵심 문장만 추출합니다.
mcp: context-mode/ctx_execute_file started
mcp: context-mode/ctx_execute_file (failed)
user cancelled MCP tool call
codex
context-mode MCP 호출이 연속 취소됐습니다. 리뷰는 계속 진행하되, 로컬 명령은 20줄 안팎의 파생 출력만 뽑는 방식으로 제한하겠습니다.
hook: PreToolUse
hook: PreToolUse Completed
hook: PostToolUse
hook: PostToolUse Completed
codex
샌드박스가 here-doc 임시 파일도 막습니다. 읽기 전용 범위 안에서 단일 `node -e`로 짧은 구조 요약만 확인합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "node -e \"const fs=require('fs'); const p='/Users/junghojang/Developments/myProject/myHarness/docs/self-evaluation-system.md'; const lines=fs.readFileSync(p,'utf8').split(/\\\\r?\\\\n/); console.log('lines='+lines.length); console.log('headings='+lines.filter(l=>/"'^#{1,4}'"\\\\s/.test(l)).length); lines.forEach((l,i)=>{if(/"'^#{1,3}'"\\\\s/.test(l)) console.log((i+1)+': '+l)})\"" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
lines=263
headings=14
1: # 하네스 팩토리 자체 평가 시스템 설계
3: ## 목적
17: ## 평가 대상 — 정책 품질 (기능 자랑이 아니라)
31: ## 기본 원칙
45: ## 평가 대상
67: ## 평가 축
82: ## 증거 패키지 — 5가지 평가 방법 (설득력 순)
109: ## Smoke 평가
128: ## Full 평가
151: ## Scorecard 스키마
195: ## 개선 루프
219: ## 반복 실패 패턴
232: ## 현재 프로젝트에 대한 적용
252: ## 결론

hook: PostToolUse
hook: PostToolUse Completed
codex
평가 설계의 비용·게이트·스키마·루프 구간이 리뷰 범위와 직접 맞습니다. 그 구간만 줄번호와 함께 확인합니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '82,150p' docs/self-evaluation-system.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
## 증거 패키지 — 5가지 평가 방법 (설득력 순)

"내가 좋다고 말함"이 아니라 **독립 검증 가능한 증거**로 정책 품질을 보인다. 비용·신뢰도 순:

1. **Policy Conformance Audit (최우선·저비용)** — `skills/myharness/SKILL.md`가 *자기 정책을 실제로 지키는지* 정적 점검. 예: Phase 6 검증 존재, scorecard 설계, 외부 리뷰 gate, runtime adapter, 비용 통제 규칙. 자체 점검 가능·노이즈 적음 → 가장 먼저.

2. **Golden Domain Replay** — 대표 도메인 10~20개(예: SaaS 개발팀·문서 자동화·보안 리뷰·콘텐츠 운영·데이터 분석)에 하네스를 생성하고 산출물 평가.
   - ⚠️ **누수 주의:** 도메인 케이스를 하네스/같은 LLM이 만들면 self-bias·과적합. **외부 seed(사람·타 모델)·negative control(스킬이 방해되는 역기획)** 포함. (`references/self-improvement-loop.md` §6 holdout 규율 준용)

3. **Baseline 비교 (vs 일반 LLM)** — baseline="이 프로젝트용 에이전트 팀 만들어줘"(plain), treatment=myharness. 비교 항목: 필수 파일 생성률·역할 중복률·검증 Phase 포함률·오케스트레이션 명확도·스킬 trigger 품질·런타임 정합성·재작업 횟수.
   - ⚠️ **자체측정은 약증거.** "X% 우수" 주장 시 **n·측정자·blind(candidate/baseline 익명)·holdout**을 같은 문장에 명시. 작은 n으로 단정 금지(과거 "+60% n=15" 과대주장 함정 회피). 객관 항목(파일 생성률 등) 우선, 주관 항목은 blind judge.

4. **External Review Evidence** — codex/gemini 외부 리뷰 루프 결과를 *증거로 남김*. "독립 리뷰어가 무엇을 잡았고 무엇을 통과시켰나"를 로그로 공개(`_workspace/reviews/`). 통과만이 아니라 **기각·미수렴도 공개**(체리피킹 금지).

5. **Scorecard 공개** — 케이스별 점수를 표로. 예(서식 예시 — 실측값 아님):
   | 축 | 점수 |
   |----|------|
   | file_completeness | 0.95 |
   | role_fit | 0.86 |
   | role_conflict_safety | 0.91 |
   | orchestration_fit | 0.88 |
   | validation_loop | 0.93 |
   | runtime_consistency | 0.72 |
   - ⚠️ 위 숫자는 **서식 예시**다. 실측 scorecard만 증거로 인용. 낮은 축(예 runtime_consistency)은 숨기지 말고 개선 항목으로 노출.

> 용어 정합: 본 문서 `self_eval_scorecard`(하네스 *산출물* 품질) ≈ `references/self-improvement-loop.md`의 `artifact_benchmark`. 루프 *효율*은 `loop_scorecard`(`loop-self-eval.md`)로 별도 — 셋을 섞지 말 것.

## Smoke 평가

`smoke`는 LLM judge 없이 가능한 검사를 우선한다.

필수 검사:

- `.claude/agents/` 또는 런타임별 agent 정의 존재
- `.claude/skills/` 또는 `.agents/skills/` 존재
- 오케스트레이터 스킬 존재
- `CLAUDE.md` 또는 `AGENTS.md` 포인터 존재
- 각 `SKILL.md` frontmatter의 `name`, `description` 존재
- references/scripts 참조 파일 존재
- 검증 Phase 또는 동등한 validation section 존재
- agent name, role, responsibility 중복 후보 탐지
- 동일 런타임 안에서 스킬 이름 충돌 탐지
- Codex/Claude dual runtime을 주장할 경우 양쪽 산출물 존재 여부 검사

Smoke 결과는 pass/fail과 경고 목록을 낸다. 이 단계는 빠르게 실패를 잡는 용도이며, 역할 적합성 같은 판단형 품질을 확정하지 않는다.

## Full 평가

`full`은 smoke 결과에 더해 LLM judge와 외부 리뷰를 사용한다.

판정형 질문:

- 이 도메인에서 필요한 핵심 역할이 빠지지 않았는가
- 각 에이전트의 책임 경계가 명확한가
- 오케스트레이터가 실제 업무 프로세스에 맞는 순서로 작업을 배치했는가
- 설계, 구현, 검증, 릴리스 또는 운영 단계가 성공 가능한 흐름으로 연결되는가
- 검증 루프가 형식적 문구가 아니라 실패를 발견하고 수정할 수 있는 구조인가
- 스킬이 너무 넓거나 너무 좁지 않은가
- 스킬 description이 실제 사용자 요청에서 적절히 trigger될 가능성이 높은가

Full 평가는 비용이 크므로 다음 조건에서만 실행한다.

- 사용자가 명시적으로 품질 검증을 요청
- 하네스가 외부 사용자에게 배포될 예정
- 에이전트 3개 이상 추가/삭제
- 오케스트레이션 구조 변경
- 코드/설계 도메인 중대 위험 작업
- smoke 평가에서 high severity 문제가 발견됨


hook: PostToolUse
exec
/bin/zsh -lc "sed -n '151,231p' docs/self-evaluation-system.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
## Scorecard 스키마

`self_eval_scorecard.json`은 최소한 다음 필드를 가진다.

```json
{
  "schema_version": "1.0",
  "mode": "smoke",
  "target": {
    "domain": "example",
    "path": "generated/example-harness",
    "runtime": ["claude", "codex"]
  },
  "scores": {
    "file_completeness": 0.0,
    "runtime_consistency": 0.0,
    "role_fit": null,
    "role_conflict": 0.0,
    "orchestration_fit": null,
    "validation_loop": 0.0,
    "skill_fit": null,
    "failure_handling": null,
    "cost_control": 0.0
  },
  "findings": [
    {
      "severity": "high",
      "category": "runtime_consistency",
      "message": "Dual runtime claimed, but .codex/agents/*.toml is missing.",
      "evidence": ["AGENTS.md", "references/runtime-adapters.md"]
    }
  ],
  "recommendations": [
    {
      "type": "manual_review",
      "message": "Generate Codex agent definitions or downgrade the dual-runtime claim."
    }
  ],
  "auto_apply": false
}
```

점수는 0.0~1.0 범위를 사용한다. `smoke`에서 판단할 수 없는 항목은 `null`로 둔다.

## 개선 루프

자체 평가는 생성물을 바로 수정하지 않는다. 자동 수정은 팩토리가 자기 점수를 올리기 위해 기준을 왜곡하는 Goodhart 문제를 만들 수 있다.

권장 루프:

1. 하네스 생성
2. smoke self-eval 실행
3. high severity 발견 시 사용자에게 보고
4. 필요 시 full self-eval 실행
5. 실패 유형을 scorecard로 저장
6. 같은 실패가 반복될 때 개선 제안 생성
7. 사용자가 승인한 개선만 팩토리 스킬, 템플릿, references에 반영

자동 반영 금지 기준:

- 평가 기준 자체 변경
- 에이전트 역할 추가/삭제
- 오케스트레이션 Phase 변경
- 외부 리뷰 gate 변경
- 런타임 지원 범위 변경

이 항목들은 반드시 사용자 승인 후 반영한다.

## 반복 실패 패턴

누적 scorecard에서 다음 패턴이 반복되면 팩토리 개선 후보로 올린다.

- 필수 파일 누락이 3회 이상 반복
- 같은 런타임 drift가 2회 이상 반복
- 역할 충돌이 같은 카테고리에서 3회 이상 반복
- 검증 Phase 누락 또는 형식적 검증이 반복
- 스킬 trigger가 너무 약하거나 너무 넓다는 판정 반복
- 오케스트레이터가 도메인 프로세스를 반영하지 못한다는 판정 반복

단, 누적 표본이 너무 작을 때는 개선을 제안하지 않는다. 최소 기준은 `min_evaluated_harnesses >= 5` 또는 `min_adjudicated_findings >= 20`이다.


hook: PostToolUse
exec
/bin/zsh -lc "sed -n '31,81p' docs/self-evaluation-system.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
## 기본 원칙

자체 평가는 항상 켜지 않는다. 하네스 팩토리는 사용자의 도메인 요청을 빠르게 구조화하는 도구이므로, 모든 요청에 full self-eval을 붙이면 토큰 비용과 지연이 과도해진다.

따라서 자체 평가는 위험도 기반 gate로 동작한다.

| 모드 | 적용 시점 | 평가 방식 | 비용 |
|------|----------|----------|------|
| `off` | 단순 질문, 소규모 하네스, 초안 생성 | 평가 생략 | 없음 |
| `smoke` | 기본 생성 완료 후 | 정적 검사 중심 | 낮음 |
| `full` | 릴리스 전, 대규모 구조 변경, 명시적 품질 검증 요청 | 정적 검사 + LLM judge + 외부 리뷰 | 높음 |

기본값은 `smoke`다. `full`은 사용자가 요청했거나, 변경 위험도가 높은 경우에만 실행한다.

## 평가 대상

자체 평가는 생성된 하네스 디렉토리 전체를 대상으로 한다.

필수 입력:

- 생성 요청 원문
- 대상 도메인 설명
- 생성된 에이전트 정의
- 생성된 스킬 정의
- 오케스트레이터 스킬 또는 프로세스 문서
- `CLAUDE.md`, `AGENTS.md` 같은 런타임 진입점
- references/scripts 같은 보조 파일
- 실행 로그 또는 리뷰 결과가 있으면 함께 사용

필수 출력:

- `self_eval_scorecard.json`
- `self_eval_report.md`
- 개선 제안 목록
- 자동 반영 여부: 기본 `false`

## 평가 축

| 축 | 질문 | smoke | full |
|----|------|-------|------|
| 파일 완성도 | 필수 파일과 디렉토리가 생성되었는가 | yes | yes |
| 런타임 정합성 | Claude/Codex 산출물이 문서 주장과 일치하는가 | yes | yes |
| 에이전트 역할 적합성 | 도메인에 필요한 역할을 충분히 커버하는가 | partial | yes |
| 역할 충돌 | 여러 에이전트가 같은 책임을 중복 소유하지 않는가 | partial | yes |
| 책임 공백 | 중요한 업무 영역에 owner가 없는가 | partial | yes |
| 오케스트레이션 적합성 | 도메인 업무 흐름을 단계와 handoff로 표현하는가 | partial | yes |
| 검증 루프 | 작업 단계별 QA, review, test, approval gate가 있는가 | yes | yes |
| 스킬 적절성 | 스킬 범위, trigger, references/scripts가 적절한가 | partial | yes |
| 실패 처리 | 재시도, 중단, 사용자 승인, rollback 기준이 있는가 | partial | yes |
| 비용 통제 | 고비용 평가와 외부 리뷰가 위험도에 따라 켜지는가 | yes | yes |


hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
현재 문서는 비용 통제 원칙은 있으나 실행 파라미터와 실패 전파 모델이 비어 있는지 확인 중입니다. 적용 구간까지 보고 누락을 이슈화하겠습니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '232,263p' docs/self-evaluation-system.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
## 현재 프로젝트에 대한 적용

현재 하네스 팩토리에는 자체 평가 시스템의 재료가 이미 있다.

- `skills/myharness/SKILL.md`의 Phase 6 검증
- `skills/myharness/references/loop-self-eval.md`
- `skills/myharness/scripts/build-scorecard.sh`
- `skills/myharness/scripts/check-review-tools.sh`
- codex/gemini 외부 리뷰 루프

부족한 것은 이것들을 하나의 닫힌 품질관리 루프로 연결하는 실행 규칙이다.

우선 구현 순서:

1. smoke self-eval 스크립트 추가
2. `self_eval_scorecard.json` 스키마 고정
3. 생성된 하네스마다 scorecard 저장
4. full self-eval은 명시 요청 또는 릴리스 gate에서만 실행
5. 반복 실패 패턴만 팩토리 개선 제안으로 승격

## 결론

자체 평가 시스템은 가능하고 필요하다. 다만 상시 full 평가나 자동 자기수정은 피해야 한다.

가장 현실적인 형태는 다음이다.

- 기본은 저비용 `smoke`
- 위험 작업과 릴리스 전만 `full`
- scorecard는 누적
- 개선은 제안까지만 자동화
- 팩토리 본문 변경은 사용자 승인 후 반영

hook: PostToolUse
exec
/bin/zsh -lc "sed -n '1,30p' docs/self-evaluation-system.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
# 하네스 팩토리 자체 평가 시스템 설계

## 목적

이 문서는 하네스 팩토리가 생성한 에이전트, 스킬, 오케스트레이션 프로세스를 평가해 다음 생성 품질을 개선하기 위한 자체 평가 시스템을 정의한다.

목표는 별도 평가 제품이나 공개 벤치마크를 만드는 것이 아니다. 목표는 팩토리 내부 품질관리 루프를 만들어 다음을 판단하는 것이다.

- 생성된 하네스가 필수 산출물을 만들었는가
- 에이전트 역할이 도메인에 적합한가
- 역할 충돌이나 책임 공백이 없는가
- 오케스트레이터가 업무 도메인에 맞는 프로세스로 에이전트를 구성하는가
- 작업 단계별 검증 루프가 포함되어 실제 프로젝트 성공 가능성을 높이는가
- 생성된 스킬이 적절한 범위, 트리거, 참조 자료를 갖는가
- 검증 Phase가 포함되어 있는가

## 평가 대상 — 정책 품질 (기능 자랑이 아니라)

"잘 짜였다"를 주장하려면 기능 목록이 아니라 **정책 품질을 검증 가능한 증거로** 보여줘야 한다. 평가 대상은 다음 7개 정책 축이다:

| 정책 축 | 평가 질문 |
|---------|----------|
| 빌드 정책 | Phase 0~7 흐름이 타당한가 |
| 에이전트 설계 정책 | 역할 분해·책임 경계·중복 방지가 적절한가 |
| 스킬 생성 정책 | trigger·scope·references/scripts 동봉이 적절한가 |
| 오케스트레이션 정책 | 도메인 프로세스를 agent handoff로 잘 변환하는가 |
| 검증 정책 | 내부 QA·외부 리뷰·smoke/full gate가 적절한가 |
| 비용 정책 | 항상 heavy eval을 돌리지 않고 위험도 기반으로 제어하는가 |
| 듀얼 런타임 정책 | Claude/Codex 산출물과 문서가 일치하는가 |


hook: PostToolUse
exec
/bin/zsh -lc "node -e \"const fs=require('fs'); const s=fs.readFileSync('docs/self-evaluation-system.md','utf8').toLowerCase(); for (const t of ['timeout','budget','cache','lock','atomic','parallel','concurrency','incremental','rate','retry','fail-open','fail closed','baseline','external review','golden domain','scorecard']) console.log(t+': '+(s.match(new RegExp(t.replace(/[.*+?"'^${}()|['"\\\\]\\\\]/g,'\\\\\\\\"'$&'"'),'g'))||[]).length)\"" in /Users/junghojang/Developments/myProject/myHarness
 exited 1 in 0ms:
[eval]:1
const fs=require('fs'); const s=fs.readFileSync('docs/self-evaluation-system.md','utf8').toLowerCase(); for (const t of ['timeout','budget','cache','lock','atomic','parallel','concurrency','incremental','rate','retry','fail-open','fail closed','baseline','external review','golden domain','scorecard']) console.log(t+': '+(s.match(new RegExp(t.replace(/[.*+?^()|[\]\]/g,'\\$&'),'g'))||[]).length)
                                                                                                                                                                                                                                                                                                                                                                ^

SyntaxError: Invalid regular expression: missing /
    at makeContextifyScript (node:internal/vm:185:14)
    at node:internal/process/execution:107:22
    at [eval]-wrapper:6:24
    at runScript (node:internal/process/execution:101:62)
    at evalScript (node:internal/process/execution:136:3)
    at node:internal/main/eval_string:55:3

Node.js v22.11.0

hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
참조 스크립트의 실재 여부도 확인합니다. 설계가 존재하지 않는 실행물에 기대면 측정 실패가 생성 루프를 막는 장애가 됩니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc 'ls skills/myharness/scripts' in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
build-scorecard.sh
check-review-tools.sh

hook: PostToolUse
exec
/bin/zsh -lc "test -f skills/myharness/scripts/build-scorecard.sh && printf 'build-scorecard exists\\n' || printf 'build-scorecard missing\\n'; test -f skills/myharness/scripts/check-review-tools.sh && printf 'check-review-tools exists\\n' || printf 'check-review-tools missing\\n'; test -f skills/myharness/scripts/smoke-self-eval.sh && printf 'smoke-self-eval exists\\n' || printf 'smoke-self-eval missing\\n'" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
build-scorecard exists
check-review-tools exists
smoke-self-eval missing

hook: PostToolUse
exec
/bin/zsh -lc "node -e \"const fs=require('fs'); const s=fs.readFileSync('docs/self-evaluation-system.md','utf8').toLowerCase(); ['timeout','budget','cache','lock','atomic','parallel','concurrency','incremental','rate','retry','baseline','external review','golden domain','scorecard'].forEach(t=>console.log(t+': '+s.split(t).length-1))\"" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN
NaN

hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
확인 결과 smoke 실행 스크립트는 아직 없습니다. 이제 문서 기준과 실행 위험을 묶어 이슈만 보고하겠습니다.
codex
[High] Full 평가 비용 상한 부재
- 현황: `full`은 LLM judge + 외부 리뷰를 포함하고, golden domain 10~20개·baseline 비교·외부 리뷰 증거를 평가 방법으로 둔다.
- 이슈: 최악 비용식이 없다. `20 domains x baseline/treatment x LLM judge x codex/gemini review`로 쉽게 폭증한다. 릴리스 gate에서 반복 실행되면 지연도 예측 불가.
- 권고: `max_domains`, `max_judge_calls`, `max_external_reviews`, `max_tokens`, `timeout`, `daily/PR budget` 명시. 기본 full은 샘플 3~5개, 릴리스 후보만 10~20개로 분리.

[High] Baseline A/B와 golden replay 실행 범위 미분리
- 현황: Golden Domain Replay, Baseline 비교, External Review Evidence가 같은 증거 패키지에 병렬로 배치돼 있다.
- 이슈: smoke/full 모드 안에서 어떤 조합이 언제 실행되는지 불명확하다. “full” 한 번이 replay + A/B + blind judge + 외부 리뷰 전체로 해석될 수 있다.
- 권고: `full-lite`, `full-release`, `benchmark` 3단계로 분리. 생성 루프 기본은 `smoke + single-target full-lite`, benchmark는 수동/예약 실행만 허용.

[High] 측정 실패가 생성 루프를 막는지 불명확
- 현황: 개선 루프는 `smoke self-eval 실행 -> high severity 보고 -> 필요 시 full` 순서다.
- 이슈: 평가 스크립트 오류, judge timeout, 외부 리뷰 도구 부재가 하네스 생성 실패로 전파되는지 정의가 없다. 평가 장애가 본 작업을 막을 수 있다.
- 권고: 평가 실패와 생성 실패를 분리. smoke 구조 검사는 fail-closed 가능, LLM judge/외부 리뷰/scorecard 누적은 fail-open with warning. `evaluation_status: passed|failed|skipped|degraded` 추가.

[High] 미구현 smoke 스크립트 의존
- 현황: 문서는 `smoke self-eval 스크립트 추가`를 우선 구현 1번으로 둔다. 현재 `skills/myharness/scripts/smoke-self-eval.sh`는 없다.
- 이슈: 설계가 아직 없는 실행물에 핵심 gate를 의존한다. 구현 전 문서만 적용하면 “필수 평가”가 실행 불가 상태다.
- 권고: 스크립트가 없을 때는 `smoke: skipped_missing_runner`로 기록하고 생성 루프는 계속 진행. 구현 완료 전까지 full gate 자동 승격 금지.

[Medium] Scorecard 누적 오버헤드와 컨텍스트 부하 통제 부족
- 현황: 생성된 하네스마다 `self_eval_scorecard.json`, `self_eval_report.md` 저장, 누적 scorecard에서 반복 실패를 탐지한다.
- 이슈: 도메인 20개 이상, 반복 생성, 외부 리뷰 로그까지 누적되면 파일 수와 검색 컨텍스트가 커진다. 매번 전체 scorecard/report를 읽는 방식이면 자체 평가가 느려진다.
- 권고: `scorecards/index.jsonl` 같은 append-only 요약 인덱스와 케이스별 상세 파일을 분리. 반복 실패 탐지는 요약 필드만 읽고, 상세 report는 필요 시 lazy load.

[Medium] 파일 동시성 모델 부재
- 현황: 생성된 하네스마다 scorecard 저장한다고만 되어 있다.
- 이슈: 병렬 golden replay, baseline/treatment 병렬 실행, 외부 리뷰 병렬 실행 시 같은 scorecard/index/report 파일에 동시 쓰기 충돌 가능성이 있다.
- 권고: 케이스별 고유 run id 디렉토리 사용. 누적 인덱스 갱신은 atomic rename 또는 lock 파일 사용. 실패한 partial JSON은 집계 대상에서 제외.

[Medium] Full gate 트리거가 과빈발 가능
- 현황: full 조건에 “에이전트 3개 이상 추가/삭제”, “오케스트레이션 구조 변경”, “코드/설계 도메인 중대 위험 작업”, “smoke high severity”가 있다.
- 이슈: 하네스 생성 자체가 에이전트 3개 이상 추가와 오케스트레이션 생성을 자주 포함한다. 기본 생성마다 full이 켜질 수 있다.
- 권고: “기존 하네스 변경 diff 기준”인지 “신규 생성 기준”인지 분리. 신규 생성은 smoke 기본, 배포/사용자 명시/릴리스 후보만 full.

[Medium] High severity 기반 승격 노이즈
- 현황: smoke에서 high severity 문제가 발견되면 full 실행 조건이 된다.
- 이슈: smoke는 정적 검사라 false positive가 생긴다. 참조 파일 경로, dual runtime 주장, 이름 중복 후보 같은 항목이 노이즈로 full을 자주 호출할 수 있다.
- 권고: `high_confirmed`와 `high_candidate` 분리. full 승격은 confirmed high 또는 candidate 2개 이상 + 핵심 축 영향일 때만.

[Medium] 반복 실패 임계값이 노이즈를 충분히 흡수하지 못함
- 현황: 필수 파일 누락 3회, runtime drift 2회, 역할 충돌 3회 등으로 개선 후보를 올린다. 최소 표본은 `harnesses >= 5` 또는 `findings >= 20`.
- 이슈: 작은 n에서 같은 템플릿 버그가 중복 집계되거나, 한 도메인군 편향이 팩토리 개선으로 승격될 수 있다.
- 권고: 동일 root cause dedupe, 도메인 다양성 최소값, 최근 N일/최근 N회 window를 추가. 임계값은 단순 횟수보다 `rate >= x% and n >= y`로 계산.

[Medium] 외부 리뷰 지연·불안정성 통제 부족
- 현황: codex/gemini 외부 리뷰 루프 결과를 증거로 남긴다.
- 이슈: 외부 리뷰 도구 부재, rate limit, 모델 지연, 비결정적 리뷰가 full 평가 전체를 느리거나 불안정하게 만든다.
- 권고: 외부 리뷰는 optional evidence로 처리. `check-review-tools.sh` 실패 시 skip, timeout 초과 시 degraded, 리뷰어 간 불일치는 blocking이 아니라 adjudication queue로 이동.

[Medium] 대규모 확장 병목
- 현황: full은 생성된 하네스 디렉토리 전체와 실행 로그/리뷰 결과까지 사용한다.
- 이슈: 에이전트 7+, 도메인 20개에서는 전체 파일 스캔 + judge + report 생성이 병목이다. 특히 역할 적합성/충돌 판단은 조합 수가 커진다.
- 권고: smoke는 파일/메타데이터만, full은 manifest 요약을 먼저 생성해 judge 입력을 축소. 역할 충돌은 모든 pair 비교 대신 responsibility fingerprint 기반 후보만 judge.

[Low] 우선순위가 구현 순서에만 있고 실행 단순화 기준이 없음
- 현황: 우선 구현 순서는 smoke, schema, 저장, full gate, 반복 실패 승격이다.
- 이슈: 성능 관점의 MVP 경계가 없다. 초기에 baseline A/B, external review, 누적 분석까지 같이 붙으면 시스템이 무거워진다.
- 권고: 1차는 smoke + scorecard schema + fail-open 저장만. 2차는 반복 실패 집계. 3차는 수동 full. 4차에서만 golden/baseline/external review benchmark 추가.
hook: Stop
hook: Stop Completed
tokens used
50,648
[High] Full 평가 비용 상한 부재
- 현황: `full`은 LLM judge + 외부 리뷰를 포함하고, golden domain 10~20개·baseline 비교·외부 리뷰 증거를 평가 방법으로 둔다.
- 이슈: 최악 비용식이 없다. `20 domains x baseline/treatment x LLM judge x codex/gemini review`로 쉽게 폭증한다. 릴리스 gate에서 반복 실행되면 지연도 예측 불가.
- 권고: `max_domains`, `max_judge_calls`, `max_external_reviews`, `max_tokens`, `timeout`, `daily/PR budget` 명시. 기본 full은 샘플 3~5개, 릴리스 후보만 10~20개로 분리.

[High] Baseline A/B와 golden replay 실행 범위 미분리
- 현황: Golden Domain Replay, Baseline 비교, External Review Evidence가 같은 증거 패키지에 병렬로 배치돼 있다.
- 이슈: smoke/full 모드 안에서 어떤 조합이 언제 실행되는지 불명확하다. “full” 한 번이 replay + A/B + blind judge + 외부 리뷰 전체로 해석될 수 있다.
- 권고: `full-lite`, `full-release`, `benchmark` 3단계로 분리. 생성 루프 기본은 `smoke + single-target full-lite`, benchmark는 수동/예약 실행만 허용.

[High] 측정 실패가 생성 루프를 막는지 불명확
- 현황: 개선 루프는 `smoke self-eval 실행 -> high severity 보고 -> 필요 시 full` 순서다.
- 이슈: 평가 스크립트 오류, judge timeout, 외부 리뷰 도구 부재가 하네스 생성 실패로 전파되는지 정의가 없다. 평가 장애가 본 작업을 막을 수 있다.
- 권고: 평가 실패와 생성 실패를 분리. smoke 구조 검사는 fail-closed 가능, LLM judge/외부 리뷰/scorecard 누적은 fail-open with warning. `evaluation_status: passed|failed|skipped|degraded` 추가.

[High] 미구현 smoke 스크립트 의존
- 현황: 문서는 `smoke self-eval 스크립트 추가`를 우선 구현 1번으로 둔다. 현재 `skills/myharness/scripts/smoke-self-eval.sh`는 없다.
- 이슈: 설계가 아직 없는 실행물에 핵심 gate를 의존한다. 구현 전 문서만 적용하면 “필수 평가”가 실행 불가 상태다.
- 권고: 스크립트가 없을 때는 `smoke: skipped_missing_runner`로 기록하고 생성 루프는 계속 진행. 구현 완료 전까지 full gate 자동 승격 금지.

[Medium] Scorecard 누적 오버헤드와 컨텍스트 부하 통제 부족
- 현황: 생성된 하네스마다 `self_eval_scorecard.json`, `self_eval_report.md` 저장, 누적 scorecard에서 반복 실패를 탐지한다.
- 이슈: 도메인 20개 이상, 반복 생성, 외부 리뷰 로그까지 누적되면 파일 수와 검색 컨텍스트가 커진다. 매번 전체 scorecard/report를 읽는 방식이면 자체 평가가 느려진다.
- 권고: `scorecards/index.jsonl` 같은 append-only 요약 인덱스와 케이스별 상세 파일을 분리. 반복 실패 탐지는 요약 필드만 읽고, 상세 report는 필요 시 lazy load.

[Medium] 파일 동시성 모델 부재
- 현황: 생성된 하네스마다 scorecard 저장한다고만 되어 있다.
- 이슈: 병렬 golden replay, baseline/treatment 병렬 실행, 외부 리뷰 병렬 실행 시 같은 scorecard/index/report 파일에 동시 쓰기 충돌 가능성이 있다.
- 권고: 케이스별 고유 run id 디렉토리 사용. 누적 인덱스 갱신은 atomic rename 또는 lock 파일 사용. 실패한 partial JSON은 집계 대상에서 제외.

[Medium] Full gate 트리거가 과빈발 가능
- 현황: full 조건에 “에이전트 3개 이상 추가/삭제”, “오케스트레이션 구조 변경”, “코드/설계 도메인 중대 위험 작업”, “smoke high severity”가 있다.
- 이슈: 하네스 생성 자체가 에이전트 3개 이상 추가와 오케스트레이션 생성을 자주 포함한다. 기본 생성마다 full이 켜질 수 있다.
- 권고: “기존 하네스 변경 diff 기준”인지 “신규 생성 기준”인지 분리. 신규 생성은 smoke 기본, 배포/사용자 명시/릴리스 후보만 full.

[Medium] High severity 기반 승격 노이즈
- 현황: smoke에서 high severity 문제가 발견되면 full 실행 조건이 된다.
- 이슈: smoke는 정적 검사라 false positive가 생긴다. 참조 파일 경로, dual runtime 주장, 이름 중복 후보 같은 항목이 노이즈로 full을 자주 호출할 수 있다.
- 권고: `high_confirmed`와 `high_candidate` 분리. full 승격은 confirmed high 또는 candidate 2개 이상 + 핵심 축 영향일 때만.

[Medium] 반복 실패 임계값이 노이즈를 충분히 흡수하지 못함
- 현황: 필수 파일 누락 3회, runtime drift 2회, 역할 충돌 3회 등으로 개선 후보를 올린다. 최소 표본은 `harnesses >= 5` 또는 `findings >= 20`.
- 이슈: 작은 n에서 같은 템플릿 버그가 중복 집계되거나, 한 도메인군 편향이 팩토리 개선으로 승격될 수 있다.
- 권고: 동일 root cause dedupe, 도메인 다양성 최소값, 최근 N일/최근 N회 window를 추가. 임계값은 단순 횟수보다 `rate >= x% and n >= y`로 계산.

[Medium] 외부 리뷰 지연·불안정성 통제 부족
- 현황: codex/gemini 외부 리뷰 루프 결과를 증거로 남긴다.
- 이슈: 외부 리뷰 도구 부재, rate limit, 모델 지연, 비결정적 리뷰가 full 평가 전체를 느리거나 불안정하게 만든다.
- 권고: 외부 리뷰는 optional evidence로 처리. `check-review-tools.sh` 실패 시 skip, timeout 초과 시 degraded, 리뷰어 간 불일치는 blocking이 아니라 adjudication queue로 이동.

[Medium] 대규모 확장 병목
- 현황: full은 생성된 하네스 디렉토리 전체와 실행 로그/리뷰 결과까지 사용한다.
- 이슈: 에이전트 7+, 도메인 20개에서는 전체 파일 스캔 + judge + report 생성이 병목이다. 특히 역할 적합성/충돌 판단은 조합 수가 커진다.
- 권고: smoke는 파일/메타데이터만, full은 manifest 요약을 먼저 생성해 judge 입력을 축소. 역할 충돌은 모든 pair 비교 대신 responsibility fingerprint 기반 후보만 judge.

[Low] 우선순위가 구현 순서에만 있고 실행 단순화 기준이 없음
- 현황: 우선 구현 순서는 smoke, schema, 저장, full gate, 반복 실패 승격이다.
- 이슈: 성능 관점의 MVP 경계가 없다. 초기에 baseline A/B, external review, 누적 분석까지 같이 붙으면 시스템이 무거워진다.
- 권고: 1차는 smoke + scorecard schema + fail-open 저장만. 2차는 반복 실패 집계. 3차는 수동 full. 4차에서만 golden/baseline/external review benchmark 추가.
