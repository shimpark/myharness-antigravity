Reading additional input from stdin...
OpenAI Codex v0.137.0
--------
workdir: /Users/junghojang/Developments/myProject/myHarness
model: gpt-5.5
provider: openai
approval: never
sandbox: read-only
reasoning effort: medium
reasoning summaries: none
session id: 019eb036-0284-7233-84bf-1a0679a58cbb
--------
user
나는 Claude Code 플러그인(에이전트 팀 + 스킬을 생성하는 메타 스킬 "하네스 팩토리")을 Codex CLI에서도 동일 워크플로우로 쓰이게 듀얼 런타임으로 포팅하려 한다. Codex CLI(0.137.0) 런타임에 대해 정확히 알려달라:

1. AGENTS.md 자동 발견 규칙: ~/.codex/AGENTS.md(글로벌), 레포 루트 AGENTS.md, 서브디렉토리 AGENTS.md의 로드/우선순위/병합 방식?
2. 커스텀 슬래시 프롬프트: ~/.codex/prompts/*.md 지원 여부와 동작 방식? 인자 전달($ARGUMENTS 등)?
3. 멀티 에이전트/서브에이전트: Codex가 네이티브로 에이전트 팀(병렬 협업)을 지원하나? 없다면 codex exec subprocess 호출이 유일한 병렬화 수단인가? `codex exec` 비대화 실행 베스트 프랙티스?
4. config.toml: 프로젝트 단위 설정/프로파일/MCP 등록 방식? 레포에 동봉해 배포 가능한가?
5. Claude Code의 "스킬 자동 트리거(description 기반)"에 해당하는 Codex 메커니즘이 있나? 없으면 AGENTS.md 인라인 지시가 최선인가?

각 항목 간결히, 확실한 것/불확실한 것 구분해서 답해줘.
hook: SessionStart
hook: SessionStart Completed
hook: UserPromptSubmit
hook: UserPromptSubmit Completed
codex
`openai-docs`와 `context-mode` 스킬을 사용합니다. Codex 런타임 사실관계는 공식/로컬 문서 기준으로 확인하고, 긴 원문은 인덱싱해 필요한 결론만 꺼내겠습니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '1,220p' /Users/junghojang/.codex/skills/.system/openai-docs/SKILL.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
---
name: "openai-docs"
description: "Use when the user asks how to build with OpenAI products or APIs, asks about Codex itself or choosing Codex surfaces, needs up-to-date official documentation with citations, help choosing the latest model for a use case, or model upgrade and prompt-upgrade guidance; use OpenAI docs MCP tools for non-Codex docs questions, use the Codex manual helper first for broad Codex self-knowledge, and restrict fallback browsing to official OpenAI domains."
---


# OpenAI Docs

Provide authoritative, current guidance from OpenAI developer docs using the developers.openai.com MCP server. "Docs MCP" means `mcp__openaiDeveloperDocs__search_openai_docs` and `mcp__openaiDeveloperDocs__fetch_openai_doc`; for API reference, schema, parameter, or required-field questions, also use `mcp__openaiDeveloperDocs__get_openapi_spec` when available. Official-domain web search is fallback after those tools are unavailable or unhelpful. Broad Codex questions use the manual helper before Docs MCP. This skill also owns model selection, API model migration, and prompt-upgrade guidance.

## API Key Setup

For requests to build, run, configure, debug, or implement an API-backed app, script, CLI, generator, or tool, use `openai-platform-api-key` first when available. After that credential gate is resolved, return here for current docs as needed.

Use this skill directly for docs-only questions, citations, model/API guidance, conceptual explanations, and examples that do not require building or running an API-backed artifact.

## Workflow Configuration

### Source Priority

- For Codex self-knowledge, use the Codex source route below; it owns when to use the manual helper, Docs MCP, or bounded uncertainty.
- For non-Codex OpenAI docs questions, use `mcp__openaiDeveloperDocs__search_openai_docs` to find the most relevant doc pages.
- For non-Codex OpenAI docs questions, fetch the relevant page with `mcp__openaiDeveloperDocs__fetch_openai_doc` before answering. If search is noisy, run a narrower Docs MCP search; when any plausible official OpenAI docs URL is known or found, try fetching that URL through Docs MCP before relying on web-search content.
- For API reference, schema, parameter, or required-field questions, use `mcp__openaiDeveloperDocs__get_openapi_spec` when available to verify the API shape alongside the relevant guide or reference page.
- Use `mcp__openaiDeveloperDocs__list_openai_docs` only when you need to browse or discover non-Codex pages without a clear query.
- For model-selection, "latest model", or default-model questions, fetch `https://developers.openai.com/api/docs/guides/latest-model.md` first. If that is unavailable, load `references/latest-model.md`.
- For model upgrades or prompt upgrades, run `node scripts/resolve-latest-model-info.js` only when the target is latest/current/default or otherwise unspecified; otherwise preserve the explicitly requested target.
- Preserve explicit target requests: if the user names a target model like "migrate to GPT-5.4", keep that requested target even if `latest-model.md` names a newer model. Mention newer guidance only as optional.
- If current remote guidance is needed, fetch both the returned migration and prompting guide URLs directly. If direct fetch fails, use MCP/search fallback; if that also fails, use bundled fallback references and disclose the fallback.

## OpenAI product snapshots

1. Apps SDK: Build ChatGPT apps by providing a web component UI and an MCP server that exposes your app's tools to ChatGPT.
2. Responses API: A unified endpoint designed for stateful, multimodal, tool-using interactions in agentic workflows.
3. Chat Completions API: Generate a model response from a list of messages comprising a conversation.
4. Codex: OpenAI's coding agent for software development that can write, understand, review, and debug code.
5. gpt-oss: Open-weight OpenAI reasoning models (gpt-oss-120b and gpt-oss-20b) released under the Apache 2.0 license.
6. Realtime API: Build low-latency, multimodal experiences including natural speech-to-speech conversations.
7. Agents SDK: A toolkit for building agentic apps where a model can use tools and context, hand off to other agents, stream partial results, and keep a full trace.

## Codex self-knowledge

Use this path for questions about Codex itself: configuring, extending, operating, troubleshooting, local state, product surfaces, or where Codex behavior should live. A codebase merely mentioning a plugin, skill, hook, MCP server, browser, or automation is not enough. For generic software tasks, answer the software task directly; if asked whether Codex self-knowledge applies, answer that meta question briefly and continue the requested artifact.

### Source Route

The Codex manual is the first source for broad Codex synthesis. Treat the manual and Docs MCP as different lanes, not interchangeable official-doc sources. For published-user Codex product answers, the source route is complete: the manual, Docs MCP when this route calls for it, official OpenAI web fallback, and callable capabilities surfaced in the current session when the question is about that capability. Knowledge bases outside developers.openai.com are outside this route for public product answers.

For broad Codex behavior, setup, customization, skills, plugins, MCP, hooks, `AGENTS.md`, automations, surfaces, local state, or system-map questions:

1. Reuse a same-thread manual and outline path when it is still fresh.
2. Otherwise run the skill-local helper first in normal writable sessions. Skip it without trying only when the session is explicitly read-only, shell execution is unavailable, or visible policy shows no allowed temp cache.
3. By default, the helper chooses the first usable temp cache dir in this order: `$TMPDIR/openai-docs-cache`, `%TEMP%\openai-docs-cache`, `%TMP%\openai-docs-cache`, `/private/tmp/openai-docs-cache`, then `/tmp/openai-docs-cache`. Workspace-only write access is not enough for this temp cache.
4. Run the helper directly unless you need to override the cache dir. The helper falls back to `curl` when native `fetch` is unavailable or when proxy env vars are present, so no shell-specific proxy prefix is required. Resolve `<skill-dir>` to this skill's actual directory; in copied local eval workdirs this is usually `.codex/skills/openai-docs`:

```bash
node <skill-dir>/scripts/fetch-codex-manual.mjs
```

If you need to override the cache dir, pass `--cache-dir <cache-dir>`. On Windows, the helper checks `%TEMP%` and `%TMP%` automatically; in PowerShell, `$env:TEMP\\openai-docs-cache` is a typical explicit override.

Treat helper availability as established by explicit read-only/no-shell policy or an actual command result. A guessed sandbox or guessed helper failure is not enough to switch to Docs MCP or web lookup; after an actual helper command failure, continue to the narrowest official next source below.

The helper verifies freshness, writes `codex-manual.md`, and emits `codex-manual.outline.md`. The outline maps source pages and headings to line ranges; use it to choose the relevant manual section, then read or search targeted manual sections for Codex product facts. Use the skill directory to locate and run the helper; after the helper succeeds, use the returned manual and outline paths as the search scope for Codex product facts and term coverage checks.

Reuse the same-thread manual and outline paths for follow-up Codex questions. Refresh first when the manual was fetched more than about a day ago, the path is unusable, the path came from another thread or uncertain provenance, or likely-current information is missing and staleness is plausible.

For questions about whether the manual is current enough to rely on now, run the helper when temp caching is allowed and base the answer on its returned status, manual path, and outline path.

If the manual resolves a Codex claim, answer from it and stop expanding sources for that claim; continue the user's broader task if the docs lookup was only one dependency. Manual source pages and known anchors are enough citation support for manual-covered material.

If the helper is skipped because the session is read-only, has no shell execution, or has no allowed temp cache, the next source is Docs MCP: call `mcp__openaiDeveloperDocs__search_openai_docs`, then `mcp__openaiDeveloperDocs__fetch_openai_doc` for a relevant hit before any web fallback.

If a user names a Codex term or mode that a fresh manual does not use, search the manual for obvious adjacent concepts, then answer that the exact term is not documented and use the closest documented terminology. If the prompt asks how that term maps to Codex behavior, resolve the mapping from adjacent manual sections. If the exact term remains material or likely current after that manual pass, use one narrow Docs MCP search/fetch before bounded uncertainty; otherwise, the source lookup for that terminology or mapping claim is complete.

Use the narrowest official next source only when the manual is unavailable, the helper fails, temp caching is not allowed, another material claim is missing or likely stale, or the user explicitly needs a page-specific citation. Prefer one specific Docs MCP search and, if it returns a clearly relevant page, one fetch; for unresolved Codex capability names, acronyms, scheduling terms, or exact error text, this Docs MCP step is the next source before web search. After the manual plus any permitted Docs MCP gap-fill, resolve remaining gaps as bounded uncertainty. Use official-domain web fallback only after that Docs MCP path is unavailable or unhelpful. If the claim is still not established, stop with bounded uncertainty. If official docs/manual conflict with a callable capability already surfaced in the current session, state the conflict and prefer verified current-session behavior for that environment.

For undocumented or private-looking model slugs, product mode labels, entitlement labels, account access paths, or rollout names, answer from current public docs and bounded uncertainty. Those labels are not a reason to leave the public source route.

For support-style diagnostics, prefer a layer-by-layer answer from the manual over provider-specific web lookups: installed/enabled plugin, bundled app or connector authorization, MCP setup, workspace/admin policy, restart or new-thread expectations, then support or feedback if still unresolved.

If the source route still does not establish a claim, return bounded uncertainty or route to support, an admin, or product feedback instead of widening the investigation.

For unresolved product terminology, answer from the manual plus the allowed official next source. If those sources do not establish the term, answer with bounded uncertainty from those sources.

### Surface Map

When Codex nouns or durable-instruction surfaces overlap, recommend the smallest surface that matches the scope:

- Prompt or thread context -> one-off task constraints.
- `AGENTS.md` -> durable repo conventions, commands, verification steps, and review expectations; closer nested files apply under their subtree.
- Project `.codex/config.toml` -> trusted-repo Codex settings such as sandbox, MCP, hooks, model, or reasoning defaults.
- Global config or global guidance -> personal defaults across repos.
- Skill -> reusable task workflow with references or scripts.
- Plugin -> installable bundle with skills plus commands, tools, MCP config, hooks, assets, apps, or marketplace metadata.
- MCP server or app connector -> live external data/actions or authorized private app/workspace data. Use connectors for private Google Docs, Calendar, Slack, GitHub, Notion, and similar data instead of web search or model memory.
- Automation -> scheduled checks, reminders, monitors, or follow-up work; use a thread heartbeat when continuity in an existing thread matters.
- Hook -> lifecycle enforcement around tool calls, commands, or file edits.

Split mixed-scope requests instead of forcing one answer. Example: "always do X, but only for this PR" defaults to prompt/thread context for the current run; use `AGENTS.md` or project config only if it should persist, hooks only for mechanical enforcement, and automations only for scheduled or follow-up work.

Use this quick product map when needed: CLI is terminal-first local repo work; IDE extension is editor-attached coding; Codex app is desktop planning, review, and interactive work; cloud/web is hosted parallel/offloaded work; Browser Use/in-app browser is Codex-controlled web testing; Chrome extension uses the user's Chrome profile; Computer Use controls desktop apps and OS UI. Keep `config.toml` defaults, `requirements.toml` constraints, and managed/admin policy separate.

### Boundaries And Output

- API key auth does not imply ChatGPT, cloud task, or connector access. For plugin/app/auth failures, check bundle availability, plugin installed/enabled state, connector/app authorization, MCP setup, restart/refresh expectations, workspace policy, and per-surface availability before answering.
- Sandbox or network denials need scoped escalation with a clear justification. Destructive commands, writes outside the workspace, or broad access changes require explicit approval.
- Memory can provide user preference or context, but explicit prompt instructions win and memory is not a source for current external facts.
- For affirmative surface-selection answers, use this shape: recommendation, why, what to avoid, and the manual/source evidence used.
- When page-specific Codex citations are actually needed, these anchors often fit: `concepts/customization#agents-guidance` for `AGENTS.md`, `concepts/customization#skills` for skills, `plugins/build#plugin-structure` for plugins, `concepts/customization#mcp` for MCP, `config-advanced#hooks` for hooks, `app/automations#thread-automations` for thread automations, and `config-reference#configtoml` for config.

## If MCP server is missing

If MCP tools fail or no OpenAI docs resources are available:

1. Run the install command yourself: `codex mcp add openaiDeveloperDocs --url https://developers.openai.com/mcp`
2. If it fails due to permissions/sandboxing, immediately retry the same command with escalated permissions and include a 1-sentence justification for approval.
3. Ask the user to run the install command only if the escalated attempt fails.
4. Ask the user to restart Codex.
5. Re-run the doc search/fetch after restart.

## Workflow

1. Clarify whether the request is general docs lookup, model selection, a model-string upgrade, prompt-upgrade guidance, or broader API/provider migration.
2. For Codex self-knowledge requests, follow the Codex self-knowledge source procedure above.
3. For model-selection or upgrade requests, prefer current remote docs over bundled references when the user asks for latest/current/default guidance.
   - Fetch `https://developers.openai.com/api/docs/guides/latest-model.md`.
   - Find the latest model ID and explicit migration or prompt-guidance links.
   - Prefer explicit links from the latest-model page over derived URLs.
   - For explicit named-model requests, preserve the requested model target. Mention newer remote guidance only as optional.
   - For dynamic latest/current/default upgrades, run `node scripts/resolve-latest-model-info.js`, then fetch both returned guide URLs directly when possible.
   - If direct guide fetch fails, use the developer-docs MCP tools or official OpenAI-domain search to find the same guide content.
   - If remote docs are unavailable, use bundled fallback references and say that fallback guidance was used.
4. For model upgrades, keep changes narrow: update active OpenAI API model defaults and directly related prompts only when safe.
5. Leave historical docs, examples, eval baselines, fixtures, provider comparisons, provider registries, pricing tables, alias defaults, low-cost fallback paths, and ambiguous older model usage unchanged unless the user explicitly asks to upgrade them.
6. Keep SDK, tooling, IDE, plugin, shell, auth, and provider-environment migrations out of a model-and-prompt upgrade unless the user explicitly asks for them.
7. If an upgrade needs API-surface changes, schema rewiring, tool-handler changes, or implementation work beyond a literal model-string replacement and prompt edits, report it as blocked or confirmation-needed.
8. For general docs lookup, search docs with a precise query, fetch the best page and exact section needed, and answer with concise citations.

## Reference map

Read only what you need:

- `https://developers.openai.com/api/docs/guides/latest-model.md` -> current model-selection and "best/latest/current model" questions.
- `scripts/fetch-codex-manual.mjs` -> current Codex manual fetch, verification, local temp cache, and outline generation.
- `https://developers.openai.com/codex/codex-manual.md` -> current Codex self-knowledge synthesis, including setup, customization, skills, plugins, MCP, hooks, `AGENTS.md`, automations, and surface behavior; normally access it through the helper path and targeted file reads when temp caching is available.
- `references/latest-model.md` -> bundled fallback for model-selection and "best/latest/current model" questions.
- `references/upgrade-guide.md` -> bundled fallback for model upgrade and upgrade-planning requests.
- `references/prompting-guide.md` -> bundled fallback for prompt rewrites and prompt-behavior upgrades.

## Quality rules

- Treat OpenAI docs as the source of truth; avoid speculation.
- For Codex self-knowledge, follow the source route above instead of relying on remembered behavior.
- Keep migration changes narrow and behavior-preserving.
- Prefer prompt-only upgrades when possible.
- Avoid inventing pricing, availability, parameters, API changes, or breaking changes.
- Keep quotes short and within policy limits; prefer paraphrase with citations.
- If multiple pages differ, call out the difference and cite both.
- If official docs and verified callable current-session behavior disagree, state the conflict before making broad claims or edits.
- If docs do not cover the user’s need, say so and offer next steps.

## Tooling notes

- Use MCP doc tools before web search for OpenAI-related markdown docs. The Codex manual flow is the exception: follow the Codex self-knowledge source procedure for broad Codex synthesis.
- If the MCP server is installed but returns no meaningful results, then use web search as a fallback.
- When falling back to web search, restrict to official OpenAI domains (developers.openai.com, platform.openai.com) and cite sources.

hook: PostToolUse
exec
/bin/zsh -lc "sed -n '1,220p' /Users/junghojang/.codex/skills/context-mode/SKILL.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
---
name: context-mode
description: Use the context-mode MCP server and routing hooks when tasks involve large context, many files, or repeated analysis that should be indexed instead of pasted.
---

# context-mode

Use this skill when a task benefits from the context-mode MCP server installed from `mksglu/context-mode`.

## What it does

- Routes Codex tool use through context-mode hooks.
- Pushes large or repeated context into indexed memory instead of flooding the chat.
- Provides `ctx_*` commands for search, batch execution, indexing, and maintenance.

## How to use

- Keep `context-mode` installed on PATH.
- Ensure `~/.codex/config.toml` contains the `context-mode` MCP server entry.
- Ensure `~/.codex/hooks.json` points Codex hook events at `context-mode hook codex ...`.
- Keep `~/.codex/AGENTS.md` loaded as the routing policy for Codex sessions.

## When to prefer it

- Large repo analysis.
- Repeated file exploration.
- Multi-file search or transform work.
- Tasks that need a local indexed memory instead of raw transcript growth.

## Operational rule

- Prefer indexed search and batch execution over raw context dumps.
- Prefer code that reads, indexes, and summarizes over manual copy/paste.

hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
공식 Codex manual을 먼저 색인합니다. 질문 항목별 키워드로 같은 원문에서 확인해 확실/불확실을 나누겠습니다.
mcp: context-mode/ctx_fetch_and_index started
mcp: context-mode/ctx_fetch_and_index (failed)
user cancelled MCP tool call
web search: 
web search: site:developers.openai.com/codex AGENTS.md Codex CLI config.toml prompts slash commands skills plugins MCP codex exec
web search: 
web search: https://developers.openai.com/codex/codex-manual.md
codex
context-mode fetch가 취소되어 공식 manual helper로 전환합니다. 출력은 경로/상태만 받고, 필요한 섹션만 좁혀 읽겠습니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc 'node /Users/junghojang/.codex/skills/.system/openai-docs/scripts/fetch-codex-manual.mjs' in /Users/junghojang/Developments/myProject/myHarness
 exited 1 in 0ms:
Error: Manual cache directory is unavailable; pass --cache-dir to override or use OpenAI Docs MCP fallback.

Details:
ManualFetchError: Manual cache directory is unavailable; pass --cache-dir to override or use OpenAI Docs MCP fallback.
    at fetchCodexManual (file:///Users/junghojang/.codex/skills/.system/openai-docs/scripts/fetch-codex-manual.mjs:415:11)
    at async main (file:///Users/junghojang/.codex/skills/.system/openai-docs/scripts/fetch-codex-manual.mjs:534:35)

hook: PostToolUse
hook: PostToolUse Completed
web search: 
web search: Codex CLI AGENTS.md configuration prompts config.toml MCP codex exec site:developers.openai.com/codex
codex
공식 manual fetch는 캐시 디렉터리 제한 때문에 실패했습니다. 이제 설치된 `codex` 0.137.0의 로컬 help/패키지 문서를 확인합니다.
mcp: context-mode/ctx_execute started
mcp: context-mode/ctx_execute (failed)
user cancelled MCP tool call
codex
context-mode 실행도 취소되었습니다. 같은 확인을 일반 셸로 짧게 실행합니다. 원문 덤프 없이 관련 라인만 필터링합니다.
hook: PreToolUse
hook: PreToolUse Completed
hook: PostToolUse
hook: PostToolUse Completed
codex
셸 here-doc도 읽기 전용 제한에 걸렸습니다. 임시파일 없는 단일 명령으로 축소해 확인합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "codex --version && codex --help | grep -Ei 'exec|config|mcp|profile|prompt|agent|slash|resume|sandbox|approval|model|cd|json|output|schema|last|full' | head -120 && codex exec --help | grep -Ei 'config|profile|sandbox|approval|json|output|cd|skip|model|prompt|agent|mcp|schema|last|full' | head -120 && codex mcp --help | head -120" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
 succeeded in 487ms:
WARNING: proceeding, even though we could not update PATH: Operation not permitted (os error 1)
codex-cli 0.137.0
WARNING: proceeding, even though we could not update PATH: Operation not permitted (os error 1)
Usage: codex [OPTIONS] [PROMPT]
  exec            Run Codex non-interactively [aliases: e]
  mcp             Manage external MCP servers for Codex
  mcp-server      Start Codex as an MCP server (stdio)
  doctor          Diagnose local Codex installation, config, auth, and runtime health
  sandbox         Run commands within a Codex-provided sandbox
  apply           Apply the latest diff produced by Codex agent as a `git apply` to your local
  resume          Resume a previous interactive session (picker by default; use --last to continue
  fork            Fork a previous interactive session (picker by default; use --last to fork the
  exec-server     [EXPERIMENTAL] Run the standalone exec-server service
  [PROMPT]
          Optional user prompt to start the session
  -c, --config <key=value>
          Override a configuration value that would otherwise be loaded from `~/.codex/config.toml`.
          Examples: - `-c model="o3"` - `-c 'sandbox_permissions=["disk-full-read-access"]'` - `-c
      --strict-config
          Error out when config.toml contains fields that are not recognized by this version of
          Optional image(s) to attach to the initial prompt
  -m, --model <MODEL>
          Model the agent should use
          will use config default or show selection
  -p, --profile <CONFIG_PROFILE_V2>
          Layer $CODEX_HOME/<name>.config.toml on top of the base user config
  -s, --sandbox <SANDBOX_MODE>
          Select the sandbox policy to use when executing model-generated shell commands
          [possible values: read-only, workspace-write, danger-full-access]
      --dangerously-bypass-approvals-and-sandbox
          Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY
          DANGEROUS. Intended solely for running in environments that are externally sandboxed
  -C, --cd <DIR>
          Tell the agent to use the specified directory as its working root
  -a, --ask-for-approval <APPROVAL_POLICY>
          Configure when the model requires human approval before executing a command
            approval. Will escalate to the user if the model proposes a command that is not in the
          - on-failure: DEPRECATED: Run all commands without asking for user approval. Only asks for
            approval if a command fails to execute, in which case it will escalate to the user to
            ask for un-sandboxed execution. Prefer `on-request` for interactive runs or `never` for
          - on-request: The model decides when to ask the user for approval
          - never:      Never ask for user approval Execution failures are immediately returned to
            the model
          to the model (no per‑call approval)
WARNING: proceeding, even though we could not update PATH: Operation not permitted (os error 1)
Usage: codex exec [OPTIONS] [PROMPT]
  resume  Resume a previous session by id or pick the most recent with --last
  [PROMPT]
          Initial instructions for the agent. If not provided as an argument (or if `-` is used),
          instructions are read from stdin. If stdin is piped and a prompt is also provided, stdin
  -c, --config <key=value>
          Override a configuration value that would otherwise be loaded from `~/.codex/config.toml`.
          Examples: - `-c model="o3"` - `-c 'sandbox_permissions=["disk-full-read-access"]'` - `-c
      --strict-config
          Error out when config.toml contains fields that are not recognized by this version of
          Optional image(s) to attach to the initial prompt
  -m, --model <MODEL>
          Model the agent should use
          will use config default or show selection
  -p, --profile <CONFIG_PROFILE_V2>
          Layer $CODEX_HOME/<name>.config.toml on top of the base user config
  -s, --sandbox <SANDBOX_MODE>
          Select the sandbox policy to use when executing model-generated shell commands
          [possible values: read-only, workspace-write, danger-full-access]
      --dangerously-bypass-approvals-and-sandbox
          Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY
          DANGEROUS. Intended solely for running in environments that are externally sandboxed
  -C, --cd <DIR>
          Tell the agent to use the specified directory as its working root
      --skip-git-repo-check
      --ignore-user-config
          Do not load `$CODEX_HOME/config.toml`; auth still uses `CODEX_HOME`
      --output-schema <FILE>
          Path to a JSON Schema file describing the model's final response shape
          Specifies color settings for use in the output
      --json
          Print events to stdout as JSONL
  -o, --output-last-message <FILE>
          Specifies file where the last message from the agent should be written
WARNING: proceeding, even though we could not update PATH: Operation not permitted (os error 1)
Manage external MCP servers for Codex

Usage: codex mcp [OPTIONS] <COMMAND>

Commands:
  list    
  get     
  add     
  remove  
  login   
  logout  
  help    Print this message or the help of the given subcommand(s)

Options:
  -c, --config <key=value>
          Override a configuration value that would otherwise be loaded from `~/.codex/config.toml`.
          Use a dotted path (`foo.bar.baz`) to override nested values. The `value` portion is parsed
          as TOML. If it fails to parse as TOML, the raw string is used as a literal.
          
          Examples: - `-c model="o3"` - `-c 'sandbox_permissions=["disk-full-read-access"]'` - `-c
          shell_environment_policy.inherit=all`

      --enable <FEATURE>
          Enable a feature (repeatable). Equivalent to `-c features.<name>=true`

      --disable <FEATURE>
          Disable a feature (repeatable). Equivalent to `-c features.<name>=false`

  -h, --help
          Print help (see a summary with '-h')

hook: PostToolUse Completed
codex
로컬 CLI help는 확인됐습니다. AGENTS/skills/prompts는 help에 안 나오므로 설치 패키지와 공식 공개 문서 흔적을 좁혀 검색합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc 'which codex && npm root -g 2>/dev/null && find $(npm root -g 2>/dev/null) -maxdepth 4 -iname '"'*codex*' -type d 2>/dev/null | head -40" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
 succeeded in 555ms:
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/context-mode/hooks/codex
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/context-mode/configs/codex
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/context-mode/build/adapters/codex
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/context-mode/.codex-plugin

hook: PostToolUse Completed
codex
패키지 위치를 찾았습니다. 이제 README/문서 파일에서 해당 기능명만 추출합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "rg -n \"AGENTS\\.md|prompts|slash|skills|sub.?agent|agent team|config\\.toml|mcp_servers|profile|codex exec|\\"'$ARGUMENTS|CODEX_HOME" /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex -g '"'*.md' -g '*.toml' -g '*.json' | head -200" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
hook: PostToolUse
hook: PostToolUse Completed
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "find /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex -maxdepth 3 -type f | sed 's#"'^#/##'"' | head -120" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
sed: 1: "s#^#/##
": bad flag in substitute command: '#'

hook: PostToolUse
hook: PostToolUse Completed
codex
패키지는 문서가 거의 없는 바이너리 배포로 보입니다. 파일 구조만 짧게 확인하고, 필요하면 바이너리 문자열/공식 원격 문서로 보완합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc 'find /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex -maxdepth 3 -type f | head -120' in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/bin/codex.js
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/README.md
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/package.json

hook: PostToolUse
hook: PostToolUse Completed
codex
README가 핵심일 가능성이 큽니다. 긴 내용 대신 관련 헤딩과 일치 라인만 읽습니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "rg -n \"AGENTS\\.md|prompts|slash|skills|sub.?agent|config\\.toml|mcp|profile|codex exec|CODEX_HOME|approval|sandbox|prompt\" /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/README.md | head -200" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
hook: PostToolUse
hook: PostToolUse Completed
codex
README에 해당 키워드가 없습니다. 크기만 보고 짧으면 전체 확인합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "wc -l /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/README.md && sed -n '1,180p' /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/README.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
      71 /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/README.md
<p align="center"><strong>Codex CLI</strong> is a coding agent from OpenAI that runs locally on your computer.
<p align="center">
  <img src="https://github.com/openai/codex/blob/main/.github/codex-cli-splash.png" alt="Codex CLI splash" width="80%" />
</p>
</br>
If you want Codex in your code editor (VS Code, Cursor, Windsurf), <a href="https://developers.openai.com/codex/ide">install in your IDE.</a>
</br>If you want the desktop app experience, run <code>codex app</code> or visit <a href="https://chatgpt.com/codex?app-landing-page=true">the Codex App page</a>.
</br>If you are looking for the <em>cloud-based agent</em> from OpenAI, <strong>Codex Web</strong>, go to <a href="https://chatgpt.com/codex">chatgpt.com/codex</a>.</p>

---

## Quickstart

### Installing and running Codex CLI

Run the following on Mac or Linux to install Codex CLI:

```shell
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

Run the following on Windows to install Codex CLI:

```
powershell -ExecutionPolicy ByPass -c "irm https://chatgpt.com/codex/install.ps1 | iex"
```

Codex CLI can also be installed via the following package managers:

```shell
# Install using npm
npm install -g @openai/codex
```

```shell
# Install using Homebrew
brew install --cask codex
```

Then simply run `codex` to get started.

<details>
<summary>You can also go to the <a href="https://github.com/openai/codex/releases/latest">latest GitHub Release</a> and download the appropriate binary for your platform.</summary>

Each GitHub Release contains many executables, but in practice, you likely want one of these:

- macOS
  - Apple Silicon/arm64: `codex-aarch64-apple-darwin.tar.gz`
  - x86_64 (older Mac hardware): `codex-x86_64-apple-darwin.tar.gz`
- Linux
  - x86_64: `codex-x86_64-unknown-linux-musl.tar.gz`
  - arm64: `codex-aarch64-unknown-linux-musl.tar.gz`

Each archive contains a single entry with the platform baked into the name (e.g., `codex-x86_64-unknown-linux-musl`), so you likely want to rename it to `codex` after extracting it.

</details>

### Using Codex with your ChatGPT plan

Run `codex` and select **Sign in with ChatGPT**. We recommend signing into your ChatGPT account to use Codex as part of your Plus, Pro, Business, Edu, or Enterprise plan. [Learn more about what's included in your ChatGPT plan](https://help.openai.com/en/articles/11369540-codex-in-chatgpt).

You can also use Codex with an API key, but this requires [additional setup](https://developers.openai.com/codex/auth#sign-in-with-an-api-key).

## Docs

- [**Codex Documentation**](https://developers.openai.com/codex)
- [**Contributing**](./docs/contributing.md)
- [**Installing & building**](./docs/install.md)
- [**Open source fund**](./docs/open-source-fund.md)

This repository is licensed under the [Apache-2.0 License](LICENSE).

hook: PostToolUse
hook: PostToolUse Completed
web search: 
web search: github openai codex AGENTS.md config.toml prompts skills codex exec
web search: 
web search: https://developers.openai.com/codex/cli
web search: 
web search: https://developers.openai.com/codex/cli
web search: 
web search: 'global' in https://developers.openai.com/codex/guides/agents-md
web search: 
web search: https://developers.openai.com/codex/cli/slash-commands
web search: 
web search: 'custom' in https://developers.openai.com/codex/cli/slash-commands
web search: 
web search: site:developers.openai.com/codex "custom prompts" "Codex CLI"
web search: 
web search: 'config_profile' in https://developers.openai.com/codex/config-reference
web search: 
web search: 'Expected: Codex reports' in https://developers.openai.com/codex/guides/agents-md
codex
확인 기준: 공식 Codex docs + 로컬 `codex-cli 0.137.0 --help`.

1. **`AGENTS.md` 자동 발견**
확실:
- 글로벌: `$CODEX_HOME` 기본값 `~/.codex`. `AGENTS.override.md`가 있으면 그것만, 없으면 `AGENTS.md`. 글로벌 레벨은 첫 non-empty 파일 1개만 사용.
- 프로젝트: 프로젝트 루트, 보통 Git root, 에서 현재 작업 디렉터리까지 내려오며 각 디렉터리마다 `AGENTS.override.md` → `AGENTS.md` → `project_doc_fallback_filenames` 순서로 검사. 디렉터리당 최대 1개.
- 병합: 루트에서 현재 디렉터리 방향으로 concat. 뒤에 붙는, 즉 더 가까운 디렉터리 지시가 앞 지시보다 우선.
- 기본 combined cap: `project_doc_max_bytes`, docs상 32 KiB 기본값.
출처: 공식 AGENTS.md docs ([developers.openai.com](https://developers.openai.com/codex/guides/agents-md))

2. **커스텀 슬래시 프롬프트 `~/.codex/prompts/*.md`**
확실:
- 공식 CLI slash command 문서는 built-in slash commands 중심. `/skills`, `/agent`, `/plan`, `/permissions` 등은 있음. ([developers.openai.com](https://developers.openai.com/codex/cli/slash-commands)) ([developers.openai.com](https://developers.openai.com/codex/cli/slash-commands))
- 공식 docs 검색/로컬 help 기준으로 `~/.codex/prompts/*.md`, `$ARGUMENTS` 같은 Claude Code식 커스텀 slash prompt는 확인되지 않음.
불확실:
- 숨은/실험 기능으로 존재할 가능성까지 0이라고 단정은 못 함. 하지만 0.137.0 공식 문서화된 호환 메커니즘은 아님.

3. **멀티 에이전트/서브에이전트**
확실:
- Codex는 네이티브 subagents 지원. 병렬 specialized agents spawn 후 결과를 모아 응답 가능.
- 명시적으로 요청할 때만 새 agent를 spawn.
- CLI에서 `/agent`로 active agent thread 전환/검사.
- 내장 agent: `default`, `worker`, `explorer`.
- 커스텀 agent: `~/.codex/agents/*.toml` 또는 프로젝트 `.codex/agents/*.toml`.
출처: 공식 Subagents docs ([developers.openai.com](https://developers.openai.com/codex/subagents)) ([developers.openai.com](https://developers.openai.com/codex/subagents))

따라서 `codex exec` subprocess가 유일한 병렬화 수단은 아님. 다만 외부 오케스트레이터/CI에서 완전 독립 프로세스 병렬 실행을 원하면 `codex exec` 여러 개를 띄우는 방식도 가능.

`codex exec` 베스트 프랙티스:
- 기본은 read-only sandbox.
- 자동화에서 필요한 최소 권한만 명시: `--sandbox workspace-write` 등.
- 스크립트 소비는 `--json`.
- 최종 메시지만 파일로 받으려면 `-o/--output-last-message`.
- config 격리가 필요하면 `--ignore-user-config`.
출처: 공식 non-interactive docs ([developers.openai.com](https://developers.openai.com/codex/noninteractive)) ([developers.openai.com](https://developers.openai.com/codex/noninteractive))

4. **`config.toml` 프로젝트/프로파일/MCP**
확실:
- 사용자 config: `~/.codex/config.toml`.
- 프로젝트 config: repo 안 `.codex/config.toml`; trusted project에서만 로드.
- 우선순위: CLI flags/`--config` > 프로젝트 `.codex/config.toml`들, root→cwd, closest wins > `--profile` 파일 > user config > system config > defaults.
- profile 파일: `$CODEX_HOME/<profile-name>.config.toml`, `--profile <name>`로 선택.
- MCP 서버는 `config.toml`의 `mcp_servers.<id>.*`로 등록. CLI/IDE 공유. 프로젝트 `.codex/config.toml`에도 둘 수 있음, trusted project 한정.
- 프로젝트 config는 배포 가능하지만, provider/auth/telemetry/profile selection 등 일부 machine-local 키는 project-local에서 무시됨.
출처: config basics/reference/MCP docs ([developers.openai.com](https://developers.openai.com/codex/config-basic)) ([developers.openai.com](https://developers.openai.com/codex/config-reference)) ([developers.openai.com](https://developers.openai.com/codex/mcp))

5. **Claude Code식 skill auto-trigger 대응**
확실:
- Codex에도 description 기반 implicit skill activation 있음.
- skill은 `SKILL.md`에 `name`, `description` 필요.
- CLI/IDE에서 `/skills` 또는 `$skill-name`로 명시 호출 가능.
- 저장 위치: repo `.agents/skills` 계층, user `$HOME/.agents/skills`, admin `/etc/codex/skills`.
출처: Skills docs ([developers.openai.com](https://developers.openai.com/codex/skills)) ([developers.openai.com](https://developers.openai.com/codex/skills))

결론: “하네스 팩토리”는 Codex에서 `AGENTS.md` 인라인 지시만으로 포팅할 필요 없음. 더 맞는 포팅 단위는 **plugin + skills + optional subagents + project `.codex/config.toml`**. Custom slash prompt만 Claude Code와 1:1 대응이 불확실/미지원 쪽.
hook: Stop
hook: Stop Completed
tokens used
119,192
확인 기준: 공식 Codex docs + 로컬 `codex-cli 0.137.0 --help`.

1. **`AGENTS.md` 자동 발견**
확실:
- 글로벌: `$CODEX_HOME` 기본값 `~/.codex`. `AGENTS.override.md`가 있으면 그것만, 없으면 `AGENTS.md`. 글로벌 레벨은 첫 non-empty 파일 1개만 사용.
- 프로젝트: 프로젝트 루트, 보통 Git root, 에서 현재 작업 디렉터리까지 내려오며 각 디렉터리마다 `AGENTS.override.md` → `AGENTS.md` → `project_doc_fallback_filenames` 순서로 검사. 디렉터리당 최대 1개.
- 병합: 루트에서 현재 디렉터리 방향으로 concat. 뒤에 붙는, 즉 더 가까운 디렉터리 지시가 앞 지시보다 우선.
- 기본 combined cap: `project_doc_max_bytes`, docs상 32 KiB 기본값.
출처: 공식 AGENTS.md docs ([developers.openai.com](https://developers.openai.com/codex/guides/agents-md))

2. **커스텀 슬래시 프롬프트 `~/.codex/prompts/*.md`**
확실:
- 공식 CLI slash command 문서는 built-in slash commands 중심. `/skills`, `/agent`, `/plan`, `/permissions` 등은 있음. ([developers.openai.com](https://developers.openai.com/codex/cli/slash-commands)) ([developers.openai.com](https://developers.openai.com/codex/cli/slash-commands))
- 공식 docs 검색/로컬 help 기준으로 `~/.codex/prompts/*.md`, `$ARGUMENTS` 같은 Claude Code식 커스텀 slash prompt는 확인되지 않음.
불확실:
- 숨은/실험 기능으로 존재할 가능성까지 0이라고 단정은 못 함. 하지만 0.137.0 공식 문서화된 호환 메커니즘은 아님.

3. **멀티 에이전트/서브에이전트**
확실:
- Codex는 네이티브 subagents 지원. 병렬 specialized agents spawn 후 결과를 모아 응답 가능.
- 명시적으로 요청할 때만 새 agent를 spawn.
- CLI에서 `/agent`로 active agent thread 전환/검사.
- 내장 agent: `default`, `worker`, `explorer`.
- 커스텀 agent: `~/.codex/agents/*.toml` 또는 프로젝트 `.codex/agents/*.toml`.
출처: 공식 Subagents docs ([developers.openai.com](https://developers.openai.com/codex/subagents)) ([developers.openai.com](https://developers.openai.com/codex/subagents))

따라서 `codex exec` subprocess가 유일한 병렬화 수단은 아님. 다만 외부 오케스트레이터/CI에서 완전 독립 프로세스 병렬 실행을 원하면 `codex exec` 여러 개를 띄우는 방식도 가능.

`codex exec` 베스트 프랙티스:
- 기본은 read-only sandbox.
- 자동화에서 필요한 최소 권한만 명시: `--sandbox workspace-write` 등.
- 스크립트 소비는 `--json`.
- 최종 메시지만 파일로 받으려면 `-o/--output-last-message`.
- config 격리가 필요하면 `--ignore-user-config`.
출처: 공식 non-interactive docs ([developers.openai.com](https://developers.openai.com/codex/noninteractive)) ([developers.openai.com](https://developers.openai.com/codex/noninteractive))

4. **`config.toml` 프로젝트/프로파일/MCP**
확실:
- 사용자 config: `~/.codex/config.toml`.
- 프로젝트 config: repo 안 `.codex/config.toml`; trusted project에서만 로드.
- 우선순위: CLI flags/`--config` > 프로젝트 `.codex/config.toml`들, root→cwd, closest wins > `--profile` 파일 > user config > system config > defaults.
- profile 파일: `$CODEX_HOME/<profile-name>.config.toml`, `--profile <name>`로 선택.
- MCP 서버는 `config.toml`의 `mcp_servers.<id>.*`로 등록. CLI/IDE 공유. 프로젝트 `.codex/config.toml`에도 둘 수 있음, trusted project 한정.
- 프로젝트 config는 배포 가능하지만, provider/auth/telemetry/profile selection 등 일부 machine-local 키는 project-local에서 무시됨.
출처: config basics/reference/MCP docs ([developers.openai.com](https://developers.openai.com/codex/config-basic)) ([developers.openai.com](https://developers.openai.com/codex/config-reference)) ([developers.openai.com](https://developers.openai.com/codex/mcp))

5. **Claude Code식 skill auto-trigger 대응**
확실:
- Codex에도 description 기반 implicit skill activation 있음.
- skill은 `SKILL.md`에 `name`, `description` 필요.
- CLI/IDE에서 `/skills` 또는 `$skill-name`로 명시 호출 가능.
- 저장 위치: repo `.agents/skills` 계층, user `$HOME/.agents/skills`, admin `/etc/codex/skills`.
출처: Skills docs ([developers.openai.com](https://developers.openai.com/codex/skills)) ([developers.openai.com](https://developers.openai.com/codex/skills))

결론: “하네스 팩토리”는 Codex에서 `AGENTS.md` 인라인 지시만으로 포팅할 필요 없음. 더 맞는 포팅 단위는 **plugin + skills + optional subagents + project `.codex/config.toml`**. Custom slash prompt만 Claude Code와 1:1 대응이 불확실/미지원 쪽.
