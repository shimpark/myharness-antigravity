나는 Claude Code 플러그인(에이전트 팀 + 스킬을 생성하는 메타 스킬 "하네스 팩토리")을 Codex CLI에서도 동일 워크플로우로 쓰이게 듀얼 런타임으로 포팅하려 한다. Codex CLI(0.137.0) 런타임에 대해 정확히 알려달라:

1. AGENTS.md 자동 발견 규칙: ~/.codex/AGENTS.md(글로벌), 레포 루트 AGENTS.md, 서브디렉토리 AGENTS.md의 로드/우선순위/병합 방식?
2. 커스텀 슬래시 프롬프트: ~/.codex/prompts/*.md 지원 여부와 동작 방식? 인자 전달($ARGUMENTS 등)?
3. 멀티 에이전트/서브에이전트: Codex가 네이티브로 에이전트 팀(병렬 협업)을 지원하나? 없다면 codex exec subprocess 호출이 유일한 병렬화 수단인가? `codex exec` 비대화 실행 베스트 프랙티스?
4. config.toml: 프로젝트 단위 설정/프로파일/MCP 등록 방식? 레포에 동봉해 배포 가능한가?
5. Claude Code의 "스킬 자동 트리거(description 기반)"에 해당하는 Codex 메커니즘이 있나? 없으면 AGENTS.md 인라인 지시가 최선인가?

각 항목 간결히, 확실한 것/불확실한 것 구분해서 답해줘.
