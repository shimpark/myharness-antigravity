# 외부 리뷰 루프 (External Review Loop) — 방법론 & 생성 템플릿

이 파일은 두 역할을 한다:
1. **방법론 정본** — 단계 산출물 마감 게이트(외부 독립 AI 리뷰)의 표준 절차.
2. **생성 템플릿** — 코드/설계 도메인 하네스를 만들 때, 이 내용을 타겟 프로젝트의 `.claude/skills/external-review-loop/SKILL.md`로 생성한다(아래 frontmatter 포함). **단, 생성 전 `check-review-tools.sh`로 codex/agy 연동을 확인**하고, 둘 다 미설치면 스킬을 만들지 않는다(Phase 4-6). 생성 시 `check-review-tools.sh`를 스킬의 `scripts/`로 함께 번들한다.

**왜 외부 리뷰인가**: 내부 생성-검증/QA는 같은 세션·같은 컨텍스트라 *동일한 맹점*을 공유한다. 외부 독립 AI는 다른 관점으로 결함을 잡는다. 단, **합의=정답이 아니다** — 두 AI가 같은 답을 내도 공유 학습데이터로 인한 상관 오류일 수 있다. 합의는 약한 증거이며, **판정 권위는 오케스트레이터에 있다 — 근거 수집(실코드 대조)은 보조 에이전트에 위임 가능하나, 최종 확정(confirm)은 비위임.**

**독립성 = 엔진 다양성(req)**: 리뷰어 모델 ≠ 러너 모델이어야 진짜 독립이다. subprocess 격리로 *컨텍스트*는 분리돼도, **러너와 같은 엔진은 같은 맹점을 공유**한다(codex가 codex를 검증 = 자기검증). 따라서 외부 리뷰어는 **현재 런타임의 러너 엔진을 제외**하고 고른다:
- **Claude Code 런타임**(러너=claude) → 일반/정합성 리뷰어 = **codex**, 성능/안정성 = **agy**(Gemini)
- **Codex 런타임**(러너=codex) → 일반/정합성 리뷰어 = **claude**, 성능/안정성 = **agy**(Gemini)
- agy(Gemini)는 양쪽 런타임 모두에서 러너와 다른 엔진이라 항상 유효. `check-review-tools.sh [runner]`가 러너 제외한 `REVIEWERS:` 줄을 산출한다.

## 생성 시 frontmatter
```yaml
---
name: external-review-loop
description: 작업 단계 산출물(설계서·코드·문서)마다 외부 독립 AI(러너 엔진 제외 — Claude면 codex+agy, Codex면 claude+agy)에 리뷰 요청 → 오케스트레이터가 실코드 대조 전건 판정(확인/부분/이월/기각) → 확인분만 TDD 수정·커밋하는 단계 마감 게이트. "외부 리뷰", "codex/claude/agy 리뷰", "리뷰 게이트", "설계서/코드 리뷰해서 검증·수정", "이슈 검증하고 수정" 요청 시 반드시 사용. 사용자 수동 이슈 제출에도 Step4~7 적용. 내부 QA와 별개의 독립 관점 게이트.
---
```

## 입력 (플레이스홀더)
- `{산출물}`: 리뷰 대상 — 설계서/코드 디렉토리/문서
- `{단계ID}`: 임의 단계 식별자 (예: `design-auth`, `feat-login`)
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
2종 분담: **일반/정합성 리뷰어**(러너가 claude면 `codex`, codex면 `claude`) + **성능·안정성 리뷰어 = agy(antigravity, Gemini 모델)**. (gemini CLI는 deprecated → agy로 이관. agy 없으면 gemini legacy 폴백.) 일반 리뷰어는 `check-review-tools.sh`의 `REVIEWERS:`에서 러너 제외분으로 자동 결정. 산출물 유형에 맞게 "소스코드"→"설계서/문서" 치환.
```text
리뷰 대상 : {산출물}
관련 commit id : {커밋id}   # 없으면 생략
위 산출물과 관련 자료를 리뷰·검토하여 발생 가능한 이슈를 모두 찾아 보고해줘.
<이슈 작성 방법>
1. [{이슈레벨}] {타이틀}
- 현황: {상황}  - 이슈: {상세}  - 권고: {대응방안}
</이슈 작성 방법>
```
agy(성능 리뷰어)는 동일 틀 + "성능/속도·안정성 중심으로" 추가.

