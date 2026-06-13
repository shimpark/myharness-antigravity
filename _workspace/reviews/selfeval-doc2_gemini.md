[ExtensionManager] Error loading agent from caveman: Failed to load agent from /Users/junghojang/.gemini/extensions/caveman/agents/cavecrew-builder.md: Validation failed: Agent Definition:
tools.0: Invalid tool name
tools.1: Invalid tool name
tools.2: Invalid tool name
tools.3: Invalid tool name
tools.4: Invalid tool name
[ExtensionManager] Error loading agent from caveman: Failed to load agent from /Users/junghojang/.gemini/extensions/caveman/agents/cavecrew-investigator.md: Validation failed: Agent Definition:
tools.0: Invalid tool name
tools.1: Invalid tool name
tools.2: Invalid tool name
tools.3: Invalid tool name
[ExtensionManager] Error loading agent from caveman: Failed to load agent from /Users/junghojang/.gemini/extensions/caveman/agents/cavecrew-reviewer.md: Validation failed: Agent Definition:
tools.0: Invalid tool name
tools.1: Invalid tool name
tools.2: Invalid tool name
Ripgrep is not available. Falling back to GrepTool.
1차 리뷰에 이어, **성능/속도 및 안정성** 관점에서 `docs/self-evaluation-system.md` 및 관련 시스템을 분석한 결과입니다.

### [위험] 고비용 대규모 리뷰 산출물로 인한 컨텍스트 폭발 및 비용 전이
- **현황:** `_workspace/reviews/` 로그 분석 결과, 단일 리뷰 파일(`*_codex.md`)이 **270KB(~60k-80k tokens)**에 달하는 사례 확인. `full` 모드에서 2개 이상의 외부 AI(Codex/Gemini)가 병렬 실행될 경우 단일 라운드에서 100k tokens 이상의 데이터가 생성됨.
- **이슈:** `Step 4(전건 판정)` 시 오케스트레이터가 이 대용량 로그를 직접 읽을 경우 컨텍스트 윈도우 임계치에 도달하거나, 추론 지연 및 토큰 비용이 급증함. 특히 `MAX_ROUNDS=3` 반복 시 비용이 기하급수적으로 증가할 수 있으나, 현재 설계에 라운드별/단계별 **토큰 예산(Token Budget) 하한선**이 없음.
- **권고:** 
    1. **이슈 추출 분리:** 오케스트레이터가 리뷰 원문을 직접 읽지 않고, `mcp__context-mode__ctx_execute` 등을 사용하여 이슈만 구조화된 형태(JSON)로 추출하여 전달하도록 강제.
    2. **Cost-Aware Termination:** 라운드가 반복될수록 `new_confirmed` 이슈가 줄어들지만 토큰 비용은 유지됨. `cost_per_confirmed` 지표가 임계를 넘으면 `converged`로 간주하고 조기 종료하는 로직 추가.

### [안정성] 외부 도구 실행의 불확실성 및 타임아웃 처리 취약성
- **현황:** `Step 2(비대화 실행)`에서 `timeout` 명령어를 사용하나, macOS 환경(gtimeout) 호환성 및 600초라는 긴 하드코딩된 대기 시간을 가짐.
- **이슈:** 외부 AI CLI(특히 gemini)는 네트워크 상황에 따라 무응답(hang) 가능성이 높음. `wait` 명령어로 대기 시 하나의 도구만 멈춰도 전체 루프가 중단됨. 재시도 로직(`x2`)이 있으나, "재시도 후에도 실패 시 단일 출처로 진행"하는 폴백이 실제 오케스트레이터의 '판정' 단계에서 `verdicts.json` 정합성 오류를 일으킬 위험이 있음.
- **권고:** 
    1. **Watchdog 강화:** `check-review-tools.sh`에서 단순히 실행 가능 여부만 체크하는 것이 아니라, 가벼운 `echo test | gemini` 식의 **Liveness Check**를 수행.
    2. **Partial Recovery:** 한 쪽 도구 실패 시 "실패 도구 로그" 자리에 에러 메시지를 명시적으로 남겨, `Step 3(이슈 통합)`에서 누락을 인지하고 진행하도록 `verdicts.json`에 `failed_sources` 필드 추가.

### [확장성] Scorecard 누적 오버헤드 및 파일 시스템 병목
- **현황:** `build-scorecard.sh`가 `summary.jsonl`에 `flock`을 사용하여 원자적 append를 수행함.
- **이슈:** 에이전트가 7개 이상인 대규모 하네스에서 각 에이전트의 Phase마다 리뷰 루프가 돌 경우, `summary.jsonl` 파일이 비대해져 "Phase 0(현황 감사)" 시 이를 읽는 것 자체가 오버헤드가 됨. 또한, `_workspace/reviews/` 하위에 수백 개의 파일이 생성될 때의 정리(Cleanup) 정책이 부재함.
- **권고:** 
    1. **Summary Rolling:** `summary.jsonl`은 최근 N개(예: 50개)만 유지하도록 회전(Rotate) 정책 도입.
    2. **Artifact Lifecycle:** `self_eval_report.md` 생성 완료 후, 개별 라운드의 대용량 원문 로그(`.md`)는 아카이브(압축)하거나 일정 기간 후 자동 삭제하는 정책 명시.

### [안정성] 미구현 스크립트 의존으로 인한 "Ghost Failure"
- **현황:** `docs/self-evaluation-system.md`에서 `smoke self-eval` 스크립트 추가를 "우선 구현 순서 1번"으로 명시하고 있으나, 실제 `skills/myharness/scripts/`에는 `build-scorecard.sh`만 존재함.
- **이슈:** 시스템은 `smoke` 모드가 기본이라고 주장하지만, 이를 수행할 실제 코드가 없어 오케스트레이터가 "성공한 것으로 간주"하고 넘어가는 False Positive가 발생할 수 있음. 측정 실패가 생성 루프를 막지 않는다는 원칙(`build-scorecard.sh`의 jq 체크 부분)은 좋으나, 핵심 검증이 누락되는 것을 인지하지 못할 위험이 있음.
- **권고:** 
    1. **Minimal Smoke Script:** 최소한 필수 파일 존재 여부라도 체크하는 `check-completeness.sh`를 즉시 구현하여 번들링.
    2. **Validation Requirement:** `self_eval_scorecard.json`이 생성되지 않은 경우 `release` Phase 진입을 차단하는 Hard Gate 설정.

### [성능] Golden Domain 10~20개 평가의 실행 지연
- **현황:** `증거 패키지 2번`으로 도메인 10~20개 리플레이를 제안함.
- **이슈:** 단일 도메인 생성 및 `full` 평가에 10분 이상 소요될 수 있음. 20개 도메인 순차 평가 시 3시간 이상의 지연 발생. 이는 개발 루프의 피드백 속도를 저해함.
- **권고:** 
    1. **Risk-based Sampling:** 매번 20개를 돌리는 대신, 변경된 스킬이나 에이전트의 "영향 범위(Blast Radius)"에 해당하는 도메인만 선택적으로 실행.
    2. **Parallel Eval Harness:** 도메인 평가를 병렬로 수행할 수 있는 전용 하네스(Evaluator) 구성을 `references/self-improvement-loop.md`에 추가.

---
**요약:** 현재 설계는 "무엇을 평가할 것인가"는 훌륭하나, **"얼마나 빠르고 안전하게 실행할 것인가"**에 대한 제약이 부족합니다. 특히 대용량 토큰 소비를 방어하기 위한 **Sandboxed Issue Extraction**과 **Cost-based Termination** 도입이 시급합니다.
