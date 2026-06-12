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