## Step 2 — 병렬 비대화 실행
먼저 `bash {스킬scripts}/check-review-tools.sh {러너}`로 **러너 제외 리뷰어 재확인**(끝줄 `REVIEWERS:` — 러너 엔진은 이미 빠져 있음). 두 플레이스홀더는 **스킬 생성 시 런타임별로 치환**한다(아래 "생성 시 치환" 참조) — 자동감지에 의존하면 Codex에서 env 누락 시 자기검증으로 역전된다. `REVIEWERS:`에 든 도구만 실행. 루트에서 백그라운드 병렬·읽기전용. 프롬프트·출력 모두 `_workspace/reviews/`에 보존(감사 — /tmp 금지).

> **생성 시 치환(req):** 팩토리는 생성 런타임을 알므로 명시 주입한다 — Claude Code면 `{스킬scripts}`=`.claude/skills/external-review-loop/scripts`·`{러너}`=`claude`, Codex면 `{스킬scripts}`=`.agents/skills/external-review-loop/scripts`·`{러너}`=`codex`. (자동감지는 보조 폴백.)

> **REVIEWERS는 루프 진입 전 1회만 산출**해 재사용한다(라운드마다 재호출 불필요 — 리뷰어 집합은 라운드 간 불변).
```bash
mkdir -p _workspace/reviews
trap 'pkill -P $$ 2>/dev/null' EXIT   # 셸 종료 시 하위 프로세스 정리(좀비 방지)
# timeout은 GNU coreutils — macOS엔 없을 수 있다(gtimeout). 이식성 위해 탐지 후 적용.
TO="$(command -v timeout || command -v gtimeout || true)"
S={단계ID}
# 러너 제외 리뷰어 목록(스크립트가 산출). REVIEWERS: 줄만 신뢰. {러너}=생성 시 claude|codex로 치환.
REVIEWERS="$(bash {스킬scripts}/check-review-tools.sh {러너} | sed -n 's/^REVIEWERS: //p')"

# 도구 전무 폴백: 결과파일 미생성으로 Step 3이 깨지지 않게 기계판독 상태파일을 남기고 종료.
if [ -z "$REVIEWERS" ] || [ "$REVIEWERS" = "none" ]; then
  printf '{"status":"no-reviewers","note":"러너 외 외부 리뷰어 없음 — 내부 QA로 진행"}\n' \
    > "_workspace/reviews/${S}_review_status.json"
  echo "WARN: REVIEWERS none → 외부 리뷰 생략, 내부 QA만." >&2
else
  # 일반/정합성 리뷰어 = REVIEWERS 중 codex 또는 claude(러너 아닌 쪽). 둘 중 든 것만 실행.
  case " $REVIEWERS " in
    *" codex "*)   # Claude Code 런타임: 일반 리뷰어 = codex. stdin 열려 있으면 무한 대기 → 반드시 < /dev/null
      ${TO:+$TO 600s} codex exec --sandbox read-only "$(cat _workspace/reviews/${S}_prompt_general.md)" < /dev/null \
        > "_workspace/reviews/${S}_codex.md" 2>&1 & ;;
    *" claude "*)  # Codex 런타임: 일반 리뷰어 = claude. -p(비대화). plan 모드 + 읽기도구만 허용으로 쓰기 차단.
      ${TO:+$TO 600s} claude -p "$(cat _workspace/reviews/${S}_prompt_general.md)" \
        --permission-mode plan --allowedTools "Read,Grep,Glob,Bash(git diff:*),Bash(git log:*),Bash(rg:*)" < /dev/null \
        > "_workspace/reviews/${S}_claude.md" 2>&1 & ;;
  esac

  # 성능/안정성 리뷰어 = agy(Gemini, 양쪽 런타임 공통). 비대화 -p/--print, --sandbox(터미널 제한), --print-timeout.
  #   agy 없고 gemini(legacy)만 REVIEWERS에 있으면: gemini -p "..." < /dev/null 로 대체.
  case " $REVIEWERS " in
    *" agy "*)
      ${TO:+$TO 600s} agy -p "$(cat _workspace/reviews/${S}_prompt_perf.md)" \
        --model "Gemini 3.1 Pro (High)" --sandbox --print-timeout 600s < /dev/null \
        > "_workspace/reviews/${S}_agy.md" 2>&1 & ;;
    *" gemini "*)
      ${TO:+$TO 600s} gemini -p "$(cat _workspace/reviews/${S}_prompt_perf.md)" < /dev/null \
        > "_workspace/reviews/${S}_gemini.md" 2>&1 & ;;
  esac
  wait
fi
```
- **타임아웃 무방비 주의:** `timeout`/`gtimeout` 없으면 `codex`·`claude`는 타임아웃 없이 실행된다(agy만 `--print-timeout` 자체 보유). hang 시 `wait`가 무한 블로킹 → **GNU coreutils(`gtimeout`) 설치 권장**. 자체 타이머(`sleep…&kill`)는 오탐 kill 위험이라 미채택.
- 타임아웃·실패 → 1회 재시도 → 재실패 시 해당 도구 누락 명시 후 단일 출처로 진행(**루프 차단 금지**). 실패한 도구도 빈 `_codex.md`/`_claude.md`가 남으니 Step 3은 파일 유무가 아니라 내용으로 판단.
- 모델은 `agy models`로 확인(Gemini 3.1 Pro / 3.5 Flash 등). 가용 모델명으로 치환.
- **자원·비용:** 리뷰어 2종 병렬 = 토큰 2배·로컬 자원 경합. 초대형 산출물이면 순차 실행(한쪽 `wait` 후 다른쪽) 또는 성능 리뷰어를 경량 모델(`Gemini 3.5 Flash`)로.
- **도구 부재 폴백:** `REVIEWERS: none`이면 위 분기가 상태파일만 남기고 외부 리뷰 생략 — 결과서에 명시하고 내부 QA만으로 진행. 일반 리뷰어 1종만 살아도 단일 출처로 진행.

