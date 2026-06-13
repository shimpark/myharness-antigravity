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
API returned invalid content after all retries. Full report available at: /var/folders/ng/j4zg0ntj14sfk363m7fftm3r0000gn/T/gemini-client-error-generateJson-invalid-content-2026-06-13T08-18-25-301Z.json Error: Retry attempts exhausted
    at retryWithBackoff (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:304954:9)
    at async BaseLlmClient._generateWithRetry (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:305111:14)
    at async BaseLlmClient.generateJson (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:305004:21)
    at async NumericalClassifierStrategy.route (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:355848:28)
    at async CompositeStrategy.route (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:355919:26)
    at async ModelRouterService.route (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:356082:18)
    at async GeminiClient.processTurn (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:342159:24)
    at async GeminiClient.sendMessageStream (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:342278:14)
    at async file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/gemini-T3PINYWC.js:10871:26
    at async main (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/gemini-T3PINYWC.js:16276:5)
[Routing] NumericalClassifierStrategy failed: Error: Failed to generate content: Retry attempts exhausted
    at BaseLlmClient._generateWithRetry (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:305141:13)
    at async BaseLlmClient.generateJson (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:305004:21)
    at async NumericalClassifierStrategy.route (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:355848:28)
    at async CompositeStrategy.route (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:355919:26)
    at async ModelRouterService.route (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:356082:18)
    at async GeminiClient.processTurn (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:342159:24)
    at async GeminiClient.sendMessageStream (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/chunk-GPVT36PL.js:342278:14)
    at async file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/gemini-T3PINYWC.js:10871:26
    at async main (file:///Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@google/gemini-cli/bundle/gemini-T3PINYWC.js:16276:5)
docs/self-evaluation-system.md와 기존 정책 문서(loop-self-eval, self-improvement-loop 등)를 비교 분석한 리뷰 결과입니다.

1. [Critical] 용어 충돌 및 정책 모순: self_eval_scorecard vs artifact_benchmark
- 현황: 설계 문서(`self-evaluation-system.md`)는 새 스키마 `self_eval_scorecard`를 도입. 기존 정책(`self-improvement-loop.md`)은 산출물 품질에 `artifact_benchmark`를 쓰도록 강제.
- 이슈: 2개의 다른 용어와 스키마 혼용. 기존 문서의 "루프 효율(scorecard)과 산출물 품질(benchmark) 지표를 섞지 말라"는 원칙과 충돌.
- 권고: `self_eval_scorecard` 명칭 폐기. `self-improvement-loop.md`의 `artifact_benchmark` 스키마로 단일화.

2. [Critical] LLM 주관적 자기채점 금지 원칙 정면 위반
- 현황: 스키마 내 `role_fit`, `orchestration_fit` 등 주관적 축에 LLM이 0.0~1.0 점수를 직접 매김.
- 이슈: `loop-self-eval.md`의 "오케스트레이터의 주관적 품질 자기단정 금지" 및 "메타 자기채점 제거" 교리 위반. LLM이 자기 결과에 점수 부여 시 극심한 낙관 편향(에코체임버/Goodhart) 발생.
- 권고: 주관적 항목의 직접 점수 매기기(0.0~1.0) 제거. 외부 리뷰어의 pass/fail 라벨 또는 Ground Truth(assertion 통과율) 기반 객관적 수치로만 채점.

3. [High] build-scorecard.sh 스크립트 목적 오용 및 미구현 의존성 숨김
- 현황: "현재 프로젝트에 대한 적용" 섹션에서 `scripts/build-scorecard.sh`를 자체 평가 재료로 언급.
- 이슈: 해당 스크립트는 `verdicts.json`을 읽어 "루프 실행 효율(`loop_scorecard`)"을 계산할 뿐, "산출물 품질(`self_eval_scorecard`)"을 계산할 수 없음. 실제 필요한 산출물 측정 러너(`run-benchmark.sh`)는 미구현 상태이나 문서에 명시되지 않음.
- 권고: `build-scorecard.sh` 참조 삭제. 실제 실행을 위한 MVP 1단계 필수 스크립트(`run-benchmark.sh`) 미구현 사실 및 의존성 명시.

4. [High] 임계치 하드코딩에 의한 플래핑(Flapping) 방어선 누락
- 현황: "반복 실패 패턴" 승격 기준을 하드코딩(예: n>=5, 20)으로 설정.
- 이슈: `loop-self-eval.md`에서 경고한 "단일 노이즈 무시 및 롤링윈도우/3회 연속 하락 시 발화" 같은 플래핑 방지 안전장치가 없음. 고정 수치 임계치는 LLM 평가 노이즈에 취약.
- 권고: 절대 수치가 아닌 롤링 윈도우 추세(예: "동일 카테고리 3회 연속 실패") 기반으로 트리거 조건 강화. 수치는 관찰 시작용 기본값(θ)으로만 취급.

5. [Medium] Policy Audit(정적 점검)의 자체측정 환각(Hallucination) 취약성
- 현황: 5법 중 1번(Policy Audit)을 SKILL.md가 정책을 지키는지 스스로 점검하는 최우선 증거로 제안.
- 이슈: 정적 검사(grep/AST) 없이 LLM에게 읽고 점검하라고 맡기면 없는 검증 Phase도 있다고 거짓 보고함. "자체측정 약증거" 한계.
- 권고: Policy Audit은 LLM 판정을 배제하고 100% 쉘 스크립트(smoke 테스트) 기반의 정적 구조 검증으로만 한정.

6. [Low] Null 점수 처리로 인한 파이프라인 형변환 취약성
- 현황: `smoke` 모드에서 판단 불가 시 `null` 할당 권장.
- 이슈: JSON 스키마 기반 통계 집계 파이프라인에서 숫자(0.0)와 `null`이 섞이면 런타임 크래시나 통계 왜곡 가능성 높음.
- 권고: `null` 대신 상태 라벨 필드(`"status": "not_evaluated"`)를 별도로 빼거나 생략(`N/A`) 기호 체계로 분리.
