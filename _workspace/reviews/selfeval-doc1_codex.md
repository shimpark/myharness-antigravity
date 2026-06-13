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
session id: 019ec00d-a306-71e0-b261-809ab3c1297a
--------
user
리뷰 대상(설계 문서): docs/self-evaluation-system.md — 하네스 팩토리(skills/myharness/) 자체 평가 시스템 설계. smoke/full 게이트·평가축·정책 7축·증거 패키지 5법(policy audit·golden domain·baseline 비교·external review·scorecard)·개선 루프·반복실패 패턴.
관련: skills/myharness/references/loop-self-eval.md, self-improvement-loop.md, SKILL.md(Phase 6/7), scripts/build-scorecard.sh.
1차 — 정합성·타당성·실현성 리뷰. 발생 가능한 이슈를 모두 보고:
- 기존 정책(loop-self-eval·self-improvement·Phase 6/7)과 중복·모순·용어 충돌(self_eval_scorecard vs artifact_benchmark vs loop_scorecard)
- 5 증거법의 타당성·구멍(baseline 자체측정 약증거, golden domain 누수, scorecard 자기채점, policy audit 자기검증 한계)
- smoke/full 게이트·평가축·점수(null 처리)·반복실패 임계(5/20)의 근거
- 미구현(스크립트 없음) 의존, 정책 vs 실행 갭, 과설계
<이슈 작성 방법>
1. [레벨(critical/high/med/low)] 제목
- 현황: / - 이슈: / - 권고:
</이슈 작성 방법>
hook: SessionStart
hook: SessionStart Completed
hook: UserPromptSubmit
hook: UserPromptSubmit Completed
codex
`context-mode` 규칙 적용. 먼저 관련 도구를 로드하고, 문서와 참조 파일은 원문 덤프 없이 필요한 근거만 뽑아 리뷰하겠습니다.
codex
`myharness` 스킬도 적용합니다. 설계 문서가 하네스 팩토리 자체 평가 정책이라, 먼저 스킬의 Phase 구조와 기존 정책 위치를 확인합니다.
mcp: context-mode/ctx_execute_file started
mcp: context-mode/ctx_execute_file (failed)
user cancelled MCP tool call
codex
첫 MCP 호출이 취소되었습니다. 같은 범위를 더 작게 나눠 재시도합니다. 원문 전체 출력 없이 라인 번호와 관련 섹션만 추출합니다.
mcp: context-mode/ctx_batch_execute started
mcp: context-mode/ctx_batch_execute (failed)
user cancelled MCP tool call
codex
MCP가 두 번 취소되어, 동일한 원칙으로 로컬 Node 스크립트만 실행해 필요한 라인만 제한 출력합니다. 파일 원문 덤프는 피합니다.
hook: PreToolUse
hook: PreToolUse Completed
hook: PostToolUse
hook: PostToolUse Completed
codex
읽기 전용 셸이라 here-doc 임시 파일 생성도 막혔습니다. 쓰기 없는 `node -e` 한 줄 실행으로 전환합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "node -e \"const fs=require('fs'); const files=['/Users/junghojang/Developments/myProject/myHarness/docs/self-evaluation-system.md','/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md','/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/self-improvement-loop.md','/Users/junghojang/Developments/myProject/myHarness/skills/myharness/SKILL.md','/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh']; const re=/"'^#{1,4}'"\\\\s+|smoke|full|scorecard|self_eval_scorecard|artifact_benchmark|loop_scorecard|policy audit|golden|baseline|external review|평가|증거|Phase 6|Phase 7|null|반복|5\\\\/20|threshold|임계|fail|failure|개선|review|gate|audit/i; for (const p of files){ const ok=fs.existsSync(p); const lines=ok?fs.readFileSync(p,'utf8').split(/\\\\r?\\\\n/):[]; console.log('\\\\nFILE '+p+' lines '+(ok?lines.length:'MISSING')); let count=0; for(let i=0;i<lines.length;i++){ if(re.test(lines[i])){ console.log((i+1)+': '+lines[i].slice(0,220)); if(++count>=90){ console.log('... capped'); break; } } } }\"" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:

FILE /Users/junghojang/Developments/myProject/myHarness/docs/self-evaluation-system.md lines 263
1: # 하네스 팩토리 자체 평가 시스템 설계
3: ## 목적
5: 이 문서는 하네스 팩토리가 생성한 에이전트, 스킬, 오케스트레이션 프로세스를 평가해 다음 생성 품질을 개선하기 위한 자체 평가 시스템을 정의한다.
7: 목표는 별도 평가 제품이나 공개 벤치마크를 만드는 것이 아니다. 목표는 팩토리 내부 품질관리 루프를 만들어 다음을 판단하는 것이다.
17: ## 평가 대상 — 정책 품질 (기능 자랑이 아니라)
19: "잘 짜였다"를 주장하려면 기능 목록이 아니라 **정책 품질을 검증 가능한 증거로** 보여줘야 한다. 평가 대상은 다음 7개 정책 축이다:
21: | 정책 축 | 평가 질문 |
27: | 검증 정책 | 내부 QA·외부 리뷰·smoke/full gate가 적절한가 |
31: ## 기본 원칙
33: 자체 평가는 항상 켜지 않는다. 하네스 팩토리는 사용자의 도메인 요청을 빠르게 구조화하는 도구이므로, 모든 요청에 full self-eval을 붙이면 토큰 비용과 지연이 과도해진다.
35: 따라서 자체 평가는 위험도 기반 gate로 동작한다.
37: | 모드 | 적용 시점 | 평가 방식 | 비용 |
39: | `off` | 단순 질문, 소규모 하네스, 초안 생성 | 평가 생략 | 없음 |
40: | `smoke` | 기본 생성 완료 후 | 정적 검사 중심 | 낮음 |
41: | `full` | 릴리스 전, 대규모 구조 변경, 명시적 품질 검증 요청 | 정적 검사 + LLM judge + 외부 리뷰 | 높음 |
43: 기본값은 `smoke`다. `full`은 사용자가 요청했거나, 변경 위험도가 높은 경우에만 실행한다.
45: ## 평가 대상
47: 자체 평가는 생성된 하네스 디렉토리 전체를 대상으로 한다.
62: - `self_eval_scorecard.json`
64: - 개선 제안 목록
67: ## 평가 축
69: | 축 | 질문 | smoke | full |
77: | 검증 루프 | 작업 단계별 QA, review, test, approval gate가 있는가 | yes | yes |
80: | 비용 통제 | 고비용 평가와 외부 리뷰가 위험도에 따라 켜지는가 | yes | yes |
82: ## 증거 패키지 — 5가지 평가 방법 (설득력 순)
84: "내가 좋다고 말함"이 아니라 **독립 검증 가능한 증거**로 정책 품질을 보인다. 비용·신뢰도 순:
86: 1. **Policy Conformance Audit (최우선·저비용)** — `skills/myharness/SKILL.md`가 *자기 정책을 실제로 지키는지* 정적 점검. 예: Phase 6 검증 존재, scorecard 설계, 외부 리뷰 gate, runtime adapter, 비용 통제 규칙. 자체 점검 가능·노이즈 적음 → 가장 먼저.
88: 2. **Golden Domain Replay** — 대표 도메인 10~20개(예: SaaS 개발팀·문서 자동화·보안 리뷰·콘텐츠 운영·데이터 분석)에 하네스를 생성하고 산출물 평가.
91: 3. **Baseline 비교 (vs 일반 LLM)** — baseline="이 프로젝트용 에이전트 팀 만들어줘"(plain), treatment=myharness. 비교 항목: 필수 파일 생성률·역할 중복률·검증 Phase 포함률·오케스트레이션 명확도·스킬 trigger 품질·런타임 정합성·재작업 횟수.
92:    - ⚠️ **자체측정은 약증거.** "X% 우수" 주장 시 **n·측정자·blind(candidate/baseline 익명)·holdout**을 같은 문장에 명시. 작은 n으로 단정 금지(과거 "+60% n=15" 과대주장 함정 회피). 객관 항목(파일 생성률 등) 우선, 주관 항목은 blind judge.
94: 4. **External Review Evidence** — codex/gemini 외부 리뷰 루프 결과를 *증거로 남김*. "독립 리뷰어가 무엇을 잡았고 무엇을 통과시켰나"를 로그로 공개(`_workspace/reviews/`). 통과만이 아니라 **기각·미수렴도 공개**(체리피킹 금지).
96: 5. **Scorecard 공개** — 케이스별 점수를 표로. 예(서식 예시 — 실측값 아님):
105:    - ⚠️ 위 숫자는 **서식 예시**다. 실측 scorecard만 증거로 인용. 낮은 축(예 runtime_consistency)은 숨기지 말고 개선 항목으로 노출.
107: > 용어 정합: 본 문서 `self_eval_scorecard`(하네스 *산출물* 품질) ≈ `references/self-improvement-loop.md`의 `artifact_benchmark`. 루프 *효율*은 `loop_scorecard`(`loop-self-eval.md`)로 별도 — 셋을 섞지 말 것.
109: ## Smoke 평가
111: `smoke`는 LLM judge 없이 가능한 검사를 우선한다.
126: Smoke 결과는 pass/fail과 경고 목록을 낸다. 이 단계는 빠르게 실패를 잡는 용도이며, 역할 적합성 같은 판단형 품질을 확정하지 않는다.
128: ## Full 평가
130: `full`은 smoke 결과에 더해 LLM judge와 외부 리뷰를 사용한다.
142: Full 평가는 비용이 크므로 다음 조건에서만 실행한다.
149: - smoke 평가에서 high severity 문제가 발견됨
151: ## Scorecard 스키마
153: `self_eval_scorecard.json`은 최소한 다음 필드를 가진다.
158:   "mode": "smoke",
167:     "role_fit": null,
169:     "orchestration_fit": null,
171:     "skill_fit": null,
172:     "failure_handling": null,
185:       "type": "manual_review",
193: 점수는 0.0~1.0 범위를 사용한다. `smoke`에서 판단할 수 없는 항목은 `null`로 둔다.
195: ## 개선 루프
197: 자체 평가는 생성물을 바로 수정하지 않는다. 자동 수정은 팩토리가 자기 점수를 올리기 위해 기준을 왜곡하는 Goodhart 문제를 만들 수 있다.
202: 2. smoke self-eval 실행
204: 4. 필요 시 full self-eval 실행
205: 5. 실패 유형을 scorecard로 저장
206: 6. 같은 실패가 반복될 때 개선 제안 생성
207: 7. 사용자가 승인한 개선만 팩토리 스킬, 템플릿, references에 반영
211: - 평가 기준 자체 변경
214: - 외부 리뷰 gate 변경
219: ## 반복 실패 패턴
221: 누적 scorecard에서 다음 패턴이 반복되면 팩토리 개선 후보로 올린다.
223: - 필수 파일 누락이 3회 이상 반복
224: - 같은 런타임 drift가 2회 이상 반복
225: - 역할 충돌이 같은 카테고리에서 3회 이상 반복
226: - 검증 Phase 누락 또는 형식적 검증이 반복
227: - 스킬 trigger가 너무 약하거나 너무 넓다는 판정 반복
228: - 오케스트레이터가 도메인 프로세스를 반영하지 못한다는 판정 반복
230: 단, 누적 표본이 너무 작을 때는 개선을 제안하지 않는다. 최소 기준은 `min_evaluated_harnesses >= 5` 또는 `min_adjudicated_findings >= 20`이다.
232: ## 현재 프로젝트에 대한 적용
234: 현재 하네스 팩토리에는 자체 평가 시스템의 재료가 이미 있다.
236: - `skills/myharness/SKILL.md`의 Phase 6 검증
238: - `skills/myharness/scripts/build-scorecard.sh`
239: - `skills/myharness/scripts/check-review-tools.sh`
246: 1. smoke self-eval 스크립트 추가
247: 2. `self_eval_scorecard.json` 스키마 고정
248: 3. 생성된 하네스마다 scorecard 저장
249: 4. full self-eval은 명시 요청 또는 릴리스 gate에서만 실행
250: 5. 반복 실패 패턴만 팩토리 개선 제안으로 승격
252: ## 결론
254: 자체 평가 시스템은 가능하고 필요하다. 다만 상시 full 평가나 자동 자기수정은 피해야 한다.
258: - 기본은 저비용 `smoke`
259: - 위험 작업과 릴리스 전만 `full`
260: - scorecard는 누적
261: - 개선은 제안까지만 자동화

