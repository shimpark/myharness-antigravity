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
session id: 019ebc5c-0e33-7ad2-8646-711640116ac6
--------
user
리뷰 대상(작업결과 문서): _workspace/reviews/loop-eval-v2_artifact.md — 하네스 팩토리의 루프 자체 평가 성숙도 개선(우선순위 1~4) 결과.
관련 파일: skills/myharness/references/loop-self-eval.md, external-review-loop.md, scripts/build-scorecard.sh.
이 개선의 타당성·정합성·구현 정확성을 리뷰해 이슈를 모두 보고하라:
- escaped_defect_rate가 내부 recall 프록시로 타당한가, round/source 태깅 의존의 약점, 오·과대 측정 위험
- build-scorecard.sh 계산 정확성·엣지(0분모, jq 부재, source 누락, summary append 동시성)
- 졸업 기준 수치(10/20/θ)·표본 충분성·근거
- design-ok 라벨이 또 다른 자기채점(체크리스트 자기충족)으로 흐를 위험
- 기존 정책(external-review-loop·loop-self-eval)과의 정합·중복·모순, 과설계 여부, 단순화 지점
<이슈 작성 방법>
1. [레벨(critical/high/med/low)] 제목
- 현황: / - 이슈: / - 권고:
</이슈 작성 방법>
hook: SessionStart
hook: SessionStart Completed
hook: UserPromptSubmit
hook: UserPromptSubmit Completed
codex
context-mode 규칙 적용. 먼저 사용 가능한 ctx 도구 확인하고, 관련 문서만 색인/검색해 리뷰 근거 뽑겠습니다.
mcp: context-mode/ctx_execute_file started
mcp: context-mode/ctx_execute_file (failed)
user cancelled MCP tool call
codex
도구 호출 취소됨. 전체 파일을 대화에 붓지 않고, 파일별 출력은 ctx 인덱스에 저장한 뒤 관련 구간만 검색하겠습니다.
mcp: context-mode/ctx_batch_execute started
mcp: context-mode/ctx_batch_execute (failed)
user cancelled MCP tool call
codex
ctx MCP가 연속 취소되어 진행 불가. 폴백으로 `rg`/짧은 범위 출력만 사용해 필요한 라인만 확인합니다. 원문 전체 덤프는 피하겠습니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc 'rg -n "escaped_defect_rate|recall|round|source|tag|graduat|졸업|10|20|theta|θ|design-ok|checklist|self|자기" _workspace/reviews/loop-eval-v2_artifact.md skills/myharness/references/loop-self-eval.md skills/myharness/references/external-review-loop.md skills/myharness/scripts/build-scorecard.sh' in /Users/junghojang/Developments/myProject/myHarness
exec
/bin/zsh -lc 'rg -n "jq|denominator|0|summary|append|flock|source|review_summary|defect|escape|ROUND|SOURCE|design-ok" skills/myharness/scripts/build-scorecard.sh skills/myharness/references/loop-self-eval.md skills/myharness/references/external-review-loop.md _workspace/reviews/loop-eval-v2_artifact.md' in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
skills/myharness/references/loop-self-eval.md:12:| **1 (현재 정본)** | `loop_scorecard.json` 로깅만. 측정·기록 | 로깅 **≥ 10회**(`scorecard-summary` 집계 가능) | 없음 |
skills/myharness/references/loop-self-eval.md:13:| 2 | 누적 scorecard 요약을 사람이 수동 검토 | rolling N≥10 + `min_adjudicated_claims≥20` + 사람 sign-off | 없음 |
skills/myharness/references/loop-self-eval.md:17:> 3·4단계는 롤링윈도우(최근 N회)·3회 연속 하락·`min_adjudicated_claims ≥ 20` 충족 시에만. 단일 실행 노이즈로 프롬프트/게이트를 바꾸지 않는다(플래핑 방지). "충분 데이터"는 위 졸업 기준 수치로만 판단(메타 모호성 제거).
skills/myharness/references/loop-self-eval.md:21:- `scripts/build-scorecard.sh`가 매 루프 종료 시 scorecard 발행 + `_workspace/evals/{loop}/summary.json`에 최근 N회 집계(append).
skills/myharness/references/loop-self-eval.md:22:- 오케스트레이터는 **Phase 0(현황 감사)·Phase 7(진화) 진입 시 `summary.json` 1줄 요약만** 읽는다(원본 JSON 미로드 — Lean). 악화 추세가 보이면 사람에게 보고(2단계 수동 검토).
skills/myharness/references/loop-self-eval.md:31:  "run_id": "20260612_1530",
skills/myharness/references/loop-self-eval.md:35:  "new_per_round": [10, 1, 0],
skills/myharness/references/loop-self-eval.md:36:  "alignment_score": 0.67,        // (confirmed + 0.5*partial) / adjudicated_non_deferred. deferred 분모 제외
skills/myharness/references/loop-self-eval.md:37:  "rejected_rate": 0.11,          // rejected / adjudicated_new_claims (1-alignment 아님, 별도)
skills/myharness/references/loop-self-eval.md:38:  "deferred_rate": 0.10,
skills/myharness/references/loop-self-eval.md:39:  "duplicate_rate": 0.09,
skills/myharness/references/loop-self-eval.md:40:  "rounds_normalized": 0.6,       // rounds / f(diff_lines, risk_level) — 난이도 보정
skills/myharness/references/loop-self-eval.md:41:  "diff_lines": 120, "risk_level": "standard",
skills/myharness/references/loop-self-eval.md:42:  "cost_per_run_tokens": 48000,
skills/myharness/references/loop-self-eval.md:43:  "cost_per_confirmed": 8000,     // confirmed>0일 때만. 0이면 null
skills/myharness/references/loop-self-eval.md:44:  "quality_label": "gate_pass | failed-quality-gate | design-ok | n/a",
skills/myharness/references/loop-self-eval.md:45:  "escaped_defect_rate": 0.17,    // 수정본 재리뷰 기반 내부 recall 프록시 (아래). 데이터 없으면 null
skills/myharness/references/loop-self-eval.md:46:  "missed_defect_rate": null,     // 외부 Ground Truth(seeded 등) 있을 때만
skills/myharness/references/loop-self-eval.md:52:- **계산 도출(메타 자기채점 제거):** `verdict_counts`·`rounds`·`new_per_round`·`*_rate`·`cost`·`escaped_defect_rate`는 **`scripts/build-scorecard.sh`가 `verdicts.json`+`timing.json`에서 기계적으로 산출**한다. LLM은 라벨 해석에만 관여(`quality_label` 등). 카운트를 LLM이 손으로 적지 않는다(오기·낙관 편향 방지).
skills/myharness/references/loop-self-eval.md:57:- **alignment_score** = (confirmed + 0.5·partial) / (adjudicated 중 deferred 제외). 이름 그대로 "리뷰 보고 ↔ 오케스트레이터 판정" 정합도. **리뷰어 건강·정밀도라고 부르지 않는다.**
skills/myharness/references/loop-self-eval.md:59:- **rounds_to_converge** 원시값은 K·MAX_ROUNDS·변경 규모에 좌우 → `diff_lines`·`risk_level`로 정규화한 `rounds_normalized`를 1차 지표로, 원시값은 보조.
skills/myharness/references/loop-self-eval.md:60:- **cost_per_confirmed** confirmed=0이면 분모 0 → `null`. 항상 `cost_per_run`·`cost_per_adjudicated_claim`과 함께 본다.
skills/myharness/references/loop-self-eval.md:61:- **escaped_defect_rate (내부 recall 프록시 — 핵심)** = (round N+1 재리뷰가 **이전 라운드 게이트를 통과한 산출물**에서 새로 확인한 결함 수) / (이전 라운드 confirmed 수). 수정본 재리뷰가 이미 루프에 있으므로 **공짜로 얻는 Ground-Truth-ish 신호** — "게이트가 놓친 결함" 측정. (예: timeout 수정이 다음 라운드/2차에서 macOS 결함으로 잡힘 = escaped.) 이것으로 alignment_score 단독의 해석 불능(노이즈 리뷰어 vs 엄격 판정)을 보완한다.
skills/myharness/references/loop-self-eval.md:62:- **missed_defect_rate (외부 recall)** — escaped로도 못 잡는 진짜 누락은 **외부 Ground Truth**(seeded 결함 탐지율·사후 회귀 역추적·사용자 반박)가 있을 때만. 없으면 null + escaped_defect_rate로 갈음.
skills/myharness/references/loop-self-eval.md:66:- `converged-good`: 신규 확인 0건 K회 + (코드 단계) 게이트 PASS·assertion ≥ θ.
skills/myharness/references/loop-self-eval.md:67:- `exhausted`: 신규 0건이나 품질 신호 부재/미달(소진).
skills/myharness/references/loop-self-eval.md:68:- `max-rounds`: MAX_ROUNDS 강제 종료(미수렴 보고).
skills/myharness/references/loop-self-eval.md:69:- `failed-quality-gate`: 품질 θ 미달이 명백 → **루프 중단**(MAX_ROUNDS 헛돌지 않게, 비용 폭증 방지).
skills/myharness/references/loop-self-eval.md:70:- **`design-ok` (설계/문서 단계 양의 신호):** 게이트가 없는 단계는 `exhausted`로 오라벨하지 말 것. 신규 확인 0건 + **verdicts.json 완료 + 정본 대조 체크리스트 PASS**면 `design-ok`(양호 수렴). 체크리스트 미충족일 때만 `exhausted`.
skills/myharness/references/loop-self-eval.md:78:- `min_adjudicated_claims ≥ 20` 전에는 트리거 금지(표본 부족).
_workspace/reviews/loop-eval-v2_artifact.md:7:### 1. escaped_defect_rate — 내부 recall 프록시 (recall 공백 해소)
_workspace/reviews/loop-eval-v2_artifact.md:9:- 근거: 수정본 재리뷰가 이미 루프에 존재 → 추가 비용 0의 Ground-Truth-ish 신호. 게이트가 놓친 결함(누출)을 측정.
_workspace/reviews/loop-eval-v2_artifact.md:10:- alignment_score 단독의 해석 불능(노이즈 리뷰어 vs 엄격 판정)을 보완. missed_defect_rate(외부 GT)는 seeded 등 있을 때만.
_workspace/reviews/loop-eval-v2_artifact.md:13:- `scripts/build-scorecard.sh`: verdict_counts·rounds·alignment_score·*_rate·escaped_defect_rate·cost를 `verdicts.json`(+timing.json)에서 **jq로 기계 계산**.
_workspace/reviews/loop-eval-v2_artifact.md:15:- 검증: 샘플 verdicts로 alignment 0.7·escaped 0.33 정확 산출 확인. `summary.json` 집계 append.
_workspace/reviews/loop-eval-v2_artifact.md:18:- 졸업 기준: 1→2 로깅≥10회, 2→3 rolling N≥10+min_adjudicated_claims≥20+사람 sign-off, 3→4 holdout 통과율≥θ+승인. "충분 데이터" 메타 모호성 제거.
_workspace/reviews/loop-eval-v2_artifact.md:19:- 읽기 경로: build-scorecard가 summary.json 집계 → 오케스트레이터가 Phase 0/7 진입 시 **요약만** 읽음(write-only 로그 방지, Lean 유지).
_workspace/reviews/loop-eval-v2_artifact.md:22:- 게이트 없는 설계/문서 단계: 신규 0건 + verdicts 완료 + 정본 대조 체크리스트 PASS면 **`design-ok`**(양호 수렴). 미충족만 `exhausted`. 기존엔 설계 리뷰가 거의 `exhausted`로 오라벨되던 문제 해소.
_workspace/reviews/loop-eval-v2_artifact.md:28:- escaped_defect_rate 산식이 내부 recall 프록시로 타당한가? round>1 source 태깅에 의존하는 약점은?
_workspace/reviews/loop-eval-v2_artifact.md:29:- build-scorecard.sh의 계산 정확성·엣지(0분모·jq 부재·source 누락).
_workspace/reviews/loop-eval-v2_artifact.md:30:- 졸업 기준 수치(10/20/θ)의 근거·표본 충분성.
_workspace/reviews/loop-eval-v2_artifact.md:31:- design-ok 라벨이 또 다른 자기채점(체크리스트 자기충족)으로 흐를 위험.
skills/myharness/references/external-review-loop.md:27:round = 1; dry_streak = 0
skills/myharness/references/external-review-loop.md:31:  if 신규_확인 == 0: dry_streak += 1
skills/myharness/references/external-review-loop.md:32:  else: dry_streak = 0; Step 5~7 (신규_확인만 수정·게이트·기록)
skills/myharness/references/external-review-loop.md:34:  if round >= MAX_ROUNDS(기본 3): break + 잔여 미수렴 보고
skills/myharness/references/external-review-loop.md:37:- **K회 연속 신규 확인 0건**이면 수렴 종료. **MAX_ROUNDS 도달 시 강제 종료 + 미수렴 이슈 보고**(무한 루프 차단). **품질 θ 미달이 명백하면 `failed-quality-gate`로 즉시 중단**(MAX_ROUNDS 헛돌지 않게). 종료 사유는 `converged-good`/`exhausted`/`max-rounds`/`failed-quality-gate` 라벨로 기록. (gate/assertion은 코드 단계 전용 — 설계·문서는 `verdicts.json` 완료+정본 대조로 종료. 상세: `loop-self-eval.md`)
skills/myharness/references/external-review-loop.md:62:${TO:+$TO 600s} codex exec --sandbox read-only "$(cat _workspace/reviews/{단계ID}_prompt_general.md)" < /dev/null \
skills/myharness/references/external-review-loop.md:66:${TO:+$TO 600s} gemini -p "$(cat _workspace/reviews/{단계ID}_prompt_perf.md)" < /dev/null \
skills/myharness/references/external-review-loop.md:76:두 출력에서 이슈 추출 → 중복 병합(동일 대상·동일 결함=1건, 출처 병기) → 번호 재부여. **`verdicts.json` 원장과 대조해 이미 판정된(기각/이월/기수정) 이슈는 제외하고 신규만 Step 4로** (dedup vs seen). 리뷰 보고 0건이면 "외부 리뷰 — 이슈 0건" 기록, dry_streak +1.
skills/myharness/references/external-review-loop.md:79:신규 이슈마다 실코드/실문서 대조(grep/Read) 후 판정. **이슈 10+건이면 이슈별/배치로 판정 보조 에이전트에 위임** — 보조는 실코드 대조 근거 + 판정 *초안(draft)*만 반환(쓰기 금지). 오케스트레이터는 초안을 받아 **최종 확정(confirm)**만 직접 수행(권위 비위임). 판정 결과는 `verdicts.json`에 기록(이슈지문·판정·라운드·근거).
skills/myharness/references/external-review-loop.md:90:## Step 5 — 확인분 TDD 수정 (확인 0건이면 생략)
skills/myharness/references/external-review-loop.md:91:**'확인/부분 확인'이 0건이면 Step 5~7을 생략**하고 판정 기록만 남긴 뒤 dry_streak +1로 루프 제어로 복귀(전부 기각/이월인데 수정·게이트 도는 낭비 방지). 확인분이 있으면: `tdd-doctrine.md` 규율(Red→Green→Refactor, 구조/행위 분리). 다중 에이전트 병렬 시 파일권 명시 분리(병렬 충돌 = 1차 실패 주원인). 에이전트는 커밋·브랜치 금지, status는 `_workspace/status/`.
skills/myharness/references/external-review-loop.md:104:루프 종료 시 **`bash scripts/build-scorecard.sh {단계ID}_verdicts.json _workspace/evals/external-review/{단계ID}/{run_id}/scorecard.json [timing.json]`** 실행 — verdict_counts·rounds·`alignment_score`(정밀도 아님)·`*_rate`·cost·**`escaped_defect_rate`**(round>1 재리뷰가 잡은 이전 라운드 누출 = 내부 recall)를 **스크립트가 verdicts.json에서 기계 계산**(LLM 자기보고 아님). 라벨(`converged-good`/`design-ok`/`exhausted`/...)만 오케스트레이터가 해석. **측정·기록만**, 자동 흐름 변경 없음.
skills/myharness/references/external-review-loop.md:105:- `verdicts.json` 각 이슈에 `round`·`source` 기록(round>1 재리뷰분은 `source:"re-review"`)해야 escaped 계산됨.
skills/myharness/references/external-review-loop.md:106:- 스크립트가 `summary.json`에 집계 append → Phase 0/7 진입 시 **요약만** 읽음(읽기 경로, Lean). 스키마·졸업 기준·단계적 도입은 `loop-self-eval.md`. (jq 필요)
skills/myharness/references/external-review-loop.md:112:- **정상(수렴)**: round1 — codex 8+gemini 3→중복 1 병합→10건 판정(확인6/부분2/이월1/기각1)→수정·게이트 PASS·기록. round2 — 수정 diff 재리뷰, 신규 확인 0 → dry_streak 1=K → 종료.
skills/myharness/references/external-review-loop.md:113:- **수정이 새 결함(재리뷰 효과)**: round2에서 수정분 재리뷰가 신규 확인 1건 발견 → 수정 → round3 신규 0 → 종료.
skills/myharness/scripts/build-scorecard.sh:5:#   verdicts.json 형식: {"issues":[{"fingerprint","verdict","round","source"}...],
skills/myharness/scripts/build-scorecard.sh:8:#   escaped: round>1에서 verdict=confirmed 이고 source="re-review"인 건(이전 라운드 게이트 누출)
skills/myharness/scripts/build-scorecard.sh:12:command -v jq >/dev/null || { echo "jq 필요(brew install jq)"; exit 2; }
skills/myharness/scripts/build-scorecard.sh:14:tok=0
skills/myharness/scripts/build-scorecard.sh:15:[ -n "$T" ] && [ -f "$T" ] && tok="$(jq -r '.total_tokens // 0' "$T" 2>/dev/null || echo 0)"
skills/myharness/scripts/build-scorecard.sh:17:jq -n --slurpfile v "$V" --argjson tok "$tok" '
skills/myharness/scripts/build-scorecard.sh:18:  ($v[0]) as $d | ($d.issues // []) as $i |
skills/myharness/scripts/build-scorecard.sh:26:  ($i | map(select(.round>1 and .verdict=="confirmed" and .source=="re-review")) | length) as $esc |
skills/myharness/scripts/build-scorecard.sh:32:    alignment_score: (if $adj_nondef>0 then (($c + 0.5*$p)/$adj_nondef) else null end),
skills/myharness/scripts/build-scorecard.sh:33:    rejected_rate:   (if $adj>0 then ($r/$adj) else null end),
skills/myharness/scripts/build-scorecard.sh:34:    deferred_rate:   (if $adj>0 then ($df/$adj) else null end),
skills/myharness/scripts/build-scorecard.sh:35:    duplicate_rate:  (if $adj>0 then ($dup/$adj) else null end),
skills/myharness/scripts/build-scorecard.sh:36:    escaped_defect_rate: (if $c>0 then ($esc/$c) else null end),
skills/myharness/scripts/build-scorecard.sh:38:    cost_per_confirmed: (if $c>0 then ($tok/$c) else null end),
skills/myharness/scripts/build-scorecard.sh:43:# 집계: summary.json에 append (최근 N회 추세용)
skills/myharness/scripts/build-scorecard.sh:44:SUM="$(dirname "$OUT")/../summary.json"
skills/myharness/scripts/build-scorecard.sh:45:jq -c '{stage_id,rounds,termination_reason,alignment_score,escaped_defect_rate,cost_per_run_tokens}' "$OUT" >> "$SUM" 2>/dev/null || true

 succeeded in 0ms:
skills/myharness/references/loop-self-eval.md:3:루프(external-review-loop 등)가 자기 실행을 측정해 흐름 개선으로 환류하는 닫힌 고리. **외부 리뷰(codex/gemini) 검증을 거쳐 교정된 정본** — 순진한 precision·자동 적용·grading.json 재사용을 모두 제거했다.
skills/myharness/references/loop-self-eval.md:6:- **자기채점 ≠ 품질.** 오케스트레이터가 자기 판정으로 산출한 지표는 "정밀도"가 아니라 *자기와의 정합도*다. 그래서 precision이 아니라 **`alignment_score`**로 부른다. 리뷰어가 아무것도 안 내도 alignment는 좋아 보인다 — **놓친 결함(recall/miss)은 Ground Truth로만** 측정한다(아래).
skills/myharness/references/loop-self-eval.md:10:| 단계 | 내용 | 졸업 기준(다음 단계로) | 자동화 |
skills/myharness/references/loop-self-eval.md:12:| **1 (현재 정본)** | `loop_scorecard.json` 로깅만. 측정·기록 | 로깅 **≥ 10회**(`scorecard-summary` 집계 가능) | 없음 |
skills/myharness/references/loop-self-eval.md:13:| 2 | 누적 scorecard 요약을 사람이 수동 검토 | rolling N≥10 + `min_adjudicated_claims≥20` + 사람 sign-off | 없음 |
skills/myharness/references/loop-self-eval.md:14:| 3 | 수치 트리거가 **개선안 "제안"**만 emit (적용 X) | 제안의 holdout 통과율 ≥ θ + 명시 승인 | 제안만 + 승인 게이트 |
skills/myharness/references/loop-self-eval.md:17:> 3·4단계는 롤링윈도우(최근 N회)·3회 연속 하락·`min_adjudicated_claims ≥ 20` 충족 시에만. 단일 실행 노이즈로 프롬프트/게이트를 바꾸지 않는다(플래핑 방지). "충분 데이터"는 위 졸업 기준 수치로만 판단(메타 모호성 제거).
skills/myharness/references/loop-self-eval.md:25:실행 단위 디렉터리에 발행: `_workspace/evals/{loop}/{stage_id}/{run_id}/scorecard.json`.
skills/myharness/references/loop-self-eval.md:30:  "stage_id": "design-auth",
skills/myharness/references/loop-self-eval.md:31:  "run_id": "20260612_1530",
skills/myharness/references/loop-self-eval.md:32:  "rounds": 3,
skills/myharness/references/loop-self-eval.md:33:  "termination_reason": "converged-good | exhausted | max-rounds | failed-quality-gate",
skills/myharness/references/loop-self-eval.md:35:  "new_per_round": [10, 1, 0],
skills/myharness/references/loop-self-eval.md:38:  "deferred_rate": 0.10,
skills/myharness/references/loop-self-eval.md:40:  "rounds_normalized": 0.6,       // rounds / f(diff_lines, risk_level) — 난이도 보정
skills/myharness/references/loop-self-eval.md:41:  "diff_lines": 120, "risk_level": "standard",
skills/myharness/references/loop-self-eval.md:44:  "quality_label": "gate_pass | failed-quality-gate | design-ok | n/a",
skills/myharness/references/loop-self-eval.md:45:  "escaped_defect_rate": 0.17,    // 수정본 재리뷰 기반 내부 recall 프록시 (아래). 데이터 없으면 null
skills/myharness/references/loop-self-eval.md:46:  "missed_defect_rate": null,     // 외부 Ground Truth(seeded 등) 있을 때만
skills/myharness/references/loop-self-eval.md:48:  "computed_by": "scripts/build-scorecard.sh",  // 사실 필드는 스크립트 계산(LLM 자기보고 아님)
skills/myharness/references/loop-self-eval.md:49:  "links": { "grading": "../grading.json", "timing": "../timing.json", "verdicts": "../../{stage_id}_verdicts.json" }
skills/myharness/references/loop-self-eval.md:52:- **계산 도출(메타 자기채점 제거):** `verdict_counts`·`rounds`·`new_per_round`·`*_rate`·`cost`·`escaped_defect_rate`는 **`scripts/build-scorecard.sh`가 `verdicts.json`+`timing.json`에서 기계적으로 산출**한다. LLM은 라벨 해석에만 관여(`quality_label` 등). 카운트를 LLM이 손으로 적지 않는다(오기·낙관 편향 방지).
skills/myharness/references/loop-self-eval.md:59:- **rounds_to_converge** 원시값은 K·MAX_ROUNDS·변경 규모에 좌우 → `diff_lines`·`risk_level`로 정규화한 `rounds_normalized`를 1차 지표로, 원시값은 보조.
skills/myharness/references/loop-self-eval.md:61:- **escaped_defect_rate (내부 recall 프록시 — 핵심)** = (round N+1 재리뷰가 **이전 라운드 게이트를 통과한 산출물**에서 새로 확인한 결함 수) / (이전 라운드 confirmed 수). 수정본 재리뷰가 이미 루프에 있으므로 **공짜로 얻는 Ground-Truth-ish 신호** — "게이트가 놓친 결함" 측정. (예: timeout 수정이 다음 라운드/2차에서 macOS 결함으로 잡힘 = escaped.) 이것으로 alignment_score 단독의 해석 불능(노이즈 리뷰어 vs 엄격 판정)을 보완한다.
skills/myharness/references/loop-self-eval.md:62:- **missed_defect_rate (외부 recall)** — escaped로도 못 잡는 진짜 누락은 **외부 Ground Truth**(seeded 결함 탐지율·사후 회귀 역추적·사용자 반박)가 있을 때만. 없으면 null + escaped_defect_rate로 갈음.
skills/myharness/references/loop-self-eval.md:66:- `converged-good`: 신규 확인 0건 K회 + (코드 단계) 게이트 PASS·assertion ≥ θ.
skills/myharness/references/loop-self-eval.md:68:- `max-rounds`: MAX_ROUNDS 강제 종료(미수렴 보고).
skills/myharness/references/loop-self-eval.md:69:- `failed-quality-gate`: 품질 θ 미달이 명백 → **루프 중단**(MAX_ROUNDS 헛돌지 않게, 비용 폭증 방지).
skills/myharness/references/loop-self-eval.md:70:- **`design-ok` (설계/문서 단계 양의 신호):** 게이트가 없는 단계는 `exhausted`로 오라벨하지 말 것. 신규 확인 0건 + **verdicts.json 완료 + 정본 대조 체크리스트 PASS**면 `design-ok`(양호 수렴). 체크리스트 미충족일 때만 `exhausted`.
skills/myharness/references/loop-self-eval.md:72:## 판정 보정 (P5 — Ground Truth만)
skills/myharness/references/loop-self-eval.md:78:- `min_adjudicated_claims ≥ 20` 전에는 트리거 금지(표본 부족).
skills/myharness/references/loop-self-eval.md:80:- θ·ε·N은 리스크 등급별 기본값 + 관찰 전용 시작(고정 자동화 금지).
skills/myharness/scripts/build-scorecard.sh:3:# LLM 자기보고 제거 — 사실 필드는 스크립트가 산출, LLM은 라벨 해석만.
skills/myharness/scripts/build-scorecard.sh:5:#   verdicts.json 형식: {"issues":[{"fingerprint","verdict","round","source"}...],
skills/myharness/scripts/build-scorecard.sh:6:#                        "rounds":N,"diff_lines":D,"risk_level":"...","termination_reason":"..."}
skills/myharness/scripts/build-scorecard.sh:8:#   escaped: round>1에서 verdict=confirmed 이고 source="re-review"인 건(이전 라운드 게이트 누출)
skills/myharness/scripts/build-scorecard.sh:26:  ($i | map(select(.round>1 and .verdict=="confirmed" and .source=="re-review")) | length) as $esc |
skills/myharness/scripts/build-scorecard.sh:27:  ($d.rounds // ($i | map(.round) | max // 1)) as $rounds |
skills/myharness/scripts/build-scorecard.sh:29:    schema_version:"1", loop:($d.loop//"external-review"), stage_id:($d.stage_id//"?"),
skills/myharness/scripts/build-scorecard.sh:30:    rounds:$rounds, termination_reason:($d.termination_reason//"unknown"),
skills/myharness/scripts/build-scorecard.sh:36:    escaped_defect_rate: (if $c>0 then ($esc/$c) else null end),
skills/myharness/scripts/build-scorecard.sh:45:jq -c '{stage_id,rounds,termination_reason,alignment_score,escaped_defect_rate,cost_per_run_tokens}' "$OUT" >> "$SUM" 2>/dev/null || true
_workspace/reviews/loop-eval-v2_artifact.md:3:대상: `skills/myharness/references/loop-self-eval.md`, `external-review-loop.md`, 신규 `scripts/build-scorecard.sh`. 이전 교정본(측정-전용 1단계) 위에 재리뷰 지적 4건을 반영.
_workspace/reviews/loop-eval-v2_artifact.md:7:### 1. escaped_defect_rate — 내부 recall 프록시 (recall 공백 해소)
_workspace/reviews/loop-eval-v2_artifact.md:8:- 정의: `(round N+1 재리뷰가 이전 라운드 게이트 통과 산출물에서 새로 확인한 결함) / (이전 라운드 confirmed)`.
_workspace/reviews/loop-eval-v2_artifact.md:9:- 근거: 수정본 재리뷰가 이미 루프에 존재 → 추가 비용 0의 Ground-Truth-ish 신호. 게이트가 놓친 결함(누출)을 측정.
_workspace/reviews/loop-eval-v2_artifact.md:12:### 2. scorecard 계산 스크립트화 — 메타 자기채점 제거
_workspace/reviews/loop-eval-v2_artifact.md:13:- `scripts/build-scorecard.sh`: verdict_counts·rounds·alignment_score·*_rate·escaped_defect_rate·cost를 `verdicts.json`(+timing.json)에서 **jq로 기계 계산**.
_workspace/reviews/loop-eval-v2_artifact.md:17:### 3. 단계 졸업 기준 수치화 + 1단계 읽기 경로
_workspace/reviews/loop-eval-v2_artifact.md:18:- 졸업 기준: 1→2 로깅≥10회, 2→3 rolling N≥10+min_adjudicated_claims≥20+사람 sign-off, 3→4 holdout 통과율≥θ+승인. "충분 데이터" 메타 모호성 제거.
_workspace/reviews/loop-eval-v2_artifact.md:22:- 게이트 없는 설계/문서 단계: 신규 0건 + verdicts 완료 + 정본 대조 체크리스트 PASS면 **`design-ok`**(양호 수렴). 미충족만 `exhausted`. 기존엔 설계 리뷰가 거의 `exhausted`로 오라벨되던 문제 해소.
_workspace/reviews/loop-eval-v2_artifact.md:28:- escaped_defect_rate 산식이 내부 recall 프록시로 타당한가? round>1 source 태깅에 의존하는 약점은?
_workspace/reviews/loop-eval-v2_artifact.md:29:- build-scorecard.sh의 계산 정확성·엣지(0분모·jq 부재·source 누락).
_workspace/reviews/loop-eval-v2_artifact.md:30:- 졸업 기준 수치(10/20/θ)의 근거·표본 충분성.
_workspace/reviews/loop-eval-v2_artifact.md:31:- design-ok 라벨이 또 다른 자기채점(체크리스트 자기충족)으로 흐를 위험.
skills/myharness/references/external-review-loop.md:27:round = 1; dry_streak = 0
skills/myharness/references/external-review-loop.md:29:  Step 1~4 (round==1: {산출물} 전체 / round>1: 직전 수정분 diff만 좁게 재리뷰)
skills/myharness/references/external-review-loop.md:34:  if round >= MAX_ROUNDS(기본 3): break + 잔여 미수렴 보고
skills/myharness/references/external-review-loop.md:35:  round += 1
skills/myharness/references/external-review-loop.md:37:- **K회 연속 신규 확인 0건**이면 수렴 종료. **MAX_ROUNDS 도달 시 강제 종료 + 미수렴 이슈 보고**(무한 루프 차단). **품질 θ 미달이 명백하면 `failed-quality-gate`로 즉시 중단**(MAX_ROUNDS 헛돌지 않게). 종료 사유는 `converged-good`/`exhausted`/`max-rounds`/`failed-quality-gate` 라벨로 기록. (gate/assertion은 코드 단계 전용 — 설계·문서는 `verdicts.json` 완료+정본 대조로 종료. 상세: `loop-self-eval.md`)
skills/myharness/references/external-review-loop.md:38:- **수정본 재리뷰(req)**: round>1은 이전 라운드 수정 diff만 좁게 재리뷰 → 수정이 새 결함을 만들지 검증(같은 맹점 회피 전제가 수정에도 적용).
skills/myharness/references/external-review-loop.md:79:신규 이슈마다 실코드/실문서 대조(grep/Read) 후 판정. **이슈 10+건이면 이슈별/배치로 판정 보조 에이전트에 위임** — 보조는 실코드 대조 근거 + 판정 *초안(draft)*만 반환(쓰기 금지). 오케스트레이터는 초안을 받아 **최종 확정(confirm)**만 직접 수행(권위 비위임). 판정 결과는 `verdicts.json`에 기록(이슈지문·판정·라운드·근거).
skills/myharness/references/external-review-loop.md:104:루프 종료 시 **`bash scripts/build-scorecard.sh {단계ID}_verdicts.json _workspace/evals/external-review/{단계ID}/{run_id}/scorecard.json [timing.json]`** 실행 — verdict_counts·rounds·`alignment_score`(정밀도 아님)·`*_rate`·cost·**`escaped_defect_rate`**(round>1 재리뷰가 잡은 이전 라운드 누출 = 내부 recall)를 **스크립트가 verdicts.json에서 기계 계산**(LLM 자기보고 아님). 라벨(`converged-good`/`design-ok`/`exhausted`/...)만 오케스트레이터가 해석. **측정·기록만**, 자동 흐름 변경 없음.
skills/myharness/references/external-review-loop.md:105:- `verdicts.json` 각 이슈에 `round`·`source` 기록(round>1 재리뷰분은 `source:"re-review"`)해야 escaped 계산됨.
skills/myharness/references/external-review-loop.md:106:- 스크립트가 `summary.json`에 집계 append → Phase 0/7 진입 시 **요약만** 읽음(읽기 경로, Lean). 스키마·졸업 기준·단계적 도입은 `loop-self-eval.md`. (jq 필요)
skills/myharness/references/external-review-loop.md:109:재진입은 위 **루프 제어**의 라운드 반복으로 일원화한다. round>1은 직전 수정분 diff만 좁게 재리뷰하고, `verdicts.json` seen 대조로 기수정·기각 이슈는 다시 판정하지 않는다("기수정 확인"은 원장+게이트 재실행으로 갈음). 사용자가 동일 목록을 수동 재제출해도 원장 대조 → 신규만 판정.
skills/myharness/references/external-review-loop.md:112:- **정상(수렴)**: round1 — codex 8+gemini 3→중복 1 병합→10건 판정(확인6/부분2/이월1/기각1)→수정·게이트 PASS·기록. round2 — 수정 diff 재리뷰, 신규 확인 0 → dry_streak 1=K → 종료.
skills/myharness/references/external-review-loop.md:113:- **수정이 새 결함(재리뷰 효과)**: round2에서 수정분 재리뷰가 신규 확인 1건 발견 → 수정 → round3 신규 0 → 종료.
skills/myharness/references/external-review-loop.md:114:- **미수렴**: round3(MAX)까지 신규 확인 지속 → 강제 종료 + 잔여 미수렴 이슈를 결과서·백로그에 보고.

hook: PostToolUse
hook: PostToolUse
exec
/bin/zsh -lc 'git diff -- _workspace/reviews/loop-eval-v2_artifact.md skills/myharness/references/loop-self-eval.md skills/myharness/references/external-review-loop.md skills/myharness/scripts/build-scorecard.sh' in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse
 succeeded in 2533ms:
git: warning: confstr() failed with code 5: couldn't get path of DARWIN_USER_TEMP_DIR; using /tmp instead
git: error: couldn't create cache file '/tmp/xcrun_db-way1HkFB' (errno=Operation not permitted)
diff --git a/skills/myharness/references/external-review-loop.md b/skills/myharness/references/external-review-loop.md
index c535064..f2cf24e 100644
--- a/skills/myharness/references/external-review-loop.md
+++ b/skills/myharness/references/external-review-loop.md
@@ -100,8 +100,10 @@ wait
    - **push는 자율이어도 기본 대기** — `_workspace/.autonomous-push` 마커 시만 자동.
    - 권한모드(bypassPermissions)는 스킬이 못 읽으므로 마커/발화로 명시. 마커 ON이어도 리뷰·판정·게이트는 그대로(인간 승인 한 스텝만 생략).
 
-## Step 8 — 자체 평가 (1단계: 측정 로깅만)
-루프 종료 시 `_workspace/evals/external-review/{단계ID}/{run_id}/scorecard.json` 발행 — `rounds`·`termination_reason`·`verdict_counts`·`new_per_round`·`alignment_score`(정밀도 아님)·`rounds_normalized`·`cost_per_run`·`cost_per_confirmed`(confirmed>0만). **측정·기록만**. 자동 흐름 변경 없음(자기강화·플래핑 방지). 스키마·메트릭 정의·단계적 도입(수동 리포트→제안 트리거→자동)은 `loop-self-eval.md`. recall(놓친 결함)은 Ground Truth 있을 때만.
+## Step 8 — 자체 평가 (1단계: 측정 로깅만, 계산 도출)
+루프 종료 시 **`bash scripts/build-scorecard.sh {단계ID}_verdicts.json _workspace/evals/external-review/{단계ID}/{run_id}/scorecard.json [timing.json]`** 실행 — verdict_counts·rounds·`alignment_score`(정밀도 아님)·`*_rate`·cost·**`escaped_defect_rate`**(round>1 재리뷰가 잡은 이전 라운드 누출 = 내부 recall)를 **스크립트가 verdicts.json에서 기계 계산**(LLM 자기보고 아님). 라벨(`converged-good`/`design-ok`/`exhausted`/...)만 오케스트레이터가 해석. **측정·기록만**, 자동 흐름 변경 없음.
+- `verdicts.json` 각 이슈에 `round`·`source` 기록(round>1 재리뷰분은 `source:"re-review"`)해야 escaped 계산됨.
+- 스크립트가 `summary.json`에 집계 append → Phase 0/7 진입 시 **요약만** 읽음(읽기 경로, Lean). 스키마·졸업 기준·단계적 도입은 `loop-self-eval.md`. (jq 필요)
 
 ## 재진입 (루프 라운드 = 재진입)
 재진입은 위 **루프 제어**의 라운드 반복으로 일원화한다. round>1은 직전 수정분 diff만 좁게 재리뷰하고, `verdicts.json` seen 대조로 기수정·기각 이슈는 다시 판정하지 않는다("기수정 확인"은 원장+게이트 재실행으로 갈음). 사용자가 동일 목록을 수동 재제출해도 원장 대조 → 신규만 판정.
diff --git a/skills/myharness/references/loop-self-eval.md b/skills/myharness/references/loop-self-eval.md
index ba82043..f3f6835 100644
--- a/skills/myharness/references/loop-self-eval.md
+++ b/skills/myharness/references/loop-self-eval.md
@@ -7,14 +7,19 @@
 - **측정과 자동화를 분리한다.** 측정은 안전, 자동 흐름 변경은 고위험(Goodhart·플래핑). **단계적 도입**으로 측정부터.
 
 ## 단계적 도입 (한 번에 다 넣지 말 것)
-| 단계 | 내용 | 자동화 |
-|------|------|--------|
-| **1 (현재 정본)** | `loop_scorecard.json` 로깅만. 측정·기록. | 없음 |
-| 2 | 누적 scorecard 요약을 사람이 수동 검토 | 없음 |
-| 3 | 수치 트리거가 **개선안 "제안"**만 emit (적용 X) | 제안만 + 승인 게이트 |
-| 4 | 충분 데이터 + holdout 검증 후 자동 흐름 개선 | 최후, 승인 필수 |
+| 단계 | 내용 | 졸업 기준(다음 단계로) | 자동화 |
+|------|------|----------------------|--------|
+| **1 (현재 정본)** | `loop_scorecard.json` 로깅만. 측정·기록 | 로깅 **≥ 10회**(`scorecard-summary` 집계 가능) | 없음 |
+| 2 | 누적 scorecard 요약을 사람이 수동 검토 | rolling N≥10 + `min_adjudicated_claims≥20` + 사람 sign-off | 없음 |
+| 3 | 수치 트리거가 **개선안 "제안"**만 emit (적용 X) | 제안의 holdout 통과율 ≥ θ + 명시 승인 | 제안만 + 승인 게이트 |
+| 4 | holdout 검증 후 자동 흐름 개선 | — | 최후, 승인 필수 |
 
-> 3·4단계는 롤링윈도우(최근 N회)·3회 연속 하락·`min_adjudicated_claims ≥ 20` 충족 시에만. 단일 실행 노이즈로 프롬프트/게이트를 바꾸지 않는다(플래핑 방지).
+> 3·4단계는 롤링윈도우(최근 N회)·3회 연속 하락·`min_adjudicated_claims ≥ 20` 충족 시에만. 단일 실행 노이즈로 프롬프트/게이트를 바꾸지 않는다(플래핑 방지). "충분 데이터"는 위 졸업 기준 수치로만 판단(메타 모호성 제거).
+
+## 읽기 경로 (1단계에도 소비자 필수 — write-only 방지)
+측정만 하고 안 읽으면 낭비. 1단계부터 **읽기 경로**를 둔다:
+- `scripts/build-scorecard.sh`가 매 루프 종료 시 scorecard 발행 + `_workspace/evals/{loop}/summary.json`에 최근 N회 집계(append).
+- 오케스트레이터는 **Phase 0(현황 감사)·Phase 7(진화) 진입 시 `summary.json` 1줄 요약만** 읽는다(원본 JSON 미로드 — Lean). 악화 추세가 보이면 사람에게 보고(2단계 수동 검토).
 
 ## loop_scorecard.json 스키마 (신규 — grading.json 재사용 아님)
 실행 단위 디렉터리에 발행: `_workspace/evals/{loop}/{stage_id}/{run_id}/scorecard.json`.
@@ -36,12 +41,15 @@
   "diff_lines": 120, "risk_level": "standard",
   "cost_per_run_tokens": 48000,
   "cost_per_confirmed": 8000,     // confirmed>0일 때만. 0이면 null
-  "quality_label": "gate_pass | failed-quality-gate | n/a(design)",
-  "missed_defect_rate": null,     // Ground Truth 있을 때만 채움(아래)
+  "quality_label": "gate_pass | failed-quality-gate | design-ok | n/a",
+  "escaped_defect_rate": 0.17,    // 수정본 재리뷰 기반 내부 recall 프록시 (아래). 데이터 없으면 null
+  "missed_defect_rate": null,     // 외부 Ground Truth(seeded 등) 있을 때만
   "overturned_rejection_rate": null,
+  "computed_by": "scripts/build-scorecard.sh",  // 사실 필드는 스크립트 계산(LLM 자기보고 아님)
   "links": { "grading": "../grading.json", "timing": "../timing.json", "verdicts": "../../{stage_id}_verdicts.json" }
 }
 ```
+- **계산 도출(메타 자기채점 제거):** `verdict_counts`·`rounds`·`new_per_round`·`*_rate`·`cost`·`escaped_defect_rate`는 **`scripts/build-scorecard.sh`가 `verdicts.json`+`timing.json`에서 기계적으로 산출**한다. LLM은 라벨 해석에만 관여(`quality_label` 등). 카운트를 LLM이 손으로 적지 않는다(오기·낙관 편향 방지).
 - **Lean:** 원본 JSON을 세션에 상시 로드하지 않는다. 파일로만 보존, **Phase 시작 시 요약본만** 읽는다.
 - `grading.json`/`timing.json`은 assertion·토큰 정보가 있을 때 **링크**로 연결(중복 보관 금지).
 
@@ -50,7 +58,8 @@
 - **rejected_rate / deferred_rate / duplicate_rate** — 각각 별도. `false_positive_rate`는 *사후 확정 가능*할 때만(기각이 나중에 진짜 결함으로 판명) `overturned_rejection_rate`로 기록.
 - **rounds_to_converge** 원시값은 K·MAX_ROUNDS·변경 규모에 좌우 → `diff_lines`·`risk_level`로 정규화한 `rounds_normalized`를 1차 지표로, 원시값은 보조.
 - **cost_per_confirmed** confirmed=0이면 분모 0 → `null`. 항상 `cost_per_run`·`cost_per_adjudicated_claim`과 함께 본다.
-- **missed_defect_rate (recall)** — 자기채점으로 불가. **Ground Truth가 있을 때만**: seeded(주입) 결함 탐지율, 사후 발견된 회귀의 원인 역추적, 사용자 반박. 없으면 비워두고 "보고 품질"로만 명명(리뷰어 누락은 측정 안 됨).
+- **escaped_defect_rate (내부 recall 프록시 — 핵심)** = (round N+1 재리뷰가 **이전 라운드 게이트를 통과한 산출물**에서 새로 확인한 결함 수) / (이전 라운드 confirmed 수). 수정본 재리뷰가 이미 루프에 있으므로 **공짜로 얻는 Ground-Truth-ish 신호** — "게이트가 놓친 결함" 측정. (예: timeout 수정이 다음 라운드/2차에서 macOS 결함으로 잡힘 = escaped.) 이것으로 alignment_score 단독의 해석 불능(노이즈 리뷰어 vs 엄격 판정)을 보완한다.
+- **missed_defect_rate (외부 recall)** — escaped로도 못 잡는 진짜 누락은 **외부 Ground Truth**(seeded 결함 탐지율·사후 회귀 역추적·사용자 반박)가 있을 때만. 없으면 null + escaped_defect_rate로 갈음.
 
 ## 종료 사유 라벨 (P2 — 종료조건 아님, 라벨)
 gate/assertion은 **코드/테스트 단계 전용**. 설계·문서 리뷰엔 측정값이 없으므로 종료조건에 넣지 않는다.
@@ -58,7 +67,7 @@ gate/assertion은 **코드/테스트 단계 전용**. 설계·문서 리뷰엔 
 - `exhausted`: 신규 0건이나 품질 신호 부재/미달(소진).
 - `max-rounds`: MAX_ROUNDS 강제 종료(미수렴 보고).
 - `failed-quality-gate`: 품질 θ 미달이 명백 → **루프 중단**(MAX_ROUNDS 헛돌지 않게, 비용 폭증 방지).
-- **설계/문서 단계:** 게이트 대신 `verdicts.json` 완료 + 정본 대조 체크리스트로 종료 판정.
+- **`design-ok` (설계/문서 단계 양의 신호):** 게이트가 없는 단계는 `exhausted`로 오라벨하지 말 것. 신규 확인 0건 + **verdicts.json 완료 + 정본 대조 체크리스트 PASS**면 `design-ok`(양호 수렴). 체크리스트 미충족일 때만 `exhausted`.
 
 ## 판정 보정 (P5 — Ground Truth만)
 같은 오케스트레이터·같은 근거수집으로 재점검하면 편향 반복(에코체임버). 보정은 **독립 신호가 있을 때만** 발화: 사용자 반박 / 후속 결함 발견 / 독립 리뷰어 표본 감사. 결과는 `overturned_rejection_rate`로 기록하고, 임계 초과 시 기각 사유표·리뷰어 신뢰도를 *제안* 형태로 조정(자동 적용 금지).

hook: PostToolUse Completed
codex
핵심 변경 위치 파악됨. 이제 스크립트 산식과 정책 문장 간 불일치 위주로 확인합니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '20,45p' skills/myharness/references/external-review-loop.md" in /Users/junghojang/Developments/myProject/myHarness
exec
/bin/zsh -lc "sed -n '1,90p' skills/myharness/scripts/build-scorecard.sh" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
#!/usr/bin/env bash
# loop_scorecard.json을 verdicts.json(+선택 timing.json)에서 기계적으로 계산한다.
# LLM 자기보고 제거 — 사실 필드는 스크립트가 산출, LLM은 라벨 해석만.
# 사용: build-scorecard.sh <verdicts.json> <out_scorecard.json> [timing.json]
#   verdicts.json 형식: {"issues":[{"fingerprint","verdict","round","source"}...],
#                        "rounds":N,"diff_lines":D,"risk_level":"...","termination_reason":"..."}
#   verdict ∈ confirmed|partial|deferred|rejected|duplicate
#   escaped: round>1에서 verdict=confirmed 이고 source="re-review"인 건(이전 라운드 게이트 누출)
set -euo pipefail
V="${1:?verdicts.json 경로}"; OUT="${2:?출력 경로}"; T="${3:-}"

command -v jq >/dev/null || { echo "jq 필요(brew install jq)"; exit 2; }

tok=0
[ -n "$T" ] && [ -f "$T" ] && tok="$(jq -r '.total_tokens // 0' "$T" 2>/dev/null || echo 0)"

jq -n --slurpfile v "$V" --argjson tok "$tok" '
  ($v[0]) as $d | ($d.issues // []) as $i |
  ($i | map(select(.verdict=="confirmed")) | length) as $c |
  ($i | map(select(.verdict=="partial"))   | length) as $p |
  ($i | map(select(.verdict=="deferred"))  | length) as $df |
  ($i | map(select(.verdict=="rejected"))  | length) as $r |
  ($i | map(select(.verdict=="duplicate")) | length) as $dup |
  (($c+$p+$df+$r) ) as $adj |
  (($c+$p+$df+$r) - $df) as $adj_nondef |
  ($i | map(select(.round>1 and .verdict=="confirmed" and .source=="re-review")) | length) as $esc |
  ($d.rounds // ($i | map(.round) | max // 1)) as $rounds |
  {
    schema_version:"1", loop:($d.loop//"external-review"), stage_id:($d.stage_id//"?"),
    rounds:$rounds, termination_reason:($d.termination_reason//"unknown"),
    verdict_counts:{confirmed:$c,partial:$p,deferred:$df,rejected:$r,duplicate:$dup},
    alignment_score: (if $adj_nondef>0 then (($c + 0.5*$p)/$adj_nondef) else null end),
    rejected_rate:   (if $adj>0 then ($r/$adj) else null end),
    deferred_rate:   (if $adj>0 then ($df/$adj) else null end),
    duplicate_rate:  (if $adj>0 then ($dup/$adj) else null end),
    escaped_defect_rate: (if $c>0 then ($esc/$c) else null end),
    cost_per_run_tokens:$tok,
    cost_per_confirmed: (if $c>0 then ($tok/$c) else null end),
    diff_lines:($d.diff_lines//null), risk_level:($d.risk_level//null),
    computed_by:"scripts/build-scorecard.sh"
  }' > "$OUT"
echo "scorecard → $OUT"
# 집계: summary.json에 append (최근 N회 추세용)
SUM="$(dirname "$OUT")/../summary.json"
jq -c '{stage_id,rounds,termination_reason,alignment_score,escaped_defect_rate,cost_per_run_tokens}' "$OUT" >> "$SUM" 2>/dev/null || true

 succeeded in 0ms:
- `{커밋id}`: 해당 시 `git rev-parse HEAD`, 아니면 생략
- `{게이트명령}`: 프로젝트 테스트/린트 게이트 (예: `npm test && tsc --noEmit` / 없으면 생략)

## 루프 제어 (수렴·종료 — 무한 루프/미검증 방지)
이 게이트는 **라운드 반복 루프**다. 단일 패스가 아니다.

```
round = 1; dry_streak = 0
while True:
  Step 1~4 (round==1: {산출물} 전체 / round>1: 직전 수정분 diff만 좁게 재리뷰)
  신규_확인 = 이번 라운드 '확인/부분' 중 verdicts 원장에 없던 것
  if 신규_확인 == 0: dry_streak += 1
  else: dry_streak = 0; Step 5~7 (신규_확인만 수정·게이트·기록)
  if dry_streak >= K(기본 1, 중대 2): break        # loop-until-dry
  if round >= MAX_ROUNDS(기본 3): break + 잔여 미수렴 보고
  round += 1
```
- **K회 연속 신규 확인 0건**이면 수렴 종료. **MAX_ROUNDS 도달 시 강제 종료 + 미수렴 이슈 보고**(무한 루프 차단). **품질 θ 미달이 명백하면 `failed-quality-gate`로 즉시 중단**(MAX_ROUNDS 헛돌지 않게). 종료 사유는 `converged-good`/`exhausted`/`max-rounds`/`failed-quality-gate` 라벨로 기록. (gate/assertion은 코드 단계 전용 — 설계·문서는 `verdicts.json` 완료+정본 대조로 종료. 상세: `loop-self-eval.md`)
- **수정본 재리뷰(req)**: round>1은 이전 라운드 수정 diff만 좁게 재리뷰 → 수정이 새 결함을 만들지 검증(같은 맹점 회피 전제가 수정에도 적용).
- **판정 원장(req)**: `_workspace/reviews/{단계ID}_verdicts.json` — 이슈지문(파일+결함요지 해시)→ 판정·라운드·근거. 매 라운드 **seen 대조로 신규만 판정**(기각 이슈 재부상 방지, dedup vs seen).

## Step 1 — 리뷰 요청 프롬프트
2종 분담: **codex = 일반/정합성**, **gemini = 성능·안정성**. 산출물 유형에 맞게 "소스코드"→"설계서/문서" 치환.
```text
리뷰 대상 : {산출물}
관련 commit id : {커밋id}   # 없으면 생략

hook: PostToolUse
hook: PostToolUse
exec
/bin/zsh -lc "sed -n '52,82p' skills/myharness/references/loop-self-eval.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
- **계산 도출(메타 자기채점 제거):** `verdict_counts`·`rounds`·`new_per_round`·`*_rate`·`cost`·`escaped_defect_rate`는 **`scripts/build-scorecard.sh`가 `verdicts.json`+`timing.json`에서 기계적으로 산출**한다. LLM은 라벨 해석에만 관여(`quality_label` 등). 카운트를 LLM이 손으로 적지 않는다(오기·낙관 편향 방지).
- **Lean:** 원본 JSON을 세션에 상시 로드하지 않는다. 파일로만 보존, **Phase 시작 시 요약본만** 읽는다.
- `grading.json`/`timing.json`은 assertion·토큰 정보가 있을 때 **링크**로 연결(중복 보관 금지).

## 메트릭 정의 (교정본)
- **alignment_score** = (confirmed + 0.5·partial) / (adjudicated 중 deferred 제외). 이름 그대로 "리뷰 보고 ↔ 오케스트레이터 판정" 정합도. **리뷰어 건강·정밀도라고 부르지 않는다.**
- **rejected_rate / deferred_rate / duplicate_rate** — 각각 별도. `false_positive_rate`는 *사후 확정 가능*할 때만(기각이 나중에 진짜 결함으로 판명) `overturned_rejection_rate`로 기록.
- **rounds_to_converge** 원시값은 K·MAX_ROUNDS·변경 규모에 좌우 → `diff_lines`·`risk_level`로 정규화한 `rounds_normalized`를 1차 지표로, 원시값은 보조.
- **cost_per_confirmed** confirmed=0이면 분모 0 → `null`. 항상 `cost_per_run`·`cost_per_adjudicated_claim`과 함께 본다.
- **escaped_defect_rate (내부 recall 프록시 — 핵심)** = (round N+1 재리뷰가 **이전 라운드 게이트를 통과한 산출물**에서 새로 확인한 결함 수) / (이전 라운드 confirmed 수). 수정본 재리뷰가 이미 루프에 있으므로 **공짜로 얻는 Ground-Truth-ish 신호** — "게이트가 놓친 결함" 측정. (예: timeout 수정이 다음 라운드/2차에서 macOS 결함으로 잡힘 = escaped.) 이것으로 alignment_score 단독의 해석 불능(노이즈 리뷰어 vs 엄격 판정)을 보완한다.
- **missed_defect_rate (외부 recall)** — escaped로도 못 잡는 진짜 누락은 **외부 Ground Truth**(seeded 결함 탐지율·사후 회귀 역추적·사용자 반박)가 있을 때만. 없으면 null + escaped_defect_rate로 갈음.

## 종료 사유 라벨 (P2 — 종료조건 아님, 라벨)
gate/assertion은 **코드/테스트 단계 전용**. 설계·문서 리뷰엔 측정값이 없으므로 종료조건에 넣지 않는다.
- `converged-good`: 신규 확인 0건 K회 + (코드 단계) 게이트 PASS·assertion ≥ θ.
- `exhausted`: 신규 0건이나 품질 신호 부재/미달(소진).
- `max-rounds`: MAX_ROUNDS 강제 종료(미수렴 보고).
- `failed-quality-gate`: 품질 θ 미달이 명백 → **루프 중단**(MAX_ROUNDS 헛돌지 않게, 비용 폭증 방지).
- **`design-ok` (설계/문서 단계 양의 신호):** 게이트가 없는 단계는 `exhausted`로 오라벨하지 말 것. 신규 확인 0건 + **verdicts.json 완료 + 정본 대조 체크리스트 PASS**면 `design-ok`(양호 수렴). 체크리스트 미충족일 때만 `exhausted`.

## 판정 보정 (P5 — Ground Truth만)
같은 오케스트레이터·같은 근거수집으로 재점검하면 편향 반복(에코체임버). 보정은 **독립 신호가 있을 때만** 발화: 사용자 반박 / 후속 결함 발견 / 독립 리뷰어 표본 감사. 결과는 `overturned_rejection_rate`로 기록하고, 임계 초과 시 기각 사유표·리뷰어 신뢰도를 *제안* 형태로 조정(자동 적용 금지).

## 환류(P3/P4) 안전장치 — 3·4단계에서만
- 자동 **"적용" 금지 → "제안"**만. 적용 전 사용자 또는 독립 검토 게이트.
- 롤링윈도우(최근 N회 평균)·3회 연속 하락만 발화(단일 노이즈 무시).
- `min_adjudicated_claims ≥ 20` 전에는 트리거 금지(표본 부족).
- 변경 후 holdout 시나리오·기존 회귀 케이스로 검증.
- θ·ε·N은 리스크 등급별 기본값 + 관찰 전용 시작(고정 자동화 금지).

> 테스트 개선 루프 수렴(assertion 통과율 델타 < ε)은 목적이 달라 분리한다 — `skill-testing-guide.md`에서 다루고, scorecard 링크 규약만 공유.

hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "nl -ba skills/myharness/scripts/build-scorecard.sh | sed -n '17,45p'" in /Users/junghojang/Developments/myProject/myHarness
exec
/bin/zsh -lc "nl -ba skills/myharness/references/external-review-loop.md | sed -n '27,38p;76,80p;104,106p'" in /Users/junghojang/Developments/myProject/myHarness
exec
/bin/zsh -lc "nl -ba skills/myharness/references/loop-self-eval.md | sed -n '10,22p;52,72p;76,80p'" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
    27	round = 1; dry_streak = 0
    28	while True:
    29	  Step 1~4 (round==1: {산출물} 전체 / round>1: 직전 수정분 diff만 좁게 재리뷰)
    30	  신규_확인 = 이번 라운드 '확인/부분' 중 verdicts 원장에 없던 것
    31	  if 신규_확인 == 0: dry_streak += 1
    32	  else: dry_streak = 0; Step 5~7 (신규_확인만 수정·게이트·기록)
    33	  if dry_streak >= K(기본 1, 중대 2): break        # loop-until-dry
    34	  if round >= MAX_ROUNDS(기본 3): break + 잔여 미수렴 보고
    35	  round += 1
    36	```
    37	- **K회 연속 신규 확인 0건**이면 수렴 종료. **MAX_ROUNDS 도달 시 강제 종료 + 미수렴 이슈 보고**(무한 루프 차단). **품질 θ 미달이 명백하면 `failed-quality-gate`로 즉시 중단**(MAX_ROUNDS 헛돌지 않게). 종료 사유는 `converged-good`/`exhausted`/`max-rounds`/`failed-quality-gate` 라벨로 기록. (gate/assertion은 코드 단계 전용 — 설계·문서는 `verdicts.json` 완료+정본 대조로 종료. 상세: `loop-self-eval.md`)
    38	- **수정본 재리뷰(req)**: round>1은 이전 라운드 수정 diff만 좁게 재리뷰 → 수정이 새 결함을 만들지 검증(같은 맹점 회피 전제가 수정에도 적용).
    76	두 출력에서 이슈 추출 → 중복 병합(동일 대상·동일 결함=1건, 출처 병기) → 번호 재부여. **`verdicts.json` 원장과 대조해 이미 판정된(기각/이월/기수정) 이슈는 제외하고 신규만 Step 4로** (dedup vs seen). 리뷰 보고 0건이면 "외부 리뷰 — 이슈 0건" 기록, dry_streak +1.
    77	
    78	## Step 4 — 전건 판정 (근거수집 위임 가능 · 최종 확정 비위임)
    79	신규 이슈마다 실코드/실문서 대조(grep/Read) 후 판정. **이슈 10+건이면 이슈별/배치로 판정 보조 에이전트에 위임** — 보조는 실코드 대조 근거 + 판정 *초안(draft)*만 반환(쓰기 금지). 오케스트레이터는 초안을 받아 **최종 확정(confirm)**만 직접 수행(권위 비위임). 판정 결과는 `verdicts.json`에 기록(이슈지문·판정·라운드·근거).
    80	
   104	루프 종료 시 **`bash scripts/build-scorecard.sh {단계ID}_verdicts.json _workspace/evals/external-review/{단계ID}/{run_id}/scorecard.json [timing.json]`** 실행 — verdict_counts·rounds·`alignment_score`(정밀도 아님)·`*_rate`·cost·**`escaped_defect_rate`**(round>1 재리뷰가 잡은 이전 라운드 누출 = 내부 recall)를 **스크립트가 verdicts.json에서 기계 계산**(LLM 자기보고 아님). 라벨(`converged-good`/`design-ok`/`exhausted`/...)만 오케스트레이터가 해석. **측정·기록만**, 자동 흐름 변경 없음.
   105	- `verdicts.json` 각 이슈에 `round`·`source` 기록(round>1 재리뷰분은 `source:"re-review"`)해야 escaped 계산됨.
   106	- 스크립트가 `summary.json`에 집계 append → Phase 0/7 진입 시 **요약만** 읽음(읽기 경로, Lean). 스키마·졸업 기준·단계적 도입은 `loop-self-eval.md`. (jq 필요)

 succeeded in 0ms:
    17	jq -n --slurpfile v "$V" --argjson tok "$tok" '
    18	  ($v[0]) as $d | ($d.issues // []) as $i |
    19	  ($i | map(select(.verdict=="confirmed")) | length) as $c |
    20	  ($i | map(select(.verdict=="partial"))   | length) as $p |
    21	  ($i | map(select(.verdict=="deferred"))  | length) as $df |
    22	  ($i | map(select(.verdict=="rejected"))  | length) as $r |
    23	  ($i | map(select(.verdict=="duplicate")) | length) as $dup |
    24	  (($c+$p+$df+$r) ) as $adj |
    25	  (($c+$p+$df+$r) - $df) as $adj_nondef |
    26	  ($i | map(select(.round>1 and .verdict=="confirmed" and .source=="re-review")) | length) as $esc |
    27	  ($d.rounds // ($i | map(.round) | max // 1)) as $rounds |
    28	  {
    29	    schema_version:"1", loop:($d.loop//"external-review"), stage_id:($d.stage_id//"?"),
    30	    rounds:$rounds, termination_reason:($d.termination_reason//"unknown"),
    31	    verdict_counts:{confirmed:$c,partial:$p,deferred:$df,rejected:$r,duplicate:$dup},
    32	    alignment_score: (if $adj_nondef>0 then (($c + 0.5*$p)/$adj_nondef) else null end),
    33	    rejected_rate:   (if $adj>0 then ($r/$adj) else null end),
    34	    deferred_rate:   (if $adj>0 then ($df/$adj) else null end),
    35	    duplicate_rate:  (if $adj>0 then ($dup/$adj) else null end),
    36	    escaped_defect_rate: (if $c>0 then ($esc/$c) else null end),
    37	    cost_per_run_tokens:$tok,
    38	    cost_per_confirmed: (if $c>0 then ($tok/$c) else null end),
    39	    diff_lines:($d.diff_lines//null), risk_level:($d.risk_level//null),
    40	    computed_by:"scripts/build-scorecard.sh"
    41	  }' > "$OUT"
    42	echo "scorecard → $OUT"
    43	# 집계: summary.json에 append (최근 N회 추세용)
    44	SUM="$(dirname "$OUT")/../summary.json"
    45	jq -c '{stage_id,rounds,termination_reason,alignment_score,escaped_defect_rate,cost_per_run_tokens}' "$OUT" >> "$SUM" 2>/dev/null || true

 succeeded in 0ms:
    10	| 단계 | 내용 | 졸업 기준(다음 단계로) | 자동화 |
    11	|------|------|----------------------|--------|
    12	| **1 (현재 정본)** | `loop_scorecard.json` 로깅만. 측정·기록 | 로깅 **≥ 10회**(`scorecard-summary` 집계 가능) | 없음 |
    13	| 2 | 누적 scorecard 요약을 사람이 수동 검토 | rolling N≥10 + `min_adjudicated_claims≥20` + 사람 sign-off | 없음 |
    14	| 3 | 수치 트리거가 **개선안 "제안"**만 emit (적용 X) | 제안의 holdout 통과율 ≥ θ + 명시 승인 | 제안만 + 승인 게이트 |
    15	| 4 | holdout 검증 후 자동 흐름 개선 | — | 최후, 승인 필수 |
    16	
    17	> 3·4단계는 롤링윈도우(최근 N회)·3회 연속 하락·`min_adjudicated_claims ≥ 20` 충족 시에만. 단일 실행 노이즈로 프롬프트/게이트를 바꾸지 않는다(플래핑 방지). "충분 데이터"는 위 졸업 기준 수치로만 판단(메타 모호성 제거).
    18	
    19	## 읽기 경로 (1단계에도 소비자 필수 — write-only 방지)
    20	측정만 하고 안 읽으면 낭비. 1단계부터 **읽기 경로**를 둔다:
    21	- `scripts/build-scorecard.sh`가 매 루프 종료 시 scorecard 발행 + `_workspace/evals/{loop}/summary.json`에 최근 N회 집계(append).
    22	- 오케스트레이터는 **Phase 0(현황 감사)·Phase 7(진화) 진입 시 `summary.json` 1줄 요약만** 읽는다(원본 JSON 미로드 — Lean). 악화 추세가 보이면 사람에게 보고(2단계 수동 검토).
    52	- **계산 도출(메타 자기채점 제거):** `verdict_counts`·`rounds`·`new_per_round`·`*_rate`·`cost`·`escaped_defect_rate`는 **`scripts/build-scorecard.sh`가 `verdicts.json`+`timing.json`에서 기계적으로 산출**한다. LLM은 라벨 해석에만 관여(`quality_label` 등). 카운트를 LLM이 손으로 적지 않는다(오기·낙관 편향 방지).
    53	- **Lean:** 원본 JSON을 세션에 상시 로드하지 않는다. 파일로만 보존, **Phase 시작 시 요약본만** 읽는다.
    54	- `grading.json`/`timing.json`은 assertion·토큰 정보가 있을 때 **링크**로 연결(중복 보관 금지).
    55	
    56	## 메트릭 정의 (교정본)
    57	- **alignment_score** = (confirmed + 0.5·partial) / (adjudicated 중 deferred 제외). 이름 그대로 "리뷰 보고 ↔ 오케스트레이터 판정" 정합도. **리뷰어 건강·정밀도라고 부르지 않는다.**
    58	- **rejected_rate / deferred_rate / duplicate_rate** — 각각 별도. `false_positive_rate`는 *사후 확정 가능*할 때만(기각이 나중에 진짜 결함으로 판명) `overturned_rejection_rate`로 기록.
    59	- **rounds_to_converge** 원시값은 K·MAX_ROUNDS·변경 규모에 좌우 → `diff_lines`·`risk_level`로 정규화한 `rounds_normalized`를 1차 지표로, 원시값은 보조.
    60	- **cost_per_confirmed** confirmed=0이면 분모 0 → `null`. 항상 `cost_per_run`·`cost_per_adjudicated_claim`과 함께 본다.
    61	- **escaped_defect_rate (내부 recall 프록시 — 핵심)** = (round N+1 재리뷰가 **이전 라운드 게이트를 통과한 산출물**에서 새로 확인한 결함 수) / (이전 라운드 confirmed 수). 수정본 재리뷰가 이미 루프에 있으므로 **공짜로 얻는 Ground-Truth-ish 신호** — "게이트가 놓친 결함" 측정. (예: timeout 수정이 다음 라운드/2차에서 macOS 결함으로 잡힘 = escaped.) 이것으로 alignment_score 단독의 해석 불능(노이즈 리뷰어 vs 엄격 판정)을 보완한다.
    62	- **missed_defect_rate (외부 recall)** — escaped로도 못 잡는 진짜 누락은 **외부 Ground Truth**(seeded 결함 탐지율·사후 회귀 역추적·사용자 반박)가 있을 때만. 없으면 null + escaped_defect_rate로 갈음.
    63	
    64	## 종료 사유 라벨 (P2 — 종료조건 아님, 라벨)
    65	gate/assertion은 **코드/테스트 단계 전용**. 설계·문서 리뷰엔 측정값이 없으므로 종료조건에 넣지 않는다.
    66	- `converged-good`: 신규 확인 0건 K회 + (코드 단계) 게이트 PASS·assertion ≥ θ.
    67	- `exhausted`: 신규 0건이나 품질 신호 부재/미달(소진).
    68	- `max-rounds`: MAX_ROUNDS 강제 종료(미수렴 보고).
    69	- `failed-quality-gate`: 품질 θ 미달이 명백 → **루프 중단**(MAX_ROUNDS 헛돌지 않게, 비용 폭증 방지).
    70	- **`design-ok` (설계/문서 단계 양의 신호):** 게이트가 없는 단계는 `exhausted`로 오라벨하지 말 것. 신규 확인 0건 + **verdicts.json 완료 + 정본 대조 체크리스트 PASS**면 `design-ok`(양호 수렴). 체크리스트 미충족일 때만 `exhausted`.
    71	
    72	## 판정 보정 (P5 — Ground Truth만)
    76	- 자동 **"적용" 금지 → "제안"**만. 적용 전 사용자 또는 독립 검토 게이트.
    77	- 롤링윈도우(최근 N회 평균)·3회 연속 하락만 발화(단일 노이즈 무시).
    78	- `min_adjudicated_claims ≥ 20` 전에는 트리거 금지(표본 부족).
    79	- 변경 후 holdout 시나리오·기존 회귀 케이스로 검증.
    80	- θ·ε·N은 리스크 등급별 기본값 + 관찰 전용 시작(고정 자동화 금지).

hook: PostToolUse
hook: PostToolUse
hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
[high] `escaped_defect_rate` 산식이 문서 정의와 스크립트 구현 불일치
- 현황: 문서는 “round N+1 재리뷰가 이전 라운드 게이트 통과 산출물에서 새로 확인한 결함 / 이전 라운드 confirmed 수”로 정의합니다. [loop-self-eval.md:61](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:61)
- 이슈: 스크립트는 분모를 전체 confirmed 수 `$c`로 둡니다. round2 escaped 결함도 분모에 포함되어 값이 희석됩니다. 또 partial은 루프상 “신규_확인”에 포함되지만 escaped numerator에는 confirmed만 들어갑니다. [build-scorecard.sh:19](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:19), [build-scorecard.sh:26](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:26), [build-scorecard.sh:36](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:36)
- 권고: `escaped_defect_rate`를 “round>1 escaped count / prior-round eligible confirmed-or-partial count”처럼 실제 정의로 계산하거나, 현재 구현 명칭을 `re_review_confirmed_share` 수준으로 낮추십시오.

[high] `escaped_defect_rate`는 내부 recall 프록시로 과대 주장됨
- 현황: round>1은 “직전 수정분 diff만 좁게 재리뷰”합니다. [external-review-loop.md:29](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/external-review-loop.md:29), [external-review-loop.md:38](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/external-review-loop.md:38)
- 이슈: 이 방식은 “수정이 만든 새 결함” 탐지에는 맞지만, 이전 라운드 전체 산출물에서 놓친 결함 recall을 대표하지 못합니다. 미수정 영역 결함은 관측 불가라 과소 측정되고, 수정 diff의 새 회귀를 “이전 게이트 누출”로 세면 과대 측정됩니다.
- 권고: 문구를 “수정 diff 재리뷰 누출률/회귀 탐지율”로 축소하십시오. 내부 recall 프록시로 쓰려면 round>1 표본 재리뷰 범위를 이전 산출물 전체 또는 층화 표본으로 명시해야 합니다.

[high] `round`/`source` 태깅 의존이 무검증이라 지표가 조용히 0으로 붕괴
- 현황: escaped는 `.round>1 && .source=="re-review"`만 셉니다. [build-scorecard.sh:26](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:26)
- 이슈: `source` 누락, 오타, 다른 라벨 사용 시 escaped가 0으로 계산됩니다. 스크립트는 경고도 실패도 내지 않아 “문제 없음”처럼 보입니다.
- 권고: round>1 confirmed/partial 중 `source` 누락 또는 비허용 값을 schema error로 처리하십시오. 최소한 `warnings` 필드에 누락 수를 기록하십시오.

[med] scorecard 스키마와 구현 산출물이 맞지 않음
- 현황: 문서는 `new_per_round`, `rounds_normalized`, `quality_label`, `links`, `cost_per_confirmed`, `cost_per_adjudicated_claim` 계열을 언급합니다. [loop-self-eval.md:52](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:52), [loop-self-eval.md:59](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:59)
- 이슈: 스크립트는 `new_per_round`, `rounds_normalized`, `quality_label`, `links`, `cost_per_adjudicated_claim`을 만들지 않습니다. 문서가 “스크립트가 기계적으로 산출”한다고 한 필드와 실제 구현이 다릅니다.
- 권고: 구현할 필드만 스키마에 남기거나, jq에 누락 필드 계산을 추가하십시오. 라벨은 별도 후처리라면 스크립트 산출 대상에서 제외한다고 명확히 쓰십시오.

[med] `summary.json` append 경로와 형식이 문서와 다름
- 현황: 문서는 `_workspace/evals/{loop}/summary.json`에 최근 N회 집계라고 합니다. [loop-self-eval.md:21](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:21)
- 이슈: 스크립트는 `OUT` 기준 `../summary.json`에 append합니다. 예시 경로 기준으로는 `_workspace/evals/external-review/{stage_id}/summary.json`입니다. 또 JSON 배열이 아니라 JSONL append입니다. [build-scorecard.sh:44](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:44)
- 권고: 파일명을 `summary.jsonl`로 바꾸거나 배열 JSON으로 원자 갱신하십시오. 경로도 loop-level인지 stage-level인지 하나로 고정하십시오.

[med] summary append 동시성·실패 은폐
- 현황: `>> "$SUM" 2>/dev/null || true`로 append합니다. [build-scorecard.sh:45](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:45)
- 이슈: 병렬 루프 실행 시 append 경합 가능성이 있고, 쓰기 실패가 조용히 무시됩니다. “읽기 경로”의 핵심 로그가 빠져도 성공처럼 보입니다.
- 권고: `flock` 또는 임시파일+원자적 rename을 쓰고, append 실패는 stderr 경고 또는 non-zero로 노출하십시오.

[med] 졸업 기준 `10/20/θ` 근거 부족
- 현황: 로깅 ≥10, rolling N≥10, `min_adjudicated_claims≥20`, holdout ≥θ를 충분 데이터 기준으로 고정합니다. [loop-self-eval.md:12](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:12), [loop-self-eval.md:17](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:17)
- 이슈: 20건 판정은 비율 지표 안정성에 약합니다. stage/risk/reviewer가 섞이면 더 약합니다. θ도 정의가 없어 실행자가 임의 해석할 수 있습니다.
- 권고: 수치를 “관찰 시작 최소치”로 낮춰 표현하고, 자동/제안 트리거는 리스크별 최소 표본, 신뢰구간, holdout 크기, θ 기본값을 명시하십시오.

[med] `design-ok`가 자기채점 라벨로 흐를 위험
- 현황: 신규 확인 0건 + verdicts 완료 + 정본 대조 체크리스트 PASS면 `design-ok`입니다. [loop-self-eval.md:70](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:70)
- 이슈: 체크리스트 작성·대조·최종 판정을 같은 오케스트레이터가 하면 “체크리스트 자기충족”입니다. 기존 원칙인 “자기채점 ≠ 품질”과 긴장됩니다. [loop-self-eval.md:6](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:6)
- 권고: `design-ok` 조건에 독립 리뷰어 표본 감사, 사용자 승인, 또는 최소한 체크리스트 항목별 근거 링크를 요구하십시오. 아니면 `design-reviewed`처럼 품질 함의를 줄인 라벨로 바꾸십시오.

[low] `jq` 부재 처리는 있으나 운영 문서 연결이 약함
- 현황: 스크립트는 `jq` 없으면 exit 2를 냅니다. [build-scorecard.sh:12](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:12)
- 이슈: external-review-loop는 “jq 필요”만 적고 실패 시 scorecard 미발행이 루프 실패인지, 평가 생략인지 정의하지 않습니다.
- 권고: Step 8 실패 정책을 명시하십시오. 예: scorecard 실패는 루프 결과 실패가 아니라 “eval-unavailable” 경고로 보고하고 원 산출물은 유지.

[low] 개선이 다소 과설계됨
- 현황: 1단계 측정 로깅에 escaped, summary, 졸업 기준, design-ok, holdout θ까지 한 번에 들어왔습니다.
- 이슈: “측정과 자동화를 분리” 원칙은 유지하지만, 초기 운영자는 라벨·지표·요약 파일의 의미를 동시에 맞춰야 합니다.
- 권고: v2 최소안은 `scorecard.jsonl` append + alignment/basic counts + 명시적 `warnings`만 두고, escaped/design-ok/졸업 기준은 “experimental” 섹션으로 격리하는 편이 더 단순합니다.
hook: Stop
hook: Stop Completed
tokens used
73,259
[high] `escaped_defect_rate` 산식이 문서 정의와 스크립트 구현 불일치
- 현황: 문서는 “round N+1 재리뷰가 이전 라운드 게이트 통과 산출물에서 새로 확인한 결함 / 이전 라운드 confirmed 수”로 정의합니다. [loop-self-eval.md:61](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:61)
- 이슈: 스크립트는 분모를 전체 confirmed 수 `$c`로 둡니다. round2 escaped 결함도 분모에 포함되어 값이 희석됩니다. 또 partial은 루프상 “신규_확인”에 포함되지만 escaped numerator에는 confirmed만 들어갑니다. [build-scorecard.sh:19](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:19), [build-scorecard.sh:26](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:26), [build-scorecard.sh:36](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:36)
- 권고: `escaped_defect_rate`를 “round>1 escaped count / prior-round eligible confirmed-or-partial count”처럼 실제 정의로 계산하거나, 현재 구현 명칭을 `re_review_confirmed_share` 수준으로 낮추십시오.

[high] `escaped_defect_rate`는 내부 recall 프록시로 과대 주장됨
- 현황: round>1은 “직전 수정분 diff만 좁게 재리뷰”합니다. [external-review-loop.md:29](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/external-review-loop.md:29), [external-review-loop.md:38](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/external-review-loop.md:38)
- 이슈: 이 방식은 “수정이 만든 새 결함” 탐지에는 맞지만, 이전 라운드 전체 산출물에서 놓친 결함 recall을 대표하지 못합니다. 미수정 영역 결함은 관측 불가라 과소 측정되고, 수정 diff의 새 회귀를 “이전 게이트 누출”로 세면 과대 측정됩니다.
- 권고: 문구를 “수정 diff 재리뷰 누출률/회귀 탐지율”로 축소하십시오. 내부 recall 프록시로 쓰려면 round>1 표본 재리뷰 범위를 이전 산출물 전체 또는 층화 표본으로 명시해야 합니다.

[high] `round`/`source` 태깅 의존이 무검증이라 지표가 조용히 0으로 붕괴
- 현황: escaped는 `.round>1 && .source=="re-review"`만 셉니다. [build-scorecard.sh:26](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:26)
- 이슈: `source` 누락, 오타, 다른 라벨 사용 시 escaped가 0으로 계산됩니다. 스크립트는 경고도 실패도 내지 않아 “문제 없음”처럼 보입니다.
- 권고: round>1 confirmed/partial 중 `source` 누락 또는 비허용 값을 schema error로 처리하십시오. 최소한 `warnings` 필드에 누락 수를 기록하십시오.

[med] scorecard 스키마와 구현 산출물이 맞지 않음
- 현황: 문서는 `new_per_round`, `rounds_normalized`, `quality_label`, `links`, `cost_per_confirmed`, `cost_per_adjudicated_claim` 계열을 언급합니다. [loop-self-eval.md:52](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:52), [loop-self-eval.md:59](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:59)
- 이슈: 스크립트는 `new_per_round`, `rounds_normalized`, `quality_label`, `links`, `cost_per_adjudicated_claim`을 만들지 않습니다. 문서가 “스크립트가 기계적으로 산출”한다고 한 필드와 실제 구현이 다릅니다.
- 권고: 구현할 필드만 스키마에 남기거나, jq에 누락 필드 계산을 추가하십시오. 라벨은 별도 후처리라면 스크립트 산출 대상에서 제외한다고 명확히 쓰십시오.

[med] `summary.json` append 경로와 형식이 문서와 다름
- 현황: 문서는 `_workspace/evals/{loop}/summary.json`에 최근 N회 집계라고 합니다. [loop-self-eval.md:21](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:21)
- 이슈: 스크립트는 `OUT` 기준 `../summary.json`에 append합니다. 예시 경로 기준으로는 `_workspace/evals/external-review/{stage_id}/summary.json`입니다. 또 JSON 배열이 아니라 JSONL append입니다. [build-scorecard.sh:44](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:44)
- 권고: 파일명을 `summary.jsonl`로 바꾸거나 배열 JSON으로 원자 갱신하십시오. 경로도 loop-level인지 stage-level인지 하나로 고정하십시오.

[med] summary append 동시성·실패 은폐
- 현황: `>> "$SUM" 2>/dev/null || true`로 append합니다. [build-scorecard.sh:45](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:45)
- 이슈: 병렬 루프 실행 시 append 경합 가능성이 있고, 쓰기 실패가 조용히 무시됩니다. “읽기 경로”의 핵심 로그가 빠져도 성공처럼 보입니다.
- 권고: `flock` 또는 임시파일+원자적 rename을 쓰고, append 실패는 stderr 경고 또는 non-zero로 노출하십시오.

[med] 졸업 기준 `10/20/θ` 근거 부족
- 현황: 로깅 ≥10, rolling N≥10, `min_adjudicated_claims≥20`, holdout ≥θ를 충분 데이터 기준으로 고정합니다. [loop-self-eval.md:12](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:12), [loop-self-eval.md:17](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:17)
- 이슈: 20건 판정은 비율 지표 안정성에 약합니다. stage/risk/reviewer가 섞이면 더 약합니다. θ도 정의가 없어 실행자가 임의 해석할 수 있습니다.
- 권고: 수치를 “관찰 시작 최소치”로 낮춰 표현하고, 자동/제안 트리거는 리스크별 최소 표본, 신뢰구간, holdout 크기, θ 기본값을 명시하십시오.

[med] `design-ok`가 자기채점 라벨로 흐를 위험
- 현황: 신규 확인 0건 + verdicts 완료 + 정본 대조 체크리스트 PASS면 `design-ok`입니다. [loop-self-eval.md:70](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:70)
- 이슈: 체크리스트 작성·대조·최종 판정을 같은 오케스트레이터가 하면 “체크리스트 자기충족”입니다. 기존 원칙인 “자기채점 ≠ 품질”과 긴장됩니다. [loop-self-eval.md:6](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/references/loop-self-eval.md:6)
- 권고: `design-ok` 조건에 독립 리뷰어 표본 감사, 사용자 승인, 또는 최소한 체크리스트 항목별 근거 링크를 요구하십시오. 아니면 `design-reviewed`처럼 품질 함의를 줄인 라벨로 바꾸십시오.

[low] `jq` 부재 처리는 있으나 운영 문서 연결이 약함
- 현황: 스크립트는 `jq` 없으면 exit 2를 냅니다. [build-scorecard.sh:12](/Users/junghojang/Developments/myProject/myHarness/skills/myharness/scripts/build-scorecard.sh:12)
- 이슈: external-review-loop는 “jq 필요”만 적고 실패 시 scorecard 미발행이 루프 실패인지, 평가 생략인지 정의하지 않습니다.
- 권고: Step 8 실패 정책을 명시하십시오. 예: scorecard 실패는 루프 결과 실패가 아니라 “eval-unavailable” 경고로 보고하고 원 산출물은 유지.

[low] 개선이 다소 과설계됨
- 현황: 1단계 측정 로깅에 escaped, summary, 졸업 기준, design-ok, holdout θ까지 한 번에 들어왔습니다.
- 이슈: “측정과 자동화를 분리” 원칙은 유지하지만, 초기 운영자는 라벨·지표·요약 파일의 의미를 동시에 맞춰야 합니다.
- 권고: v2 최소안은 `scorecard.jsonl` append + alignment/basic counts + 명시적 `warnings`만 두고, escaped/design-ok/졸업 기준은 “experimental” 섹션으로 격리하는 편이 더 단순합니다.
