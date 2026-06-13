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