## Step 3 — 이슈 통합 + 원장 대조
**먼저 산출물 유무 확인:** `_review_status.json`(no-reviewers)만 있고 `_codex.md`/`_claude.md`/`_agy.md`가 없으면 외부 리뷰 생략 상태 → 내부 QA로 진행(결과서 명시). 출력 파일은 있으나 비었거나 에러면 해당 도구 누락으로 간주. 두 출력에서 이슈 추출 → 중복 병합(동일 대상·동일 결함=1건, 출처 병기) → 번호 재부여. **`verdicts.json` 원장과 대조해 이미 판정된(기각/이월/기수정) 이슈는 제외하고 신규만 Step 4로** (dedup vs seen). 리뷰 보고 0건이면 "외부 리뷰 — 이슈 0건" 기록, dry_streak +1.

## Step 4 — 전건 판정 (근거수집 위임 가능 · 최종 확정 비위임)
신규 이슈마다 실코드/실문서 대조(grep/Read) 후 판정. **이슈 10+건이면 이슈별/배치로 판정 보조 에이전트에 위임** — 보조는 실코드 대조 근거 + 판정 *초안(draft)*만 반환(쓰기 금지). 오케스트레이터는 초안을 받아 **최종 확정(confirm)**만 직접 수행(권위 비위임). 판정 결과는 `verdicts.json`에 기록(이슈지문·판정·라운드·근거).

| 판정 | 기준 | 처리 |
|------|------|------|
| **확인** | 결함 재현/실재 | Step 5 수정 |
| **부분 확인** | 지적 실재하나 권고 과잉/계약 위배 | 비파괴 범위만 + 잔여 기각 근거 |
| **이월** | 타당하나 본 단계 범위 외 | 백로그 위치 명기 — 기각과 구분 |
| **기각** | 사유표 | 근거 명시(코드/정본 인용) — 삭제 금지 |

**기각 사유표:** 동결 계약 위배 · 설계 정본 명시 결정 · 기구현 오판(호출 형태만 보고 오판) · YAGNI/과설계 · 리뷰어 자인 비병목 · 기존 설계와 상충(멱등·격리 등).

