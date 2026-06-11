이 레포에서 Codex CLI로 "harness" 스킬을 실행하려는데 사용자가 `/harness`를 쳤더니 안 된다. 정확히 알려달라(확실/불확실 구분):
1. Codex CLI(0.137.0)에서 커스텀 스킬 호출 정확한 문법? `/harness`가 되나, 아니면 `$harness`나 `/skills` 메뉴인가? description 기반 암묵 활성화는 어떻게 트리거되나?
2. 스킬이 repo `.agents/skills/harness`에 심링크(→ ../../skills/harness)로 있다. Codex가 (a) repo `.agents/skills`를 스캔하나? (b) 심링크를 따르나? (c) trusted project 설정이 필요한가? (d) 설치 후 세션 재시작이 필요한가?
3. 지금 이 작업 디렉토리에서 harness 스킬이 Codex에 인식되는지 실제로 확인해줘.