FILE /Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md lines 84
1: # 루프 자체 평가 (Loop Self-Evaluation) — scorecard & 단계적 도입
3: 루프(external-review-loop 등)가 자기 실행을 측정해 흐름 개선으로 환류하는 닫힌 고리. **외부 리뷰(codex/gemini) 검증을 거쳐 교정된 정본** — 순진한 precision·자동 적용·grading.json 재사용을 모두 제거했다.
5: ## 핵심 경계 (먼저 읽을 것)
9: ## 단계적 도입 (한 번에 다 넣지 말 것)
12: | **1 (현재 정본)** | `loop_scorecard.json` 로깅만. 측정·기록 | 로깅 **≥ 10회** | 없음 |
14: | 3 (실험) | 수치 트리거가 **개선안 "제안"**만 emit | 제안 holdout 통과율 ≥ θ + 명시 승인 | 제안만 + 승인 게이트 |
15: | 4 (실험) | holdout 검증 후 자동 흐름 개선 | — | 최후, 승인 필수 |
17: > **수치(10/30/θ)는 "관찰 시작 최소치"이지 통계적 확정 임계가 아니다** — LLM 평가 노이즈상 비율 지표는 표본이 더 필요할 수 있다. 리스크/단계/리뷰어가 섞이면 신뢰구간을 함께 보고, θ는 리스크 등급별 기본값으로 둔다. 3·4단계는 롤링윈도우·3회 연속 하락 시에만, 단일 실행 노이즈로 흐름을 바꾸지 않는다(플래핑 방지). **2단계까지가 실용 권장 — 3·4(자동 환류
19: ## 읽기 경로 (1단계에도 소비자 필수 — write-only 방지)
21: - `scripts/build-scorecard.sh`가 매 루프 종료 시 scorecard 발행 + `_workspace/evals/{loop}/summary.jsonl`에 최근 N회 집계(append).
22: - 오케스트레이터는 **Phase 0(현황 감사)·Phase 7(진화) 진입 시 `summary.jsonl` 1줄 요약만** 읽는다(원본 JSON 미로드 — Lean). 악화 추세가 보이면 사람에게 보고(2단계 수동 검토).
24: ## loop_scorecard.json 스키마 (신규 — grading.json 재사용 아님)
25: 실행 단위 디렉터리에 발행: `_workspace/evals/{loop}/{stage_id}/{run_id}/scorecard.json`.
29:   "loop": "external-review",
33:   "termination_reason": "converged-good | exhausted | max-rounds | failed-quality-gate",
43:   "cost_per_confirmed": 8000,     // confirmed>0일 때만. 0이면 null
44:   "quality_label": "gate_pass | failed-quality-gate | converged | n/a",  // 설계단계 품질 자기단정 금지
47:   "missed_defect_rate": null,     // 진짜 recall: 외부 Ground Truth(seeded·사후 회귀·사용자 반박) 있을 때만
48:   "overturned_rejection_rate": null,
49:   "computed_by": "scripts/build-scorecard.sh",  // 사실 필드는 스크립트 계산(LLM 자기보고 아님). quality_label만 LLM 해석
53: - **계산 도출(메타 자기채점 제거):** `verdict_counts`·`rounds`·`new_per_round`·`*_rate`·`cost`·`regression_catch_rate`는 **`scripts/build-scorecard.sh`가 `verdicts.json`+`timing.json`에서 기계적으로 산출**한다. LLM은 라벨 해석에만 관여(`quality_label` 등)
57: ## 메트릭 정의 (교정본)
61: - **cost_per_confirmed** confirmed=0이면 분모 0 → `null`. 항상 `cost_per_run`·`cost_per_adjudicated_claim`과 함께 본다.
63: - **missed_defect_rate (진짜 recall)** — 전체 누락은 **외부 Ground Truth**(seeded 결함 탐지율·사후 회귀 역추적·사용자 반박)가 있을 때만. 없으면 null. regression_catch_rate는 보조 신호일 뿐 recall을 대체하지 않는다.
65: ## 종료 사유 라벨 (P2 — 종료조건 아님, 라벨)
66: gate/assertion은 **코드/테스트 단계 전용**. 설계·문서 리뷰엔 측정값이 없으므로 종료조건에 넣지 않는다.
70: - `failed-quality-gate`: (코드 단계) 품질 θ 미달 명백 → **루프 중단**(MAX_ROUNDS 헛돌지 않게).
73: ## 판정 보정 (P5 — Ground Truth만)
74: 같은 오케스트레이터·같은 근거수집으로 재점검하면 편향 반복(에코체임버). 보정은 **독립 신호가 있을 때만** 발화: 사용자 반박 / 후속 결함 발견 / 독립 리뷰어 표본 감사. 결과는 `overturned_rejection_rate`로 기록하고, 임계 초과 시 기각 사유표·리뷰어 신뢰도를 *제안* 형태로 조정(자동 적용 금지).
76: ## 환류(P3/P4) 안전장치 — 3·4단계에서만
83: > 테스트 개선 루프 수렴(assertion 통과율 델타 < ε)은 목적이 달라 분리한다 — `skill-testing-guide.md`에서 다루고, scorecard 링크 규약만 공유.

FILE /Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/self-improvement-loop.md lines 90
1: # 자기개선 루프 (Self-Improvement Loop) — 벤치마크 앵커 자기개선 (설계 정본)
3: 생성된 스킬·에이전트를 **벤치마크로 측정 → 개정안 제안 → holdout 검증 → 사람 승인 → 채택**하는 닫힌 고리. `loop-self-eval.md`(루프 자체 평가)의 확장 — 대상이 *루프*가 아니라 *생성 산출물*. **자동 적용 아님.** 외부 리뷰(codex+gemini) 검증으로 교정된 정본.
5: ## 목차
6: 1. 왜 위험한가 · 2. 용어 분리(루프 vs 산출물) · 3. MVP 단계 · 4. 러너 계약(필수) · 5. 4앵커 + 독립성 · 6. holdout 누수 방지 · 7. baseline immutable · 8. 통계 기준 · 9. capability 등급 · 10. 비용 통제 · 11. rollback · 12. 한계
8: ## 1. 왜 — 그리고 왜 위험한가 (먼저)
9: 이전 external-review-loop 리뷰가 반복 입증한 함정: **Goodhart/과적합·에코체임버·플래핑·약증거(자체측정)**. 모든 채택 결정은 §5 앵커 + §6~8 통제에 묶인다. 앵커는 *필요조건이지 충분조건이 아니다* — 독립성(§5)이 핵심.
11: ## 2. 용어 분리 (중복 제거)
12: - **`loop_scorecard.json`** = *오케스트레이션 루프* 효율 (alignment·rounds·cost). `loop-self-eval.md` 소관.
13: - **`artifact_benchmark.json`** = *생성 스킬/에이전트* 품질 (pass_rate·with/without delta·holdout). 본 문서 소관.
14: - 오케스트레이터 보고 시 두 지표를 **섞지 않는다**. Phase 6/7 호출 순서·경로는 §3 표.
16: ## 3. MVP 단계 (한 번에 다 만들지 말 것)
22: | 4 (실험) | 승인 기반 채택 · re-baseline · rollback 자동 | 사람 승인 필수 |
25: ## 4. 러너 계약 (미구현이면 설계가 공허 — 최소 스펙 고정)
30: - **재실행:** 동일 입력 → 반복 실행 R회(§8), 결과는 immutable append.
34: ## 5. 4앵커 + 독립성 (앵커는 필요조건일 뿐)
41: ## 6. Holdout 누수 방지 (LLM 생성 과제는 semantic sibling)
49: ## 7. baseline immutable (표류 방지)
50: - baseline은 **immutable artifact** — `skill_hash·assertion_version·runner_version·model·env·seed·case_ids·holdout_score·n` 고정.
51: - 후보는 **current champion AND original/reference baseline 둘 다** 이겨야 채택(국소 표류 차단).
53: - **assertion 버전 변경 시 baseline 무효화** → 전체 재측정.
55: ## 8. 통계 기준 (플래핑 방지 — 비어있으면 노이즈 채택)
56: - 리스크별 **최소 holdout n**, **반복 실행 R회**(LLM stochasticity), **bootstrap/CI**, **effect size**, **gray-zone(tie) 보류 정책**.
60: ## 9. capability 등급 (자동개선 대상/비대상)
66: | subjective | 문체·디자인·창작 | 자동개선 비대상 — 사람 평가 |
67: > objective 일부 통과 ≠ 전체 품질 개선. hybrid는 blind review 없이 채택 금지.
69: ## 10. 비용 통제 (벤치가 배보다 배꼽 되지 않게)
70: - **Tiered:** `smoke`(1~2 케이스) 통과 시에만 `full`(holdout 전체).
71: - **baseline 캐싱:** without/champion 결과는 skill/assertion/model 불변 동안 영구 캐싱(매번 재실행 금지).
74: ## 11. rollback (artifact 수준 폐쇄)
75: - 점수만 되돌리면 안 됨. **rollback manifest**: adopted diff·artifact hashes·이전 파일 경로·baseline snapshot·eval case snapshot·command·expected score.
76: - Phase 7에 rollback 실행 절차 명시(재현 가능).
78: ## 12. 정직한 한계
79: - 자체측정 벤치 = 약증거. 외부 인용 시 n·측정자·holdout·assertion 버전 명시.
80: - objective/hybrid만 자동개선. subjective는 사람.
83: ## 통합 지점 (Phase 6/7 단일 표)
86: | Phase 6 | 측정(with/without·assertion) | `artifact_benchmark.json` |
87: | Phase 6 | 루프 효율 측정 | `loop_scorecard.json` (별도) |
88: | Phase 7 | 감지·제안·holdout 검증·승인·채택·re-baseline | baseline 레지스트리·rollback manifest |

FILE /Users/junghojang/Developments/myProject/myHarness/skills/myharness/SKILL.md lines 498
3: description: "하네스(에이전트 팀 + 스킬)를 구성·확장·점검하는 메타 스킬 (Claude: /myharness · Codex: $myharness). 신규 도메인/프로젝트 자동화 체계 구축, 기존 하네스 재구성·운영·유지보수에 사용. 트리거 — KO: '하네스 구성/구축/설계/엔지니어링', '하네스 점검/감사/현황', '에이전트·스킬 동기화'; EN: 'build a harnes
6: # Harness — The Team-Architecture Factory
13: 5. **품질 게이트 2층 (코드/설계 도메인).** *내부* 생성-검증(같은 세션 QA)과 *외부* 리뷰 루프(codex/gemini 독립 검증)를 병행한다. 같은 컨텍스트 QA는 같은 맹점을 공유하므로 외부 독립 관점이 추가 결함을 잡는다. 단 합의=정답 아님 — 판정 권위는 오케스트레이터. 상세: `references/external-review-loop.md`.
18: ## 항법 (최소 경로 — 기본은 슬림)
19: 팩토리가 커졌어도 **기본은 슬림**. 게이트·평가·자기개선은 *리스크가 오를 때만* 켠다(단순 하네스 강제 금지).
23: | 단순/비코드 · 코드 경량 | Phase 0~7 코어 + 내부 QA (dev-rules만 선택) | 외부 리뷰·TDD·평가·self-improve |
25: | 코드/설계 중대 | + 단계마다 외부 리뷰 + 승인 사다리 + scorecard | 자동 채택(실험) |
29: ## 워크플로우
31: ### Phase 0: 현황 감사
39:    - **운영/유지보수**: 기존 하네스의 감사·수정·동기화 요청 → Phase 7-5 운영/유지보수 워크플로우로 이동
42:    | 변경 유형 | Phase 1 | Phase 2 | Phase 3 | Phase 4 | Phase 5 | Phase 6 |
50: ### Phase 1: 도메인 분석
57: ### Phase 2: 팀 아키텍처 설계
59: #### 2-1. 실행 모드 선택
76: #### 2-2. 아키텍처 패턴 선택
87: #### 2-3. 에이전트 분리 기준
91: ### Phase 3: 에이전트 정의 생성
95: #### 3-0. 기존 에이전트 중복 검토
97: 신규 에이전트 생성 전, `프로젝트/.claude/agents/`의 기존 에이전트와 중복 여부를 확인한다. 하네스를 반복 구축하다 보면 역할이 겹치는 에이전트가 다른 이름으로 누적되기 쉽다.
122: #### 3-1. 교리 주입 (코드/수정 에이전트)
130: ### Phase 4: 스킬 생성
134: #### 4-0. 기존 스킬 중복 검토
136: 신규 스킬 생성 전, `프로젝트/.claude/skills/`의 기존 스킬과 중복 여부를 확인한다. 하네스를 반복 구축하다 보면 기능이 겹치는 스킬이 다른 이름으로 누적되기 쉽다.
140: #### 4-1. 스킬 구조
148:     ├── scripts/    - 반복/결정적 작업용 실행 코드
153: #### 4-2. Description 작성 — 적극적 트리거 유도
157: #### 4-3. 본문 작성 원칙
164: | **반복 코드는 번들링** | 테스트 실행에서 에이전트들이 공통으로 작성하는 스크립트가 발견되면 `scripts/`에 미리 번들링한다. |
167: #### 4-4. Progressive Disclosure (단계적 정보 공개)
191: #### 4-5. 스킬-에이전트 연결 원칙
199: #### 4-6. 외부 리뷰 스킬 생성 (코드/설계 — 도구 연동 확인 후)
202: 1. **점검:** `bash skills/myharness/scripts/check-review-tools.sh` → 끝줄 `AVAILABLE:`. **none**=스킬 생성 안 함(내부 QA만, 보고서·CLAUDE.md에 "도구 미연동 생략" 명시) / **하나만**=그 도구만 쓰는 저하 모드 생성 / **둘 다**=풀 생성.
203: 2. **생성:** `references/external-review-loop.md`(방법론 겸 템플릿)를 타겟 `.claude/skills/external-review-loop/SKILL.md`(듀얼 런타임이면 `.agents/skills/external-review-loop/`에도)로 생성(frontmatter 포함). `check-review-tools.sh`·`build-scoreca
206: ### Phase 5: 통합 및 오케스트레이션
214: #### 5-0. 오케스트레이터 패턴 (모드별)
226: #### 5-1. 데이터 전달 프로토콜
247: #### 5-2. 에러 핸들링
253: #### 5-3. 팀 크기 가이드라인
264: #### 5-4. CLAUDE.md 하네스 포인터 등록
271: ## 하네스: {도메인명}
287: #### 5-5. 후속 작업 지원
295: - "이전 결과 기반으로", "결과 개선"
300: - `_workspace/` 존재 + 사용자가 새 입력 제공 → **새 실행** (기존 _workspace를 `_workspace_{YYYYMMDD_HHMMSS}/`로 이동 — 반복 실행 덮어쓰기 방지, 템플릿과 일치)
305: - 이전 결과 파일이 존재하면 읽고 개선점을 반영
310: #### 5-6. 품질 게이트 (코드/설계 도메인)
318: | 중대 | 계약 변경·비가역·다도메인 | **단계마다** 외부리뷰 + 승인 사다리(PRD→계획서→실행: 각 관문마다 사용자 승인+외부리뷰, 반려 시 해당 단계 재작업; 승인 관문 절차는 external-review-loop Step 7 준용) |
320: **단계 마감 게이트(표준·중대):** 오케스트레이터가 `external-review-loop` 스킬 호출 — **라운드 반복 루프**(codex/gemini 병렬 → 판정 → 확인분만 TDD 수정·게이트 → 수정 diff 재리뷰). **loop-until-dry**(신규 확인 0건 K회 연속) 또는 MAX_ROUNDS에서 종료. 판정 원장(`verdicts.json`)으로 신규만 판정. 근
327: **리뷰 예산(비용·지연 통제):** run당 외부 리뷰 횟수 상한을 두고, **코드 변경 없으면 게이트 생략(skip-when-no-delta)**. 검증된 반복 구간은 `_workspace/.fast-pass` 마커로 우회. 이슈 다수(10+)면 판정 보조로 일괄 처리해 오케스트레이터 컨텍스트 비대화를 막는다.
329: ### Phase 6: 검증 및 테스트
333: #### 6-1. 구조 검증
340: #### 6-2. 실행 모드별 검증
346: #### 6-3. 스킬 실행 테스트
348: > **smoke/full 모드(비용 통제):** 기본은 **smoke** — 스킬당 대표 프롬프트 1개 + 정적 트리거 lint. with/without 비교·20개 트리거 eval·반복 최적화 등 **full**은 명시 요청 또는 릴리스 게이트에서만(스킬 N개면 agent run이 곱셈으로 폭증).
356:    - **Without-skill (baseline)**: 같은 프롬프트를 스킬 없이 수행
358: 3. **결과 평가** — 산출물의 품질을 정성적(사용자 리뷰) + 정량적(assertion 기반) 으로 평가한다. 산출물이 객관적으로 검증 가능한 경우(파일 생성, 데이터 추출 등) assertion을 정의하고, 주관적인 경우(문체, 디자인) 사용자 피드백에 의존한다.
360: 4. **반복 개선 루프** — 테스트 결과에서 문제가 발견되면:
363:    - 사용자가 만족하거나 의미 있는 개선이 더 이상 없을 때까지 반복한다
365: 5. **반복 패턴 번들링** — 테스트 실행에서 에이전트들이 공통으로 작성하는 코드(예: 모든 테스트에서 동일한 헬퍼 스크립트를 생성)가 발견되면, 해당 코드를 `scripts/`에 미리 번들링한다.
367: #### 6-4. 트리거 검증
378: #### 6-5. 드라이런 테스트
385: #### 6-6. 테스트 시나리오 작성
390: ### Phase 7: 하네스 진화
394: #### 7-1. 실행 후 피드백 수집
397: - "결과에서 개선할 부분이 있나요?"
402: #### 7-2. 피드백 반영 경로
414: #### 7-3. 변경 이력
429: #### 7-4. 진화 트리거
432: - 같은 유형의 피드백이 2회 이상 반복될 때
433: - 에이전트가 반복적으로 실패하는 패턴이 발견될 때
435: - **(수치 기반 — 데이터 충분 시)** 누적 `loop_scorecard.json` 추세가 악화: `alignment_score` 롤링 하락 3회 연속, `rounds_normalized` 상승 추세, `overturned_rejection_rate` 임계 초과, 동일 경계 N회 실패. **단, 자동 적용 금지 — 제안만 + 승인 게이트**, `min_adjudicated_claims≥
437: #### 7-5. 운영/유지보수 워크플로우
454: - 수정된 에이전트/스킬의 구조 검증 (Phase 6-1 기준)
455: - 수정 범위가 트리거에 영향을 주면 트리거 검증 (Phase 6-4 기준)
456: - 대규모 변경(아키텍처 변경, 에이전트 3개 이상 추가/삭제) 시 Phase 6-3(실행 테스트), 6-5(드라이런)까지 수행
459: #### 7-6. 런타임 동기화 (듀얼 런타임 — drift 방지)
462: ## 산출물 체크리스트
480: - [ ] (코드/설계) **codex/gemini 연동 점검**(`check-review-tools.sh`) 후 `external-review-loop` 스킬 생성 — 도구 전무면 생략(불필요 스킬 방지) + 단계 게이트 배선, 단계마다 리스크 등급 판정 (Phase 4-6, 5-6)
485: ## 참고
492: - **스킬 테스트 가이드**: `references/skill-testing-guide.md` — 테스트/평가/반복 개선 방법론
494: - **루프 평가/개선**: `references/loop-self-eval.md`(루프 scorecard·alignment·단계적 — 측정만→수동→제안→자동) + `references/self-improvement-loop.md`(생성 산출물 벤치→holdout→승인→채택, 설계만·MVP 단계적·자동 적용 아님). 용어: `loop_scorecard`(루프) vs `artifact_benc
495: - **외부 리뷰 루프**: `references/external-review-loop.md` — codex/gemini 독립 검증 단계 게이트. 방법론 겸 생성 템플릿. **루프 제어(loop-until-dry·MAX_ROUNDS·라운드 카운터)·판정 원장(verdicts.json, dedup vs seen)·수정본 재리뷰·근거수집 위임/확정 비위임**·기각 사유표·커밋 순서·자율 노브 포

FILE /Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh lines 65
2: # loop_scorecard.json을 verdicts.json(+선택 timing.json)에서 기계적으로 계산한다.
3: # LLM 자기보고 제거 — 사실 필드는 스크립트가 산출, LLM은 라벨 해석만.
4: # 사용: build-scorecard.sh <verdicts.json> <out_scorecard.json> [timing.json]
5: #   verdicts.json: {"loop","stage_id","rounds","diff_lines","risk_level","termination_reason",
6: #                   "issues":[{"fingerprint","verdict","round","source"}...]}
7: #   verdict ∈ confirmed|partial|deferred|rejected|duplicate
8: #   regression_catch_rate = (round>1 재리뷰가 잡은 confirmed+partial) / (round==1 confirmed+partial)
9: #     ※ 이것은 "수정 diff에서 잡힌 회귀/누출"이지 전체 산출물 recall이 아니다(과대 해석 금지).
10: set -uo pipefail
13: # graceful degradation: 측정은 부가 기능 — jq 없으면 루프를 깨지 않고 경고만 (eval-unavailable)
14: if ! command -v jq >/dev/null; then
15:   echo '{"eval_status":"eval-unavailable","reason":"jq not installed"}' > "$OUT" 2>/dev/null || true
16:   echo "WARN: jq 없음 → scorecard 생략(eval-unavailable). 루프는 계속." >&2
22: [ -n "$T" ] && [ -f "$T" ] && tok="$(jq -r '.total_tokens // 0' "$T" 2>/dev/null || echo 0)"
33:   # regression: round>1 & confirmed/partial & source=="re-review"
34:   ($i | map(select(.round>1 and (.verdict=="confirmed" or .verdict=="partial") and .source=="re-review")) | length) as $reg_num |
38:   ($i | map(select(.round>1 and (.verdict=="confirmed" or .verdict=="partial") and ((.source//"")|IN("re-review","codex","gemini","orchestrator")|not))) | length) as $bad_src |
40:     schema_version:"1", loop:($d.loop//"external-review"), stage_id:($d.stage_id//"?"),
44:     alignment_score: (if $adj_nondef>0 then (($c + 0.5*$p)/$adj_nondef) else null end),
45:     rejected_rate:   (if $adj>0 then ($r/$adj) else null end),
46:     deferred_rate:   (if $adj>0 then ($df/$adj) else null end),
47:     duplicate_rate:  (if $adj>0 then ($dup/$adj) else null end),
48:     regression_catch_rate: (if $reg_den>0 then ($reg_num/$reg_den) else null end),
50:     cost_per_confirmed: (if $c>0 then ($tok/$c) else null end),
51:     diff_lines:($d.diff_lines//null), risk_level:($d.risk_level//null),
53:     computed_by:"scripts/build-scorecard.sh"
55: echo "scorecard → $OUT"
57: # 집계: stage-level summary.jsonl에 원자적 append(flock — 병렬 경합 방지). 실패는 노출.
60: if command -v flock >/dev/null; then

hook: PostToolUse
hook: PostToolUse Completed
codex
핵심 파일 구조와 충돌 후보를 잡았습니다. 이제 특정 구간만 라인 단위로 더 확인해서 이슈를 정리합니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '9,18p;24,63p;73,80p' /Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md" in /Users/junghojang/Developments/myProject/myHarness
exec
/bin/zsh -lc "sed -n '11,22p;25,58p;69,80p;83,88p' /Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/self-improvement-loop.md" in /Users/junghojang/Developments/myProject/myHarness
exec
/bin/zsh -lc "sed -n '17,45p;67,107p;109,130p;142,193p;195,230p' /Users/junghojang/Developments/myProject/myHarness/docs/self-evaluation-system.md" in /Users/junghojang/Developments/myProject/myHarness
exec
/bin/zsh -lc "sed -n '430,438p;488,496p' /Users/junghojang/Developments/myProject/myHarness/skills/myharness/SKILL.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
## 단계적 도입 (한 번에 다 넣지 말 것)
| 단계 | 내용 | 졸업 기준(다음 단계로) | 자동화 |
|------|------|----------------------|--------|
| **1 (현재 정본)** | `loop_scorecard.json` 로깅만. 측정·기록 | 로깅 **≥ 10회** | 없음 |
| 2 (사람) | 누적 요약을 사람이 수동 검토·판단 | rolling N≥10 + `min_adjudicated_claims≥30` + 사람 sign-off | 없음 |
| 3 (실험) | 수치 트리거가 **개선안 "제안"**만 emit | 제안 holdout 통과율 ≥ θ + 명시 승인 | 제안만 + 승인 게이트 |
| 4 (실험) | holdout 검증 후 자동 흐름 개선 | — | 최후, 승인 필수 |

> **수치(10/30/θ)는 "관찰 시작 최소치"이지 통계적 확정 임계가 아니다** — LLM 평가 노이즈상 비율 지표는 표본이 더 필요할 수 있다. 리스크/단계/리뷰어가 섞이면 신뢰구간을 함께 보고, θ는 리스크 등급별 기본값으로 둔다. 3·4단계는 롤링윈도우·3회 연속 하락 시에만, 단일 실행 노이즈로 흐름을 바꾸지 않는다(플래핑 방지). **2단계까지가 실용 권장 — 3·4(자동 환류)는 실험적**, 데이터 충분+holdout 후에만.

## loop_scorecard.json 스키마 (신규 — grading.json 재사용 아님)
실행 단위 디렉터리에 발행: `_workspace/evals/{loop}/{stage_id}/{run_id}/scorecard.json`.
```json
{
  "schema_version": "1",
  "loop": "external-review",
  "stage_id": "design-auth",
  "run_id": "20260612_1530",
  "rounds": 3,
  "termination_reason": "converged-good | exhausted | max-rounds | failed-quality-gate",
  "verdict_counts": { "confirmed": 6, "partial": 2, "deferred": 1, "rejected": 1, "duplicate": 1 },
  "new_per_round": [10, 1, 0],
  "alignment_score": 0.67,        // (confirmed + 0.5*partial) / adjudicated_non_deferred. deferred 분모 제외
  "rejected_rate": 0.11,          // rejected / adjudicated_new_claims (1-alignment 아님, 별도)
  "deferred_rate": 0.10,
  "duplicate_rate": 0.09,
  "rounds_normalized": 0.6,       // rounds / f(diff_lines, risk_level) — 난이도 보정
  "diff_lines": 120, "risk_level": "standard",
  "cost_per_run_tokens": 48000,
  "cost_per_confirmed": 8000,     // confirmed>0일 때만. 0이면 null
  "quality_label": "gate_pass | failed-quality-gate | converged | n/a",  // 설계단계 품질 자기단정 금지
  "regression_catch_rate": 0.33,  // round>1 재리뷰가 잡은(confirmed+partial) / round1 confirmed+partial. "수정 diff의 회귀/누출"이지 전체 recall 아님
  "warnings": [],                 // round>1 source 태깅 누락 등 — 조용한 0 방지
  "missed_defect_rate": null,     // 진짜 recall: 외부 Ground Truth(seeded·사후 회귀·사용자 반박) 있을 때만
  "overturned_rejection_rate": null,
  "computed_by": "scripts/build-scorecard.sh",  // 사실 필드는 스크립트 계산(LLM 자기보고 아님). quality_label만 LLM 해석
  "links": { "grading": "../grading.json", "timing": "../timing.json", "verdicts": "../../{stage_id}_verdicts.json" }
}
```
- **계산 도출(메타 자기채점 제거):** `verdict_counts`·`rounds`·`new_per_round`·`*_rate`·`cost`·`regression_catch_rate`는 **`scripts/build-scorecard.sh`가 `verdicts.json`+`timing.json`에서 기계적으로 산출**한다. LLM은 라벨 해석에만 관여(`quality_label` 등). 카운트를 LLM이 손으로 적지 않는다(오기·낙관 편향 방지).
- **Lean:** 원본 JSON을 세션에 상시 로드하지 않는다. 파일로만 보존, **Phase 시작 시 요약본만** 읽는다.
- `grading.json`/`timing.json`은 assertion·토큰 정보가 있을 때 **링크**로 연결(중복 보관 금지).

## 메트릭 정의 (교정본)
- **alignment_score** = (confirmed + 0.5·partial) / (adjudicated 중 deferred 제외). 이름 그대로 "리뷰 보고 ↔ 오케스트레이터 판정" 정합도. **리뷰어 건강·정밀도라고 부르지 않는다.**
- **rejected_rate / deferred_rate / duplicate_rate** — 각각 별도. `false_positive_rate`는 *사후 확정 가능*할 때만(기각이 나중에 진짜 결함으로 판명) `overturned_rejection_rate`로 기록.
- **rounds_to_converge** 원시값은 K·MAX_ROUNDS·변경 규모에 좌우 → `diff_lines`·`risk_level`로 정규화한 `rounds_normalized`를 1차 지표로, 원시값은 보조.
- **cost_per_confirmed** confirmed=0이면 분모 0 → `null`. 항상 `cost_per_run`·`cost_per_adjudicated_claim`과 함께 본다.
- **regression_catch_rate (수정 회귀/누출 탐지 — 부분 신호)** = (round>1 재리뷰가 잡은 confirmed+partial) / (**round1** confirmed+partial). round>1은 *수정 diff만* 좁게 재리뷰하므로 이것은 "수정이 만든 회귀/이전 게이트 누출" 탐지율이지 **전체 산출물 recall이 아니다**(미수정 영역 누락은 관측 불가 → 과대 해석 금지). (예: timeout 수정이 2차에서 macOS 결함으로 잡힘.) 분모는 누적이 아닌 round1 기준(희석 방지). round>1 confirmed/partial에 `source` 태깅이 없으면 `warnings`에 기록(조용한 0 방지).
- **missed_defect_rate (진짜 recall)** — 전체 누락은 **외부 Ground Truth**(seeded 결함 탐지율·사후 회귀 역추적·사용자 반박)가 있을 때만. 없으면 null. regression_catch_rate는 보조 신호일 뿐 recall을 대체하지 않는다.
## 판정 보정 (P5 — Ground Truth만)
같은 오케스트레이터·같은 근거수집으로 재점검하면 편향 반복(에코체임버). 보정은 **독립 신호가 있을 때만** 발화: 사용자 반박 / 후속 결함 발견 / 독립 리뷰어 표본 감사. 결과는 `overturned_rejection_rate`로 기록하고, 임계 초과 시 기각 사유표·리뷰어 신뢰도를 *제안* 형태로 조정(자동 적용 금지).

## 환류(P3/P4) 안전장치 — 3·4단계에서만
- 자동 **"적용" 금지 → "제안"**만. 적용 전 사용자 또는 독립 검토 게이트.
- 롤링윈도우(최근 N회 평균)·3회 연속 하락만 발화(단일 노이즈 무시).
- `min_adjudicated_claims ≥ 30` 전에는 트리거 금지(표본 부족).
- 변경 후 holdout 시나리오·기존 회귀 케이스로 검증.

 succeeded in 0ms:

사용자가 명시적으로 "하네스 수정해줘"라고 할 때만이 아니라, 다음 상황에서도 진화를 제안한다:
- 같은 유형의 피드백이 2회 이상 반복될 때
- 에이전트가 반복적으로 실패하는 패턴이 발견될 때
- 사용자가 오케스트레이터를 우회하여 수동으로 작업하는 것이 관찰될 때
- **(수치 기반 — 데이터 충분 시)** 누적 `loop_scorecard.json` 추세가 악화: `alignment_score` 롤링 하락 3회 연속, `rounds_normalized` 상승 추세, `overturned_rejection_rate` 임계 초과, 동일 경계 N회 실패. **단, 자동 적용 금지 — 제안만 + 승인 게이트**, `min_adjudicated_claims≥20` 전 발화 금지(플래핑·Goodhart 방지). 상세: `references/loop-self-eval.md`.

#### 7-5. 운영/유지보수 워크플로우

- 하네스 패턴: `references/agent-design-patterns.md`
- 기존 하네스 예시 (실제 파일 전문 포함): `references/team-examples.md`
- 오케스트레이터 템플릿: `references/orchestrator-template.md`
- **스킬 작성 가이드**: `references/skill-writing-guide.md` — 작성 패턴, 예시, 데이터 스키마 표준
- **스킬 테스트 가이드**: `references/skill-testing-guide.md` — 테스트/평가/반복 개선 방법론
- **QA 에이전트 가이드**: `references/qa-agent-guide.md` — 빌드 하네스에 QA 에이전트를 포함할 때 참조. 통합 정합성 검증 방법론, 경계면 버그 패턴, QA 에이전트 정의 템플릿 포함. 실제 프로젝트에서 발견된 7개 버그 사례 기반.
- **루프 평가/개선**: `references/loop-self-eval.md`(루프 scorecard·alignment·단계적 — 측정만→수동→제안→자동) + `references/self-improvement-loop.md`(생성 산출물 벤치→holdout→승인→채택, 설계만·MVP 단계적·자동 적용 아님). 용어: `loop_scorecard`(루프) vs `artifact_benchmark`(산출물).
- **외부 리뷰 루프**: `references/external-review-loop.md` — codex/gemini 독립 검증 단계 게이트. 방법론 겸 생성 템플릿. **루프 제어(loop-until-dry·MAX_ROUNDS·라운드 카운터)·판정 원장(verdicts.json, dedup vs seen)·수정본 재리뷰·근거수집 위임/확정 비위임**·기각 사유표·커밋 순서·자율 노브 포함.
- **TDD 교리 / 개발 규칙**: `references/tdd-doctrine.md`, `references/dev-rules.md` — 코드/수정 에이전트 작업 원칙 주입용.

 succeeded in 0ms:
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
Full 평가는 비용이 크므로 다음 조건에서만 실행한다.

- 사용자가 명시적으로 품질 검증을 요청
- 하네스가 외부 사용자에게 배포될 예정
- 에이전트 3개 이상 추가/삭제
- 오케스트레이션 구조 변경
- 코드/설계 도메인 중대 위험 작업
- smoke 평가에서 high severity 문제가 발견됨

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

 succeeded in 0ms:
## 2. 용어 분리 (중복 제거)
- **`loop_scorecard.json`** = *오케스트레이션 루프* 효율 (alignment·rounds·cost). `loop-self-eval.md` 소관.
- **`artifact_benchmark.json`** = *생성 스킬/에이전트* 품질 (pass_rate·with/without delta·holdout). 본 문서 소관.
- 오케스트레이터 보고 시 두 지표를 **섞지 않는다**. Phase 6/7 호출 순서·경로는 §3 표.

## 3. MVP 단계 (한 번에 다 만들지 말 것)
| 단계 | 범위 | 자동화 |
|------|------|--------|
| **1 (정본 시작)** | 케이스 스키마 + **최소 러너(§4)** + immutable 결과 기록 + 수동 승인 | 없음 |
| 2 | holdout/champion 비교 + 사람 리포트 | 없음 |
| 3 (실험) | 개정안 *제안* + holdout 검증 결과 제시 | 제안만+승인 |
| 4 (실험) | 승인 기반 채택 · re-baseline · rollback 자동 | 사람 승인 필수 |
## 4. 러너 계약 (미구현이면 설계가 공허 — 최소 스펙 고정)
`run-benchmark.sh`(별도 구현)의 **계약**을 먼저 못박는다:
- **입력:** `{case_id, skill_path, mode: with|without}`.
- **출력:** `grading.json`(`expectations[].passed/evidence`, `summary.pass_rate`) + `timing.json`(tokens·ms) + `run_manifest.json`(skill_hash·assertion_version·runner_version·model·seed·env·case_ids).
- **격리:** 케이스마다 독립 작업디렉토리, read-only 소스, 결정적 seed 기록.
- **재실행:** 동일 입력 → 반복 실행 R회(§8), 결과는 immutable append.
- **실패 처리:** 러너 실패는 "측정 불가"로 기록(채택 근거 안 됨), 루프 불중단.
- **비교식:** `adopt_if = candidate.holdout_score ≥ champion.holdout_score + δ AND candidate ≥ original_reference AND CI 비중첩`.

## 5. 4앵커 + 독립성 (앵커는 필요조건일 뿐)
1. **Ground-Truth assertion** — 객관 검증(파일·데이터·코드 동작)에 채택을 묶는다. judge 단독 금지.
2. **Holdout 분리** — §6.
3. **제안 + 사람 승인** — 자동 채택 금지.
4. **단계적** — §3.
**독립성(충분조건화):** assertion 작성자 ≠ 개정안 생성자, holdout 작성자 ≠ proposal generator(holdout 접근 금지). 채택 비교는 **blind**(candidate/champion 익명). 사람 승인은 rubber-stamp 방지 위해 **승인 체크리스트**(반례 검토·blind 비교 확인·holdout 누수 점검) + 외부 리뷰/사용자 표본. 다수 제안은 **batch best-of-N** 승인.

## 6. Holdout 누수 방지 (LLM 생성 과제는 semantic sibling)
70/30만으론 약함 — 문면이 달라도 같은 도메인·생성 프롬프트면 누수.
- **locked append-only holdout** — 한 번 정하면 고정, 개정 튜닝에 재사용 금지.
- **provenance 기록** + **생성 프롬프트 분리** + **유사도 dedup**(semantic) + **cluster split**(같은 클러스터가 train/holdout 양쪽에 안 가게).
- **external seed** — holdout에 하네스 외부(사람·타 모델) 주입 과제 강제 포함.
- **negative control** — "스킬이 오히려 방해되는" 역기획 과제 포함(과적합 시 여기서 점수 폭락 → 탐지).
- proposal generator는 holdout 내용 열람 금지.

## 7. baseline immutable (표류 방지)
- baseline은 **immutable artifact** — `skill_hash·assertion_version·runner_version·model·env·seed·case_ids·holdout_score·n` 고정.
- 후보는 **current champion AND original/reference baseline 둘 다** 이겨야 채택(국소 표류 차단).
- **정기 재측정** — 모델 업그레이드·assertion 노후 반영(예: 주기적 전체 re-benchmark).
- **assertion 버전 변경 시 baseline 무효화** → 전체 재측정.

## 8. 통계 기준 (플래핑 방지 — 비어있으면 노이즈 채택)
- 리스크별 **최소 holdout n**, **반복 실행 R회**(LLM stochasticity), **bootstrap/CI**, **effect size**, **gray-zone(tie) 보류 정책**.
- 채택은 점수 차 단독 아님 — CI 비중첩 + effect size ≥ 기준 + 회귀 케이스 통과.
- δ·min n·R·θ는 리스크 등급별 기본값 + 관찰 전용 시작(고정 자동화 금지).
## 10. 비용 통제 (벤치가 배보다 배꼽 되지 않게)
- **Tiered:** `smoke`(1~2 케이스) 통과 시에만 `full`(holdout 전체).
- **baseline 캐싱:** without/champion 결과는 skill/assertion/model 불변 동안 영구 캐싱(매번 재실행 금지).
- **cheap-judge:** 측정·감지는 경량 모델(Haiku/Sonnet), 최종 승인 판단만 opus. (SKILL.md 모델 라우팅 준용)

## 11. rollback (artifact 수준 폐쇄)
- 점수만 되돌리면 안 됨. **rollback manifest**: adopted diff·artifact hashes·이전 파일 경로·baseline snapshot·eval case snapshot·command·expected score.
- Phase 7에 rollback 실행 절차 명시(재현 가능).

## 12. 정직한 한계
- 자체측정 벤치 = 약증거. 외부 인용 시 n·측정자·holdout·assertion 버전 명시.
- objective/hybrid만 자동개선. subjective는 사람.
## 통합 지점 (Phase 6/7 단일 표)
| 시점 | 행위 | 산출물 |
|------|------|--------|
| Phase 6 | 측정(with/without·assertion) | `artifact_benchmark.json` |
| Phase 6 | 루프 효율 측정 | `loop_scorecard.json` (별도) |
| Phase 7 | 감지·제안·holdout 검증·승인·채택·re-baseline | baseline 레지스트리·rollback manifest |

hook: PostToolUse
hook: PostToolUse
hook: PostToolUse
hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
남은 확인점은 full judge 계약, 실행 스크립트 존재 여부, 저장 경로입니다. 구현 가능성 이슈를 가르기 위해 파일 목록과 스크립트 계약만 확인합니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '130,151p;232,249p' /Users/junghojang/Developments/myProject/myHarness/docs/self-evaluation-system.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
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

## Scorecard 스키마
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

hook: PostToolUse
exec
/bin/zsh -lc 'find /Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts -maxdepth 1 -type f -print | sort' in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/check-review-tools.sh

hook: PostToolUse
exec
/bin/zsh -lc "sed -n '1,65p' /Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
#!/usr/bin/env bash
# loop_scorecard.json을 verdicts.json(+선택 timing.json)에서 기계적으로 계산한다.
# LLM 자기보고 제거 — 사실 필드는 스크립트가 산출, LLM은 라벨 해석만.
# 사용: build-scorecard.sh <verdicts.json> <out_scorecard.json> [timing.json]
#   verdicts.json: {"loop","stage_id","rounds","diff_lines","risk_level","termination_reason",
#                   "issues":[{"fingerprint","verdict","round","source"}...]}
#   verdict ∈ confirmed|partial|deferred|rejected|duplicate
#   regression_catch_rate = (round>1 재리뷰가 잡은 confirmed+partial) / (round==1 confirmed+partial)
#     ※ 이것은 "수정 diff에서 잡힌 회귀/누출"이지 전체 산출물 recall이 아니다(과대 해석 금지).
set -uo pipefail
V="${1:?verdicts.json 경로}"; OUT="${2:?출력 경로}"; T="${3:-}"

# graceful degradation: 측정은 부가 기능 — jq 없으면 루프를 깨지 않고 경고만 (eval-unavailable)
if ! command -v jq >/dev/null; then
  echo '{"eval_status":"eval-unavailable","reason":"jq not installed"}' > "$OUT" 2>/dev/null || true
  echo "WARN: jq 없음 → scorecard 생략(eval-unavailable). 루프는 계속." >&2
  exit 0
fi

mkdir -p "$(dirname "$OUT")"   # 깊은 출력 경로 보장(없으면 리다이렉션 실패)
tok=0
[ -n "$T" ] && [ -f "$T" ] && tok="$(jq -r '.total_tokens // 0' "$T" 2>/dev/null || echo 0)"

jq -n --slurpfile v "$V" --argjson tok "$tok" '
  ($v[0]) as $d | ($d.issues // []) as $i |
  ($i | map(select(.verdict=="confirmed")) | length) as $c |
  ($i | map(select(.verdict=="partial"))   | length) as $p |
  ($i | map(select(.verdict=="deferred"))  | length) as $df |
  ($i | map(select(.verdict=="rejected"))  | length) as $r |
  ($i | map(select(.verdict=="duplicate")) | length) as $dup |
  (($c+$p+$df+$r)) as $adj |
  (($c+$p+$r)) as $adj_nondef |
  # regression: round>1 & confirmed/partial & source=="re-review"
  ($i | map(select(.round>1 and (.verdict=="confirmed" or .verdict=="partial") and .source=="re-review")) | length) as $reg_num |
  # 분모: round==1 confirmed+partial (초기 라운드 기준 — 누적 아님)
  ($i | map(select(.round==1 and (.verdict=="confirmed" or .verdict=="partial"))) | length) as $reg_den |
  # 태깅 무결성: round>1 confirmed/partial 중 source 누락/비허용 → 경고(조용한 0 방지)
  ($i | map(select(.round>1 and (.verdict=="confirmed" or .verdict=="partial") and ((.source//"")|IN("re-review","codex","gemini","orchestrator")|not))) | length) as $bad_src |
  {
    schema_version:"1", loop:($d.loop//"external-review"), stage_id:($d.stage_id//"?"),
    rounds:($d.rounds // ($i|map(.round)|max // 1)),
    termination_reason:($d.termination_reason//"unknown"),
    verdict_counts:{confirmed:$c,partial:$p,deferred:$df,rejected:$r,duplicate:$dup},
    alignment_score: (if $adj_nondef>0 then (($c + 0.5*$p)/$adj_nondef) else null end),
    rejected_rate:   (if $adj>0 then ($r/$adj) else null end),
    deferred_rate:   (if $adj>0 then ($df/$adj) else null end),
    duplicate_rate:  (if $adj>0 then ($dup/$adj) else null end),
    regression_catch_rate: (if $reg_den>0 then ($reg_num/$reg_den) else null end),
    cost_per_run_tokens:$tok,
    cost_per_confirmed: (if $c>0 then ($tok/$c) else null end),
    diff_lines:($d.diff_lines//null), risk_level:($d.risk_level//null),
    warnings: ( [ if $bad_src>0 then "round>1 confirmed/partial \($bad_src)건 source 태깅 누락 — regression_catch_rate 과소측정 가능" else empty end ] ),
    computed_by:"scripts/build-scorecard.sh"
  }' > "$OUT"
echo "scorecard → $OUT"

# 집계: stage-level summary.jsonl에 원자적 append(flock — 병렬 경합 방지). 실패는 노출.
SUM="$(dirname "$OUT")/../summary.jsonl"
LINE="$(jq -c '{stage_id,rounds,termination_reason,alignment_score,regression_catch_rate,cost_per_run_tokens,warnings}' "$OUT")"
if command -v flock >/dev/null; then
  flock "$SUM.lock" -c "printf '%s\n' '$LINE' >> '$SUM'" || echo "WARN: summary append 실패" >&2
else
  printf '%s\n' "$LINE" >> "$SUM" || echo "WARN: summary append 실패(flock 없음)" >&2
fi

hook: PostToolUse
exec
/bin/zsh -lc 'find /Users/junghojang/Developments/myProject/myHarness/skills/myharness/references -maxdepth 1 -type f -print | sort' in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/agent-design-patterns.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/dev-rules.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/external-review-loop.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/factory-map.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/orchestrator-template.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/qa-agent-guide.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/runtime-adapters.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/self-improvement-loop.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/skill-testing-guide.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/skill-writing-guide.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/tdd-doctrine.md
/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/team-examples.md

hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
검토 대상 확인: `docs/self-evaluation-system.md`, `loop-self-eval.md`, `self-improvement-loop.md`, `SKILL.md` Phase 6/7, `build-scorecard.sh`.

1. [critical] 평가 대상이 정책 품질과 생성 산출물 품질 사이에서 흔들림
- 현황: 문서 초반은 “정책 품질 7축” 평가라고 정의하지만, 뒤에서는 “생성된 하네스 디렉토리 전체”와 `self_eval_scorecard.json` 산출물 점수를 평가한다.
- 이슈: factory 정책 감사, 개별 하네스 산출물 평가, 루프 효율 평가가 한 문서 안에서 섞인다. 구현 시 어떤 점수가 무엇을 대표하는지 불명확.
- 권고: `factory_policy_audit`, `artifact_self_eval`, `loop_scorecard`를 별도 산출물로 분리. 문서도 “정책 감사”와 “생성 산출물 평가” 장을 분리.

2. [critical] `self_eval_scorecard`와 `artifact_benchmark` 동치 표기가 부정확
- 현황: 문서가 `self_eval_scorecard` ≈ `artifact_benchmark`라고 쓴다.
- 이슈: `artifact_benchmark.json`은 with/without, holdout, baseline, runner 계약 중심이다. `self_eval_scorecard.json`은 정적 검사 + judge 점수 중심이다. 동치로 두면 baseline/holdout 통제가 빠진 점수를 benchmark처럼 오용할 위험.
- 권고: “관련 있으나 대체 불가”로 수정. `artifact_benchmark`는 채택/성능 비교용, `self_eval_scorecard`는 생성물 품질 감사용으로 고정.

3. [critical] 실행 구현 없음
- 현황: 현재 스크립트는 `build-scorecard.sh`, `check-review-tools.sh`뿐이다. 문서도 “smoke self-eval 스크립트 추가”를 부족분으로 적는다.
- 이슈: 기본값이 `smoke`인데 실제 smoke runner, schema validator, scorecard writer, 저장 경로 규약이 없다. 정책은 있으나 실행 불가.
- 권고: MVP로 `run-self-eval-smoke.sh` 먼저 정의. 입력 path, 출력 `self_eval_scorecard.json`, exit code, missing dependency 처리, 저장 위치를 고정.

4. [high] `build-scorecard.sh`는 `self_eval_scorecard`가 아니라 `loop_scorecard` 전용
- 현황: `build-scorecard.sh`는 verdicts 기반 `loop_scorecard.json`을 계산한다.
- 이슈: 문서가 현재 프로젝트 재료로 이 스크립트를 들지만, self-eval 점수 필드와 호환되지 않는다. 구현자가 재사용하면 schema mismatch 발생.
- 권고: `build-loop-scorecard.sh`로 이름을 명확히 하거나, 별도 `build-self-eval-scorecard.sh` 추가.

5. [high] 5 증거법의 “독립 검증 가능” 표현 과장
- 현황: Policy audit, golden replay, baseline, external review, scorecard 공개를 독립 증거로 묶는다.
- 이슈: policy audit과 scorecard는 자기검증이다. baseline도 자기 측정이면 약증거. external review만 상대적으로 독립적이며 그마저 동일 컨텍스트/동일 프롬프트면 독립성 제한.
- 권고: 증거 등급을 `self-check`, `controlled benchmark`, `independent review`로 나누고, 독립성 조건을 각 방법에 붙여라.

6. [high] Policy Conformance Audit 우선순위 근거 약함
- 현황: policy audit을 “최우선·저비용”으로 둔다.
- 이슈: 저비용은 맞지만 신뢰도 최우선은 아니다. “Phase 6 존재” 같은 체크박스는 형식 준수만 본다.
- 권고: “첫 번째 실행 단계”와 “가장 강한 증거”를 분리. policy audit은 gate용, 품질 주장은 golden/baseline/external review 기반으로 제한.

7. [high] Full 평가 judge 계약 부재
- 현황: full은 LLM judge와 외부 리뷰를 쓴다고만 한다.
- 이슈: judge 모델, blind 처리, rubric, evidence requirement, adjudication, disagreement 처리, judge contamination 방지가 없다.
- 권고: `self-improvement-loop.md`의 blind/holdout/독립성 규칙을 full judge 계약에 이식. judge output schema와 “판단 불가=null” 기준 추가.

8. [high] `null` 점수 처리와 전체 판정 규칙 없음
- 현황: smoke에서 판단 불가 항목은 `null`.
- 이슈: pass/fail 산출 시 null을 제외할지 0점 처리할지 불명. 평균 점수나 high severity 판정 기준도 없다.
- 권고: aggregate 금지 또는 `scored_axes_count`, `unknown_axes`, `blocking_findings_count`를 별도 필드로 둬라. smoke pass는 점수 평균이 아니라 blocking rule 기반으로 정의.

9. [high] 반복 실패 임계 `5/20`이 기존 정책과 충돌
- 현황: 새 문서는 `min_evaluated_harnesses >= 5` 또는 `min_adjudicated_findings >= 20`. `loop-self-eval.md`는 `min_adjudicated_claims ≥ 30`, SKILL은 loop 추세에 `≥20`.
- 이슈: 단위가 harness, finding, claim으로 섞이고 OR 조건이라 작은 표본에서도 제안이 발화될 수 있다.
- 권고: 산출물 평가용 임계와 루프 평가용 임계를 분리. 최소는 AND 조건 권장: `harnesses >= 5 AND findings >= 20`, loop는 기존 `claims >= 30` 유지 또는 통일.

10. [med] 반복 실패 패턴별 임계 근거 없음
- 현황: 파일 누락 3회, runtime drift 2회, 역할 충돌 3회 등.
- 이슈: 기간, 윈도우, severity, 동일 원인 판정 기준이 없다. 한 프로젝트 반복 실행이 전체 추세처럼 보일 수 있음.
- 권고: rolling window, unique domain count, same-root-cause fingerprint, severity 가중치 추가.

11. [med] smoke/full/off 라우팅 충돌
- 현황: 문서는 기본값 `smoke`, 동시에 `off`는 소규모/초안에 적용. SKILL은 “기본은 슬림, 평가는 리스크 오를 때만”이라고 한다.
- 이슈: “기본 smoke”와 “단순 하네스 강제 금지”가 충돌한다.
- 권고: 기본값을 “generated harness에는 smoke, 단순 질문/초안에는 off”처럼 요청 유형별로 명시.

12. [med] Golden Domain Replay 누수 방지 부족
- 현황: 외부 seed, negative control, holdout 규율 준용을 언급한다.
- 이슈: case registry, locked holdout, provenance, semantic dedup, cluster split, generator 접근 금지가 실행 규칙으로 없다.
- 권고: golden domain set을 파일로 고정하고 train/golden/holdout 분리. 생성자가 holdout 내용을 읽지 못하게 경로와 절차 분리.

13. [med] Baseline 비교가 immutable baseline 정책을 충분히 반영하지 않음
- 현황: plain prompt vs myharness 비교를 제안한다.
- 이슈: model, seed, runner, assertion version, case IDs, R회 반복, CI/effect size가 빠지면 약증거에서 벗어나지 못한다.
- 권고: `self-improvement-loop.md` §7 baseline immutable 계약을 그대로 요구. “X% 우수” 문구는 이 메타데이터 없으면 금지.

14. [med] Scorecard 공개는 증거가 아니라 보고 형식에 가까움
- 현황: 5번째 증거법으로 scorecard 공개를 둔다.
- 이슈: scorecard가 자기채점이면 독립 증거가 아니다. 공개 자체는 투명성이지 검증이 아니다.
- 권고: “Evidence method”가 아니라 “reporting artifact”로 낮춰라. 각 점수마다 `computed_by`, `evaluator`, `evidence_links`, `n`, `blind` 필드 필요.

15. [med] self-eval schema에 재현성 필드 없음
- 현황: schema는 scores/findings/recommendations 중심.
- 이슈: 어떤 버전의 factory, 모델, runner, case set, prompt로 평가했는지 남지 않는다.
- 권고: `factory_version`, `skill_hash`, `runner_version`, `model`, `case_ids`, `eval_started_at`, `evidence_package`, `source_hashes` 추가.

16. [med] smoke 검사가 정적 존재 확인에 치우침
- 현황: 필수 파일, frontmatter, 참조 파일, 이름 충돌 등을 본다.
- 이슈: 역할 충돌, 책임 공백, trigger 품질은 단순 문자열로는 오탐/누락이 많다.
- 권고: smoke는 “candidate warning”까지만. blocking fail은 구조 결손, schema 오류, missing referenced file 같은 결정적 항목으로 제한.

17. [med] runtime consistency 검사가 “양쪽 산출물 존재”에 머묾
- 현황: dual runtime 주장 시 양쪽 산출물 존재 여부를 검사한다.
- 이슈: Claude/Codex agent 의미, skill path, orchestration pointer가 서로 drift해도 통과 가능.
- 권고: semantic parity checklist 추가. agent count/name/role mapping, skill trigger mapping, CLAUDE/AGENTS pointer parity 검사.

18. [med] 외부 리뷰 증거의 독립성 조건 부족
- 현황: codex/gemini 리뷰 로그를 증거로 남긴다.
- 이슈: 같은 근거수집, 같은 설계 설명, 같은 오케스트레이터 판정이면 에코체임버 가능. 기각/미수렴 공개는 좋지만 blind/adjudication 없음.
- 권고: reviewer prompt, input bundle, adjudicator, accepted/rejected rationale, unresolved findings를 schema화. 리뷰어 간 disagreement도 보존.

19. [low] 점수 축 명명 불일치
- 현황: 평가 축은 `역할 충돌`, 예시 표는 `role_conflict_safety`, schema는 `role_conflict`.
- 이슈: 집계와 비교 시 필드 drift 발생.
- 권고: canonical axis ID 표를 하나 두고 문서/JSON/예시를 맞춰라.

20. [low] graceful degradation이 기본 smoke와 충돌 가능
- 현황: `build-scorecard.sh`는 `jq` 없으면 `eval-unavailable` 후 루프 계속.
- 이슈: self-eval도 같은 패턴을 쓰면 기본 smoke가 조용히 비활성화될 수 있다.
- 권고: 부가 loop scorecard는 warn 가능. release/full gate의 self-eval은 dependency missing을 blocking failure로 처리.

21. [low] 과설계 위험
- 현황: smoke/full, 7축, 5증거법, scorecard, golden, baseline, external review, 개선 루프가 한 번에 설계됨.
- 이슈: MVP 전 구현 표면이 크다. 실제로는 runner 없음 상태에서 정책만 늘어난다.
- 권고: 1차 구현은 `smoke runner + schema + 저장 + 요약`으로 제한. golden/baseline/full judge는 phase 2 이후.

총평: 방향은 타당함. 핵심 결함은 “무엇을 평가하는가”와 “어떤 scorecard가 어떤 근거인가”가 아직 분리되지 않은 점. 먼저 용어/산출물 경계를 고정하고, smoke runner 계약부터 구현해야 함.
hook: Stop
hook: Stop Completed
tokens used
59,337
검토 대상 확인: `docs/self-evaluation-system.md`, `loop-self-eval.md`, `self-improvement-loop.md`, `SKILL.md` Phase 6/7, `build-scorecard.sh`.

1. [critical] 평가 대상이 정책 품질과 생성 산출물 품질 사이에서 흔들림
- 현황: 문서 초반은 “정책 품질 7축” 평가라고 정의하지만, 뒤에서는 “생성된 하네스 디렉토리 전체”와 `self_eval_scorecard.json` 산출물 점수를 평가한다.
- 이슈: factory 정책 감사, 개별 하네스 산출물 평가, 루프 효율 평가가 한 문서 안에서 섞인다. 구현 시 어떤 점수가 무엇을 대표하는지 불명확.
- 권고: `factory_policy_audit`, `artifact_self_eval`, `loop_scorecard`를 별도 산출물로 분리. 문서도 “정책 감사”와 “생성 산출물 평가” 장을 분리.

2. [critical] `self_eval_scorecard`와 `artifact_benchmark` 동치 표기가 부정확
- 현황: 문서가 `self_eval_scorecard` ≈ `artifact_benchmark`라고 쓴다.
- 이슈: `artifact_benchmark.json`은 with/without, holdout, baseline, runner 계약 중심이다. `self_eval_scorecard.json`은 정적 검사 + judge 점수 중심이다. 동치로 두면 baseline/holdout 통제가 빠진 점수를 benchmark처럼 오용할 위험.
- 권고: “관련 있으나 대체 불가”로 수정. `artifact_benchmark`는 채택/성능 비교용, `self_eval_scorecard`는 생성물 품질 감사용으로 고정.

3. [critical] 실행 구현 없음
- 현황: 현재 스크립트는 `build-scorecard.sh`, `check-review-tools.sh`뿐이다. 문서도 “smoke self-eval 스크립트 추가”를 부족분으로 적는다.
- 이슈: 기본값이 `smoke`인데 실제 smoke runner, schema validator, scorecard writer, 저장 경로 규약이 없다. 정책은 있으나 실행 불가.
- 권고: MVP로 `run-self-eval-smoke.sh` 먼저 정의. 입력 path, 출력 `self_eval_scorecard.json`, exit code, missing dependency 처리, 저장 위치를 고정.

4. [high] `build-scorecard.sh`는 `self_eval_scorecard`가 아니라 `loop_scorecard` 전용
- 현황: `build-scorecard.sh`는 verdicts 기반 `loop_scorecard.json`을 계산한다.
- 이슈: 문서가 현재 프로젝트 재료로 이 스크립트를 들지만, self-eval 점수 필드와 호환되지 않는다. 구현자가 재사용하면 schema mismatch 발생.
- 권고: `build-loop-scorecard.sh`로 이름을 명확히 하거나, 별도 `build-self-eval-scorecard.sh` 추가.

5. [high] 5 증거법의 “독립 검증 가능” 표현 과장
- 현황: Policy audit, golden replay, baseline, external review, scorecard 공개를 독립 증거로 묶는다.
- 이슈: policy audit과 scorecard는 자기검증이다. baseline도 자기 측정이면 약증거. external review만 상대적으로 독립적이며 그마저 동일 컨텍스트/동일 프롬프트면 독립성 제한.
- 권고: 증거 등급을 `self-check`, `controlled benchmark`, `independent review`로 나누고, 독립성 조건을 각 방법에 붙여라.

6. [high] Policy Conformance Audit 우선순위 근거 약함
- 현황: policy audit을 “최우선·저비용”으로 둔다.
- 이슈: 저비용은 맞지만 신뢰도 최우선은 아니다. “Phase 6 존재” 같은 체크박스는 형식 준수만 본다.
- 권고: “첫 번째 실행 단계”와 “가장 강한 증거”를 분리. policy audit은 gate용, 품질 주장은 golden/baseline/external review 기반으로 제한.

7. [high] Full 평가 judge 계약 부재
- 현황: full은 LLM judge와 외부 리뷰를 쓴다고만 한다.
- 이슈: judge 모델, blind 처리, rubric, evidence requirement, adjudication, disagreement 처리, judge contamination 방지가 없다.
- 권고: `self-improvement-loop.md`의 blind/holdout/독립성 규칙을 full judge 계약에 이식. judge output schema와 “판단 불가=null” 기준 추가.

8. [high] `null` 점수 처리와 전체 판정 규칙 없음
- 현황: smoke에서 판단 불가 항목은 `null`.
- 이슈: pass/fail 산출 시 null을 제외할지 0점 처리할지 불명. 평균 점수나 high severity 판정 기준도 없다.
- 권고: aggregate 금지 또는 `scored_axes_count`, `unknown_axes`, `blocking_findings_count`를 별도 필드로 둬라. smoke pass는 점수 평균이 아니라 blocking rule 기반으로 정의.

9. [high] 반복 실패 임계 `5/20`이 기존 정책과 충돌
- 현황: 새 문서는 `min_evaluated_harnesses >= 5` 또는 `min_adjudicated_findings >= 20`. `loop-self-eval.md`는 `min_adjudicated_claims ≥ 30`, SKILL은 loop 추세에 `≥20`.
- 이슈: 단위가 harness, finding, claim으로 섞이고 OR 조건이라 작은 표본에서도 제안이 발화될 수 있다.
- 권고: 산출물 평가용 임계와 루프 평가용 임계를 분리. 최소는 AND 조건 권장: `harnesses >= 5 AND findings >= 20`, loop는 기존 `claims >= 30` 유지 또는 통일.

10. [med] 반복 실패 패턴별 임계 근거 없음
- 현황: 파일 누락 3회, runtime drift 2회, 역할 충돌 3회 등.
- 이슈: 기간, 윈도우, severity, 동일 원인 판정 기준이 없다. 한 프로젝트 반복 실행이 전체 추세처럼 보일 수 있음.
- 권고: rolling window, unique domain count, same-root-cause fingerprint, severity 가중치 추가.

11. [med] smoke/full/off 라우팅 충돌
- 현황: 문서는 기본값 `smoke`, 동시에 `off`는 소규모/초안에 적용. SKILL은 “기본은 슬림, 평가는 리스크 오를 때만”이라고 한다.
- 이슈: “기본 smoke”와 “단순 하네스 강제 금지”가 충돌한다.
- 권고: 기본값을 “generated harness에는 smoke, 단순 질문/초안에는 off”처럼 요청 유형별로 명시.

12. [med] Golden Domain Replay 누수 방지 부족
- 현황: 외부 seed, negative control, holdout 규율 준용을 언급한다.
- 이슈: case registry, locked holdout, provenance, semantic dedup, cluster split, generator 접근 금지가 실행 규칙으로 없다.
- 권고: golden domain set을 파일로 고정하고 train/golden/holdout 분리. 생성자가 holdout 내용을 읽지 못하게 경로와 절차 분리.

13. [med] Baseline 비교가 immutable baseline 정책을 충분히 반영하지 않음
- 현황: plain prompt vs myharness 비교를 제안한다.
- 이슈: model, seed, runner, assertion version, case IDs, R회 반복, CI/effect size가 빠지면 약증거에서 벗어나지 못한다.
- 권고: `self-improvement-loop.md` §7 baseline immutable 계약을 그대로 요구. “X% 우수” 문구는 이 메타데이터 없으면 금지.

14. [med] Scorecard 공개는 증거가 아니라 보고 형식에 가까움
- 현황: 5번째 증거법으로 scorecard 공개를 둔다.
- 이슈: scorecard가 자기채점이면 독립 증거가 아니다. 공개 자체는 투명성이지 검증이 아니다.
- 권고: “Evidence method”가 아니라 “reporting artifact”로 낮춰라. 각 점수마다 `computed_by`, `evaluator`, `evidence_links`, `n`, `blind` 필드 필요.

15. [med] self-eval schema에 재현성 필드 없음
- 현황: schema는 scores/findings/recommendations 중심.
- 이슈: 어떤 버전의 factory, 모델, runner, case set, prompt로 평가했는지 남지 않는다.
- 권고: `factory_version`, `skill_hash`, `runner_version`, `model`, `case_ids`, `eval_started_at`, `evidence_package`, `source_hashes` 추가.

16. [med] smoke 검사가 정적 존재 확인에 치우침
- 현황: 필수 파일, frontmatter, 참조 파일, 이름 충돌 등을 본다.
- 이슈: 역할 충돌, 책임 공백, trigger 품질은 단순 문자열로는 오탐/누락이 많다.
- 권고: smoke는 “candidate warning”까지만. blocking fail은 구조 결손, schema 오류, missing referenced file 같은 결정적 항목으로 제한.

17. [med] runtime consistency 검사가 “양쪽 산출물 존재”에 머묾
- 현황: dual runtime 주장 시 양쪽 산출물 존재 여부를 검사한다.
- 이슈: Claude/Codex agent 의미, skill path, orchestration pointer가 서로 drift해도 통과 가능.
- 권고: semantic parity checklist 추가. agent count/name/role mapping, skill trigger mapping, CLAUDE/AGENTS pointer parity 검사.

18. [med] 외부 리뷰 증거의 독립성 조건 부족
- 현황: codex/gemini 리뷰 로그를 증거로 남긴다.
- 이슈: 같은 근거수집, 같은 설계 설명, 같은 오케스트레이터 판정이면 에코체임버 가능. 기각/미수렴 공개는 좋지만 blind/adjudication 없음.
- 권고: reviewer prompt, input bundle, adjudicator, accepted/rejected rationale, unresolved findings를 schema화. 리뷰어 간 disagreement도 보존.

19. [low] 점수 축 명명 불일치
- 현황: 평가 축은 `역할 충돌`, 예시 표는 `role_conflict_safety`, schema는 `role_conflict`.
- 이슈: 집계와 비교 시 필드 drift 발생.
- 권고: canonical axis ID 표를 하나 두고 문서/JSON/예시를 맞춰라.

20. [low] graceful degradation이 기본 smoke와 충돌 가능
- 현황: `build-scorecard.sh`는 `jq` 없으면 `eval-unavailable` 후 루프 계속.
- 이슈: self-eval도 같은 패턴을 쓰면 기본 smoke가 조용히 비활성화될 수 있다.
- 권고: 부가 loop scorecard는 warn 가능. release/full gate의 self-eval은 dependency missing을 blocking failure로 처리.

21. [low] 과설계 위험
- 현황: smoke/full, 7축, 5증거법, scorecard, golden, baseline, external review, 개선 루프가 한 번에 설계됨.
- 이슈: MVP 전 구현 표면이 크다. 실제로는 runner 없음 상태에서 정책만 늘어난다.
- 권고: 1차 구현은 `smoke runner + schema + 저장 + 요약`으로 제한. golden/baseline/full judge는 phase 2 이후.

총평: 방향은 타당함. 핵심 결함은 “무엇을 평가하는가”와 “어떤 scorecard가 어떤 근거인가”가 아직 분리되지 않은 점. 먼저 용어/산출물 경계를 고정하고, smoke runner 계약부터 구현해야 함.