## Step 5 — 확인분 TDD 수정 (확인 0건이면 생략)
**'확인/부분 확인'이 0건이면 Step 5~7을 생략**하고 판정 기록만 남긴 뒤 dry_streak +1로 루프 제어로 복귀(전부 기각/이월인데 수정·게이트 도는 낭비 방지). 확인분이 있으면: `tdd-doctrine.md` 규율(Red→Green→Refactor, 구조/행위 분리). 다중 에이전트 병렬 시 파일권 명시 분리(병렬 충돌 = 1차 실패 주원인). 에이전트는 커밋·브랜치 금지, status는 `_workspace/status/`.

## Step 6 — 통합 게이트
`{게이트명령}` 실행 → PASS. 게이트 없으면(설계서) 정본 정합성 재확인으로 대체. 테스트 리소스 간섭 게이트는 동시 실행 금지.

## Step 7 — 기록·커밋 (커밋 순서·자율 노브)
1. 결과서에 `## 외부 리뷰 반영 ({일자} — {단계ID} {k}건)` § — 판정표·게이트 수치·출처(리뷰어: codex|claude + agy, 러너 제외분).
2. 순서: 게이트 PASS → **승인 관문** → 단일 커밋(`fix: 외부 리뷰 {k}건 — {요지}`, Co-Authored-By).
   - 승인 관문 기본: 사용자 대기. `_workspace/.autonomous` 마커(또는 "자율로" 발화) 시 자동 통과.
   - **push는 자율이어도 기본 대기** — `_workspace/.autonomous-push` 마커 시만 자동.
   - 권한모드(bypassPermissions)는 스킬이 못 읽으므로 마커/발화로 명시. 마커 ON이어도 리뷰·판정·게이트는 그대로(인간 승인 한 스텝만 생략).

## Step 8 — 자체 평가 (1단계: 측정 로깅만, 계산 도출)
루프 종료 시 **`bash {스킬scripts}/build-scorecard.sh {단계ID}_verdicts.json _workspace/evals/external-review/{단계ID}/{run_id}/scorecard.json [timing.json]`** 실행 (`{스킬scripts}`는 Step 2와 동일 — 생성 시 런타임별 치환) — verdict_counts·rounds·`alignment_score`(정밀도 아님)·`*_rate`·cost·**`regression_catch_rate`**(round>1 재리뷰가 잡은 회귀/누출 — 전체 recall 아님)를 **스크립트가 verdicts.json에서 기계 계산**(LLM 자기보고 아님). 라벨(`converged-good`/`converged`/`max-rounds`/...)만 오케스트레이터가 해석. **측정·기록만**, 자동 흐름 변경 없음.
- `verdicts.json` 각 이슈에 `round`·`source` 기록(round>1 재리뷰분은 `source:"re-review"`)해야 regression_catch_rate 계산됨.
- 스크립트가 `summary.jsonl`에 집계 append → Phase 0/7 진입 시 **요약만** 읽음(읽기 경로, Lean). 스키마·졸업 기준·단계적 도입은 `loop-self-eval.md`. (jq 필요)

## 재진입 (루프 라운드 = 재진입)
재진입은 위 **루프 제어**의 라운드 반복으로 일원화한다. round>1은 직전 수정분 diff만 좁게 재리뷰하고, `verdicts.json` seen 대조로 기수정·기각 이슈는 다시 판정하지 않는다("기수정 확인"은 원장+게이트 재실행으로 갈음). 사용자가 동일 목록을 수동 재제출해도 원장 대조 → 신규만 판정.

## 테스트 시나리오
- **정상(수렴)**: round1 — codex 8+agy 3→중복 1 병합→10건 판정(확인6/부분2/이월1/기각1)→수정·게이트 PASS·기록. round2 — 수정 diff 재리뷰, 신규 확인 0 → dry_streak 1=K → 종료.
- **수정이 새 결함(재리뷰 효과)**: round2에서 수정분 재리뷰가 신규 확인 1건 발견 → 수정 → round3 신규 0 → 종료.
- **미수렴**: round3(MAX)까지 신규 확인 지속 → 강제 종료 + 잔여 미수렴 이슈를 결과서·백로그에 보고.
- **도구 에러**: agy 타임아웃 ×2 → "agy 미수집" 명시, codex 단독 진행 — 라운드 완료.
