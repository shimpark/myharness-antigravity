# 작업결과: 루프 자체 평가 성숙도 개선 (우선순위 1~4)

대상: `skills/myharness/references/loop-self-eval.md`, `external-review-loop.md`, 신규 `scripts/build-scorecard.sh`. 이전 교정본(측정-전용 1단계) 위에 재리뷰 지적 4건을 반영.

## 변경 내용

### 1. escaped_defect_rate — 내부 recall 프록시 (recall 공백 해소)
- 정의: `(round N+1 재리뷰가 이전 라운드 게이트 통과 산출물에서 새로 확인한 결함) / (이전 라운드 confirmed)`.
- 근거: 수정본 재리뷰가 이미 루프에 존재 → 추가 비용 0의 Ground-Truth-ish 신호. 게이트가 놓친 결함(누출)을 측정.
- alignment_score 단독의 해석 불능(노이즈 리뷰어 vs 엄격 판정)을 보완. missed_defect_rate(외부 GT)는 seeded 등 있을 때만.

### 2. scorecard 계산 스크립트화 — 메타 자기채점 제거
- `scripts/build-scorecard.sh`: verdict_counts·rounds·alignment_score·*_rate·escaped_defect_rate·cost를 `verdicts.json`(+timing.json)에서 **jq로 기계 계산**.
- LLM은 라벨 해석에만 관여. 카운트를 손으로 적지 않음(오기·낙관 편향 방지).
- 검증: 샘플 verdicts로 alignment 0.7·escaped 0.33 정확 산출 확인. `summary.json` 집계 append.

### 3. 단계 졸업 기준 수치화 + 1단계 읽기 경로
- 졸업 기준: 1→2 로깅≥10회, 2→3 rolling N≥10+min_adjudicated_claims≥20+사람 sign-off, 3→4 holdout 통과율≥θ+승인. "충분 데이터" 메타 모호성 제거.
- 읽기 경로: build-scorecard가 summary.json 집계 → 오케스트레이터가 Phase 0/7 진입 시 **요약만** 읽음(write-only 로그 방지, Lean 유지).

### 4. 설계 라벨 분리 (오라벨 방지)
- 게이트 없는 설계/문서 단계: 신규 0건 + verdicts 완료 + 정본 대조 체크리스트 PASS면 **`design-ok`**(양호 수렴). 미충족만 `exhausted`. 기존엔 설계 리뷰가 거의 `exhausted`로 오라벨되던 문제 해소.

## 불변 (이전 교정 유지)
측정과 자동화 분리(1단계=측정만), 자동 적용 금지(제안+승인), Goodhart/플래핑 방지(롤링윈도우·min samples), grading.json 재사용 아님(링크).

## 리뷰 요청 포인트
- escaped_defect_rate 산식이 내부 recall 프록시로 타당한가? round>1 source 태깅에 의존하는 약점은?
- build-scorecard.sh의 계산 정확성·엣지(0분모·jq 부재·source 누락).
- 졸업 기준 수치(10/20/θ)의 근거·표본 충분성.
- design-ok 라벨이 또 다른 자기채점(체크리스트 자기충족)으로 흐를 위험.

## 외부 리뷰 반영 (2026-06-13 — codex+gemini, 확인 다수)
| 판정 | 이슈 | 처리 |
|------|------|------|
| 확인 | escaped 분모 오류(누적 confirmed) | 분모=round1 confirmed+partial로 교정(희석 제거) |
| 확인 | escaped를 내부 recall로 과대주장 | **`regression_catch_rate`로 개명** — "수정 diff 회귀/누출"이지 전체 recall 아님 명시 |
| 확인 | source 태깅 무검증 → 조용한 0 | `warnings` 필드로 누락 감지 |
| 확인 | 스키마 vs 구현 불일치 | 스크립트 산출 필드로 정렬, LLM 해석은 quality_label만 |
| 확인 | summary 경로/형식·동시성 | `summary.jsonl` + `flock` 원자 append + 실패 노출 |
| 확인 | jq 부재 exit2 과도 | graceful — exit0 + eval-unavailable 경고(루프 불중단) |
| 확인 | design-ok 자기채점 | 라벨 폐지 → 중립 `converged` + 품질 자기단정 금지 |
| 부분 | 졸업 기준 10/20/θ | "관찰 시작 최소치" 명시 + min 30 + θ 등급 기본값 |
| 부분 | 과설계 | 3·4단계 "실험적" 격리, 2단계까지 실용 권장 |
게이트: build-scorecard.sh 샘플 검증 PASS(alignment 0.7·regression 0.33). 종료 사유: converged.
