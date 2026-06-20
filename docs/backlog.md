# 백로그 (이월 항목)

외부 감사에서 타당하나 현 시점 적용 보류한 항목. 적용 트리거(규모·빈도)가 충족되면 재검토.

## harness-update.sh — 성능/안정성 (2026-06-20 성능 감사 이월)

근거: `update`는 **단일 사용자 수동 1회 도구**, 관리 대상 v1 = 4파일(화이트리스트). 아래는 비병목이거나 과견고(dev-rules §2 단순성·§6 추측성 금지)라 보류.

- **P2 프로세스/IO 최적화** — `classify`가 파일마다 `jq`(manifest_sha)+`sha`×2를 호출, `plan`→`apply` 시 동일 classify 중복. 관리 파일이 4개라 현재 비병목. **트리거:** 관리 대상이 ~20개+로 늘면 manifest 1회 로드(연관배열 캐시)+해시 단일 패스로 전환.
- **P1b 동시 실행 락** — `manifest`/`plan`/`apply`가 락 없이 같은 `SKILL_DIR`·manifest 접근. 단일 사용자 수동 도구라 경합 빈도 극저. **트리거:** 자동화/CI에서 병렬 호출 가능성이 생기면 `mkdir "$MANIFEST.lock"` 기반 뮤텍스(+trap cleanup) 추가.

## external-review-loop Step 2 — 병렬 실행 견고성 (2026-06-20 이월)

근거: 자체 watchdog/프로세스그룹 킬은 오탐 kill 위험이 크고, 현재는 `gtimeout` 권장 + 문서화로 대응 중.

- **P8 timeout 강제 watchdog** — `timeout`/`gtimeout` 부재 시 `codex`/`claude`가 무한 대기 가능. 자체 `sleep…&kill` 타이머는 오탐 kill 위험이라 미채택. **트리거:** 무인 자동화(cron)에서 hang이 실제 문제가 되면 PID 추적 watchdog 도입.
- **P9 프로세스 그룹 정리** — `trap pkill -P $$`가 직계 자식만 정리 → `timeout`/CLI의 손자 프로세스 누수 가능. **트리거:** 좀비 누수가 관측되면 `setsid`+`kill -- -$pgid`(macOS fallback 분리).
- **P10 프롬프트 argv 전달** — `tool "$(cat prompt)"`가 대형 산출물에서 ARG_MAX 초과·프로세스 목록 노출 가능. **트리거:** 초대형 프롬프트가 필요해지면 stdin/프롬프트-파일 옵션으로 전환.
- **P12 리뷰어 실행 가능성 probe** — `check-review-tools.sh`는 `command -v`(설치)만 확인, 인증 만료·모델명 불일치는 Step 2 실행에서야 드러남. **트리거:** 인증 만료 오류가 잦으면 `--probe`(짧은 timeout `--version`/noninteractive) 추가.
- **P13 REVIEWERS 캐시** — 문서는 "루프 진입 전 1회 산출"이나 라운드 반복 구현이 매번 재호출 가능. 비용 작음. **트리거:** 라운드 수가 많아지면 `_workspace/reviews/{단계ID}_reviewers.txt`에 고정 저장·재사용.
