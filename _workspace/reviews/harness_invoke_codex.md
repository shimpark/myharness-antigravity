Reading additional input from stdin...
OpenAI Codex v0.139.0
--------
workdir: /Users/junghojang/Developments/myProject/myHarness
model: gpt-5.5
provider: openai
approval: never
sandbox: read-only
reasoning effort: medium
reasoning summaries: none
session id: 019eb044-94ed-70f3-9161-5e990de211ee
--------
user
이 레포에서 Codex CLI로 "harness" 스킬을 실행하려는데 사용자가 `/harness`를 쳤더니 안 된다. 정확히 알려달라(확실/불확실 구분):
1. Codex CLI(0.137.0)에서 커스텀 스킬 호출 정확한 문법? `/harness`가 되나, 아니면 `$harness`나 `/skills` 메뉴인가? description 기반 암묵 활성화는 어떻게 트리거되나?
2. 스킬이 repo `.agents/skills/harness`에 심링크(→ ../../skills/harness)로 있다. Codex가 (a) repo `.agents/skills`를 스캔하나? (b) 심링크를 따르나? (c) trusted project 설정이 필요한가? (d) 설치 후 세션 재시작이 필요한가?
3. 지금 이 작업 디렉토리에서 harness 스킬이 Codex에 인식되는지 실제로 확인해줘.
hook: SessionStart
hook: SessionStart Completed
hook: UserPromptSubmit
hook: UserPromptSubmit Completed
codex
`harness` 스킬 요청으로 처리합니다. 먼저 현재 Codex 세션에서 노출된 스킬 목록과 로컬 파일 상태를 확인하고, CLI 문법은 로컬 설치 문서/바이너리 기준으로 확인합니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "find /Users/junghojang/.codex -maxdepth 3 \\( -name 'SKILL.md' -o -name '*.toml' -o -name '*.json' \\) 2>/dev/null | sed 's#"'^#/##'"' | head -200" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
sed: 1: "s#^#/##
": bad flag in substitute command: '#'

hook: PostToolUse
exec
/bin/zsh -lc 'pwd && command -v codex && codex --version && ls -la .agents/skills 2>/dev/null && ls -la .agents/skills/harness 2>/dev/null && readlink .agents/skills/harness 2>/dev/null && ls -la /Users/junghojang/.codex/skills/harness 2>/dev/null' in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
exec
/bin/zsh -lc "codex --help | sed -n '1,220p'" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
 succeeded in 145ms:
WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)
codex-cli 0.139.0
total 0
drwxr-xr-x@ 3 junghojang  staff  96 Jun 10 15:33 .
drwxr-xr-x@ 3 junghojang  staff  96 Jun 10 15:33 ..
lrwxr-xr-x@ 1 junghojang  staff  20 Jun 10 15:33 harness -> ../../skills/harness
lrwxr-xr-x@ 1 junghojang  staff  20 Jun 10 15:33 .agents/skills/harness -> ../../skills/harness
../../skills/harness
total 64
drwxr-xr-x@ 4 junghojang  staff    128 Jun  4 23:22 .
drwxr-xr-x  5 junghojang  staff    160 Jun  4 23:38 ..
-rw-r--r--@ 1 junghojang  staff  29830 Jun  4 23:22 SKILL.md
drwxr-xr-x@ 8 junghojang  staff    256 Jun  4 23:22 references

 succeeded in 123ms:
WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)
Codex CLI

If no subcommand is specified, options will be forwarded to the interactive CLI.

Usage: codex [OPTIONS] [PROMPT]
       codex [OPTIONS] <COMMAND> [ARGS]

Commands:
  exec            Run Codex non-interactively [aliases: e]
  review          Run a code review non-interactively
  login           Manage login
  logout          Remove stored authentication credentials
  mcp             Manage external MCP servers for Codex
  plugin          Manage Codex plugins
  mcp-server      Start Codex as an MCP server (stdio)
  app-server      [experimental] Run the app server or related tooling
  remote-control  [experimental] Manage the app-server daemon with remote control enabled
  app             Launch the Codex desktop app (opens the app installer if missing)
  completion      Generate shell completion scripts
  update          Update Codex to the latest version
  doctor          Diagnose local Codex installation, config, auth, and runtime health
  sandbox         Run commands within a Codex-provided sandbox
  debug           Debugging tools
  apply           Apply the latest diff produced by Codex agent as a `git apply` to your local
                  working tree [aliases: a]
  resume          Resume a previous interactive session (picker by default; use --last to continue
                  the most recent)
  archive         Archive a saved session by id or session name
  unarchive       Unarchive a saved session by id or session name
  fork            Fork a previous interactive session (picker by default; use --last to fork the
                  most recent)
  cloud           [EXPERIMENTAL] Browse tasks from Codex Cloud and apply changes locally
  exec-server     [EXPERIMENTAL] Run the standalone exec-server service
  features        Inspect feature flags
  help            Print this message or the help of the given subcommand(s)

Arguments:
  [PROMPT]
          Optional user prompt to start the session

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

      --remote <ADDR>
          Connect the TUI to a remote app server endpoint.
          
          Accepted forms: `ws://host:port`, `wss://host:port`, `unix://`, or `unix://PATH`.

      --remote-auth-token-env <ENV_VAR>
          Name of the environment variable containing the bearer token to send to a remote app
          server websocket

      --strict-config
          Error out when config.toml contains fields that are not recognized by this version of
          Codex

  -i, --image <FILE>...
          Optional image(s) to attach to the initial prompt

  -m, --model <MODEL>
          Model the agent should use

      --oss
          Use open-source provider

      --local-provider <OSS_PROVIDER>
          Specify which local provider to use (lmstudio or ollama). If not specified with --oss,
          will use config default or show selection

  -p, --profile <CONFIG_PROFILE_V2>
          Layer $CODEX_HOME/<name>.config.toml on top of the base user config

  -s, --sandbox <SANDBOX_MODE>
          Select the sandbox policy to use when executing model-generated shell commands
          
          [possible values: read-only, workspace-write, danger-full-access]

      --dangerously-bypass-approvals-and-sandbox
          Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY
          DANGEROUS. Intended solely for running in environments that are externally sandboxed

      --dangerously-bypass-hook-trust
          Run enabled hooks without requiring persisted hook trust for this invocation. DANGEROUS.
          Intended only for automation that already vets hook sources

  -C, --cd <DIR>
          Tell the agent to use the specified directory as its working root

      --add-dir <DIR>
          Additional directories that should be writable alongside the primary workspace

  -a, --ask-for-approval <APPROVAL_POLICY>
          Configure when the model requires human approval before executing a command

          Possible values:
          - untrusted:  Only run "trusted" commands (e.g. ls, cat, sed) without asking for user
            approval. Will escalate to the user if the model proposes a command that is not in the
            "trusted" set
          - on-failure: DEPRECATED: Run all commands without asking for user approval. Only asks for
            approval if a command fails to execute, in which case it will escalate to the user to
            ask for un-sandboxed execution. Prefer `on-request` for interactive runs or `never` for
            non-interactive runs
          - on-request: The model decides when to ask the user for approval
          - never:      Never ask for user approval Execution failures are immediately returned to
            the model

      --search
          Enable live web search. When enabled, the native Responses `web_search` tool is available
          to the model (no per‑call approval)

      --no-alt-screen
          Disable alternate screen mode
          
          Runs the TUI in inline mode, preserving terminal scrollback history.

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version

hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
`context-mode` 도구가 노출됐습니다. 큰 탐색은 `ctx_execute`로 줄여서 확인합니다. 로컬 Codex는 현재 `0.139.0`으로 나옵니다. 사용자가 말한 `0.137.0`과 다르므로, 버전 차이는 따로 표시합니다.
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse
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
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '1,220p' /Users/junghojang/.codex/skills/harness/SKILL.md" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
---
name: harness
description: "하네스를 구성합니다. 전문 에이전트를 정의하며, 해당 에이전트가 사용할 스킬을 생성하는 메타 스킬. (1) '하네스 구성해줘', '하네스 구축해줘' 요청 시, (2) '하네스 설계', '하네스 엔지니어링' 요청 시, (3) 새로운 도메인/프로젝트에 대한 하네스 기반 자동화 체계를 구축할 때, (4) 하네스 구성을 재구성하거나 확장할 때, (5) '하네스 점검', '하네스 감사', '하네스 현황', '에이전트/스킬 동기화' 등 기존 하네스 운영/유지보수 요청 시 사용."
---

# Harness — Agent Team & Skill Architect

도메인/프로젝트에 맞는 하네스를 구성하고, 각 에이전트의 역할을 정의하며, 에이전트가 사용할 스킬을 생성하는 메타 스킬.

**핵심 원칙:**
1. 에이전트 정의(`.claude/agents/`)와 스킬(`.claude/skills/`)을 생성한다.
2. **에이전트 팀을 기본 실행 모드로 사용한다.**
3. **CLAUDE.md에 하네스 포인터를 등록한다.** — 새 세션에서 오케스트레이터 스킬이 트리거되도록 최소한의 포인터(트리거 규칙 + 변경 이력)만 기록한다.
4. **하네스는 고정물이 아니라 진화하는 시스템이다.** — 매 실행 후 피드백을 반영하고, 에이전트·스킬·CLAUDE.md를 지속 갱신한다.

## 워크플로우

### Phase 0: 현황 감사

하네스 스킬이 트리거되면 가장 먼저 기존 하네스 현황을 확인한다.

1. `프로젝트/.claude/agents/`, `프로젝트/.claude/skills/`, `프로젝트/CLAUDE.md`를 읽는다
2. 현황에 따라 실행 모드를 분기한다:
   - **신규 구축**: 에이전트/스킬 디렉토리가 없거나 비어있음 → Phase 1부터 전체 실행
   - **기존 확장**: 기존 하네스가 있고 새 에이전트/스킬 추가 요청 → 아래 Phase 선택 매트릭스에 따라 필요한 Phase만 실행
   - **운영/유지보수**: 기존 하네스의 감사·수정·동기화 요청 → Phase 7-5 운영/유지보수 워크플로우로 이동

   **기존 확장 시 Phase 선택 매트릭스:**
   | 변경 유형 | Phase 1 | Phase 2 | Phase 3 | Phase 4 | Phase 5 | Phase 6 |
   |----------|---------|---------|---------|---------|---------|---------|
   | 에이전트 추가 | 건너뜀 (Phase 0 결과 활용) | 배치 결정만 | 필수 (3-0 포함) | 전용 스킬 필요 시 (4-0 포함) | 오케스트레이터 수정 | 필수 |
   | 스킬 추가/수정 | 건너뜀 | 건너뜀 | 건너뜀 | 필수 (4-0 포함) | 연결 변경 시 | 필수 |
   | 아키텍처 변경 | 건너뜀 | 필수 | 영향받는 에이전트만 (3-0 포함) | 영향받는 스킬만 (4-0 포함) | 필수 | 필수 |
3. 기존 에이전트/스킬 목록과 CLAUDE.md 기록을 대조하여 불일치(drift)를 감지한다
4. 감사 결과를 사용자에게 요약 보고하고, 실행 계획을 확인받는다

### Phase 1: 도메인 분석
1. 사용자 요청에서 도메인/프로젝트 파악
2. 핵심 작업 유형 식별 (생성, 검증, 편집, 분석 등)
3. Phase 0 감사 결과를 기반으로 기존 에이전트/스킬과의 충돌/중복 분석
4. 프로젝트 코드베이스 탐색 — 기술 스택, 데이터 모델, 주요 모듈 파악
5. **사용자 숙련도 감지** — 대화의 맥락 단서(사용 용어, 질문 수준)로 기술 수준을 파악하고, 이후 커뮤니케이션 톤을 조절한다. 코딩 경험이 적은 사용자에게는 "assertion", "JSON schema" 같은 용어를 설명 없이 쓰지 않는다.

### Phase 2: 팀 아키텍처 설계

#### 2-1. 실행 모드 선택

**에이전트 팀이 최우선 기본값이다.** 2개 이상의 에이전트가 협업할 때는 반드시 에이전트 팀을 먼저 검토한다. 팀원 간 직접 통신(SendMessage)과 공유 작업 목록(TaskCreate)으로 자체 조율하며, 발견 공유·상충 토론·누락 보완이 결과 품질을 높인다.

| 모드 | 언제 사용 | 특성 |
|------|----------|------|
| **에이전트 팀** (기본) | 2명 이상 협업, 실시간 조율·피드백 교환이 필요, 중간 산출물 상호 참조 | `TeamCreate` + `SendMessage` + `TaskCreate`로 자체 조율 |
| **서브 에이전트** (대안) | 단일 에이전트 작업, 결과만 메인에 반환하면 충분, 팀 통신 오버헤드가 과할 때 | `Agent` 도구 직접 호출, `run_in_background`로 병렬 |
| **하이브리드** | Phase마다 특성이 다를 때 — 예: 병렬 수집(서브) → 합의 기반 통합(팀) | Phase 단위로 팀/서브를 섞어 구성 |

**의사결정 순서:**
1. 먼저 에이전트 팀으로 설계 가능한지 검토한다 — 2명 이상이면 기본값
2. 팀 통신이 구조적으로 불필요하고(결과 전달만), 팀 오버헤드가 이득보다 클 때만 서브 에이전트 선택
3. Phase별 특성이 확연히 다르면 하이브리드 고려 — 각 Phase의 실행 모드를 오케스트레이터에 명시

> 상세 비교표와 패턴별 의사결정 트리는 `references/agent-design-patterns.md`의 "실행 모드" 참조.

#### 2-2. 아키텍처 패턴 선택

1. 작업을 전문 영역으로 분해
2. 에이전트 팀 구조 결정 (아키텍처 패턴은 `references/agent-design-patterns.md` 참조)
   - **파이프라인**: 순차 의존 작업
   - **팬아웃/팬인**: 병렬 독립 작업
   - **전문가 풀**: 상황별 선택 호출
   - **생성-검증**: 생성 후 품질 검수
   - **감독자**: 중앙 에이전트가 상태 관리 및 동적 분배
   - **계층적 위임**: 상위 에이전트가 하위에 재귀적 위임

#### 2-3. 에이전트 분리 기준

전문성·병렬성·컨텍스트·재사용성 4축으로 판단한다. 상세 기준표는 `references/agent-design-patterns.md`의 "에이전트 분리 기준" 참조. 기존 에이전트와의 중복·재사용 검토는 Phase 3-0에서 다룬다.

### Phase 3: 에이전트 정의 생성

#### 3-0. 기존 에이전트 중복 검토

신규 에이전트 생성 전, `프로젝트/.claude/agents/`의 기존 에이전트와 중복 여부를 확인한다. 하네스를 반복 구축하다 보면 역할이 겹치는 에이전트가 다른 이름으로 누적되기 쉽다.

> 중복 분류 기준과 재사용 설계는 `references/agent-design-patterns.md`의 "에이전트 재사용 설계" 참조.

**모든 에이전트는 반드시 `프로젝트/.claude/agents/{name}.md` 파일로 정의한다.** 에이전트 정의 파일 없이 Agent 도구의 prompt에 역할을 직접 넣는 것은 금지한다. 이유:
- 에이전트 정의가 파일로 존재해야 다음 세션에서 재사용 가능
- 팀 통신 프로토콜이 명시되어야 에이전트 간 협업 품질 보장
- 하네스의 핵심 가치는 에이전트(누가)와 스킬(어떻게)의 분리

빌트인 타입(`general-purpose`, `Explore`, `Plan`)을 사용하더라도 에이전트 정의 파일은 생성한다. 빌트인 타입은 Agent 도구의 `subagent_type` 파라미터로 지정하고, 에이전트 정의 파일에는 역할·원칙·프로토콜을 담는다.

**모델 설정:** 모든 에이전트는 `model: "opus"`를 사용한다. Agent 도구 호출 시 반드시 `model: "opus"` 파라미터를 명시한다. 하네스의 품질은 에이전트의 추론 능력에 직결되며, opus가 최고 품질을 보장한다.

**팀 재구성:** 에이전트 팀은 세션당 한 팀만 활성화할 수 있지만, Phase 간에 팀을 해체하고 새 팀을 구성할 수 있다. 파이프라인 패턴처럼 Phase별로 다른 전문가 조합이 필요하면, 이전 팀의 산출물을 파일로 저장한 뒤 팀을 정리하고 새 팀을 생성한다.

각 에이전트를 `프로젝트/.claude/agents/{name}.md`에 정의한다. 필수 섹션: 핵심 역할, 작업 원칙, 입력/출력 프로토콜, 에러 핸들링, 협업. 에이전트 팀 모드에서는 `## 팀 통신 프로토콜` 섹션을 추가하여 메시지 수신/발신 대상과 작업 요청 범위를 명시한다.

> 정의 템플릿과 실제 파일 전문은 `references/agent-design-patterns.md`의 "에이전트 정의 구조" + `references/team-examples.md` 참조.

**QA 에이전트 포함 시 필수 사항:**
- QA 에이전트는 `general-purpose` 타입을 사용하라 (`Explore`는 읽기 전용이므로 검증 스크립트 실행 불가)
- QA의 핵심은 "존재 확인"이 아니라 **"경계면 교차 비교"** — API 응답과 프론트 훅을 동시에 읽고 shape을 비교
- QA는 전체 완성 후 1회가 아니라, **각 모듈 완성 직후 점진적으로 실행** (incremental QA)
- 상세 가이드: `references/qa-agent-guide.md` 참조

### Phase 4: 스킬 생성

각 에이전트가 사용할 스킬을 `프로젝트/.claude/skills/{name}/SKILL.md`에 생성한다. 상세 작성 가이드는 `references/skill-writing-guide.md` 참조.

#### 4-0. 기존 스킬 중복 검토

신규 스킬 생성 전, `프로젝트/.claude/skills/`의 기존 스킬과 중복 여부를 확인한다. 하네스를 반복 구축하다 보면 기능이 겹치는 스킬이 다른 이름으로 누적되기 쉽다.

> 중복 분류 기준과 일반화 패턴은 `references/skill-writing-guide.md`의 "스킬 재사용 설계" 참조.

#### 4-1. 스킬 구조

```
skill-name/
├── SKILL.md (필수)
│   ├── YAML frontmatter (name, description 필수)
│   └── Markdown 본문
└── Bundled Resources (선택)
    ├── scripts/    - 반복/결정적 작업용 실행 코드
    ├── references/ - 조건부 로딩하는 참조 문서
    └── assets/     - 출력에 사용되는 파일 (템플릿, 이미지 등)
```

#### 4-2. Description 작성 — 적극적 트리거 유도

description은 스킬의 유일한 트리거 메커니즘이다. Claude는 트리거를 보수적으로 판단하는 경향이 있으므로, description을 **적극적("pushy")**으로 작성한다.

**나쁜 예:** `"PDF 문서를 처리하는 스킬"`
**좋은 예:** `"PDF 파일 읽기, 텍스트/테이블 추출, 병합, 분할, 회전, 워터마크, 암호화, OCR 등 모든 PDF 작업을 수행. .pdf 파일을 언급하거나 PDF 산출물을 요청하면 반드시 이 스킬을 사용할 것."`

핵심: 스킬이 하는 일 + 구체적 트리거 상황을 모두 기술하고, 유사하지만 트리거하면 안 되는 경우와 구분되도록 작성.

#### 4-3. 본문 작성 원칙

| 원칙 | 설명 |
|------|------|
| **Why를 설명하라** | "ALWAYS/NEVER" 같은 강압적 지시 대신, 왜 그렇게 해야 하는지 이유를 전달한다. LLM은 이유를 이해하면 엣지 케이스에서도 올바르게 판단한다. |
| **Lean하게 유지** | 컨텍스트 윈도우는 공공재다. SKILL.md 본문은 500줄 이내를 목표로, 무게를 벌지 않는 내용은 삭제하거나 references/로 이동한다. |
| **일반화하라** | 특정 예시에만 맞는 좁은 규칙보다, 원리를 설명하여 다양한 입력에 대응할 수 있게 한다. 오버피팅 금지. |
| **반복 코드는 번들링** | 테스트 실행에서 에이전트들이 공통으로 작성하는 스크립트가 발견되면 `scripts/`에 미리 번들링한다. |
| **명령형으로 작성** | "~한다", "~하라" 형태의 명령형/지시형 어조를 사용한다. |

#### 4-4. Progressive Disclosure (단계적 정보 공개)

스킬은 3단계 로딩 시스템으로 컨텍스트를 관리한다:

| 단계 | 로딩 시점 | 크기 목표 |
|------|----------|----------|
| **Metadata** (name + description) | 항상 컨텍스트에 존재 | ~100단어 |
| **SKILL.md 본문** | 스킬 트리거 시 | <500줄 |
| **references/** | 필요할 때만 | 무제한 (스크립트는 로딩 없이 실행 가능) |

**크기 관리 규칙:**
- SKILL.md가 500줄에 근접하면 세부 내용을 references/로 분리하고, 본문에 "언제 이 파일을 읽으라"는 포인터를 남긴다
- 300줄 이상의 reference 파일에는 상단에 **목차(ToC)**를 포함한다
- 도메인/프레임워크별 변형이 있으면 references/ 하위에 도메인별로 분리하여, 관련 파일만 로드한다

```
cloud-deploy/
├── SKILL.md (워크플로우 + 선택 가이드)
└── references/
    ├── aws.md    ← AWS 선택 시만 로드
    ├── gcp.md
    └── azure.md
```

#### 4-5. 스킬-에이전트 연결 원칙

- 에이전트 1개 ↔ 스킬 1~N개 (1:1 또는 1:다)
- 여러 에이전트가 공유하는 스킬도 가능
- 스킬은 "어떻게 하는가"를 담고, 에이전트는 "누가 하는가"를 담는다

> 상세 작성 패턴, 예시, 데이터 스키마 표준은 `references/skill-writing-guide.md` 참조.

### Phase 5: 통합 및 오케스트레이션

오케스트레이터는 스킬의 특수한 형태로, 개별 에이전트와 스킬을 하나의 워크플로우로 엮어 팀 전체를 조율한다. Phase 4에서 생성한 개별 스킬이 "각 에이전트가 무엇을 어떻게 하는가"를 정의한다면, 오케스트레이터는 "누가 언제 어떤 순서로 협업하는가"를 정의한다. 구체적 템플릿은 `references/orchestrator-template.md` 참조.

**기존 확장 시 오케스트레이터 수정:** 신규 구축이 아닌 기존 확장일 때는 오케스트레이터를 새로 생성하지 않고 기존 오케스트레이터를 수정한다. 에이전트 추가 시 팀 구성·작업 할당·데이터 흐름에 새 에이전트를 반영하고, description에 새 에이전트 관련 트리거 키워드를 추가한다.

Phase 2-1에서 선택한 실행 모드에 따라 오케스트레이터 패턴이 달라진다:

#### 5-0. 오케스트레이터 패턴 (모드별)

**에이전트 팀 패턴 (기본):**
오케스트레이터가 `TeamCreate`로 팀을 구성하고, `TaskCreate`로 작업을 할당한다. 팀원들은 `SendMessage`로 직접 통신하며 자체 조율한다. 리더(오케스트레이터)는 진행 상황을 모니터링하고 결과를 종합한다.

```
[오케스트레이터/리더]
    ├── TeamCreate(team_name, members)
    ├── TaskCreate(tasks with dependencies)
    ├── 팀원들이 자체 조율 (SendMessage)
    ├── 결과 수집 및 종합
    └── 팀 정리
```

**서브 에이전트 패턴 (대안):**
오케스트레이터가 `Agent` 도구로 서브 에이전트를 직접 호출한다. 병렬 실행은 `run_in_background: true`, 결과는 메인에게만 반환된다. 팀 통신이 불필요하고 오버헤드를 줄이고 싶을 때 사용.

```
[오케스트레이터]
    ├── Agent(agent-1, run_in_background=true)
    ├── Agent(agent-2, run_in_background=true)
    ├── 결과 대기 및 수집
    └── 통합 산출물 생성
```

**하이브리드 패턴:**
Phase마다 다른 모드를 섞어 구성한다. 자주 쓰이는 조합:
- **병렬 수집(서브) → 합의 통합(팀)**: Phase 2에서 서브 에이전트로 독립 자료를 병렬 수집 → Phase 3에서 팀을 만들어 토론·합의 기반 통합
- **팀 생성(팀) → 검증(서브)**: Phase 2에서 팀이 초안 생성 → Phase 3에서 단일 서브 에이전트가 독립 검증
- **Phase 간 팀 재구성**: 각 Phase마다 `TeamDelete` 후 새 `TeamCreate`, 사이에 서브 에이전트 호출 삽입

하이브리드 선택 시 오케스트레이터의 각 Phase 섹션 상단에 해당 Phase의 실행 모드를 명시한다 (예: `**실행 모드:** 에이전트 팀`).

hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
로컬 스킬 파일은 `/Users/junghojang/.codex/skills/harness/SKILL.md`에도 있습니다. 레포 안 `.agents/skills/harness`는 `../../skills/harness` 심링크라서 실제 대상은 레포의 `skills/harness`입니다. 이제 Codex 매뉴얼/설치 코드에서 `/harness`, `$harness`, `/skills` 처리를 확인합니다.
web search: 
web search: site:developers.openai.com/codex skills Codex CLI $ skill syntax /skills
web search: 
web search: https://developers.openai.com/codex/codex-manual.md
web search: 
web search: OpenAI Codex CLI skills $skill /skills
codex
공식 웹 검색은 `codex-manual.md` 원문 접근이 실패했고 검색 결과도 불충분합니다. 그래서 설치된 Codex CLI 패키지 소스/번들에서 실제 명령 파서를 확인합니다.
mcp: context-mode/ctx_execute started
mcp: context-mode/ctx_execute (failed)
user cancelled MCP tool call
codex
`ctx_execute` 호출이 취소됐습니다. 같은 확인을 일반 셸로 짧게 실행합니다. 출력은 필요한 경로/매치만 제한합니다.
hook: PreToolUse
hook: PreToolUse Completed
hook: PostToolUse
hook: PostToolUse Completed
codex
여기 문서가 read-only 샌드박스에서 임시 파일 생성을 시도해 실패했습니다. `node -e` 한 줄로만 재실행합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "node -e \"const cp=require('child_process'),fs=require('fs'),path=require('path');function sh(c){try{return cp.execSync(c,{encoding:'utf8',stdio:['ignore','pipe','ignore']}).trim()}catch(e){return ''}}const codex=sh('command -v codex'),real=fs.realpathSync(codex);const seen=new Set(),pkgs=[];let p=real;for(let i=0;i<12;i++){p=path.dirname(p);for(const rel of ['package.json','../package.json','../../package.json']){const f=path.resolve(p,rel);if("'!seen.has(f)&&fs.existsSync(f)){seen.add(f);try{const j=JSON.parse(fs.readFileSync(f,'"'utf8'));if((j.name||'').toLowerCase().includes('codex')||JSON.stringify(j.bin||{}).includes('codex'))pkgs.push([f,j.name,j.version,JSON.stringify(j.bin||{})]);}catch{}}}}console.log('codex '+codex);console.log('real '+real);for(const x of pkgs)console.log('pkg '+x.join(' | '));\"" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
codex /Users/junghojang/.nvm/versions/node/v22.11.0/bin/codex
real /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/bin/codex.js
pkg /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/package.json | @openai/codex | 0.139.0 | {"codex":"bin/codex.js"}

hook: PostToolUse
hook: PostToolUse Completed
codex
설치 경로 확인됐습니다: npm 패키지 `@openai/codex` `0.139.0`. 이제 번들 내부에서 `skills`, `slash`, `trusted`, `AGENTS` 관련 문자열만 추출합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "node -e \"const fs=require('fs'),path=require('path');const root='/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex';function walk(d,arr=[]){for(const e of fs.readdirSync(d,{withFileTypes:true})){const p=path.join(d,e.name);if(e.isDirectory()&&"'!['"'node_modules','.git'].includes(e.name))walk(p,arr);else if(e.isFile())arr.push(p)}return arr}const files=walk(root).filter(f=>/\\.(js|ts|json|md|toml|rs)"'$/.test(f)||fs.statSync(f).size<8e6);console.log('"'files '+files.length);for(const pat of ['skills','/skills','"'$'"','trusted','AGENTS.md','slash']){let hits=[];for(const f of files){let s='';try{s=fs.readFileSync(f,'utf8')}catch{continue}if(s.toLowerCase().includes(pat.toLowerCase()))hits.push(path.relative(root,f));}console.log('\\nPAT '+pat+' '+hits.length);console.log([...new Set(hits)].slice(0,60).join('\\n'));}\"" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
files 3

PAT skills 0


PAT /skills 0


PAT $ 1
bin/codex.js

PAT trusted 0


PAT AGENTS.md 0


PAT slash 0


hook: PostToolUse
hook: PostToolUse Completed
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "sed -n '1,220p' /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/bin/codex.js && find /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex -maxdepth 4 -type f | sed -n '1,200p'" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
#!/usr/bin/env node
// Unified entry point for the Codex CLI.

import { spawn } from "node:child_process";
import { existsSync, realpathSync } from "fs";
import { createRequire } from "node:module";
import path from "path";
import { fileURLToPath } from "url";

// __dirname equivalent in ESM
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const require = createRequire(import.meta.url);

const PLATFORM_PACKAGE_BY_TARGET = {
  "x86_64-unknown-linux-musl": "@openai/codex-linux-x64",
  "aarch64-unknown-linux-musl": "@openai/codex-linux-arm64",
  "x86_64-apple-darwin": "@openai/codex-darwin-x64",
  "aarch64-apple-darwin": "@openai/codex-darwin-arm64",
  "x86_64-pc-windows-msvc": "@openai/codex-win32-x64",
  "aarch64-pc-windows-msvc": "@openai/codex-win32-arm64",
};

const { platform, arch } = process;

let targetTriple = null;
switch (platform) {
  case "linux":
  case "android":
    switch (arch) {
      case "x64":
        targetTriple = "x86_64-unknown-linux-musl";
        break;
      case "arm64":
        targetTriple = "aarch64-unknown-linux-musl";
        break;
      default:
        break;
    }
    break;
  case "darwin":
    switch (arch) {
      case "x64":
        targetTriple = "x86_64-apple-darwin";
        break;
      case "arm64":
        targetTriple = "aarch64-apple-darwin";
        break;
      default:
        break;
    }
    break;
  case "win32":
    switch (arch) {
      case "x64":
        targetTriple = "x86_64-pc-windows-msvc";
        break;
      case "arm64":
        targetTriple = "aarch64-pc-windows-msvc";
        break;
      default:
        break;
    }
    break;
  default:
    break;
}

if (!targetTriple) {
  throw new Error(`Unsupported platform: ${platform} (${arch})`);
}

const platformPackage = PLATFORM_PACKAGE_BY_TARGET[targetTriple];
if (!platformPackage) {
  throw new Error(`Unsupported target triple: ${targetTriple}`);
}

function findCodexExecutable() {
  let vendorRoot;
  try {
    const packageJsonPath = require.resolve(`${platformPackage}/package.json`);
    vendorRoot = path.join(path.dirname(packageJsonPath), "vendor");
  } catch {
    vendorRoot = path.join(__dirname, "..", "vendor");
  }

  const codexExecutable = path.join(
    vendorRoot,
    targetTriple,
    "bin",
    process.platform === "win32" ? "codex.exe" : "codex",
  );
  if (existsSync(codexExecutable)) {
    return codexExecutable;
  }

  const packageManager = detectPackageManager();
  const updateCommand =
    packageManager === "bun"
      ? "bun install -g @openai/codex@latest"
      : "npm install -g @openai/codex@latest";
  throw new Error(
    `Missing optional dependency ${platformPackage}. Reinstall Codex: ${updateCommand}`,
  );
}

const binaryPath = findCodexExecutable();

// Use an asynchronous spawn instead of spawnSync so that Node is able to
// respond to signals (e.g. Ctrl-C / SIGINT) while the native binary is
// executing. This allows us to forward those signals to the child process
// and guarantees that when either the child terminates or the parent
// receives a fatal signal, both processes exit in a predictable manner.

/**
 * Use heuristics to detect the package manager that was used to install Codex
 * in order to give the user a hint about how to update it.
 */
function detectPackageManager() {
  const userAgent = process.env.npm_config_user_agent || "";
  if (/\bbun\//.test(userAgent)) {
    return "bun";
  }

  const execPath = process.env.npm_execpath || "";
  if (execPath.includes("bun")) {
    return "bun";
  }

  if (
    __dirname.includes(".bun/install/global") ||
    __dirname.includes(".bun\\install\\global")
  ) {
    return "bun";
  }

  return userAgent ? "npm" : null;
}

const packageManagerEnvVar =
  detectPackageManager() === "bun"
    ? "CODEX_MANAGED_BY_BUN"
    : "CODEX_MANAGED_BY_NPM";
const env = {
  ...process.env,
  [packageManagerEnvVar]: "1",
  CODEX_MANAGED_PACKAGE_ROOT: realpathSync(path.join(__dirname, "..")),
};

const child = spawn(binaryPath, process.argv.slice(2), {
  stdio: "inherit",
  env,
});

child.on("error", (err) => {
  // Typically triggered when the binary is missing or not executable.
  // Re-throwing here will terminate the parent with a non-zero exit code
  // while still printing a helpful stack trace.
  // eslint-disable-next-line no-console
  console.error(err);
  process.exit(1);
});

// Forward common termination signals to the child so that it shuts down
// gracefully. In the handler we temporarily disable the default behavior of
// exiting immediately; once the child has been signaled we simply wait for
// its exit event which will in turn terminate the parent (see below).
const forwardSignal = (signal) => {
  if (child.killed) {
    return;
  }
  try {
    child.kill(signal);
  } catch {
    /* ignore */
  }
};

["SIGINT", "SIGTERM", "SIGHUP"].forEach((sig) => {
  process.on(sig, () => forwardSignal(sig));
});

// When the child exits, mirror its termination reason in the parent so that
// shell scripts and other tooling observe the correct exit status.
// Wrap the lifetime of the child process in a Promise so that we can await
// its termination in a structured way. The Promise resolves with an object
// describing how the child exited: either via exit code or due to a signal.
const childResult = await new Promise((resolve) => {
  child.on("exit", (code, signal) => {
    if (signal) {
      resolve({ type: "signal", signal });
    } else {
      resolve({ type: "code", exitCode: code ?? 1 });
    }
  });
});

if (childResult.type === "signal") {
  // Re-emit the same signal so that the parent terminates with the expected
  // semantics (this also sets the correct exit code of 128 + n).
  process.kill(process.pid, childResult.signal);
} else {
  process.exit(childResult.exitCode);
}
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/bin/codex.js
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/node_modules/@openai/codex-darwin-arm64/README.md
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/node_modules/@openai/codex-darwin-arm64/package.json
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/README.md
/Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/package.json

hook: PostToolUse
hook: PostToolUse Completed
codex
Codex 본체는 Rust 네이티브 바이너리입니다. 텍스트 소스가 npm 패키지에 없어서, 바이너리 문자열과 `codex debug` 도움말을 근거로 가능한 범위를 확인합니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "codex debug --help | sed -n '1,240p'" in /Users/junghojang/Developments/myProject/myHarness
exec
/bin/zsh -lc "codex features | sed -n '1,240p'" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
hook: PostToolUse
exec
/bin/zsh -lc "strings /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/node_modules/@openai/codex-darwin-arm64/vendor/aarch64-apple-darwin/bin/codex | rg -i 'skills|/skills|skill|trusted|trust|AGENTS|slash|\\"'$[a-z]'"' | sed -n '1,220p'" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 139ms:
WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)
Inspect feature flags

Usage: codex features [OPTIONS] <COMMAND>

Commands:
  list     List known features with their stage and effective state
  enable   Enable a feature in config.toml
  disable  Disable a feature in config.toml
  help     Print this message or the help of the given subcommand(s)

Options:
  -c, --config <key=value>  Override a configuration value that would otherwise be loaded from
                            `~/.codex/config.toml`. Use a dotted path (`foo.bar.baz`) to override
                            nested values. The `value` portion is parsed as TOML. If it fails to
                            parse as TOML, the raw string is used as a literal
      --enable <FEATURE>    Enable a feature (repeatable). Equivalent to `-c features.<name>=true`
      --disable <FEATURE>   Disable a feature (repeatable). Equivalent to `-c features.<name>=false`
  -h, --help                Print help (see more with '--help')

 succeeded in 139ms:
WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)
Debugging tools

Usage: codex debug [OPTIONS] <COMMAND>

Commands:
  models        Render the raw model catalog as JSON
  app-server    Tooling: helps debug the app server
  prompt-input  Render the model-visible prompt input list as JSON
  help          Print this message or the help of the given subcommand(s)

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
hook: PostToolUse Completed
hook: PostToolUse
 succeeded in 2282ms:
strings: warning: confstr() failed with code 5: couldn't get path of DARWIN_USER_TEMP_DIR; using /tmp instead
strings: error: couldn't create cache file '/tmp/xcrun_db-ZzTKzBAg' (errno=Operation not permitted)
:. Hint: Does this role have a trust relationship with EC2?
$add_parsable_certificates processed 
$minimum throughput was specified at 
core/src/mcp_skill_dependencies.rs
@failed to load MCP servers while installing skill dependencies: 
9failed to persist MCP dependencies for mentioned skills: 
YThe following MCP servers are required by the selected skills but are not installed yet: 
agents.
agents.
agents.
agents.
$failed to serialize default config: 
failed to load skill 
core/src/agents_md.rs
3Failed to read global AGENTS.md instructions from `
$Login is restricted to workspace(s) 
$Login is restricted to workspace(s) 
$Failed to connect to Ollama server: 
$failed to mark backfill complete at 
$failed to initialize state runtime: 
$send replayed early settings frame: 
$failed to create recv stream for id 
;failed to register skills watcher for unknown environment `
app-server/src/skills_watcher.rs
$failed to resend request to client: 
$failed to submit Shutdown to thread 
,failed to persist trusted project state for 
3; continuing with in-memory trust for this thread: 
$failed to submit Shutdown to thread 
$failed to construct backend client: 
!failed to update skill settings: 
$failed to persist imported session: 
$failed to list marketplace plugins: 
8remote plugin skill read is not enabled for marketplace 
Migrate skills from 
Migrate subagents from 
core-skills/src/loader.rs
skills scan truncated after 
core-skills/src/manager.rs
core-skills/src/injection.rs
$failed to write JSON-RPC message to 
$codex-exec-server listening on ws://
$OAuth discovery requests failed for 
$handshaking with MCP server failed: 
$SOCKS5: connection failed with code 
$failed to evaluate host for CONNECT 
$MITM blocked by method policy (host=
$Removed installed marketplace root: 
$failed to delete OAuth credentials: 
$request context: detected protocol: 
$failed to encode websocket request: 
$failed to encode responses request: 
$Error logging in with access token: 
,failed to persist trusted project state for 
Failed to set trust for 
tui-skill-config-write-
$Failed to persist update dismissal: 
Failed to trust hooks: 
$Failed to start TUI session picker: 
$Failed to save default personality: 
"Failed to update skill config for 
$Not available in TUI yet for thread 
$Invalid `tui.keymap` configuration: 
$Failed to prepare side conversation 
 is not trusted
$invalid realtime session id header: 
*failed to initialize skills file watcher: 
$Input exceeds the maximum length of 
$invalid Windows sandbox setup mode: 
$Overridden by managed policy (MDM): 
exclude_slash_tmp
PluginSkillReadParams.ts
skillName
type PluginSkillReadParams
PluginSkillReadResponse.ts
type PluginSkillReadResponse
SkillsConfigWriteParams.ts
type SkillsConfigWriteParams
SubagentStart
SubagentStop
SkillsChangedNotification.ts
type SkillsChangedNotification
SkillsConfigWriteResponse.ts
type SkillsConfigWriteResponse
SkillsExtraRootsSetParams.ts
type SkillsExtraRootsSetParams
SkillsExtraRootsSetResponse.ts
 type SkillsExtraRootsSetResponse
$type McpElicitationUntitledEnumItems
$type McpToolCallProgressNotification
$type FileChangeRequestApprovalParams
$type TerminalInteractionNotification
$McpServerElicitationRequestParams.ts
$type ExternalAgentConfigDetectParams
$type ExternalAgentConfigImportParams
$FileChangeOutputDeltaNotification.ts
$FileChangeRequestApprovalResponse.ts
$type ThreadStatusChangedNotification
$ExternalAgentConfigDetectResponse.ts
$ExternalAgentConfigImportResponse.ts
$type ThreadRealtimeAppendAudioParams
$type ThreadRealtimeErrorNotification
$ThreadMetadataGitInfoUpdateParams.ts
$ThreadSettingsUpdatedNotification.ts
$AccountLoginCompletedNotification.ts
$ThreadRealtimeAppendAudioResponse.ts
$ThreadRealtimeStartedNotification.ts
$type AdditionalFileSystemPermissions
$ServerRequestResolvedNotification.ts
$type RemoteControlPairingStartParams
$type RemoteControlStatusReadResponse
$type WindowsSandboxReadinessResponse
$RemoteControlPairingStartResponse.ts
$type ExperimentalFeatureListResponse
$model_auto_compact_token_limit_scope
excludeSlashTmp
agentsStates
SkillScope.ts
type SkillScope
trustStatus
skills
SkillSummary.ts
type SkillSummary
HookTrustStatus.ts
type HookTrustStatus
SkillMetadata.ts
type SkillMetadata
({ "method": "skills/changed", "params": 
CollabAgentState.ts
type CollabAgentState
SkillErrorInfo.ts
type SkillErrorInfo
SkillInterface.ts
type SkillInterface
skill_approval
CollabAgentStatus.ts
type CollabAgentStatus
SkillsListEntry.ts
type SkillsListEntry
subagents
SkillsListParams.ts
type SkillsListParams
$schema
SkillDependencies.ts
type SkillDependencies
$allowedWindowsSandboxImplementations
SkillsListResponse.ts
type SkillsListResponse
ProcessKillParams.ts
type ProcessKillParams
SkillToolDependency.ts
type SkillToolDependency
ProcessKillResponse.ts
type ProcessKillResponse
$Failed to serialize JSONRPCMessage: 
$failed to set environment variable `
$Failed to load CA certificates from 
$env: selecting by task_count/first: 
$code mode notification task failed: 
 is marked as untrusted in 
, mark it trusted.
 as a trusted project in 
$Error parsing `grpc-timeout` header 
$Command blocked by PreToolUse hook: 
$Failed to create shell snapshot for 
$Failed to clean up shell snapshots: 
$Snapshot command exited with status 
 for skill 
[skill:$
core/src/tools/handlers/agent_jobs/spawn_agents_on_csv.rs
0failed to serialize spawn_agents_on_csv result: 
$failed to parse function arguments: 
core/src/tools/handlers/multi_agents/close_agent.rs
core/src/tools/handlers/multi_agents/resume_agent.rs
core/src/tools/handlers/multi_agents/wait.rs
core/src/tools/handlers/multi_agents/spawn.rs
core/src/tools/handlers/multi_agents_v2/message_tool.rs
core/src/tools/handlers/multi_agents_v2/interrupt_agent.rs
core/src/tools/handlers/multi_agents_v2/wait.rs
core/src/tools/handlers/multi_agents_v2/spawn.rs
core/src/tools/handlers/multi_agents_spec.rs
This spawn_agent tool provides you access to sub-agents that inherit your current model by default. Do not set the `model` field unless the user explicitly asks for a different model or there is a clear task-specific reason. You should follow the rules and guidelines below to use this tool.
Only use `spawn_agent` if and only if the user explicitly asks for sub-agents, delegation, or parallel agent work.
- First, quickly analyze the overall user task and form a succinct high-level plan. Identify which tasks are immediate blockers on the critical path, and which tasks are sidecar tasks that are needed but can run in parallel without blocking the next local step. As part of that plan, explicitly decide what immediate task you should do locally right now. Do this planning step before delegating to agents so you do not hand off the immediate blocking task to a submodel and then waste time waiting on it.
- Split implementation into disjoint codebase slices and spawn multiple agents for them in parallel when the write scopes do not overlap.
The spawned agent will have the same tools as you and the ability to spawn its own subagents.
It will be able to send you and other running agents messages, and its final answer will be provided to you when it finishes.
core/src/tools/handlers/multi_agents_common.rs
core/src/skills.rs
-- Skills from this plugin are prefixed with `
$failed to update runtime allowlist: 
 AGENTS.md instructions from `
Apps (Connectors) can be explicitly triggered in user messages in the format `[$app-name](app://{connector_id})`. Apps can also be implicitly triggered as long as the context suggests usage of available apps.
core/src/tools/handlers/multi_agents/send_input.rs
core/src/tools/handlers/multi_agents_v2/list_agents.rs
core/src/tools/handlers/multi_agents_v2/send_message.rs
core/src/tools/handlers/multi_agents_v2/followup_task.rs
$failed to run git rev-parse HEAD in 
$failed to parse plugin hooks config 
$invalid remote plugin cache id for `
$failed to join plugin install task: 
Gremote plugin skill response returned unexpected skill name: expected `
$failed to join plugin archive task: 
invalid skills config: 
/ not included in the model-visible skills list.
core-skills/src/render.rs
skills cache cleared (
!failed to install system skills: 
$file is too large to read: limit is 
$failed to parse environment config `
$exec-server transport disconnected: 
$example tokens must be strings (got 
$expected example to not match rule `
Use this skill when the user asks to run the migrated source command `
$env:
$failed to read goal metrics status: 
$imagegen input schema should parse: 
$unable to read referenced image at `
$failed to delete auth from keyring: 
$api key exchange failed with status 

hook: PostToolUse Completed
codex
바이너리 문자열상 스킬 로더/렌더러가 실제 포함돼 있습니다. 다음은 `debug prompt-input`으로 현재 세션에 모델로 들어가는 스킬 목록을 확인합니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "codex debug prompt-input --help | sed -n '1,220p'" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
 succeeded in 119ms:
WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)
Render the model-visible prompt input list as JSON

Usage: codex debug prompt-input [OPTIONS] [PROMPT]

Arguments:
  [PROMPT]
          Optional user prompt to append after session context

Options:
  -c, --config <key=value>
          Override a configuration value that would otherwise be loaded from `~/.codex/config.toml`.
          Use a dotted path (`foo.bar.baz`) to override nested values. The `value` portion is parsed
          as TOML. If it fails to parse as TOML, the raw string is used as a literal.
          
          Examples: - `-c model="o3"` - `-c 'sandbox_permissions=["disk-full-read-access"]'` - `-c
          shell_environment_policy.inherit=all`

  -i, --image <FILE>...
          Optional image(s) to attach to the user prompt

      --enable <FEATURE>
          Enable a feature (repeatable). Equivalent to `-c features.<name>=true`

      --disable <FEATURE>
          Disable a feature (repeatable). Equivalent to `-c features.<name>=false`

  -h, --help
          Print help (see a summary with '-h')

hook: PostToolUse Completed
codex
`debug prompt-input`는 현재 프롬프트 입력 JSON을 렌더링합니다. 원문 전체 대신 Node로 파싱해서 `harness` 관련 항목만 뽑습니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "node -e \"const cp=require('child_process');const out=cp.execFileSync('codex',['debug','prompt-input','하네스 점검해줘'],{encoding:'utf8',maxBuffer:20*1024*1024});const data=JSON.parse(out.replace(/"'^WARNING[''^'"\\n]*\\n/,''));const text=JSON.stringify(data);console.log('json_top '+(Array.isArray(data)?'array len '+data.length:typeof data));console.log('contains_harness '+text.includes('harness'));console.log('contains_skill_tag '+text.includes('<skill>'));console.log('contains_skills_section '+/skills/i.test(text));function walk(x,path=[]){if("'!x||typeof x!=='"'object')return; if(Array.isArray(x)){x.forEach((v,i)=>walk(v,path.concat(i)));return;} const s=JSON.stringify(x); if(/harness|<skill>|skills/i.test(s)){ const short=s.length>1200?s.slice(0,1200)+'...':s; console.log('MATCH '+path.join('.')+' '+short.replace(/\\\\n/g,'\\\\n')); } for(const [k,v] of Object.entries(x)) walk(v,path.concat(k));} walk(data);\"" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
 exited 1 in 268ms:
WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)
Error: Operation not permitted (os error 1)
node:child_process:927
    throw err;
    ^

Error: Command failed: codex debug prompt-input 하네스 점검해줘
WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)
Error: Operation not permitted (os error 1)

    at genericNodeError (node:internal/errors:983:15)
    at wrappedFn (node:internal/errors:537:14)
    at checkExecSyncError (node:child_process:888:11)
    at Object.execFileSync (node:child_process:924:15)
    at [eval]:1:48
    at runScriptInThisContext (node:internal/vm:209:10)
    at node:internal/process/execution:118:14
    at [eval]-wrapper:6:24
    at runScript (node:internal/process/execution:101:62)
    at evalScript (node:internal/process/execution:136:3) {
  status: 1,
  signal: null,
  output: [
    null,
    '',
    'WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)\n' +
      'Error: Operation not permitted (os error 1)\n'
  ],
  pid: 49619,
  stdout: '',
  stderr: 'WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)\n' +
    'Error: Operation not permitted (os error 1)\n'
}

Node.js v22.11.0

hook: PostToolUse Completed
codex
`codex debug prompt-input`는 이 샌드박스에서 쓰기/상태 파일 생성이 막혀 실패했습니다. 대신 현재 이 대화에 실제 주입된 스킬 메타데이터와 파일 시스템 확인값을 분리해 보고합니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc "find /Users/junghojang/.codex -maxdepth 3 -type f \\( -name 'config.toml' -o -name '*.toml' -o -name '*.json' \\) 2>/dev/null | sed -n '1,200p'" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
/Users/junghojang/.codex/vendor_imports/skills-curated-cache.json
/Users/junghojang/.codex/version.json
/Users/junghojang/.codex/cache/codex_apps_tools/7f525c5d75861dd796ad5366f24d0b78c4034ae8.json
/Users/junghojang/.codex/cache/codex_app_directory/6200ec33a54fcd0b7b61f9218c92f739ab16bda2.json
/Users/junghojang/.codex/cache/codex_apps_server_info/7f525c5d75861dd796ad5366f24d0b78c4034ae8.json
/Users/junghojang/.codex/hooks.json
/Users/junghojang/.codex/auth.json
/Users/junghojang/.codex/models_cache.json
/Users/junghojang/.codex/config.toml
/Users/junghojang/.codex/.codex-global-state.json

hook: PostToolUse
exec
/bin/zsh -lc "ls -la .codex 2>/dev/null; find .codex -maxdepth 3 -type f -o -type l 2>/dev/null | sed -n '1,200p'; find .agents/skills -maxdepth 2 -type f -name SKILL.md -print 2>/dev/null; find -L .agents/skills -maxdepth 2 -type f -name SKILL.md -print 2>/dev/null" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
.agents/skills/harness/SKILL.md

hook: PostToolUse
exec
/bin/zsh -lc "codex features list | sed -n '1,240p'" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
 succeeded in 126ms:
WARNING: proceeding, even though we could not create PATH aliases: Operation not permitted (os error 1)
apply_patch_freeform                 removed            false
apply_patch_streaming_events         under development  false
apps                                 stable             true
apps_mcp_path_override               under development  false
artifact                             under development  false
auth_elicitation                     under development  false
browser_use                          stable             true
browser_use_external                 stable             true
child_agents_md                      under development  false
chronicle                            under development  false
code_mode                            under development  false
code_mode_only                       under development  false
codex_git_commit                     removed            false
collaboration_modes                  removed            true
computer_use                         stable             true
default_mode_request_user_input      under development  false
elevated_windows_sandbox             removed            false
enable_fanout                        under development  false
enable_mcp_apps                      under development  false
enable_request_compression           stable             true
exec_permission_approvals            under development  false
experimental_windows_sandbox         removed            false
external_migration                   experimental       false
fast_mode                            stable             true
goals                                stable             true
guardian_approval                    stable             true
hooks                                stable             true
image_detail_original                removed            false
image_generation                     stable             true
imagegenext                          under development  false
in_app_browser                       stable             true
js_repl                              removed            false
js_repl_tools_only                   removed            false
local_thread_store_compression       under development  false
memories                             experimental       false
mentions_v2                          under development  false
multi_agent                          stable             true
multi_agent_v2                       under development  false
network_proxy                        experimental       false
non_prefixed_mcp_tool_names          under development  false
personality                          stable             true
plugin_hooks                         removed            false
plugin_sharing                       stable             true
plugins                              stable             true
prevent_idle_sleep                   experimental       false
realtime_conversation                under development  false
remote_compaction_v2                 under development  false
remote_control                       removed            false
remote_models                        removed            false
remote_plugin                        under development  false
request_permissions_tool             under development  false
request_rule                         removed            false
responses_websockets                 removed            false
responses_websockets_v2              removed            false
runtime_metrics                      under development  false
search_tool                          removed            false
shell_snapshot                       stable             true
shell_tool                           stable             true
shell_zsh_fork                       under development  false
skill_env_var_dependency_prompt      removed            false
skill_mcp_dependency_install         stable             true
sqlite                               removed            true
standalone_web_search                under development  false
steer                                removed            true
terminal_resize_reflow               experimental       true
terminal_visualization_instructions  under development  false
tool_call_mcp_elicitation            stable             true
tool_search                          removed            false
tool_search_always_defer_mcp_tools   under development  false
tool_suggest                         stable             true
tui_app_server                       removed            true
unavailable_dummy_tools              removed            false
undo                                 removed            false
unified_exec                         stable             true
unified_exec_zsh_fork                under development  false
use_legacy_landlock                  deprecated         false
use_linux_sandbox_bwrap              removed            false
web_search_cached                    deprecated         false
web_search_request                   deprecated         false
workspace_dependencies               stable             true
workspace_owner_usage_nudge          removed            false

hook: PostToolUse Completed
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
`find` 결과: 일반 `find`도 `.agents/skills/harness/SKILL.md`를 봅니다. 즉 심링크 파일 대상까지 도달합니다. 이제 설정에서 trusted/project/skill roots 관련 키만 뽑습니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "node -e \"const fs=require('fs');const files=['/Users/junghojang/.codex/config.toml','/Users/junghojang/.codex/.codex-global-state.json','/Users/junghojang/.codex/version.json'];for(const f of files){try{const s=fs.readFileSync(f,'utf8').split('\\n').filter(l=>/trust|skill|agent|project|root|version|features/i.test(l)&&"'!/token|secret|key/i.test(l));console.log('"'FILE '+f);console.log(s.slice(0,120).join('\\n')||'(no matching lines)');}catch(e){console.log('ERR '+f+' '+e.message)}}\"" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
 succeeded in 142ms:
FILE /Users/junghojang/.codex/config.toml
[projects."/Users/junghojang/Developments/myProject/allday_detoxy"]
trust_level = "trusted"
[projects."/Users/junghojang/Library/CloudStorage/OneDrive-개인/main.obsidian"]
trust_level = "trusted"
[projects."/Users/junghojang/Downloads/blog"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/didimAIStudio_mainProxy/didimAIStudio_Agent"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/didimAIStudio_mainProxy/didimAIStudio_McpTools"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/didimAIStudio_mainProxy"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/didimAIStudio_mainProxy/didimAIStudio_Models"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/DidimAIStudio"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/DidimAIStudio/services/notification"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/DidimAIStudio/services/mcp-workloads/scheduler_tool"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/DidimAIStudio/services/mcp-control"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/DidimAIStudio/services/agents"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/gemini-cli"]
trust_level = "untrusted"
[projects."/Users/junghojang/Developments/myProject/DINKIssTyle-Chrome-Extensions/Local-AI-Assistant"]
trust_level = "trusted"
[projects."/Users/junghojang"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/DidimAIStudio/services/scenario-gateway"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/DidimAIStudio/services/mcp-workloads/example_boilerplate"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/DINKIssTyle-Chrome-Extensions"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/DINKIssTyle-Chrome-Extensions/00_intro_web_landing_page"]
trust_level = "trusted"
[projects."/Users/junghojang/OneDrive"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/DashDash"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/light_rag"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/AIskillLab"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/cooky-WebCopilot"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/all_in_one_gateChannel"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/Agent_gateChannel"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/DidimAIStudio/services/mcp-bridges/n8n-bridge"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/didimProject/nara-bidPilot"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/FirstPick"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/douzone"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/gpustack"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/myHarness"]
trust_level = "trusted"
[projects."/Users/junghojang/Developments/myProject/test"]
trust_level = "trusted"
[features]
multi_agent = true
#web_search = "trusted"
trusted_hash = "sha256:ee7d802662511d58e1cbd2b8095805a178732f750819e2cb7adc0caee5aec67f"
trusted_hash = "sha256:69b4ecce0665d5cf169b85191c0756b43510c358f9e8219b93a52f111f0445fc"
trusted_hash = "sha256:89d0365c3dd05e5503c3948f1be707be703396356341736ea3923fa9e3c3e29a"
trusted_hash = "sha256:9fc7312a4a274d40081f6734c6f6553d494e9cfde20fd01339995232aea2d74a"
trusted_hash = "sha256:9f9b46244739e7f6f787757a083d0d65c07db3aa2daaaecb6fe9e65b08f362b2"
[hooks.state."/Users/junghojang/Developments/myProject/cooky-WebCopilot_hotfix/.codex/hooks.json:pre_tool_use:0:0"]
trusted_hash = "sha256:69397ab93ba1156c2c83afe08d25e51373976435fc0eb52ec3566bd19f2cf0c0"
trusted_hash = "sha256:1fe35949e38b6e8e7cb4a030b1126983a2794d0403a562cebdf38ca95d166b4e"
[hooks.state."/Users/junghojang/Developments/myProject/cooky-WebCopilot/.codex/hooks.json:pre_tool_use:0:0"]
trusted_hash = "sha256:69397ab93ba1156c2c83afe08d25e51373976435fc0eb52ec3566bd19f2cf0c0"
FILE /Users/junghojang/.codex/.codex-global-state.json
{"electron-saved-workspace-roots":["/Users/junghojang/Developments/didimProject/DidimAIStudio","/Users/junghojang/Developments/didimProject/DidimAIStudio/services/agents","/Users/junghojang/Developments/didimProject/DidimAIStudio/services/mcp-control","/Users/junghojang/Developments/didimProject/DidimAIStudio/services/mcp-workloads/scheduler_tool","/Users/junghojang/Developments/didimProject/DidimAIStudio/services/notification","/Users/junghojang/Developments/didimProject/gemini-cli","/Users/junghojang/Developments/myProject/allday_detoxy","/Users/junghojang/Downloads/blog"],"active-workspace-roots":["/Users/junghojang/Developments/didimProject/gemini-cli"],"electron-workspace-root-labels":{},"electron-persisted-atom-state":{"has-seen-latest-model-banner":true,"agent-mode":"auto","codexCloudAccess":"enabled_needs_setup","sidebar-collapsed-groups":{}},"open-in-target-preferences":{"global":"antigravity","perPath":{"/Users/junghojang/Developments/didimProject/gemini-cli":"antigravity"}},"electron-main-window-bounds":{"x":389,"y":186,"width":1280,"height":820,"isMaximized":false}}
FILE /Users/junghojang/.codex/version.json
{"latest_version":"0.139.0","last_checked_at":"2026-06-10T06:36:50.463972Z","dismissed_version":null}

hook: PostToolUse Completed
codex
설정 확인: 이 프로젝트는 이미 trusted입니다. 남은 핵심은 호출 문법인데, 현재 공개 문서 접근이 제한적이므로 설치 바이너리 문자열과 현재 세션 주입 사실을 근거로 확실/불확실을 나눕니다.
hook: PreToolUse
hook: PreToolUse Completed
exec
/bin/zsh -lc "strings /Users/junghojang/.nvm/versions/node/v22.11.0/lib/node_modules/@openai/codex/node_modules/@openai/codex-darwin-arm64/vendor/aarch64-apple-darwin/bin/codex | rg -i '("'^|[''^a-z])(/skills|skills/|skills |selected skills|mentioned skills|model-visible skills|skill read|skillName|SkillScope|SkillsList|SkillsConfig|ExtraRoots|skill:)'"' | sed -n '1,260p'" in /Users/junghojang/Developments/myProject/myHarness
hook: PostToolUse
 succeeded in 1775ms:
strings: warning: confstr() failed with code 5: couldn't get path of DARWIN_USER_TEMP_DIR; using /tmp instead
strings: error: couldn't create cache file '/tmp/xcrun_db-wrSVKGXp' (errno=Operation not permitted)
9failed to persist MCP dependencies for mentioned skills: 
YThe following MCP servers are required by the selected skills but are not installed yet: 
;failed to register skills watcher for unknown environment `
8remote plugin skill read is not enabled for marketplace 
Migrate skills from 
core-skills/src/loader.rs
skills scan truncated after 
core-skills/src/manager.rs
core-skills/src/injection.rs
*failed to initialize skills file watcher: 
skillName
SkillsConfigWriteParams.ts
type SkillsConfigWriteParams
SkillsConfigWriteResponse.ts
type SkillsConfigWriteResponse
extraRoots
SkillScope.ts
type SkillScope
({ "method": "skills/changed", "params": 
SkillsListEntry.ts
type SkillsListEntry
SkillsListParams.ts
type SkillsListParams
SkillsListResponse.ts
type SkillsListResponse
[skill:$
-- Skills from this plugin are prefixed with `
invalid skills config: 
/ not included in the model-visible skills list.
core-skills/src/render.rs
skills cache cleared (
 skills enabled, 
 skills disabled
encconnect failedwrite server reply: connect failedserve connect pipewrite server reply: connect succeeded<skills_instructions></skills_instructions><personality_spec></personality_spec>
openai.yamlinterfacedependenciesshort-descriptionPolicyallow_implicit_invocationshort_descriptionicon_smallicon_largebrand_colordefault_prompt failed to stat repo skills root 
failed to stat skills root 
failed to read skills dir 
"failed to read skills symlink dir 
failed to stat skills path 
inconsistent statestruct CompactHistoryResponse with 1 elementstruct CollabAgentInteractionEndEvent with 8 elementsenumNamesstruct LegacyEnumSchema with 5 elementsoneOfstruct NetworkMitmHookToml with 7 elementsstruct RemotePluginReleaseResponse with 11 elementsstruct RealtimeConversationClosedEvent with 1 elementstruct RealtimeInputAudioSpeechStarted with 1 elementstruct ElicitationSchema with 5 elementsdate-timeremoteControlEnabledstruct DaemonSettings with 1 elementstruct RemotePluginMutationResponse with 2 elementsstruct CodeModeConfigToml with 2 elementsstruct ApplyPatchApprovalRequestEvent with 6 elementsstruct DynamicToolCallRequest with 6 elementscurrent_working_directorystruct CollabAgentInteractionBeginEvent with 5 elementsstruct RealtimeConversationStartedEvent with 2 elementsstruct variant RawToolCallRequester::CodeCell with 1 elementchild_codex_turn_idcarried_payloadrequest_payloadpartial_response_payloadresult_payloadruntime_payloadinvocation_payloadevent_typeevent_payloadcheckpoint_payloadstruct variant RawTraceEventPayload::ThreadStarted with 3 elementsstruct variant RawTraceEventPayload::InferenceCompleted with 4 elementsstruct variant RawTraceEventPayload::CodexTurnStarted with 2 elementsstruct variant RawTraceEventPayload::ToolCallStarted with 7 elementsstruct variant RawTraceEventPayload::ToolCallEnded with 3 elementsstruct variant RawTraceEventPayload::ToolCallRuntimeEnded with 3 elementsstruct variant RawTraceEventPayload::InferenceStarted with 6 elementsstruct variant RawTraceEventPayload::CompactionRequestFailed with 3 elementsstruct variant RawTraceEventPayload::CompactionInstalled with 2 elementsstruct variant RawTraceEventPayload::InferenceFailed with 4 elementsstruct variant RawTraceEventPayload::McpToolCallCorrelationAssigned with 2 elementsstruct variant RawTraceEventPayload::InferenceCancelled with 4 elementsstruct variant RawTraceEventPayload::RolloutEnded with 1 elementstruct variant RawTraceEventPayload::CodexTurnEnded with 2 elementsstruct variant RawTraceEventPayload::CompactionRequestStarted with 7 elementsstruct variant RawTraceEventPayload::ToolCallRuntimeStarted with 2 elementsstruct variant RawTraceEventPayload::ThreadEnded with 2 elementsstruct variant RawTraceEventPayload::RolloutStarted with 2 elementsstruct variant RawTraceEventPayload::CodeCellEnded with 3 elementsstruct variant RawTraceEventPayload::CompactionRequestCompleted with 3 elementsstruct variant RawTraceEventPayload::Other with 4 elementsstruct variant RawTraceEventPayload::AgentResultObserved with 6 elementsstruct variant RawTraceEventPayload::CodeCellInitialResponse with 3 elementsstruct variant RawTraceEventPayload::ProtocolEventObserved with 2 elementsstruct variant RawTraceEventPayload::CodeCellStarted with 3 elementsstruct PermissionProfileToml with 5 elementsstruct RemotePluginInstalledResponse with 2 elementsstruct RemotePluginMcpServerResponse with 1 elementstruct MemoryCitationEntry with 4 elementsstruct RealtimeConversationRealtimeEvent with 1 elementstruct TokenUsageProfileDailyBucket with 2 elementsstruct ExecApprovalResponse with 1 elementstruct variant ToolCallKind::Other with 1 elementstruct variant ToolCallKind::Mcp with 2 elementspidstruct PidRecord with 2 elementsstruct RemotePluginSkillDetailResponse with 3 elementsa mapstruct NetworkMitmTomlUnchecked with 2 elementsstruct MultiAgentV2ConfigToml with 12 elementsstruct NetworkProxyConfigToml with 12 elementsstruct PatchApprovalResponse with 1 elementstruct variant ToolCallSummary::WaitAgent with 2 elementsstruct variant ToolCallSummary::Agent with 3 elementsstruct variant ToolCallSummary::Generic with 3 elementsstruct variant ToolCallSummary::Terminal with 1 elementrollout_startedrollout_endedthread_startedthread_endedcodex_turn_startedinference_startedinference_completedinference_cancelledtool_call_startedmcp_tool_call_correlation_assignedtool_call_runtime_startedtool_call_runtime_endedtool_call_endedcode_cell_startedcode_cell_initial_responsecode_cell_endedcompaction_request_startedcompaction_request_completedcompaction_request_failedcompaction_installedagent_result_observedprotocol_event_observedstruct RemotePluginSkillInterfaceResponse with 6 elementsstruct RemotePluginDirectorySharePrincipal with 4 elementssubscriber should downcast to expected type; this is a bug!registry should have a span for the current IDOtelDataState should be a Context after starting it; this is a bug!layer should downcast to expected type; this is a bug!struct ClientInfo with 3 elementsstruct RemotePluginReleaseInterfaceResponse with 14 elementsstruct CodexToolCallParam with 9 elementsstruct EnvironmentRegistryRegistrationResponse with 2 elementsfield index 0 <= i < 12struct RequestUserInputEvent with 3 elementsitemsstruct TitledMultiSelectEnumSchema with 7 elementsstruct JSONRPCError with 2 elementsstruct variant DynamicToolCallOutputContentItem::InputText with 1 elementstruct variant DynamicToolCallOutputContentItem::InputImage with 1 elementstruct TitledSingleSelectEnumSchema with 5 elementsstruct ProxyOptionalParamstruct ProxyOptionalParam with 2 elementsstruct AppsMcpPathOverrideConfigToml with 2 elementsstruct RealtimeConversationListVoicesResponseEvent with 1 elementstruct UntitledMultiSelectEnumSchema with 7 elementstracestruct JSONRPCRequest with 4 elementsstruct RemotePluginSharePrincipal with 4 elementsstruct RequestUserInputQuestion with 6 elementsstruct UntitledSingleSelectEnumSchema with 5 elementsstruct JSONRPCResponse with 2 elementsstruct CodexToolCallReplyParam with 3 elementsstruct RequestPermissionsEvent with 7 elementsstruct InitializeParams with 2 elementsstruct RequestPermissionProfile with 2 elementsstruct JSONRPCErrorError with 3 elementsuserAgentcodexHomeplatformFamilyplatformOsstruct InitializeResponse with 4 elementsstruct JSONRPCNotification with 2 elementsincludeTokenrefreshTokenstruct GetAuthStatusParams with 2 elementsupgradeInfoavailabilityNuxdisplayNamehiddensupportedReasoningEffortsdefaultReasoningEffortinputModalitiessupportsPersonalityadditionalSpeedTiersserviceTiersdefaultServiceTierisDefaultstruct Model with 16 elementsstruct variant CreateElicitationRequestParamDeserializeHelper::FormElicitationParam with 3 elementsstruct variant CreateElicitationRequestParamDeserializeHelper::UrlElicitationParam with 4 elementssourcePathdestinationPathrecursivestruct FsCopyParams with 3 elementsstruct RequestUserInputQuestionOption with 2 elementsstruct variant ClientRequest::ThreadCompactStart with 2 elementsstruct variant ClientRequest::ThreadSettingsUpdate with 2 elementsstruct variant ClientRequest::ThreadMetadataUpdate with 2 elementsstruct variant ClientRequest::ExperimentalFeatureEnablementSet with 2 elementsstruct variant ClientRequest::ThreadRollback with 2 elementsstruct variant ClientRequest::ThreadMemoryModeSet with 2 elementsstruct variant ClientRequest::FeedbackUpload with 2 elementsstruct variant ClientRequest::GetConversationSummary with 2 elementsstruct variant ClientRequest::PluginShareDelete with 2 elementsstruct variant ClientRequest::ExternalAgentConfigDetect with 2 elementsstruct variant ClientRequest::PluginShareUpdateTargets with 2 elementsstruct variant ClientRequest::ThreadTurnsList with 2 elementsstruct variant ClientRequest::ThreadFork with 2 elementsstruct variant ClientRequest::RemoteControlDisable with 2 elementsstruct variant ClientRequest::CommandExecTerminate with 2 elementsstruct variant ClientRequest::FsWriteFile with 2 elementsstruct variant ClientRequest::ReviewStart with 2 elementsstruct variant ClientRequest::ThreadUnsubscribe with 2 elementsstruct variant ClientRequest::MemoryReset with 2 elementsstruct variant ClientRequest::LoginAccount with 2 elementsstruct variant ClientRequest::FsReadDirectory with 2 elementsstruct variant ClientRequest::PluginShareCheckout with 2 elementsstruct variant ClientRequest::FsRemove with 2 elementsstruct variant ClientRequest::GetAuthStatus with 2 elementsstruct variant ClientRequest::HooksList with 2 elementsstruct variant ClientRequest::ThreadApproveGuardianDeniedAction with 2 elementsstruct variant ClientRequest::ThreadSearch with 2 elementsstruct variant ClientRequest::FuzzyFileSearchSessionStop with 2 elementsstruct variant ClientRequest::ProcessResizePty with 2 elementsstruct variant ClientRequest::ThreadUnarchive with 2 elementsstruct variant ClientRequest::SkillsConfigWrite with 2 elementsstruct variant ClientRequest::RemoteControlClientsList with 2 elementsstruct variant ClientRequest::ThreadList with 2 elementsstruct variant ClientRequest::ThreadArchive with 2 elementsstruct variant ClientRequest::FsCreateDirectory with 2 elementsstruct variant ClientRequest::ThreadRealtimeAppendText with 2 elementsstruct variant ClientRequest::PluginShareList with 2 elementsstruct variant ClientRequest::PluginSkillRead with 2 elementsstruct variant ClientRequest::RemoteControlStatusRead with 2 elementsstruct variant ClientRequest::CommandExecWrite with 2 elementsstruct variant ClientRequest::ThreadTurnsItemsList with 2 elementsstruct variant ClientRequest::ThreadSetName with 2 elementsstruct variant ClientRequest::ThreadInjectItems with 2 elementsstruct variant ClientRequest::ExternalAgentConfigImport with 2 elementsstruct variant ClientRequest::TurnStart with 2 elementsstruct variant ClientRequest::ThreadRealtimeStart with 2 elementsstruct variant ClientRequest::ProcessSpawn with 2 elementsstruct variant ClientRequest::EnvironmentAdd with 2 elementsstruct variant ClientRequest::MarketplaceRemove with 2 elementsstruct variant ClientRequest::RemoteControlPairingStatus with 2 elementsstruct variant ClientRequest::ExperimentalFeatureList with 2 elementsstruct variant ClientRequest::PluginRead with 2 elementsstruct variant ClientRequest::ThreadGoalGet with 2 elementsstruct variant ClientRequest::ThreadBackgroundTerminalsClean with 2 elementsstruct variant ClientRequest::McpResourceRead with 2 elementsstruct variant ClientRequest::SendAddCreditsNudgeEmail with 2 elementsstruct variant ClientRequest::LogoutAccount with 2 elementsstruct variant ClientRequest::ThreadRealtimeListVoices with 2 elementsstruct variant ClientRequest::ThreadLoadedList with 2 elementsstruct variant ClientRequest::FuzzyFileSearchSessionUpdate with 2 elementsstruct variant ClientRequest::WindowsSandboxSetupStart with 2 elementsstruct variant ClientRequest::TurnSteer with 2 elementsstruct variant ClientRequest::SkillsList with 2 elementsstruct variant ClientRequest::FsUnwatch with 2 elementsstruct variant ClientRequest::McpServerStatusList with 2 elementsstruct variant ClientRequest::McpServerToolCall with 2 elementsstruct variant ClientRequest::TurnInterrupt with 2 elementsstruct variant ClientRequest::MarketplaceAdd with 2 elementsstruct variant ClientRequest::FuzzyFileSearchSessionStart with 2 elementsstruct variant ClientRequest::MarketplaceUpgrade with 2 elementsstruct variant ClientRequest::ModelProviderCapabilitiesRead with 2 elementsstruct variant ClientRequest::FsWatch with 2 elementsstruct variant ClientRequest::ThreadGoalClear with 2 elementsstruct variant ClientRequest::SkillsExtraRootsSet with 2 elementsstruct variant ClientRequest::ThreadRealtimeStop with 2 elementsstruct variant ClientRequest::GetAccount with 2 elementsstruct variant ClientRequest::FsGetMetadata with 2 elementsstruct variant ClientRequest::ModelList with 2 elementsstruct variant ClientRequest::ProcessWriteStdin with 2 elementsstruct variant ClientRequest::ThreadDecrementElicitation with 2 elementsstruct variant ClientRequest::FsCopy with 2 elementsstruct variant ClientRequest::ConfigRequirementsRead with 2 elementsstruct variant ClientRequest::ProcessKill with 2 elementsstruct variant ClientRequest::PluginInstall with 2 elementsstruct variant ClientRequest::RemoteControlEnable with 2 elementsstruct variant ClientRequest::GitDiffToRemote with 2 elementsstruct variant ClientRequest::ConfigValueWrite with 2 elementsstruct variant ClientRequest::MockExperimentalMethod with 2 elementsstruct variant ClientRequest::Initialize with 2 elementsstruct variant ClientRequest::RemoteControlClientsRevoke with 2 elementsstruct variant ClientRequest::GetAccountRateLimits with 2 elementsstruct variant ClientRequest::CancelLoginAccount with 2 elementsstruct variant ClientRequest::ThreadGoalSet with 2 elementsstruct variant ClientRequest::ThreadResume with 2 elementsstruct variant ClientRequest::ThreadIncrementElicitation with 2 elementsstruct variant ClientRequest::ConfigBatchWrite with 2 elementsstruct variant ClientRequest::ThreadRealtimeAppendAudio with 2 elementsstruct variant ClientRequest::ThreadStart with 2 elementsstruct variant ClientRequest::McpServerOauthLogin with 2 elementsstruct variant ClientRequest::FuzzyFileSearch with 2 elementsstruct variant ClientRequest::CollaborationModeList with 2 elementsstruct variant ClientRequest::FsReadFile with 2 elementsstruct variant ClientRequest::WindowsSandboxReadiness with 2 elementsstruct variant ClientRequest::PluginUninstall with 2 elementsstruct variant ClientRequest::PluginList with 2 elementsstruct variant ClientRequest::AppsList with 2 elementsstruct variant ClientRequest::CommandExecResize with 2 elementsstruct variant ClientRequest::OneOffCommandExec with 2 elementsstruct variant ClientRequest::PermissionProfileList with 2 elementsstruct variant ClientRequest::ThreadRead with 2 elementsstruct variant ClientRequest::ThreadShellCommand with 2 elementsstruct variant ClientRequest::PluginInstalled with 2 elementsstruct variant ClientRequest::RemoteControlPairingStart with 2 elementsstruct variant ClientRequest::McpServerRefresh with 2 elementsstruct variant ClientRequest::GetAccountTokenUsage with 2 elementsstruct variant ClientRequest::ConfigRead with 2 elementsstruct variant ClientRequest::PluginShareSave with 2 elementsstruct GitDiffToRemoteParams with 1 elementstruct AppReview with 1 elementwatchIdstruct FsWatchParams with 2 elementsexperimentalApirequestAttestationoptOutNotificationMethodsstruct InitializeCapabilities with 3 elementsforcestruct FsRemoveParams with 3 elementsmemoryCitationprocessIdcommandActionsdurationMsrevisedPromptsavedPathsenderThreadIdreceiverThreadIdsreasoningEffortagentsStatescontentItemsstruct variant ThreadItem::FileChange with 3 elementsstruct variant ThreadItem::Plan with 2 elementsstruct variant ThreadItem::CollabAgentToolCall with 9 elementsstruct variant ThreadItem::EnteredReviewMode with 2 elementsstruct variant ThreadItem::ContextCompaction with 1 elementstruct variant ThreadItem::CommandExecution with 10 elementsstruct variant ThreadItem::ImageView with 2 elementsstruct variant ThreadItem::Reasoning with 3 elementsstruct variant ThreadItem::ImageGeneration with 5 elementsstruct variant ThreadItem::McpToolCall with 10 elementsstruct variant ThreadItem::AgentMessage with 4 elementsstruct variant ThreadItem::DynamicToolCall with 8 elementsstruct variant ThreadItem::UserMessage with 3 elementsstruct variant ThreadItem::HookPrompt with 2 elementsstruct variant ThreadItem::ExitedReviewMode with 2 elementsstruct variant ThreadItem::WebSearch with 3 elementswebsiteprivacyPolicytermsOfServiceisDiscoverableAppstruct AppBranding with 6 elementscategoriessubCategoriesseoDescriptionscreenshotsversionIdversionNotesfirstPartyTypefirstPartyRequiresInstallshowInComposerWhenUnlinkedstruct AppMetadata with 12 elementsstruct ToolsV2 with 1 elementstruct FsUnwatchParams with 1 elementbyteRangestruct RemoteWorkspacePluginCreateResponse with 2 elementsstruct FsReadFileParams with 1 elementstruct variant Account::Chatgpt with 2 elementsfileIduserPromptstruct AppScreenshot with 3 elementsstruct AppConfig with 7 elementsdataBase64struct FsWriteFileParams with 2 elementsstruct variant CommandAction::Search with 3 elementsstruct variant CommandAction::ListFiles with 2 elementsstruct variant CommandAction::Read with 3 elementsstruct variant CommandAction::Unknown with 1 elementbackwardsCursorstruct TurnsPage with 3 elementsinitializethread/forkthread/archivethread/increment_elicitationthread/decrement_elicitationthread/name/setthread/goal/setthread/goal/getthread/goal/clearthread/metadata/updatethread/memoryMode/setmemory/resetthread/compact/startthread/shellCommandthread/approveGuardianDeniedActionthread/backgroundTerminals/cleanthread/rollbackthread/searchthread/loaded/listthread/turns/listthread/turns/items/listthread/inject_itemsskills/listskills/extraRoots/sethooks/listmarketplace/addmarketplace/removemarketplace/upgradeplugin/listplugin/readplugin/skill/readplugin/share/saveplugin/share/updateTargetsplugin/share/listplugin/share/checkoutplugin/share/deletefs/readFilefs/writeFilefs/createDirectoryfs/getMetadatafs/removefs/copyfs/unwatchskills/config/writeplugin/installturn/steerthread/realtime/startthread/realtime/appendAudiothread/realtime/appendTextthread/realtime/stopthread/realtime/listVoicesmodel/listmodelProvider/capabilities/readexperimentalFeature/listpermissionProfile/listexperimentalFeature/enablement/setremoteControl/enableremoteControl/disableremoteControl/status/readremoteControl/pairing/startremoteControl/pairing/statusremoteControl/client/listremoteControl/client/revokecollaborationMode/listmock/experimentalMethodenvironment/addmcpServer/oauth/loginconfig/mcpServer/reloadmcpServerStatus/listmcpServer/resource/readmcpServer/tool/callwindowsSandbox/setupStartwindowsSandbox/readinessaccount/login/startaccount/login/cancelaccount/logoutaccount/rateLimits/readaccount/usage/readaccount/sendAddCreditsNudgeEmailfeedback/uploadcommand/execcommand/exec/writecommand/exec/terminatecommand/exec/resizeprocess/writeStdinprocess/killprocess/resizePtyconfig/readexternalAgentConfig/detectexternalAgentConfig/importconfig/value/writeconfig/batchWriteconfigRequirements/readaccount/readgetConversationSummarygitDiffToRemotegetAuthStatusfuzzyFileSearchfuzzyFileSearch/sessionStartfuzzyFileSearch/sessionUpdatefuzzyFileSearch/sessionStopforceRefetchstruct AppsListParams with 4 elementskeyPathmergeStrategystruct ConfigEdit with 3 elementsthreadIdslocalImagestruct RemotePluginShareUpdateTargetsResponse with 2 elementsstruct RemoteWorkspacePluginUploadUrlResponse with 3 elementsdisabledReasonstruct ConfigLayer with 4 elementsstruct FsGetMetadataParams with 1 elementsessionFlagscloudRequirementscloudManagedConfiglegacyManagedConfigFilelegacyManagedConfigMdmstruct variant PatchChangeKind::Update with 1 elementuserMessagehookPromptagentMessagefileChangemcpToolCalldynamicToolCallcollabAgentToolCallwebSearchimageViewimageGenerationenteredReviewModecontextCompactionstruct variant WebSearchAction::OpenPage with 1 elementstruct variant WebSearchAction::FindInPage with 2 elementsstruct variant WebSearchAction::Search with 2 elementsstruct McpToolCallResult with 3 elementsclientUserMessageIdresponsesapiClientMetadataadditionalContextenvironmentsruntimeWorkspaceRootsapprovalPolicyapprovalsReviewersandboxPolicyserviceTiercollaborationModestruct TurnStartParams with 19 elementsexpectedTurnIdstruct TurnSteerParams with 6 elementsrolloutPathstruct CollabAgentState with 2 elementsstruct FileUpdateChange with 3 elementseventNamehandlerTypetimeoutSecdisplayOrderisManagedcurrentHashtrustStatusstruct HookMetadata with 15 elementsactiveFlagsstruct variant ThreadStatus::Active with 1 elementcancellationTokenstruct FuzzyFileSearchParams with 3 elementsstruct AppToolConfig with 2 elementsstruct HookMigration with 1 elementstruct FsReadDirectoryParams with 1 elementincludeHiddenstruct ModelListParams with 3 elementsstruct HookErrorInfo with 2 elementsstruct SkillMetadata with 8 elementsstruct TurnStartResponse with 1 elementstruct TurnSteerResponse with 1 elementstruct PersonalAccessTokenMetadata with 5 elementsin-process app-server reject channel is closedin-process app-server worker channel is closedin-process app-server resolve channel is closedchatgpt auth token refresh is not supported for in-process app-server clientsin-process app-server event queue is fullin-process app-server request channel is closedin-process app-server shutdown channel is closeddropping in-process app-server event because consumer queue is fullfailed to deliver remote app-server server requestrejecting unknown remote app-server requestfailed to deliver remote app-server eventremote app-server worker channel is closedconnection closedremote app-server reject channel is closedremote app-server resolve channel is closedremote app-server request channel is closedws://localhost/rpcrejecting unknown remote app-server request during initializeconnection closed during initializefailed to resolve current updater executablehttps://chatgpt.com/codex/install.shfailed to fetch standalone Codex updaterstandalone Codex updater request failedfailed to read standalone Codex updater/bin/sh-sfailed to invoke standalone Codex updaterstandalone Codex updater stdin was unavailablefailed to pass standalone Codex updater to shellfailed to wait for standalone Codex updaterfailed to install updater shutdown handler--versionbackendsocketPathcliVersionalreadyEnabledalreadyDisabledautoUpdateEnabledmanagedCodexVersionbootstrappedalreadyRunningstartedrestartednotRunningtimed out waiting for remoteControl/enable responsefailed to parse remoteControl/enable responseinitializedfailed to send initialized notificationfailed to send remoteControl/enable requestapp server is running but is not managed by codex app-server daemonCodex App Server Daemonfailed to send initialize requesttimed out waiting for initialize responsefailed to parse initialize responsefailed to parse app-server JSON-RPC messageapp-server closed the control socketws://localhost/0
preToolUsepermissionRequestpostToolUsepreCompactpostCompactsessionStartsubagentStartsubagentStoplistFilesstruct ModelServiceTier with 3 elementsupgradeCopymodelLinkmigrationMarkdownstruct ModelUpgradeInfo with 4 elementserrorsstruct HooksListEntry with 4 elementsstruct SkillErrorInfo with 2 elementsiconSmalliconLargebrandColordefaultPromptstruct SkillInterface with 6 elementshttpStatusCodeitemsViewstartedAtcompletedAtstruct Turn with 8 elementsstruct FsCreateDirectoryParams with 2 elementsstruct McpResourceReadParams with 3 elementsstruct ModelListResponse with 2 elementsadminstruct SkillsListEntry with 3 elementsstruct TurnInterruptParams with 2 elementsstruct CommandMigration with 1 elementincludeLayersstruct ConfigReadParams with 2 elementssubagentsmarketplaceNamepluginNamesstruct PluginsMigration with 2 elementsstruct SessionMigration with 3 elementsokOverriddenspawnAgentsendInputresumeAgentcloseAgentfindInPagestruct PluginListParams with 2 elementsmarketplacePathremoteMarketplaceNamepluginNamestruct PluginReadParams with 3 elementsforceReloadmodelProviderdeveloperInstructionsthreadSourceexcludeTurnsstruct ThreadForkParams with 17 elementssortKeysortDirectionmodelProviderssourceKindsuseStateDbOnlysearchTermstruct ThreadListParams with 10 elementsincludeTurnsstruct ThreadReadParams with 2 elementssessionIdforkedFromIdparentThreadIdpreviewagentNicknameagentRolegitInfoturnsstruct Thread with 20 elementsdotCodexFolderstruct variant ConfigLayerSource::EnterpriseManaged with 2 elementsstruct variant ConfigLayerSource::Project with 1 elementstruct variant ConfigLayerSource::LegacyManagedConfigTomlFromFile with 1 elementstruct variant ConfigLayerSource::System with 1 elementstruct variant ConfigLayerSource::Mdm with 2 elementsstruct variant ConfigLayerSource::User with 2 elementsstruct SubagentMigration with 1 elementstruct McpResourceReadResponse with 1 elementstruct McpServerToolCallParams with 5 elementsstruct HooksListResponse with 1 elementprincipalTypeprincipalIdstruct PluginShareTarget with 3 elementsstruct SkillDependencies with 1 elementstruct ReviewStartParams with 3 elementsserviceNamesessionStartSourcedynamicToolsmockExperimentalFieldexperimentalRawEventsstruct ThreadStartParams with 21 elementsnotLoadedsystemErrororiginUrlstruct TurnEnvironmentParams with 2 elementsoriginslayersstruct ConfigReadResponse with 3 elementsstruct McpServerMigration with 1 elementreplaceupsertoverridingLayereffectiveValuestruct OverriddenMetadata with 3 elementspendingInitstruct ModelAvailabilityNux with 1 elementstruct SkillsListResponse with 1 elementascinstructionSourcesactivePermissionProfilestruct ThreadForkResponse with 12 elementsstruct ThreadListResponse with 3 elementsstruct ThreadReadResponse with 1 elementstruct ThreadResumeParams with 18 elementsstruct ThreadSearchParams with 7 elementscreated_atstruct AdditionalContextEntry with 2 elementsstruct ConfigLayerMetadata with 2 elementsoverriddenMetadatastruct ConfigWriteResponse with 4 elementsstruct ListMcpServerStatusParams with 4 elementstimeoutSecsstruct McpServerOauthLoginParams with 3 elementsstruct ReasoningEffortOption with 2 elementsstruct PluginInstallParams with 3 elementsstruct SkillToolDependency with 6 elementsprocessHandlestruct ProcessKillParams with 1 elementinlinereviewThreadIdstruct ReviewStartResponse with 2 elementscontextWindowExceededusageLimitExceededcyberPolicyhttpConnectionFailedresponseStreamConnectionFailedinternalServerErrorbadRequestthreadRollbackFailedsandboxErrorresponseStreamDisconnectedresponseTooManyFailedAttemptsactiveTurnNotSteerablestruct ThreadArchiveParams with 1 elementstruct ThreadGoalGetParams with 1 elementstruct ThreadGoalSetParams with 4 elementsstruct ThreadSetNameParams with 2 elementsstruct ThreadStartResponse with 12 elementscodexErrorInfoadditionalDetailsstruct TurnError with 3 elementsaccountrequiresOpenaiAuthstruct GetAccountResponse with 2 elementsaccessTokenchatgptPlanTypecodexStreamlinedLoginstruct variant LoginAccountParams::ApiKey with 1 elementstruct variant LoginAccountParams::ChatgptAuthTokens with 3 elementsrefNamesparsePathsstruct MarketplaceAddParams with 3 elementsstreamStdinstreamStdoutStderroutputBytesCaptimeoutMsstruct ProcessSpawnParams with 10 elementsstruct ThreadResumeResponse with 13 elementsstruct ThreadRollbackParams with 2 elementsON_INSTALLON_USEinstallSuggestionPluginNamesstruct PluginInstalledParams with 2 elementspluginPathremotePluginIdshareTargetsstruct PluginShareSaveParams with 4 elementsskillNamestruct PluginSkillReadParams with 3 elementsstruct PluginUninstallParams with 1 elementstruct ProcessTerminalSize with 2 elementswaitingOnApprovalwaitingOnUserInputstruct ThreadGoalClearParams with 1 elementstruct ThreadGoalGetResponse with 1 elementstruct ThreadGoalSetResponse with 1 elementappServersubAgentReviewsubAgentCompactsubAgentThreadSpawnsubAgentOtherstruct ThreadTurnsListParams with 5 elementsstruct ThreadUnarchiveParams with 1 elementeditsexpectedVersionstruct ConfigBatchWriteParams with 4 elementsenterpriseManagedlegacyManagedConfigTomlFromFilelegacyManagedConfigTomlFromMdmstruct ConfigValueWriteParams with 5 elementsanswersstruct ToolRequestUserInputAnswer with 1 elementstruct ThreadLoadedListParams with 2 elementsstruct ThreadRollbackResponse with 1 elementapplicationuserShellunifiedExecStartupunifiedExecInteractionstruct MarketplaceRemoveParams with 1 elementAVAILABLEENABLEDDISABLED_BY_ADMINstruct PluginShareDeleteParams with 1 elementstruct SkillsConfigWriteParams with 3 elementsclearedstruct ThreadGoalClearResponse with 1 elementstruct ThreadInjectItemsParams with 2 elementsstruct ThreadUnarchiveResponse with 1 elementstruct ThreadUnsubscribeParams with 1 element
struct HomebrewCaskInfostruct HomebrewCaskInfo with 1 elementstruct FuzzyFileSearchSessionStopParams with 1 elementclassificationincludeLogsextraLogFilesstruct FeedbackUploadParams with 6 elementsstruct ToolRequestUserInputResponse with 1 elementstruct MarketplaceUpgradeParams with 1 elementNOT_AVAILABLEINSTALLED_BY_DEFAULTstruct ProcessResizePtyParams with 2 elementsstruct ThreadCompactStartParams with 1 elementstruct ThreadLoadedListResponse with 2 elementsstruct ThreadShellCommandParams with 2 elementsstruct FuzzyFileSearchSessionStartParams with 2 elementschatgptDeviceCodechatgptAuthTokensstruct PluginShareCheckoutParams with 1 elementstruct SkillsConfigWriteResponse with 1 elementextraRootsstruct SkillsExtraRootsSetParams with 1 elementdeltaBase64closeStdinstruct ProcessWriteStdinParams with 3 elementsstruct ThreadMemoryModeSetParams with 2 elementsstruct ThreadUnsubscribeResponse with 1 elementstruct variant OtelExporterKind::OtlpHttp with 4 elementsstruct variant OtelExporterKind::OtlpGrpc with 3 elementsstruct FuzzyFileSearchSessionUpdateParams with 2 elementsloginIdstruct CancelLoginAccountParams with 1 elementstruct ThreadMetadataUpdateParams with 2 elementsstruct ThreadSettingsUpdateParams with 12 elementsstruct ThreadTurnsItemsListParams with 5 elementsexecpolicy_amendmentsampleRatenumChannelssamplesPerChannelitemIdstruct ThreadRealtimeAudioChunk with 5 elementsstruct ThreadRealtimeStopParams with 1 elementstruct MockExperimentalMethodParams with 1 elementstruct ThreadMetadataUpdateResponse with 1 elementnotSubscribedunsubscribeddisableTimeoutpermissionProfilestruct CommandExecParams with 14 elementsstruct FileChangeRequestApprovalResponse with 1 elementoutputModalityrealtimeSessionIdstruct ThreadRealtimeStartParams with 6 elementsexecServerUrlstruct EnvironmentAddParams with 2 elementsshared-with-mestruct PluginShareUpdateTargetsParams with 3 elementsincludeHomestruct ExternalAgentConfigDetectParams with 2 elementsmigrationItemsstruct ExternalAgentConfigImportParams with 1 elementcreditTypestruct SendAddCreditsNudgeEmailParams with 1 elementstruct ExternalAgentConfigMigrationItem with 4 elementsstruct variant ThreadRealtimeStartTransport::Webrtc with 1 elementstruct ThreadDecrementElicitationParams with 1 elementstruct ThreadIncrementElicitationParams with 1 elementstruct variant RealtimeEvent::SessionUpdated with 2 elementsstruct variant RealtimeEvent::ConversationItemDone with 1 elementstruct ExternalAgentConfigDetectResponse with 1 elementacceptWithExecpolicyAmendmentapplyNetworkPolicyAmendmentJSONRPCErrordata did not match any variant of untagged enum JSONRPCMessageJSONRPCResponseJSONRPCErrorErrorJSONRPCNotificationInitializeResponseInitializeCapabilitiesfileChangesgrantRootapprovalIdparsedCmddata did not match any variant of untagged enum GetConversationSummaryParamsnetworkAccessexternalSandboxworkspaceWritewritableRootsexcludeTmpdirEnvVarexcludeSlashTmpinternally tagged enum LegacyReadOnlyAccessLegacyReadOnlyAccessFullAccesssocks5Tcpsocks5UdpGrantedPermissionProfilefileSysteminternally tagged enum SandboxPolicyDeserializeSandboxPolicyDeserializeAdditionalNetworkPermissionsAdditionalFileSystemPermissionscapReachedwillRetryserverNameinstallationIdconnectingconnectedordermanualCodepairingCodemanualPairingCodesamplePathsextraCountfailedScanenablementchangedPaths$schemaarraynumberintegerstringbooleanMcpServerElicitationRequestResponseinstallUrlisAccessibleisEnabledpluginDisplayNamesexecutionModeinternally tagged enum ThreadIteminternally tagged enum CommandActionPatchChangeKindinternally tagged enum PatchChangeKindAddDeleteunifiedExecriskLeveluserAuthorizationcompletedAtMsapplyPatchconnectorIdconnectorNametoolTitlerequestPermissionscontentIndexCommandExecutionApprovalDecisionnetworkApprovalContextadditionalPermissionsproposedExecpolicyAmendmentproposedNetworkPolicyAmendmentsavailableDecisionssummaryIndextargetItemIddecisionSourceAdditionalContextEntrytrustedAccessForCyberhighRiskCyberActivityfromModeltoModelcolumninternally tagged enum ConfigLayerSourceConfigLayerSourceSessionFlagsLegacyManagedConfigTomlFromMdmrangedata did not match any variant of untagged enum ForcedChatgptWorkspaceIdsAGENTS_MDCONFIGSKILLSPLUGINSMCP_SERVER_CONFIGSUBAGENTSHOOKSThreadStatusinternally tagged enum ThreadStatusSystemErrorThreadSettingsmodelContextWindowtotalTokensinputTokenscachedInputTokensoutputTokensreasoningOutputTokensdata did not match any variant of untagged enum ThreadListCwdFilterthreadSettingstokenUsageeventinternally tagged enum AccounthasCreditsusedPercentwindowDurationMinslimitIdlimitNameindividualLimitrateLimitReachedTypeinternally tagged enum LoginAccountParamsLoginAccountParamsChatgptDeviceCodepreviousAccountIdrateLimitsinternally tagged enum ThreadRealtimeStartTransportThreadRealtimeStartTransportWebsocketapikeyagentIdentitypersonalAccessTokenitem/commandExecution/requestApprovalitem/fileChange/requestApprovalitem/tool/requestUserInputitem/permissions/requestApprovalitem/tool/callaccount/chatgptAuthTokens/refreshattestation/generateapplyPatchApprovalexecCommandApprovalinternally tagged enum ClientRequestthread/startedthread/status/changedthread/archivedthread/unarchivedthread/closedskills/changedthread/name/updatedthread/goal/updatedthread/goal/clearedthread/settings/updatedthread/tokenUsage/updatedturn/startedhook/startedturn/completedhook/completedturn/diff/updatedturn/plan/updateditem/starteditem/autoApprovalReview/starteditem/autoApprovalReview/completeditem/completedrawResponseItem/completeditem/agentMessage/deltaitem/plan/deltacommand/exec/outputDeltaprocess/outputDeltaprocess/exiteditem/commandExecution/outputDeltaitem/commandExecution/terminalInteractionitem/fileChange/outputDeltaitem/fileChange/patchUpdatedserverRequest/resolveditem/mcpToolCall/progressmcpServer/oauthLogin/completedmcpServer/startupStatus/updatedaccount/updatedaccount/rateLimits/updatedremoteControl/status/changedexternalAgentConfig/import/completedfs/changeditem/reasoning/summaryTextDeltaitem/reasoning/summaryPartAddeditem/reasoning/textDeltamodel/reroutedmodel/verificationturn/moderationMetadataguardianWarningdeprecationNoticeconfigWarningfuzzyFileSearch/sessionUpdatedfuzzyFileSearch/sessionCompletedthread/realtime/startedthread/realtime/itemAddedthread/realtime/transcript/deltathread/realtime/transcript/donethread/realtime/outputAudio/deltathread/realtime/sdpthread/realtime/errorthread/realtime/closedwindows/worldWritableWarningwindowsSandbox/setupCompletedaccount/login/completedmatch_typefile_namescoreindicesdirectoryModelProviderInfoModelProviderAwsAuthInfoAbsolutePathBufstruct variant CodexErrorInfo::ActiveTurnNotSteerable with 1 elementstruct variant CodexErrorInfo::ResponseStreamConnectionFailed with 1 elementstruct variant CodexErrorInfo::ResponseStreamDisconnected with 1 elementstruct variant CodexErrorInfo::ResponseTooManyFailedAttempts with 1 elementstruct variant CodexErrorInfo::HttpConnectionFailed with 1 elementstruct variant ReviewDecision::NetworkPolicyAmendment with 1 elementstruct variant ReviewDecision::ApprovedExecpolicyAmendment with 1 elementstruct variant SubAgentSource::ThreadSpawn with 5 elementsstruct CommandExecWriteParams with 3 elementsreadOnlyAccessstruct ThreadRealtimeAppendTextParams with 2 elementsstruct ThreadResumeInitialTurnsPageParams with 3 elementsstruct ReleaseInfostruct ReleaseInfo with 1 elementstruct CommandExecResizeParams with 2 elementsstruct CommandExecTerminalSize with 2 elementsstruct CommandExecutionRequestApprovalResponse with 1 elementfullAccessstruct ThreadRealtimeAppendAudioParams with 2 elementsstruct ThreadBackgroundTerminalsCleanParams with 1 elementstruct PermissionProfileListParams with 3 elementsstruct CommandExecTerminateParams with 1 elementstruct ThreadApproveGuardianDeniedActionParams with 2 elementsvariant index 0 <= i < 9struct RemoteControlEnableResponse with 4 elementssegment_idsegment_countmessage_size_bytesmessage_chunk_base64approx_local_messagesapprox_cloud_messagesstruct CreditStatusDetails with 5 elementscontrol socket acceptor shutting downapp-server control socket listeningremote control transport event receiver droppedtimed out forwarding remote control transport eventremote control transport event forwarding task failedconnection_closedconnection_openedstarting app-server remote control websocket taskapp-server remote control websocket task startedapp-server remote control websocket task exited without shutdownapp-server remote control websocket task exitedapp-server remote control websocket task panickedinternal error: entered unreachable code: remote control enrollment lock should stay openremote control requires ChatGPT authentication; API key auth is not supportedremote control requires ChatGPT authenticationremote control enrollment is waiting for a ChatGPT account idaarch64enrollserver enrollmentrefreshserver refreshchatgpt-account-iddevice_typeos_versiondevice_modelapp_versionlast_seen_atlist remote control clientsremote control client list limit must be between 1 and 100remote control client list requires environmentIdclient listrevoke remote control clientremote control client revoke requires clientIdremote control client revoke requires environmentIdclient revokeremote control URL cannot be a baseserver_messageserver_message_chunkackClientEventClientClosedstream_idseq_idosapp_server_versionremote_control_tokenexpires_atmanual_codepairing_codemanual_pairing_codeclaimedremote control websocket writer was stoppedremote control websocket reader was stoppedtimed out waiting for remote control connection workers to stop; abortingoutbound buffer usage channel closedserver event channel closedremote control websocket pong timeoutwebsocket stream endeddropping unsupported binary remote-control websocket messagewebsocket disconnectedapp-server remote control websocket loop startedapp-server remote control websocket loop stopped before client name was readyapp-server remote control websocket connection cycle endedapp-server remote control websocket loop exiting while waiting for enablementstarting app-server remote control websocket connection cycleapp-server remote control websocket loop exitedretrying app-server remote control websocket after auth changedconnecting to app-server remote control websocketconnected to app-server remote control websocketfailed to connect to app-server remote control websocketreset app-server remote control websocket reconnect backoff after capremote control websocket returned unrecognized HTTP 404; preserving enrollment before retrymissing remote control enrollment after enrollment stepremote control requires sqlite state dbmissing remote control enrollment before server refreshmissing remote control enrollment after websocket auth failureServer overloaded; retry later.processor unavailablewebsocket acceptor shutting downrejecting websocket client during upgradewebsocket client connecteddropping unsupported binary websocket messagewebsocket control queue full while replying to ping; closing connectionrejecting websocket listener request with Origin header
failed to list sessions while resolving session namefailed to find Codex homefailed to resolve local runtime pathsfailed to initialize environment managerfailed to resolve config cwdfailed to load config.tomlfailed to initialize state databasecodex-tuifailed to connect to remote app serverFailed to shut down temporary embedded app serverfailed to start embedded app serverskipping default app-server daemon sockettimed out probing default app-server daemon socketFailed to parse session id during TUI lookupFailed to save external config migration prompt timestampfailed to detect external agent config migrations; continuing startupfailed to persist external config migration prompt timestampfailed to persist external config migration prompt dismissalFailed to reload config after external agent migrationfailed to import external agent config migration itemsFailed to save external config migration prompt preferenceslash_commandcodex.thread.fork/forkforking the threadA thread must contain at least one turn before it can be forked.No changes detected.D I F Ffailed to load skills on startupcodex.windows_sandbox.fallback_prompt_shownfailurecodex.windows_sandbox.elevated_setup_duration_msFailed to set approval policyfailed to set approval policy on app configFailed to set permission profilefailed to set active permission profile on app configfailed to set permission profile on chat configE X E CEnvironment: Permission rule: P E R M I S S I O N SP A T C HE L I C I T A T I O Nclosing the session pickerTo continue this session, run failed to persist model selectionfailed to persist personality selectionService tier clearedfailed to persist service tier selectionfailed to persist realtime audio selectionfailed to persist approvals reviewer updatefailed to persist full access warning acknowledgementfailed to persist world-writable warning acknowledgementfailed to persist rate limit switch prompt preferencefailed to persist plan mode reasoning effortfailed to persist model migration prompt acknowledgementfailed to persist status line settings; keeping previous selectionfailed to persist terminal title items; keeping previous selectionfailed to persist theme selectionSystem defaulttimed out waiting for app-server thread shutdownfailed to clear keymap bindingfailed to persist keymap binding'/archive' is unavailable in side conversations. Press Ctrl+C to return to the main thread first.A thread must start before it can be archived.No active thread is available.history lookup task failedfailed to refresh inferred thread session before replayfailed to refresh skillsfailed to persist model availability nux countapp-server event consumer lagged; dropping ignored eventsrejecting unsupported app-server requestignoring threadless app-server requestignoring app-server notification with invalid thread_idignoring app-scoped MCP startup notification without a TUI app-level targetfailed to refresh config after external agent config importSubagentsNo agents available yet.failed to resume live thread for selection; falling back to thread/readfailed to list loaded threads for subagent backfillfailed to read loaded threadignoring loaded thread with invalid id during subagent backfillstarting a new threadthe effective config is overridden by a higher-priority layerfailed to update constrained feature flagsApprove for meFailed to enable Approve for mefailed to set auto-review approval policy on staged configfailed to set auto-review permission profile on staged configfailed to set auto-review permission profile on chat configfeature flag config write was overridden by effective configExperimental feature changesfailed to persist feature flagsmemory settings config write was overridden by effective configMemory setting changesfailed to persist memory settingsfailed to reset memoriesReset local memories.failed to set selected permission profile approval policy on app configfailed to set selected permission profile on app configfailed to set selected permission profile on chat configfailed to resolve selected permission profilefailed to rebuild config for same-cwd resume; using current in-memory configfailed to update thread memory modefailed to refresh effective config after an overridden writefailed to refresh config before thread transition; continuing with current in-memory configFailed to refresh overridden Approve for me settingsfailed to sync overridden Auto-review permission profilefailed to sync overridden Auto-review permission profile on chat configThis thread does not currently have a goal.Goal clearedUsage: /goal [<objective>|clear|edit|pause|resume]No goal is currently set.failed to resolve runtime model provider base URL for statuscodex.status_linecli_subcommandtui startup initial frame scheduledterminal input stream closed; shutting down active threadapp-server event stream closedfailed to shut down embedded app serverfailed to clear ambient pet imagefailed to clear terminal UIcodex.thread.sidestarting a side conversationA side conversation is already open. Press Ctrl+C to return before starting another.'/side' is unavailable until the main thread is ready.Cannot open external editor: set $VISUAL or $EDITOR before starting Codex.web_search="live"
<skills_instructions></skills_instructions><personality_spec></personality_spec>
event app-server/src/request_processors/account_processor.rs:796codex_app_server::request_processors::account_processorapp-server/src/request_processors/account_processor.rsExternal auth is active. Use account/login/start (chatgptAuthTokens) to update it or account/logout to clear it.event app-server/src/request_processors/account_processor.rs:740event app-server/src/request_processors/account_processor.rs:197event app-server/src/request_processors/catalog_processor.rs:240codex_app_server::request_processors::catalog_processorapp-server/src/request_processors/catalog_processor.rsevent app-server/src/request_processors/feedback_processor.rs:266codex_app_server::request_processors::feedback_processorapp-server/src/request_processors/feedback_processor.rsevent app-server/src/request_processors/feedback_processor.rs:117event app-server/src/request_processors/feedback_processor.rs:147event app-server/src/request_processors/feedback_processor.rs:76event app-server/src/request_processors/feedback_processor.rs:83event app-server/src/request_processors/feedback_processor.rs:100event app-server/src/request_processors/initialize_processor.rs:115codex_app_server::request_processors::initialize_processorapp-server/src/request_processors/initialize_processor.rsevent app-server/src/request_processors/thread_goal_processor.rs:275codex_app_server::request_processors::thread_goal_processorapp-server/src/request_processors/thread_goal_processor.rsevent app-server/src/request_processors/thread_goal_processor.rs:294event app-server/src/request_processors/thread_goal_processor.rs:340event app-server/src/request_processors/thread_goal_processor.rs:315event app-server/src/request_processors/command_exec_processor.rs:103codex_app_server::request_processors::command_exec_processorapp-server/src/request_processors/command_exec_processor.rsoverallStatusdoctor_overall_statuschecksokdoctor_ok_countdoctor_warning_countdoctor_fail_countdoctor_failed_checksdoctor_warning_checksevent app-server/src/request_processors/feedback_doctor_report.rs:79codex_app_server::request_processors::feedback_doctor_reportexecutableapp-server/src/request_processors/feedback_doctor_report.rsevent app-server/src/request_processors/feedback_doctor_report.rs:67event app-server/src/request_processors/feedback_doctor_report.rs:57event app-server/src/request_processors/feedback_doctor_report.rs:49event app-server/src/request_processors/process_exec_processor.rs:548codex_app_server::request_processors::process_exec_processorapp-server/src/request_processors/process_exec_processor.rsevent app-server/src/request_processors/process_exec_processor.rs:87process size rows and cols must be greater than 0[redacted]codex_chatgpt_android_remotecodex_chatgpt_ios_remoteremote control is unavailable for this app-serverremoteControl/pairing/status requires pairingCode or manualPairingCoderemoteControl/pairing/status accepts either pairingCode or manualPairingCode, not bothevent app-server/src/request_processors/external_agent_session_import.rs:82codex_app_server::request_processors::external_agent_session_importapp-server/src/request_processors/external_agent_session_import.rsevent app-server/src/request_processors/external_agent_session_import.rs:91event app-server/src/request_processors/external_agent_config_processor.rs:218codex_app_server::request_processors::external_agent_config_processorapp-server/src/request_processors/external_agent_config_processor.rsinstall pluginevent app-server/src/request_processors/plugins.rs:700codex_app_server::request_processors::pluginsapp-server/src/request_processors/plugins.rsevent app-server/src/request_processors/plugins.rs:645event app-server/src/request_processors/plugins.rs:729openai-curatedevent app-server/src/request_processors/plugins.rs:1017event app-server/src/request_processors/plugins.rs:1010event app-server/src/request_processors/plugins.rs:999event app-server/src/request_processors/plugins.rs:1420event app-server/src/request_processors/plugins.rs:1734event app-server/src/request_processors/plugins.rs:929event app-server/src/request_processors/plugins.rs:1641event app-server/src/request_processors/plugins.rs:506event app-server/src/request_processors/plugins.rs:1617event app-server/src/request_processors/plugins.rs:1604event app-server/src/request_processors/plugins.rs:1591event app-server/src/request_processors/plugins.rs:1860event app-server/src/request_processors/plugins.rs:1885shareTargets cannot include workspace principals; use discoverability UNLISTED for workspace link accessopenai-curated-remoteLOG_FORMATapp_server.serialized_request_queuecodex_app_server::request_serializationkeyapp-server/src/request_serialization.rsReviewer failed to output a response.event app-server/src/bespoke_event_handling.rs:720codex_app_server::bespoke_event_handlingapp-server/src/bespoke_event_handling.rsevent app-server/src/bespoke_event_handling.rs:736event app-server/src/bespoke_event_handling.rs:1655event app-server/src/bespoke_event_handling.rs:1639event app-server/src/bespoke_event_handling.rs:1650event app-server/src/bespoke_event_handling.rs:1666event app-server/src/bespoke_event_handling.rs:1701event app-server/src/bespoke_event_handling.rs:1674event app-server/src/bespoke_event_handling.rs:1805event app-server/src/bespoke_event_handling.rs:1729event app-server/src/bespoke_event_handling.rs:1942event app-server/src/bespoke_event_handling.rs:1954event app-server/src/bespoke_event_handling.rs:1938event app-server/src/bespoke_event_handling.rs:1928event app-server/src/bespoke_event_handling.rs:2031event app-server/src/bespoke_event_handling.rs:2079event app-server/src/bespoke_event_handling.rs:2027event app-server/src/bespoke_event_handling.rs:1979event app-server/src/bespoke_event_handling.rs:1836event app-server/src/bespoke_event_handling.rs:1828event app-server/src/bespoke_event_handling.rs:1861strict auto review is only supported for turn-scoped permission grantsevent app-server/src/bespoke_event_handling.rs:1847event app-server/src/bespoke_event_handling.rs:1762event app-server/src/bespoke_event_handling.rs:1754event app-server/src/bespoke_event_handling.rs:1739keyPath must not be emptycannot set value on non-table parentkeyPath segments must not be emptyunterminated quoted keyPath segmentinvalid quoted keyPath segmentunterminated escape in keyPathOverridden by session flagsOverridden by legacy managed configuration from MDMProject-local config, hooks, and exec policies are disabled in the following folders until the project is trusted, but skills still load.
openai.yamlinterfacedependenciesshort-descriptionPolicyallow_implicit_invocationdisplay_nameshort_descriptionicon_smallicon_largebrand_colordefault_prompt failed to stat repo skills root 
failed to stat skills root 
failed to read skills dir 
"failed to read skills symlink dir 
failed to stat skills path 
skillName
usage_limitcreditTypeprocessHandleclassificationreasonincludeLogsextraLogFilessampleRatenumChannelssamplesPerChannelitemIdoutputModalitypromptrealtimeSessionIdtransportvoicewebsocketwebrtcsdpClientRequestinitializethread/startthread/resumethread/forkthread/archivethread/unsubscribethread/increment_elicitationthread/decrement_elicitationthread/name/setthread/goal/setthread/goal/getthread/goal/clearthread/metadata/updatethread/settings/updatethread/memoryMode/setmemory/resetthread/compact/startthread/shellCommandthread/approveGuardianDeniedActionthread/backgroundTerminals/cleanthread/rollbackthread/listthread/searchthread/loaded/listthread/readthread/turns/listthread/turns/items/listthread/inject_itemsskills/listskills/extraRoots/sethooks/listmarketplace/addmarketplace/removemarketplace/upgradeplugin/listplugin/readplugin/skill/readplugin/share/saveplugin/share/updateTargetsplugin/share/listplugin/share/checkoutplugin/share/deletefs/readFilefs/writeFilefs/createDirectoryfs/getMetadatafs/removefs/copyfs/unwatchskills/config/writeplugin/installturn/startturn/steerturn/interruptthread/realtime/startthread/realtime/appendAudiothread/realtime/appendTextthread/realtime/stopthread/realtime/listVoicesreview/startmodel/listmodelProvider/capabilities/readexperimentalFeature/listpermissionProfile/listexperimentalFeature/enablement/setremoteControl/enableremoteControl/disableremoteControl/status/readremoteControl/pairing/startremoteControl/pairing/statusremoteControl/client/listremoteControl/client/revokecollaborationMode/listmock/experimentalMethodenvironment/addmcpServer/oauth/loginconfig/mcpServer/reloadmcpServerStatus/listmcpServer/resource/readmcpServer/tool/callwindowsSandbox/setupStartwindowsSandbox/readinessaccount/login/startaccount/login/cancelaccount/logoutaccount/rateLimits/readaccount/usage/readaccount/sendAddCreditsNudgeEmailfeedback/uploadcommand/execcommand/exec/writecommand/exec/terminatecommand/exec/resizeprocess/spawnprocess/writeStdinprocess/killprocess/resizePtyconfig/readexternalAgentConfig/detectexternalAgentConfig/importconfig/value/writeconfig/batchWriteconfigRequirements/readaccount/readgetConversationSummarygitDiffToRemotegetAuthStatusfuzzyFileSearchfuzzyFileSearch/sessionStartfuzzyFileSearch/sessionUpdatefuzzyFileSearch/sessionStopinitializedrootscancellationTokensessionIdinternal error: entered unreachable code
"date-time"McpElicitationStringFormatMcpElicitationStringSchema"decline"McpServerElicitationActionErrorNotificationMarketplaceRemoveParamsPluginInstalledResponsePluginShareDeleteParamsPluginShareListResponsePluginShareSaveResponsePluginSkillReadResponsePluginUninstallResponse Path-based selector. Name-based selector.SkillsConfigWriteParams Client-supplied, connection-scoped `processHandle` from `process/spawn`. New PTY size in character cells. Resize a running PTY-backed `process/spawn` session.ProcessResizePtyParamsThreadGoalClearResponse Raw Responses API items to append to the thread's model-visible history.ThreadInjectItemsParams if None, there are no more turns to return. Opaque cursor to pass as `cursor` when reversing `sortDirection`. This is only populated when the page contains at least one turn. Use it with the opposite `sortDirection` to include the anchor turn again and catch updates to that turn.ThreadTurnsListResponseThreadUnarchiveResponseThreadUnsubscribeParams"notLoaded""notSubscribed""unsubscribed"ThreadUnsubscribeStatusTurnCompletedNotificationMapAccess::next_value called before next_key EXPERIMENTAL - notification emitted when the app list changes.AppListUpdatedNotificationManagedHooksRequirementsFeedbackUploadResponse"acceptForSession"FileChangeApprovalDecision EXPERIMENTAL. Captures a user's answer to a request_user_input question.ToolRequestUserInputAnswer EXPERIMENTAL. Defines a single selectable option for request_user_input.ToolRequestUserInputOption EXPERIMENTAL. Params sent with a request_user_input event.ToolRequestUserInputParams Opaque cursor to pass to the next call to continue after the last item. If None, there are no more items to return.ListMcpServerStatusResponseMcpElicitationBooleanSchema"mode": "form","mode": "url",McpServerOauthLoginResponseModelReroutedNotificationExecPolicyAmendmentArray<string>MarketplaceLoadErrorInfoMarketplaceUpgradeParams
"vertical""workspace-directory"PluginListMarketplaceKindPluginShareCheckoutParamsPluginShareDeleteResponse Notification emitted when watched local skill files change. Treat this as an invalidation signal and re-run `skills/list` with the client's current parameters when refreshed skill metadata is needed.SkillsChangedNotificationSkillsConfigWriteResponseSkillsExtraRootsSetParams Empty success response for `process/resizePty`.ProcessResizePtyResponseThreadInjectItemsResponseThreadMemoryModeSetParamsThreadStartedNotificationThreadUnsubscribeResponse Notification that the turn-level unified diff has changed. Contains the latest aggregated diff across all file changes in the turn.TurnDiffUpdatedNotificationTurnPlanUpdatedNotification"credits""usage_limit"AddCreditsNudgeCreditTypeSpendControlLimitSnapshotConfiguredHookMatcherGroup"type": "execve","type": "applyPatch","type": "networkAccess","type": "mcpToolCall","type": "requestPermissions",GuardianApprovalReviewAction"approved""timedOut""aborted" [UNSTABLE] Lifecycle state for an approval auto-review.GuardianApprovalReviewStatus EXPERIMENTAL. Represents one request_user_input question and its required options.ToolRequestUserInputQuestion EXPERIMENTAL. Response payload mapping question ids to answers.ToolRequestUserInputResponseMcpElicitationPrimitiveSchemaMcpElicitationTitledEnumItems{ "kind": "root" }{ "kind": "minimal" }"kind": "project_roots",{ "kind": "tmpdir" }{ "kind": "slash_tmp" }"kind": "unknown",FileSystemSpecialPathMarketplaceUpgradeResponse"UNLISTED""PRIVATE"PluginShareDiscoverability Empty when stdout was streamed via `process/outputDelta`. Whether stdout reached `outputBytesCap`. In streaming mode, stdout is empty and cap state is also reported on the final stdout `process/outputDelta` notification. Empty when stderr was streamed via `process/outputDelta`. Whether stderr reached `outputBytesCap`. In streaming mode, stderr is empty and cap state is also reported on the final stderr `process/outputDelta` notification. Final process exit notification for `process/spawn`.ProcessExitedNotification Empty success response for `process/writeStdin`.ProcessWriteStdinResponse EXPERIMENTAL - thread realtime audio chunk.ThreadRealtimeAudioChunk EXPERIMENTAL - stop thread realtime.ThreadRealtimeStopParamsThreadArchivedNotificationThreadCompactStartResponse Patch the stored Git metadata for this thread. Omit a field to leave it unchanged, set it to `null` to clear it, or provide a string to replace the stored value.ThreadMetadataUpdateParams Override the working directory for subsequent turns. Override the approval policy for subsequent turns. Override where approval requests are routed for subsequent turns. Override the sandbox policy for subsequent turns. Select a named permissions profile id for subsequent turns. Cannot be Override the model for subsequent turns. Override the service tier for subsequent turns. `null` clears the current service tier; omission leaves it unchanged. Override the reasoning effort for subsequent turns. Override the reasoning summary for subsequent turns. EXPERIMENTAL - Set a pre-set collaboration mode for subsequent turns. For `collaboration_mode.settings.developer_instructions`, `null` means "use the built-in instructions for the selected mode". Override the personality for subsequent turns.ThreadSettingsUpdateParamsThreadShellCommandResponse Optional item page size. Optional item pagination direction; defaults to ascending.ThreadTurnsItemsListParamsAccountUpdatedNotification
adddeleteupdatestruct Settings with 3 elementsstruct LocalShellExecAction with 5 elementsstruct variant ReasoningItemContent::Text with 1 elementstruct variant ReasoningItemContent::ReasoningText with 1 elementvariant index 0 <= i < 1variant index 0 <= i < 5struct variant AgentMessageInputContent::EncryptedContent with 1 elementcmdstruct variant ParsedCommand::ListFiles with 2 elementsstruct variant ParsedCommand::Search with 3 elementsstruct variant ParsedCommand::Unknown with 1 elementstruct variant ParsedCommand::Read with 3 elementsstruct NetworkPolicyAmendment with 2 elementsstruct CollaborationMode with 2 elementsstruct variant FunctionCallOutputContentItem::InputImage with 2 elementsstruct variant FunctionCallOutputContentItem::EncryptedContent with 1 elementstruct variant FunctionCallOutputContentItem::InputText with 1 elementstruct variant ReasoningItemReasoningSummary::SummaryText with 1 elementlist_filesa mapstruct ClientInfofield identifierstruct JSONRPCErrorstruct JSONRPCRequeststruct JSONRPCResponsestruct InitializeParamsstruct JSONRPCErrorErrorstruct InitializeResponsestruct JSONRPCNotificationstruct GetAuthStatusParamsstruct AppInfologoUrllogoUrlDarkdistributionChannelappMetadatalabelsinstallUrlisAccessibleisEnabledpluginDisplayNamesstruct AppInfo with 13 elementsstruct Modelstruct FsCopyParamsapikeychatgptAuthTokensagentIdentitypersonalAccessTokenvariant identifierstruct variant ClientRequest::FsCreateDirectorystruct variant ClientRequest::MarketplaceAddstruct variant ClientRequest::PluginReadstruct variant ClientRequest::MemoryResetstruct variant ClientRequest::GetAccountTokenUsagestruct variant ClientRequest::ProcessKillstruct variant ClientRequest::ThreadGoalGetstruct variant ClientRequest::ReviewStartstruct variant ClientRequest::TurnStartstruct variant ClientRequest::AppsListstruct variant ClientRequest::PluginUninstallstruct variant ClientRequest::ThreadInjectItemsstruct variant ClientRequest::ThreadTurnsListstruct variant ClientRequest::SendAddCreditsNudgeEmailstruct variant ClientRequest::ThreadRealtimeAppendTextstruct variant ClientRequest::McpResourceReadstruct variant ClientRequest::GetAccountstruct variant ClientRequest::McpServerOauthLoginstruct variant ClientRequest::FsReadFilestruct variant ClientRequest::FuzzyFileSearchstruct variant ClientRequest::PluginSkillReadstruct variant ClientRequest::McpServerStatusListstruct variant ClientRequest::ThreadResumestruct variant ClientRequest::SkillsExtraRootsSetstruct variant ClientRequest::FsCopystruct variant ClientRequest::RemoteControlPairingStatusstruct variant ClientRequest::ProcessSpawnstruct variant ClientRequest::ThreadIncrementElicitationstruct variant ClientRequest::PluginListstruct variant ClientRequest::TurnSteerstruct variant ClientRequest::MarketplaceUpgradestruct variant ClientRequest::FsWatchstruct variant ClientRequest::ModelProviderCapabilitiesReadstruct variant ClientRequest::FsWriteFilestruct variant ClientRequest::TurnInterruptstruct variant ClientRequest::ThreadRealtimeStopstruct variant ClientRequest::ThreadDecrementElicitationstruct variant ClientRequest::ProcessWriteStdinstruct variant ClientRequest::FeedbackUploadstruct variant ClientRequest::ThreadShellCommandstruct variant ClientRequest::SkillsConfigWritestruct variant ClientRequest::FuzzyFileSearchSessionUpdatestruct variant ClientRequest::MockExperimentalMethodstruct variant ClientRequest::FsGetMetadatastruct variant ClientRequest::CommandExecTerminatestruct variant ClientRequest::ThreadApproveGuardianDeniedActionstruct variant ClientRequest::GetConversationSummarystruct variant ClientRequest::FsRemovestruct variant ClientRequest::ThreadUnarchivestruct variant ClientRequest::ExperimentalFeatureEnablementSetstruct variant ClientRequest::ConfigReadstruct variant ClientRequest::LoginAccountstruct variant ClientRequest::ThreadGoalClearstruct variant ClientRequest::RemoteControlPairingStartstruct variant ClientRequest::ConfigValueWritestruct variant ClientRequest::ThreadForkstruct variant ClientRequest::GetAccountRateLimitsstruct variant ClientRequest::RemoteControlDisablestruct variant ClientRequest::PluginShareListstruct variant ClientRequest::PluginInstallstruct variant ClientRequest::ThreadRollbackstruct variant ClientRequest::SkillsListstruct variant ClientRequest::ThreadSetNamestruct variant ClientRequest::GetAuthStatusstruct variant ClientRequest::PermissionProfileListstruct variant ClientRequest::ThreadRealtimeListVoicesstruct variant ClientRequest::GitDiffToRemotestruct variant ClientRequest::CancelLoginAccountstruct variant ClientRequest::OneOffCommandExecstruct variant ClientRequest::ThreadSearchstruct variant ClientRequest::ThreadTurnsItemsListstruct variant ClientRequest::HooksListstruct variant ClientRequest::CollaborationModeListstruct variant ClientRequest::FsUnwatchstruct variant ClientRequest::RemoteControlClientsRevokestruct variant ClientRequest::RemoteControlStatusReadstruct variant ClientRequest::EnvironmentAddstruct variant ClientRequest::CommandExecResizestruct variant ClientRequest::ProcessResizePtystruct variant ClientRequest::PluginShareCheckoutstruct variant ClientRequest::PluginShareDeletestruct variant ClientRequest::CommandExecWritestruct variant ClientRequest::ConfigRequirementsReadstruct variant ClientRequest::FsReadDirectorystruct variant ClientRequest::ExperimentalFeatureListstruct variant ClientRequest::ThreadCompactStartstruct variant ClientRequest::MarketplaceRemovestruct variant ClientRequest::ThreadRealtimeAppendAudiostruct variant ClientRequest::Initializestruct variant ClientRequest::ExternalAgentConfigDetectstruct variant ClientRequest::ExternalAgentConfigImportstruct variant ClientRequest::ThreadSettingsUpdatestruct variant ClientRequest::ThreadMetadataUpdatestruct variant ClientRequest::ThreadUnsubscribestruct variant ClientRequest::McpServerToolCallstruct variant ClientRequest::PluginShareUpdateTargetsstruct variant ClientRequest::ThreadListstruct variant ClientRequest::ThreadRealtimeStartstruct variant ClientRequest::ThreadMemoryModeSetstruct variant ClientRequest::ModelListstruct variant ClientRequest::McpServerRefreshstruct variant ClientRequest::FuzzyFileSearchSessionStopstruct variant ClientRequest::ConfigBatchWritestruct variant ClientRequest::ThreadArchivestruct variant ClientRequest::RemoteControlClientsListstruct variant ClientRequest::ThreadGoalSetstruct variant ClientRequest::PluginInstalledstruct variant ClientRequest::ThreadBackgroundTerminalsCleanstruct variant ClientRequest::FuzzyFileSearchSessionStartstruct variant ClientRequest::WindowsSandboxReadinessstruct variant ClientRequest::WindowsSandboxSetupStartstruct variant ClientRequest::LogoutAccountstruct variant ClientRequest::PluginShareSavestruct variant ClientRequest::ThreadReadstruct variant ClientRequest::ThreadLoadedListstruct variant ClientRequest::ThreadStartstruct variant ClientRequest::RemoteControlEnablestruct variant ServerRequest::AttestationGeneratestruct variant ServerRequest::CommandExecutionRequestApprovalstruct variant ServerRequest::FileChangeRequestApprovalstruct variant ServerRequest::ChatgptAuthTokensRefreshstruct variant ServerRequest::ToolRequestUserInputstruct variant ServerRequest::McpServerElicitationRequeststruct variant ServerRequest::PermissionsRequestApprovalstruct variant ServerRequest::DynamicToolCallstruct variant ServerRequest::ApplyPatchApprovalstruct variant ServerRequest::ExecCommandApprovalparamsstruct variant ServerRequest::McpServerElicitationRequest with 2 elementsstruct variant ServerRequest::AttestationGenerate with 2 elementsstruct variant ServerRequest::DynamicToolCall with 2 elementsstruct variant ServerRequest::ApplyPatchApproval with 2 elementsstruct variant ServerRequest::CommandExecutionRequestApproval with 2 elementsstruct variant ServerRequest::PermissionsRequestApproval with 2 elementsstruct variant ServerRequest::FileChangeRequestApproval with 2 elementsstruct variant ServerRequest::ToolRequestUserInput with 2 elementsstruct variant ServerRequest::ChatgptAuthTokensRefresh with 2 elementsstruct variant ServerRequest::ExecCommandApproval with 2 elementsstruct GitDiffToRemoteParamsstruct AppReviewstruct AppReview with 1 elementstruct FsWatchParamsstruct ByteRangestartendstruct ByteRange with 2 elementsstruct variant UserInput::Skillstruct variant UserInput::Imagestruct variant UserInput::LocalImagestruct variant UserInput::Mentionstruct variant UserInput::Texttext_elementsstruct variant UserInput::Mention with 2 elementsstruct variant UserInput::Skill with 2 elementsstruct variant UserInput::LocalImage with 2 elementsstruct variant UserInput::Text with 2 elementsstruct variant UserInput::Image with 2 elementsstruct InitializeCapabilitiesstruct AppSummarystruct Configstruct FsRemoveParamsstruct variant ThreadItem::McpToolCallstruct variant ThreadItem::Planstruct variant ThreadItem::FileChangestruct variant ThreadItem::ImageViewstruct variant ThreadItem::EnteredReviewModestruct variant ThreadItem::ContextCompactionstruct variant ThreadItem::ExitedReviewModestruct variant ThreadItem::ImageGenerationstruct variant ThreadItem::UserMessagestruct variant ThreadItem::CollabAgentToolCallstruct variant ThreadItem::AgentMessagestruct variant ThreadItem::CommandExecutionstruct variant ThreadItem::Reasoningstruct variant ThreadItem::DynamicToolCallstruct variant ThreadItem::HookPromptstruct variant ThreadItem::WebSearchservermcpAppResourceUridurationMsrevisedPromptsavedPathchangesmemoryCitationcwdprocessIdsourcecommandActionssenderThreadIdreceiverThreadIdspromptreasoningEffortagentsStatesfragmentscontentItemssuccessstruct variant ThreadItem::Reasoning with 3 elementsstruct variant ThreadItem::Plan with 2 elementsstruct variant ThreadItem::DynamicToolCall with 8 elementsstruct variant ThreadItem::UserMessage with 3 elementsstruct variant ThreadItem::ContextCompaction with 1 elementstruct variant ThreadItem::ImageView with 2 elementsstruct variant ThreadItem::CommandExecution with 10 elementsstruct variant ThreadItem::HookPrompt with 2 elementsstruct variant ThreadItem::CollabAgentToolCall with 9 elementsstruct variant ThreadItem::ExitedReviewMode with 2 elementsstruct variant ThreadItem::McpToolCall with 10 elementsstruct variant ThreadItem::WebSearch with 3 elementsstruct variant ThreadItem::ImageGeneration with 5 elementsstruct variant ThreadItem::EnteredReviewMode with 2 elementsstruct variant ThreadItem::AgentMessage with 4 elementsstruct variant ThreadItem::FileChange with 3 elementsstruct AppBrandingdeveloperwebsiteprivacyPolicytermsOfServiceisDiscoverableAppstruct AppBranding with 6 elementsstruct AppMetadatacategoriessubCategoriesseoDescriptionscreenshotsversionIdversionNotesfirstPartyTypefirstPartyRequiresInstallshowInComposerWhenUnlinkedstruct AppMetadata with 12 elementsstruct ToolsV2struct FsUnwatchParamsstruct TextElementbyteRangeplaceholderstruct TextElement with 2 elementsstruct ApplyPatchApprovalParamsconversationIdcallIdfileChangesreasongrantRootstruct ApplyPatchApprovalParams with 5 elementsstruct FsReadFileParamsstruct TurnPlanStepstruct TurnPlanStep with 2 elementsstruct ExecCommandApprovalParamsapprovalIdparsedCmdstruct ExecCommandApprovalParams with 7 elementsstruct variant Account::Chatgptstruct variant Account::AmazonBedrockstruct variant Account::ApiKeystruct AppScreenshotfileIduserPromptstruct AppScreenshot with 3 elementsstruct AppConfigstruct TextRange with 2 elementsstruct FsWriteFileParamsstruct variant CommandAction::Searchstruct variant CommandAction::Unknownstruct variant CommandAction::Readstruct variant CommandAction::ListFilesstruct variant CommandAction::Unknown with 1 elementstruct variant CommandAction::Read with 3 elementsstruct variant CommandAction::Search with 3 elementsstruct variant CommandAction::ListFiles with 2 elementsstruct McpServerStatusstruct TurnsPageadjacently tagged enum ServerNotificationmethodServerNotificationitem/commandExecution/requestApprovalitem/fileChange/requestApprovalitem/tool/requestUserInputmcpServer/elicitation/requestitem/permissions/requestApprovalitem/tool/callaccount/chatgptAuthTokens/refreshattestation/generateapplyPatchApprovalexecCommandApprovalstruct ApplyPatchApprovalResponsestruct ApplyPatchApprovalResponse with 1 elementstruct AppsListParamsstruct AppsConfigstruct ConfigEditstruct HookRunSummaryeventNamehandlerTypeexecutionModescopesourcePathdisplayOrderstatusMessagestartedAtcompletedAtentriesstruct HookRunSummary with 14 elementsthreadstruct MemoryCitationthreadIdsstruct MemoryCitation with 2 elementsstruct McpToolCallErrorstruct McpToolCallError with 1 elementstruct ThreadGoalobjectivetokenBudgettokensUsedtimeUsedSecondscreatedAtupdatedAtstruct ThreadGoal with 8 elementslocalImageskillmentionstruct ExecCommandApprovalResponsestruct ExecCommandApprovalResponse with 1 elementstruct ConfigLayerstruct FsGetMetadataParamsstruct HookOutputEntrystruct HookOutputEntry with 2 elementssystemprojectmdmsessionFlagsplugincloudRequirementscloudManagedConfiglegacyManagedConfigFilelegacyManagedConfigMdmvariant index 0 <= i < 11struct variant PatchChangeKind::Updatestruct variant PatchChangeKind::Update with 1 elementuserMessagehookPromptagentMessagefileChangemcpToolCalldynamicToolCallcollabAgentToolCallwebSearchimageViewimageGenerationenteredReviewModecontextCompactionvariant index 0 <= i < 16struct variant WebSearchAction::OpenPagestruct variant WebSearchAction::FindInPagestruct variant WebSearchAction::Searchstruct variant WebSearchAction::FindInPage with 2 elementsstruct variant WebSearchAction::OpenPage with 1 elementstruct variant WebSearchAction::Search with 2 elementsstruct McpToolCallResultstructuredContentstruct McpToolCallResult with 3 elementsstruct TurnStartParamsfailedinProgressstruct TurnSteerParamsstruct variant GetConversationSummaryParams::ThreadIdstruct variant GetConversationSummaryParams::RolloutPathstruct AppsListResponsestruct TextPositioncolumnstruct TextPosition with 2 elementsstruct CollabAgentStatestruct CollabAgentState with 2 elementsstruct FileUpdateChangestruct FileUpdateChange with 3 elementsstruct HookMetadatastruct PluginDetailstruct variant PluginSource::Gitstruct variant PluginSource::Localstruct SkillSummarystruct variant ReviewTarget::Commitstruct variant ReviewTarget::Customstruct variant ReviewTarget::BaseBranchstruct variant ThreadStatus::ActiveactiveFlagsstruct variant ThreadStatus::Active with 1 elementstruct FuzzyFileSearchParamsstruct FuzzyFileSearchResultmatch_typefile_namescoreindicesstruct FuzzyFileSearchResult with 6 elementsstruct AppToolConfigstruct HookMigrationstruct FsChangedNotificationwatchIdchangedPathsstruct FsChangedNotification with 2 elementsstruct FsReadDirectoryParamsstruct ModelListParamsstruct HookErrorInfostruct PluginSummarystruct SkillMetadatastruct TurnStartResponsestruct TurnSteerResponse
struct AppToolsConfigpreToolUsepermissionRequestpostToolUsepreCompactpostCompactsessionStartsubagentStartsubagentStopvariant index 0 <= i < 10runningblockedstoppedlistFilesstruct HookPromptFragmenthookRunIdstruct HookPromptFragment with 2 elementsstruct McpElicitationSchema$schemapropertiesstruct McpElicitationSchema with 4 elementsstruct ModelServiceTierstruct ModelUpgradeInfostruct HooksListEntrystruct SkillErrorInfostruct SkillInterfacerulesskill_approvalrequest_permissionshttpStatusCodestruct ThreadSettingsapprovalPolicyapprovalsReviewersandboxPolicyactivePermissionProfilemodelProviderserviceTiereffortcollaborationModepersonalitystruct ThreadSettings with 12 elementsstruct TurnitemsitemsViewstruct Turn with 8 elementsstruct AnalyticsConfigstruct FsCreateDirectoryParamsstruct MemoryCitationEntrylineStartlineEndstruct MemoryCitationEntry with 4 elementsstruct McpResourceReadParamsstruct ModelListResponsestruct HooksListParamsstruct PluginInterfacestruct SkillsListEntrystruct TurnInterruptParamsstruct CommandMigrationstruct ConfigReadParamsstruct MigrationDetailsstruct PluginsMigrationstruct SessionMigrationagentspawnAgentsendInputresumeAgentcloseAgentfindInPagestruct PluginListParamsstruct PluginReadParamsstruct SkillsListParamsstruct ThreadForkParamsstruct ThreadListParamsstruct ThreadReadParamsstruct ThreadTokenUsagemodelContextWindowstruct ThreadTokenUsage with 3 elementsstruct ThreadsessionIdforkedFromIdparentThreadIdpreviewephemeralcliVersionthreadSourceagentNicknameagentRolegitInfoturnsstruct Thread with 20 elementsstruct CreditsSnapshothasCreditsunlimitedbalancestruct CreditsSnapshot with 3 elementsstruct RateLimitWindowusedPercentwindowDurationMinsstruct RateLimitWindow with 3 elementsstruct AppsDefaultConfigstruct variant ConfigLayerSource::Mdmstruct variant ConfigLayerSource::EnterpriseManagedstruct variant ConfigLayerSource::LegacyManagedConfigTomlFromFilestruct variant ConfigLayerSource::Systemstruct variant ConfigLayerSource::Userstruct variant ConfigLayerSource::Projectstruct SubagentMigrationstruct DynamicToolCallParamsturnIdstruct DynamicToolCallParams with 6 elementsstruct PlanDeltaNotificationitemIddeltastruct PlanDeltaNotification with 4 elementsstruct McpResourceReadResponsestruct McpServerToolCallParamsstruct HooksListResponsestruct PluginHookSummarystruct PluginShareTargetstruct SkillDependenciesstruct ReviewStartParamsstruct DynamicToolSpecDestruct ThreadStartParamsnotLoadedsystemErroractivestruct GitInfoshabranchoriginUrlstruct GitInfo with 3 elementsstruct TurnEnvironmentParamsstruct TurnInterruptResponsestruct GetAccountParamsstruct ConfigReadResponsestruct McpServerMigrationstruct OverriddenMetadataasyncpendingIniterroredvariant index 0 <= i < 7struct GuardianApprovalReviewriskLeveluserAuthorizationrationalestruct GuardianApprovalReview with 4 elementsstruct ModelAvailabilityNuxstruct AppTemplateSummarystruct PluginListResponsestruct PluginReadResponsestruct PluginShareContextstruct SkillsListResponsestruct ThreadForkResponsestruct ThreadListResponsestruct ThreadReadResponsestruct ThreadResumeParamsstruct ThreadSearchParamsstruct AdditionalContextEntrystruct RateLimitSnapshotlimitIdlimitNameprimarysecondarycreditsindividualLimitrateLimitReachedTypestruct RateLimitSnapshot with 8 elementsstruct ConfigLayerMetadatastruct ConfigWriteResponsestruct HookStartedNotificationrunstruct HookStartedNotification with 3 elementsstruct DynamicToolCallResponsestruct DynamicToolCallResponse with 2 elementsstruct ItemStartedNotificationstartedAtMsstruct ItemStartedNotification with 4 elementsstruct ListMcpServerStatusParamsstruct McpElicitationConstOptionconststruct McpElicitationConstOption with 2 elementsfield index 0 <= i < 4struct McpServerOauthLoginParamsstruct ReasoningEffortOptionstruct PluginInstallParamsstruct SkillToolDependencystruct ProcessKillParamsstruct ReviewStartResponseuntrustedon-failureon-requestnevercontextWindowExceededusageLimitExceededcyberPolicyhttpConnectionFailedresponseStreamConnectionFailedinternalServerErrorunauthorizedbadRequestthreadRollbackFailedsandboxErrorresponseStreamDisconnectedresponseTooManyFailedAttemptsactiveTurnNotSteerablevariant index 0 <= i < 15struct MemoryResetResponsestruct ThreadArchiveParamsstruct ThreadGoalGetParamsstruct ThreadGoalSetParamsstruct ThreadSetNameParamsstruct ThreadStartResponsestruct TokenUsageBreakdowntotalTokensinputTokenscachedInputTokensoutputTokensreasoningOutputTokensstruct TokenUsageBreakdown with 5 elementsstruct TurnErrorcodexErrorInfoadditionalDetailsstruct TurnError with 3 elementspendingstruct TurnStartedNotificationstruct TurnStartedNotification with 2 elementsstruct GetAccountResponsestruct variant LoginAccountParams::ApiKeystruct variant LoginAccountParams::ChatgptAuthTokensstruct variant LoginAccountParams::Chatgptcontextstruct McpElicitationNumberSchemaminimummaximumstruct McpElicitationNumberSchema with 6 elementsstruct McpElicitationStringSchemaminLengthmaxLengthformatstruct McpElicitationStringSchema with 7 elementsreadycancelledtrustedAccessForCyberstruct MarketplaceAddParamsstruct MarketplaceInterfacestruct PluginSharePrincipalstruct ProcessSpawnParamsstruct ThreadResumeResponsestruct ThreadRollbackParamsdirectorystruct SandboxWorkspaceWritestruct HookCompletedNotificationstruct HookCompletedNotification with 3 elementsstruct ItemCompletedNotificationcompletedAtMsstruct ItemCompletedNotification with 4 elementsstruct ListMcpServerStatusResponsestruct McpElicitationBooleanSchemastruct McpElicitationBooleanSchema with 4 elementsrequestedSchemaelicitationIdhighRiskCyberActivitystruct PluginInstallResponsestruct PluginInstalledParamsstruct PluginShareListParamsstruct PluginShareSaveParamsstruct PluginSkillReadParamsstruct PluginUninstallParamsstruct ProcessTerminalSizewaitingOnApprovalwaitingOnUserInputstruct ThreadArchiveResponsestruct ThreadGoalClearParamsstruct ThreadGoalGetResponsestruct ThreadGoalSetResponsepausedusageLimitedbudgetLimitedvariant index 0 <= i < 6struct ThreadSetNameResponsestruct ThreadTurnsListParamsstruct ThreadUnarchiveParamsstruct TurnCompletedNotificationstruct TurnCompletedNotification with 2 elementsstruct variant LoginAccountResponse::ChatgptDeviceCodestruct variant LoginAccountResponse::Chatgptstruct variant LoginAccountResponse::ChatgptAuthTokensstruct variant LoginAccountResponse::ApiKeystruct AppListUpdatedNotificationstruct AppListUpdatedNotification with 1 elementstruct ConfigBatchWriteParamsstruct ConfigValueWriteParamsshellunifiedExecstruct ToolRequestUserInputAnsweranswersstruct ToolRequestUserInputAnswer with 1 elementstruct ToolRequestUserInputOptionlabelstruct ToolRequestUserInputOption with 2 elementsstruct ToolRequestUserInputParamsquestionsstruct ToolRequestUserInputParams with 4 elementsarraystruct MarketplaceAddResponsestruct PluginMarketplaceEntrystruct ThreadLoadedListParamsstruct ThreadRollbackResponsestruct LogoutAccountResponseuserShellunifiedExecStartupunifiedExecInteractionnumberintegerobjectstringstruct McpElicitationTitledEnumItemsanyOfstruct McpElicitationTitledEnumItems with 1 elementstruct ModelReroutedNotificationfromModeltoModelstruct ModelReroutedNotification with 5 elementsstruct MarketplaceRemoveParamsstruct PluginShareDeleteParamsstruct PluginUninstallResponsestruct SkillsConfigWriteParamsstruct ThreadGoalClearResponsestruct ThreadInjectItemsParamsstruct ThreadUnarchiveResponsestruct ThreadUnsubscribeParamsstruct TurnDiffUpdatedNotificationstruct TurnDiffUpdatedNotification with 3 elementsstruct TurnPlanUpdatedNotificationexplanationstruct TurnPlanUpdatedNotification with 4 elementsstruct FuzzyFileSearchSessionStopParamsstruct FeedbackUploadParamsstruct variant GuardianApprovalReviewAction::McpToolCallstruct variant GuardianApprovalReviewAction::NetworkAccessstruct variant GuardianApprovalReviewAction::ApplyPatchstruct variant GuardianApprovalReviewAction::RequestPermissionsstruct variant GuardianApprovalReviewAction::Execvestruct variant GuardianApprovalReviewAction::CommandpermissionsconnectorIdconnectorNametoolTitlefilesprogramtargetstruct variant GuardianApprovalReviewAction::RequestPermissions with 2 elementsstruct variant GuardianApprovalReviewAction::ApplyPatch with 2 elementsstruct variant GuardianApprovalReviewAction::Execve with 4 elementsstruct variant GuardianApprovalReviewAction::NetworkAccess with 4 elementsstruct variant GuardianApprovalReviewAction::McpToolCall with 5 elementsstruct variant GuardianApprovalReviewAction::Command with 3 elementsstruct ToolRequestUserInputQuestionheaderisOtheroptionsstruct ToolRequestUserInputQuestion with 6 elementsstruct ToolRequestUserInputResponsestruct ToolRequestUserInputResponse with 1 elementbooleanfield index 0 <= i < 2struct variant FileSystemPath::Specialstruct variant FileSystemPath::Pathstruct variant FileSystemPath::GlobPatternvaluestruct variant FileSystemPath::Special with 1 elementstruct variant FileSystemPath::GlobPattern with 1 elementstruct variant FileSystemPath::Path with 1 elementstruct MarketplaceLoadErrorInfostruct MarketplaceUpgradeParamsstruct ProcessResizePtyParamsstruct ThreadClosedNotificationstruct ThreadClosedNotification with 1 elementstruct ThreadCompactStartParamsstruct ThreadLoadedListResponsestruct ThreadShellCommandParamsstruct FuzzyFileSearchSessionStartParamsstruct ConfigWarningNotificationdetailsrangestruct ConfigWarningNotification with 4 elementsstruct AgentMessageDeltaNotificationstruct AgentMessageDeltaNotification with 4 elementsfield index 0 <= i < 6emaildate-timefield index 0 <= i < 7struct McpElicitationUntitledEnumItemsstruct McpElicitationUntitledEnumItems with 2 elementsacceptdeclinecancelstruct McpToolCallProgressNotificationstruct McpToolCallProgressNotification with 4 elementsstruct MarketplaceRemoveResponsestruct PluginShareCheckoutParamsstruct SkillsChangedNotificationstruct SkillsConfigWriteResponsestruct SkillsExtraRootsSetParamsstruct ProcessWriteStdinParamsstruct ThreadInjectItemsResponsestruct ThreadMemoryModeSetParamsstruct ThreadStartedNotificationstruct ThreadStartedNotification with 1 elementstruct ThreadUnsubscribeResponsestruct FuzzyFileSearchSessionUpdateParamsstruct CancelLoginAccountParamsstruct FeedbackUploadResponsestruct ReasoningTextDeltaNotificationcontentIndexstruct ReasoningTextDeltaNotification with 5 elementsstruct MarketplaceUpgradeResponsestdoutstderrstruct ThreadArchivedNotificationstruct ThreadArchivedNotification with 1 elementstruct ThreadCompactStartResponsestruct ThreadMetadataUpdateParamsstruct ThreadSettingsUpdateParamsstruct ThreadShellCommandResponsestruct ThreadTurnsItemsListParamsrate_limit_reachedworkspace_owner_credits_depletedworkspace_member_credits_depletedworkspace_owner_usage_limit_reachedworkspace_member_usage_limit_reachedstruct SpendControlLimitSnapshotlimitstruct SpendControlLimitSnapshot with 4 elementsstruct FileChangeRequestApprovalParamsstruct FileChangeRequestApprovalParams with 6 elementsstruct TerminalInteractionNotificationstdinstruct TerminalInteractionNotification with 5 elementsstruct McpServerElicitationRequestParamsserverNamestruct ModelVerificationNotificationverificationsstruct ModelVerificationNotification with 3 elementsstruct MarketplaceUpgradeErrorInfostruct ProcessExitedNotificationprocessHandlestruct ProcessExitedNotification with 6 elementsstruct ThreadMemoryModeSetResponsestruct AccountUpdatedNotificationstruct AccountUpdatedNotification with 2 elementsstruct CancelLoginAccountResponseexecpolicy_amendmentstruct variant DynamicToolCallOutputContentItem::InputImagestruct variant DynamicToolCallOutputContentItem::InputTextstruct variant DynamicToolCallOutputContentItem::InputText with 1 elementstruct variant DynamicToolCallOutputContentItem::InputImage with 1 elementoneOffield index 0 <= i < 1struct McpServerStatusUpdatedNotificationstruct McpServerStatusUpdatedNotification with 4 elementsrestrictedenabledstruct ThreadRealtimeAudioChunksampleRatenumChannelssamplesPerChannelstruct ThreadRealtimeAudioChunk with 5 elementsstruct ThreadRealtimeStopParamsstruct ContextCompactedNotificationstruct ContextCompactedNotification with 2 elementsstruct MockExperimentalMethodParamsstruct ThreadMetadataUpdateResponsestruct ThreadSettingsUpdateResponsestruct ThreadUnarchivedNotificationstruct ThreadUnarchivedNotification with 1 elementappServerstruct CommandExecParamsstruct FileChangeOutputDeltaNotificationstruct FileChangeOutputDeltaNotification with 4 elementsstruct FileChangeRequestApprovalResponsestruct FileChangeRequestApprovalResponse with 1 elementexecveapplyPatchnetworkAccessrequestPermissionsabortedstruct McpServerElicitationRequestResponsestruct McpServerElicitationRequestResponse with 3 elementsstruct ErrorNotificationwillRetrystruct ErrorNotification with 4 elementsglob_patternspecialstruct ThreadRealtimeStartParamsstruct ThreadGoalClearedNotificationstruct ThreadGoalClearedNotification with 1 elementstruct ThreadGoalUpdatedNotificationstruct ThreadGoalUpdatedNotification with 3 elementsstruct ThreadNameUpdatedNotificationthreadNamestruct ThreadNameUpdatedNotification with 2 elementsstruct GetAccountRateLimitsResponsestruct EnvironmentAddParamsstruct FileChangePatchUpdatedNotificationstruct FileChangePatchUpdatedNotification with 4 elementsstruct McpElicitationLegacyTitledEnumSchemaenumNamesstruct McpElicitationLegacyTitledEnumSchema with 6 elementsstruct PluginShareUpdateTargetsParamsstruct ThreadRealtimeStopResponsestruct CommandExecResponsestruct ExternalAgentConfigDetectParamsstruct ExternalAgentConfigImportParamsstruct WarningNotificationstruct WarningNotification with 2 elementsstruct variant FileSystemSpecialPath::ProjectRootsstruct variant FileSystemSpecialPath::Unknownsubpathstruct variant FileSystemSpecialPath::Unknown with 2 elementsstruct variant FileSystemSpecialPath::ProjectRoots with 1 elementstruct ThreadRealtimeStartResponsestruct ThreadStatusChangedNotificationstruct ThreadStatusChangedNotification with 2 elementsstruct ChatgptAuthTokensRefreshParamspreviousAccountIdstruct ChatgptAuthTokensRefreshParams with 2 elementsstruct SendAddCreditsNudgeEmailParamsstruct ExternalAgentConfigMigrationItemstruct RawResponseItemCompletedNotificationstruct RawResponseItemCompletedNotification with 3 elementsstruct TurnModerationMetadataNotificationstruct TurnModerationMetadataNotification with 3 elementsstruct FileSystemSandboxEntryaccessstruct FileSystemSandboxEntry with 2 elementsstruct NetworkApprovalContextstruct NetworkApprovalContext with 2 elementsstruct NetworkPolicyAmendmentstruct ProcessOutputDeltaNotificationstreamdeltaBase64capReachedstruct ProcessOutputDeltaNotification with 4 elementsstruct variant ThreadRealtimeStartTransport::Webrtcstruct ThreadDecrementElicitationParamsstruct ThreadIncrementElicitationParamsstruct FuzzyFileSearchSessionUpdatedNotificationstruct FuzzyFileSearchSessionUpdatedNotification with 3 elementsstruct ExternalAgentConfigDetectResponsestruct ExternalAgentConfigImportResponseacceptWithExecpolicyAmendmentapplyNetworkPolicyAmendmentstruct CommandExecutionRequestApprovalParamsnetworkApprovalContextadditionalPermissionsproposedExecpolicyAmendmentproposedNetworkPolicyAmendmentsavailableDecisionsstruct CommandExecutionRequestApprovalParams with 14 elementsinputTextinputImagestruct ReasoningSummaryPartAddedNotificationsummaryIndexstruct ReasoningSummaryPartAddedNotification with 4 elementsstruct ReasoningSummaryTextDeltaNotificationstruct ReasoningSummaryTextDeltaNotification with 5 elementsstruct ModelProviderCapabilitiesReadParamsstruct ActivePermissionProfileextendsstruct ActivePermissionProfile with 2 elementsstruct ThreadRealtimeSdpNotificationsdpstruct ThreadRealtimeSdpNotification with 2 elementsstruct ThreadMetadataGitInfoUpdateParamsstruct ThreadSettingsUpdatedNotificationthreadSettingsstruct ThreadSettingsUpdatedNotification with 2 elementsRequestIdcodex_app_server_protocol::jsonrpc_lite::RequestIdA response to a request that indicates an error occurred.JSONRPCErrorcodex_app_server_protocol::jsonrpc_lite::JSONRPCErrorRefers to any valid JSON-RPC object that can be decoded off the wire, or encoded to be sent.JSONRPCMessagecodex_app_server_protocol::jsonrpc_lite::JSONRPCMessageOptional W3C Trace Context for distributed tracing.traceA request that expects a response.JSONRPCRequestcodex_app_server_protocol::jsonrpc_lite::JSONRPCRequestA successful (non-error) response to a request.JSONRPCResponsecodex_app_server_protocol::jsonrpc_lite::JSONRPCResponsedata did not match any variant of untagged enum RequestIdJSONRPCErrorErrorcodex_app_server_protocol::jsonrpc_lite::JSONRPCErrorErrorA notification which does not expect a response.JSONRPCNotificationcodex_app_server_protocol::jsonrpc_lite::JSONRPCNotificationts// GENERATED CODE! DO NOT MODIFY BY HAND!
SkillScopecodex_app_server_protocol::protocol::v2::plugin::SkillScopeisManagedcurrentHashtrustStatusHookMetadatacodex_app_server_protocol::protocol::v2::plugin::HookMetadatamarketplacePathskillsappTemplatesPluginDetailcodex_app_server_protocol::protocol::v2::plugin::PluginDetaillocalgitrefNameremoteThe plugin is available in the remote catalog. Download metadata is kept server-side and is not exposed through the app-server API.PluginSourcecodex_app_server_protocol::protocol::v2::plugin::PluginSourceinterfaceSkillSummarycodex_app_server_protocol::protocol::v2::plugin::SkillSummaryHookErrorInfocodex_app_server_protocol::protocol::v2::plugin::HookErrorInfoBackend remote plugin identifier when available.remotePluginIdVersion of the locally materialized plugin package when available.localVersionRemote sharing context associated with this plugin when available.shareContextinstalledinstallPolicyauthPolicyAvailability state for installing and using the plugin.availabilityPluginSummarycodex_app_server_protocol::protocol::v2::plugin::PluginSummaryLegacy short_description from SKILL.md. Prefer SKILL.json interface.short_description.dependenciesSkillMetadatacodex_app_server_protocol::protocol::v2::plugin::SkillMetadataerrorsHooksListEntrycodex_app_server_protocol::protocol::v2::plugin::HooksListEntrySkillErrorInfocodex_app_server_protocol::protocol::v2::plugin::SkillErrorInfoiconSmalliconLargebrandColordefaultPromptSkillInterfacecodex_app_server_protocol::protocol::v2::plugin::SkillInterfaceWhen empty, defaults to the current session working directory.HooksListParamscodex_app_server_protocol::protocol::v2::plugin::HooksListParamslongDescriptiondeveloperNametermsOfServiceUrlStarter prompts for the plugin. Capped at 3 entries with a maximum of 128 characters per entry.Local composer icon path, resolved from the installed plugin package.composerIconRemote composer icon URL from the plugin catalog.composerIconUrlLocal logo path, resolved from the installed plugin package.Remote logo URL from the plugin catalog.Local screenshot paths, resolved from the installed plugin package.Remote screenshot URLs from the plugin catalog.screenshotUrlsPluginInterfacecodex_app_server_protocol::protocol::v2::plugin::PluginInterfaceSkillsListEntrycodex_app_server_protocol::protocol::v2::plugin::SkillsListEntryON_INSTALL
codex_app_server_protocol::protocol::v2::plugin::PluginAuthPolicyOptional working directories used to discover repo marketplaces. When omitted, only home-scoped marketplaces and the official curated marketplace are considered.Optional marketplace kind filter. When omitted, only local marketplaces are queried, plus the default remote catalog when enabled by feature flag.codex_app_server_protocol::protocol::v2::plugin::PluginListParamsremoteMarketplaceNamepluginNamecodex_app_server_protocol::protocol::v2::plugin::PluginReadParamsWhen true, bypass the skills cache and re-scan skills from disk.forceReloadcodex_app_server_protocol::protocol::v2::plugin::SkillsListParamsHooksListResponsecodex_app_server_protocol::protocol::v2::plugin::HooksListResponsePluginHookSummarycodex_app_server_protocol::protocol::v2::plugin::PluginHookSummaryprincipalTypeprincipalIdPluginShareTargetcodex_app_server_protocol::protocol::v2::plugin::PluginShareTargetSkillDependenciescodex_app_server_protocol::protocol::v2::plugin::SkillDependenciestemplateIdcanonicalConnectorIdmaterializedAppIdsAppTemplateSummarycodex_app_server_protocol::protocol::v2::plugin::AppTemplateSummaryDISABLED_BY_ADMINAVAILABLEPlugin-service currently sends `"ENABLED"` for available remote plugins. Codex app-server exposes `"AVAILABLE"` in its API; the alias keeps decoding compatible with that upstream response.PluginAvailabilitycodex_app_server_protocol::protocol::v2::plugin::PluginAvailabilitymarketplacesmarketplaceLoadErrorsfeaturedPluginIdsPluginListResponsecodex_app_server_protocol::protocol::v2::plugin::PluginListResponsePluginReadResponsecodex_app_server_protocol::protocol::v2::plugin::PluginReadResponseVersion of the remote shared plugin release when available.remoteVersiondiscoverabilitycreatorAccountUserIdcreatorNamesharePrincipalsPluginShareContextcodex_app_server_protocol::protocol::v2::plugin::PluginShareContextSkillsListResponsecodex_app_server_protocol::protocol::v2::plugin::SkillsListResponsePluginInstallParamscodex_app_server_protocol::protocol::v2::plugin::PluginInstallParamsNOT_AVAILABLEINSTALLED_BY_DEFAULTPluginInstallPolicycodex_app_server_protocol::protocol::v2::plugin::PluginInstallPolicylocalPluginPathPluginShareListItemcodex_app_server_protocol::protocol::v2::plugin::PluginShareListItemtransportSkillToolDependencycodex_app_server_protocol::protocol::v2::plugin::SkillToolDependencysparsePathsMarketplaceAddParamscodex_app_server_protocol::protocol::v2::plugin::MarketplaceAddParamsMarketplaceInterfacecodex_app_server_protocol::protocol::v2::plugin::MarketplaceInterfacePluginSharePrincipalcodex_app_server_protocol::protocol::v2::plugin::PluginSharePrincipalappsNeedingAuthcodex_app_server_protocol::protocol::v2::plugin::PluginInstallResponseOptional working directories used to discover repo marketplaces.Additional uninstalled plugin names that should be returned when present locally. This is used by mention surfaces that intentionally expose install entrypoints.installSuggestionPluginNamescodex_app_server_protocol::protocol::v2::plugin::PluginInstalledParamscodex_app_server_protocol::protocol::v2::plugin::PluginShareListParamspluginPathshareTargetscodex_app_server_protocol::protocol::v2::plugin::PluginShareSaveParams
codex_app_server_protocol::protocol::v2::plugin::PluginShareTargetRoleskillNamecodex_app_server_protocol::protocol::v2::plugin::PluginSkillReadParamscodex_app_server_protocol::protocol::v2::plugin::PluginUninstallParamsinstalledRootalreadyAddedcodex_app_server_protocol::protocol::v2::plugin::MarketplaceAddResponseLocal marketplace file path when the marketplace is backed by a local file. Remote-only catalog marketplaces do not have a local path.codex_app_server_protocol::protocol::v2::plugin::PluginMarketplaceEntrycodex_app_server_protocol::protocol::v2::plugin::MarketplaceRemoveParamscodex_app_server_protocol::protocol::v2::plugin::PluginInstalledResponsecodex_app_server_protocol::protocol::v2::plugin::PluginShareDeleteParamscodex_app_server_protocol::protocol::v2::plugin::PluginShareListResponsecodex_app_server_protocol::protocol::v2::plugin::PluginShareSaveResponsecodex_app_server_protocol::protocol::v2::plugin::PluginSkillReadResponsecodex_app_server_protocol::protocol::v2::plugin::PluginUninstallResponsePath-based selector.Name-based selector.codex_app_server_protocol::protocol::v2::plugin::SkillsConfigWriteParamscodex_app_server_protocol::protocol::v2::plugin::MarketplaceLoadErrorInfocodex_app_server_protocol::protocol::v2::plugin::MarketplaceUpgradeParams
Treat this as an invalidation signal and re-run `skills/list` with the client's current parameters when refreshed skill metadata is needed.codex_app_server_protocol::protocol::v2::plugin::SkillsChangedNotificationcodex_app_server_protocol::protocol::v2::plugin::SkillsConfigWriteResponseextraRootscodex_app_server_protocol::protocol::v2::plugin::SkillsExtraRootsSetParamsselectedMarketplacesupgradedRootscodex_app_server_protocol::protocol::v2::plugin::MarketplaceUpgradeResponse
When the count reaches zero, timeout accounting resumes for the thread.thread/name/setthread/goal/setthread/goal/getthread/goal/clearthread/metadata/updatethread/compact/startthread/shellCommandthread/approveGuardianDeniedActionthread/rollbackthread/listthread/loaded/listthread/readthread/inject_itemsAppend raw Responses API items to the thread history without starting a user turn.skills/listskills/extraRoots/sethooks/listmarketplace/addmarketplace/removemarketplace/upgradeplugin/listplugin/readplugin/skill/readplugin/share/saveplugin/share/updateTargetsplugin/share/listplugin/share/checkoutplugin/share/deletefs/readFilefs/writeFilefs/createDirectoryfs/getMetadatafs/removefs/copyfs/unwatchskills/config/writeplugin/installturn/startturn/steerturn/interruptreview/startmodel/listmodelProvider/capabilities/readexperimentalFeature/listpermissionProfile/listexperimentalFeature/enablement/setLists collaboration mode presets.Test-only method used to validate experimental gating.Adds or replaces a remote environment by id for later selection.mcpServer/oauth/loginconfig/mcpServer/reloadmcpServerStatus/listmcpServer/resource/readmcpServer/tool/callwindowsSandbox/setupStartwindowsSandbox/readinessaccount/login/startaccount/login/cancelaccount/logoutaccount/rateLimits/readaccount/usage/readaccount/sendAddCreditsNudgeEmailfeedback/uploadcommand/execExecute a standalone command (argv vector) under the server's sandbox.command/exec/writeWrite stdin bytes to a running `command/exec` session or close stdin.command/exec/terminateTerminate a running `command/exec` session by client-supplied `processId`.command/exec/resizeResize a running PTY-backed `command/exec` session by client-supplied `processId`.Spawn a standalone process (argv vector) without a Codex sandbox.Write stdin bytes to a running `process/spawn` session or close stdin.Terminate a running `process/spawn` session by client-supplied `processHandle`.Resize a running PTY-backed `process/spawn` session by client-supplied `processHandle`.config/readexternalAgentConfig/detectexternalAgentConfig/importconfig/value/writeconfig/batchWriteconfigRequirements/readaccount/readDEPRECATED APIs belowDEPRECATED in favor of GetAccountfuzzyFileSearchRequest from the client to the server.codex_app_server_protocol::protocol::common::ClientRequestNEW APIs Sent when approval is requested for a specific command execution. This request is used for Turns started via turn/start.Sent when approval is requested for a specific file change. This request is used for Turns started via turn/start.EXPERIMENTAL - Request input from the user for a tool call.Request input for an MCP server elicitation.Request approval for additional permissions from the user.Execute a dynamic tool call on the client.Generate a fresh upstream attestation result on demand.DEPRECATED APIs below Request to approve a patch. This request is used for Turns started via the legacy APIs (i.e. SendUserTurn, SendUserMessage).Request to exec a command. This request is used for Turns started via the legacy APIs (i.e. SendUserTurn, SendUserMessage).Request initiated from the server and sent to the client.codex_app_server_protocol::protocol::common::ServerRequestcodex_app_server_protocol::protocol::common::ClientNotificationNEW NOTIFICATIONSThis event is internal-only. Used by Codex Cloud.EXPERIMENTAL - proposed plan streaming deltas for plan items.Stream base64-encoded stdout/stderr chunks for a running `command/exec` session.Stream base64-encoded stdout/stderr chunks for a running `process/spawn` session.Final exit notification for a `process/spawn` session.Deprecated legacy apply_patch output stream notification.Notifies the user of world-writable directories on Windows, which cannot be protected by the sandbox.Notification sent from the server to the client.codex_app_server_protocol::protocol::common::ServerNotificationinternally tagged enum ServerRequestrootscancellationTokenFuzzyFileSearchParamscodex_app_server_protocol::protocol::common::FuzzyFileSearchParamsSuperset of [`codex_file_search::FileMatch`]FuzzyFileSearchResultcodex_app_server_protocol::protocol::common::FuzzyFileSearchResultFuzzyFileSearchResponsecodex_app_server_protocol::protocol::common::FuzzyFileSearchResponseFuzzyFileSearchMatchTypecodex_app_server_protocol::protocol::common::FuzzyFileSearchMatchTypecodex_app_server_protocol::protocol::common::FuzzyFileSearchSessionStopParamscodex_app_server_protocol::protocol::common::FuzzyFileSearchSessionStartParamscodex_app_server_protocol::protocol::common::FuzzyFileSearchSessionStopResponsecodex_app_server_protocol::protocol::common::FuzzyFileSearchSessionUpdateParamscodex_app_server_protocol::protocol::common::FuzzyFileSearchSessionStartResponsecodex_app_server_protocol::protocol::common::FuzzyFileSearchSessionUpdateResponsecodex_app_server_protocol::protocol::common::FuzzyFileSearchSessionUpdatedNotificationcodex_app_server_protocol::protocol::common::FuzzyFileSearchSessionCompletedNotificationv1::InitializeParamsv2::ThreadStartParamsv2::ThreadResumeParamsv2::ThreadForkParamsv2::ThreadArchiveParamsv2::ThreadUnsubscribeParamsv2::ThreadSetNameParamsv2::ThreadGoalSetParamsv2::ThreadGoalGetParamsv2::ThreadGoalClearParamsv2::ThreadMetadataUpdateParamsv2::ThreadUnarchiveParamsv2::ThreadCompactStartParamsv2::ThreadShellCommandParamsv2::ThreadApproveGuardianDeniedActionParamsv2::ThreadRollbackParamsv2::ThreadListParamsv2::ThreadLoadedListParamsv2::ThreadReadParamsv2::ThreadInjectItemsParamsv2::SkillsListParamsv2::SkillsExtraRootsSetParamsv2::HooksListParamsv2::MarketplaceAddParamsv2::MarketplaceRemoveParamsv2::MarketplaceUpgradeParamsv2::PluginListParamsv2::PluginInstalledParamsv2::PluginReadParamsv2::PluginSkillReadParamsv2::PluginShareSaveParamsv2::PluginShareUpdateTargetsParamsv2::PluginShareListParamsv2::PluginShareCheckoutParamsv2::PluginShareDeleteParamsv2::AppsListParamsv2::FsReadFileParamsv2::FsWriteFileParamsv2::FsCreateDirectoryParamsv2::FsGetMetadataParamsv2::FsReadDirectoryParamsv2::FsRemoveParamsv2::FsWatchParamsv2::FsUnwatchParamsv2::SkillsConfigWriteParamsv2::PluginInstallParamsv2::PluginUninstallParamsv2::TurnStartParamsv2::TurnSteerParamsv2::TurnInterruptParamsv2::ReviewStartParamsv2::ModelListParamsv2::ModelProviderCapabilitiesReadParamsv2::ExperimentalFeatureListParamsv2::PermissionProfileListParamsv2::ExperimentalFeatureEnablementSetParamsv2::McpServerOauthLoginParamsv2::ListMcpServerStatusParamsv2::McpResourceReadParamsv2::McpServerToolCallParamsv2::WindowsSandboxSetupStartParamsv2::LoginAccountParamsv2::CancelLoginAccountParamsv2::SendAddCreditsNudgeEmailParamsv2::FeedbackUploadParamsv2::CommandExecParamsv2::CommandExecWriteParamsv2::CommandExecTerminateParamsv2::CommandExecResizeParamsv2::ConfigReadParamsv2::ExternalAgentConfigDetectParamsv2::ExternalAgentConfigImportParamsv2::ConfigValueWriteParamsv2::ConfigBatchWriteParamsv2::GetAccountParamsv1::GetConversationSummaryParamsv1::GitDiffToRemoteParamsv1::GetAuthStatusParamsv1::InitializeResponsev2::ThreadStartResponsev2::ThreadResumeResponsev2::ThreadForkResponsev2::ThreadArchiveResponsev2::ThreadUnsubscribeResponsev2::ThreadSetNameResponsev2::ThreadGoalSetResponsev2::ThreadGoalGetResponsev2::ThreadGoalClearResponsev2::ThreadMetadataUpdateResponsev2::ThreadUnarchiveResponsev2::ThreadCompactStartResponsev2::ThreadShellCommandResponsev2::ThreadApproveGuardianDeniedActionResponsev2::ThreadRollbackResponsev2::ThreadListResponsev2::ThreadLoadedListResponsev2::ThreadReadResponsev2::ThreadInjectItemsResponsev2::SkillsListResponsev2::SkillsExtraRootsSetResponsev2::HooksListResponsev2::MarketplaceAddResponsev2::MarketplaceRemoveResponsev2::MarketplaceUpgradeResponsev2::PluginListResponsev2::PluginInstalledResponsev2::PluginReadResponsev2::PluginSkillReadResponsev2::PluginShareSaveResponsev2::PluginShareUpdateTargetsResponsev2::PluginShareListResponsev2::PluginShareCheckoutResponsev2::PluginShareDeleteResponsev2::AppsListResponsev2::FsReadFileResponsev2::FsWriteFileResponsev2::FsCreateDirectoryResponsev2::FsGetMetadataResponsev2::FsReadDirectoryResponsev2::FsRemoveResponsev2::FsCopyResponsev2::FsWatchResponsev2::FsUnwatchResponsev2::SkillsConfigWriteResponsev2::PluginInstallResponsev2::PluginUninstallResponsev2::TurnStartResponsev2::TurnSteerResponsev2::TurnInterruptResponsev2::ReviewStartResponsev2::ModelListResponsev2::ModelProviderCapabilitiesReadResponsev2::ExperimentalFeatureListResponsev2::PermissionProfileListResponsev2::ExperimentalFeatureEnablementSetResponsev2::McpServerOauthLoginResponsev2::McpServerRefreshResponsev2::ListMcpServerStatusResponsev2::McpResourceReadResponsev2::McpServerToolCallResponsev2::WindowsSandboxSetupStartResponsev2::WindowsSandboxReadinessResponsev2::LoginAccountResponsev2::CancelLoginAccountResponsev2::LogoutAccountResponsev2::GetAccountRateLimitsResponsev2::GetAccountTokenUsageResponsev2::SendAddCreditsNudgeEmailResponsev2::FeedbackUploadResponsev2::CommandExecResponsev2::CommandExecWriteResponsev2::CommandExecTerminateResponsev2::CommandExecResizeResponsev2::ConfigReadResponsev2::ExternalAgentConfigDetectResponsev2::ExternalAgentConfigImportResponsev2::ConfigWriteResponsev2::ConfigRequirementsReadResponsev2::GetAccountResponsev1::GetConversationSummaryResponsev1::GitDiffToRemoteResponsev1::GetAuthStatusResponsev2::ErrorNotificationv2::ThreadStartedNotificationv2::ThreadStatusChangedNotificationv2::ThreadArchivedNotificationv2::ThreadUnarchivedNotificationv2::ThreadClosedNotificationv2::SkillsChangedNotificationv2::ThreadNameUpdatedNotificationv2::ThreadGoalUpdatedNotificationv2::ThreadGoalClearedNotificationv2::ThreadSettingsUpdatedNotificationv2::ThreadTokenUsageUpdatedNotificationv2::TurnStartedNotificationv2::HookStartedNotificationv2::TurnCompletedNotificationv2::HookCompletedNotificationv2::TurnDiffUpdatedNotificationv2::TurnPlanUpdatedNotificationv2::ItemStartedNotificationv2::ItemGuardianApprovalReviewStartedNotificationv2::ItemGuardianApprovalReviewCompletedNotificationv2::ItemCompletedNotificationv2::RawResponseItemCompletedNotificationv2::AgentMessageDeltaNotificationv2::PlanDeltaNotificationv2::CommandExecOutputDeltaNotificationv2::ProcessOutputDeltaNotificationv2::ProcessExitedNotificationv2::CommandExecutionOutputDeltaNotificationv2::TerminalInteractionNotificationv2::FileChangeOutputDeltaNotificationv2::FileChangePatchUpdatedNotificationv2::ServerRequestResolvedNotificationv2::McpToolCallProgressNotificationv2::McpServerOauthLoginCompletedNotificationv2::McpServerStatusUpdatedNotificationv2::AccountUpdatedNotificationv2::AccountRateLimitsUpdatedNotificationv2::AppListUpdatedNotificationv2::RemoteControlStatusChangedNotificationv2::ExternalAgentConfigImportCompletedNotificationv2::FsChangedNotificationv2::ReasoningSummaryTextDeltaNotificationv2::ReasoningSummaryPartAddedNotificationv2::ReasoningTextDeltaNotificationv2::ContextCompactedNotificationv2::ModelReroutedNotificationv2::ModelVerificationNotificationv2::TurnModerationMetadataNotificationv2::WarningNotificationv2::GuardianWarningNotificationv2::DeprecationNoticeNotificationv2::ConfigWarningNotificationv2::ThreadRealtimeStartedNotificationv2::ThreadRealtimeItemAddedNotificationv2::ThreadRealtimeTranscriptDeltaNotificationv2::ThreadRealtimeTranscriptDoneNotificationv2::ThreadRealtimeOutputAudioDeltaNotificationv2::ThreadRealtimeSdpNotificationv2::ThreadRealtimeErrorNotificationv2::ThreadRealtimeClosedNotificationv2::WindowsWorldWritableWarningNotificationv2::WindowsSandboxSetupCompletedNotificationv2::AccountLoginCompletedNotificationcodex_utils_absolute_path::AbsolutePathBufstruct variant SubAgentSource::ThreadSpawn with 5 elementsstruct ChatgptAuthTokensRefreshResponsestruct ChatgptAuthTokensRefreshResponse with 3 elementsstruct SendAddCreditsNudgeEmailResponsestruct CommandExecWriteParamsstruct McpServerOauthLoginCompletedNotificationstruct McpServerOauthLoginCompletedNotification with 3 elementsstruct GrantedPermissionProfilestruct RequestPermissionProfilestruct RequestPermissionProfile with 2 elementsstruct variant SandboxPolicyDeserialize::WorkspaceWritestruct variant SandboxPolicyDeserialize::ExternalSandboxstruct variant SandboxPolicyDeserialize::ReadOnlyreadOnlyAccessstruct ThreadRealtimeAppendTextParamsstruct ThreadRealtimeListVoicesParamsstruct ThreadResumeInitialTurnsPageParamsstruct FuzzyFileSearchSessionCompletedNotificationstruct FuzzyFileSearchSessionCompletedNotification with 1 elementstruct AccountLoginCompletedNotificationstruct AccountLoginCompletedNotification with 3 elementsstruct AttestationGenerateParamsstruct CommandExecResizeParamsstruct CommandExecTerminalSizestruct CommandExecutionOutputDeltaNotificationstruct CommandExecutionOutputDeltaNotification with 4 elementsstruct CommandExecutionRequestApprovalResponsestruct CommandExecutionRequestApprovalResponse with 1 elementstruct McpElicitationTitledMultiSelectEnumSchemastruct McpElicitationTitledMultiSelectEnumSchema with 7 elementsfullAccessstruct ThreadRealtimeAppendAudioParamsstruct ThreadRealtimeErrorNotificationstruct ThreadRealtimeErrorNotification with 2 elementsstruct ThreadTokenUsageUpdatedNotificationstruct ThreadTokenUsageUpdatedNotification with 3 elementsstruct McpElicitationTitledSingleSelectEnumSchemastruct McpElicitationTitledSingleSelectEnumSchema with 5 elementscurrent_working_directorystruct ThreadRealtimeClosedNotificationstruct ThreadRealtimeClosedNotification with 2 elementsstruct ThreadBackgroundTerminalsCleanParamsstruct AttestationGenerateResponsestruct AttestationGenerateResponse with 1 elementstruct McpElicitationUntitledMultiSelectEnumSchemastruct McpElicitationUntitledMultiSelectEnumSchema with 7 elementsstruct AdditionalPermissionProfilestruct AdditionalPermissionProfile with 2 elementsstruct PermissionProfileListParamsstruct ThreadRealtimeAppendAudioResponsestruct ThreadRealtimeStartedNotificationstruct ThreadRealtimeStartedNotification with 3 elementsstruct AccountRateLimitsUpdatedNotificationstruct AccountRateLimitsUpdatedNotification with 1 elementstruct CommandExecTerminateParamsstruct McpElicitationUntitledSingleSelectEnumSchemastruct McpElicitationUntitledSingleSelectEnumSchema with 5 elementsstruct AdditionalNetworkPermissionsstruct AdditionalNetworkPermissions with 1 elementstruct ThreadBackgroundTerminalsCleanResponsestruct GuardianWarningNotificationstruct GuardianWarningNotification with 2 elementsstruct ThreadRealtimeItemAddedNotificationstruct ThreadRealtimeItemAddedNotification with 2 elementsstruct ThreadApproveGuardianDeniedActionParamsstruct ItemGuardianApprovalReviewStartedNotificationstruct ItemGuardianApprovalReviewStartedNotification with 7 elementsfield index 0 <= i < 5struct DeprecationNoticeNotificationstruct DeprecationNoticeNotification with 2 elementsstruct AdditionalFileSystemPermissionsstruct AdditionalFileSystemPermissions with 4 elementsstruct ThreadApproveGuardianDeniedActionResponsestruct PermissionsRequestApprovalParamsstruct PermissionsRequestApprovalParams with 8 elementsstruct ItemGuardianApprovalReviewCompletedNotificationstruct ItemGuardianApprovalReviewCompletedNotification with 9 elementsstruct RemoteControlEnableResponsestruct PermissionsRequestApprovalResponsestruct PermissionsRequestApprovalResponse with 3 elementsstruct ThreadRealtimeTranscriptDoneNotificationstruct ThreadRealtimeTranscriptDoneNotification with 3 elementsstruct ServerRequestResolvedNotificationstruct ServerRequestResolvedNotification with 2 elementsstruct ThreadRealtimeTranscriptDeltaNotificationstruct ThreadRealtimeTranscriptDeltaNotification with 3 elementsstruct CommandExecOutputDeltaNotificationstruct CommandExecOutputDeltaNotification with 4 elementsstruct ExternalAgentConfigImportCompletedNotificationstruct ThreadRealtimeOutputAudioDeltaNotificationstruct ThreadRealtimeOutputAudioDeltaNotification with 2 elementsstruct RemoteControlClientsListParamsstruct RemoteControlPairingStartParamsstruct RemoteControlClientsRevokeParamsstruct RemoteControlPairingStatusParamsstruct WindowsSandboxSetupStartParamsstruct CollaborationModeListParamsstruct RemoteControlStatusChangedNotificationstruct RemoteControlStatusChangedNotification with 4 elementsstruct ExperimentalFeatureListParamsstruct WindowsWorldWritableWarningNotificationstruct WindowsWorldWritableWarningNotification with 3 elementsstruct WindowsSandboxSetupCompletedNotificationstruct WindowsSandboxSetupCompletedNotification with 3 elementsstruct ExperimentalFeatureEnablementSetParamsstruct variant AskForApproval::Granular with 5 elementsstruct variant CodexErrorInfo::ResponseTooManyFailedAttempts with 1 elementstruct variant CodexErrorInfo::ResponseStreamConnectionFailed with 1 elementstruct variant CodexErrorInfo::ResponseStreamDisconnected with 1 elementstruct variant CodexErrorInfo::HttpConnectionFailed with 1 elementstruct variant CodexErrorInfo::ActiveTurnNotSteerable with 1 elementstruct variant CommandExecutionApprovalDecision::ApplyNetworkPolicyAmendment with 1 elementstruct variant CommandExecutionApprovalDecision::AcceptWithExecpolicyAmendment with 1 elementfailed to write whole bufferinternal error: entered unreachable codea scoped thread panickedRUST_MIN_STACKthreads should not terminate unexpectedlya Display implementation returned an error unexpectedlydescription() is deprecated; use Displaymid > lencalled `Result::unwrap()` on an `Err` valueassertion failed: len > 0assertion failed: idx < CAPACITYassertion failed: edge.height == self.height - 1assertion failed: src.len() == dst.len()assertion failed: edge.height == self.node.height - 1assertion failed: old_left_len >= countattempt to join into collection with len > usize::MAXcodex_protocol::protocol::InternalSessionSourcecodex_protocol::models::LocalShellExecActioncodex_protocol::approvals::NetworkPolicyAmendmentcodex_protocol::agent_path::AgentPathcodex_app_server_protocol::protocol::v2::shared::ApprovalsReviewercodex_protocol::models::FunctionCallOutputContentItemts_rs::serde_json::TsJsonValuecodex_protocol::approvals::NetworkPolicyRuleActioncodex_protocol::config_types::WebSearchContextSizecodex_protocol::config_types::WebSearchLocationcodex_app_server_protocol::protocol::v2::permissions::ExecPolicyAmendmentcodex_protocol::approvals::ExecPolicyAmendmentserde_json::value::Value
"sessionFlags""cloudRequirements""cloudManagedConfig""legacyManagedConfigFile""legacyManagedConfigMdm""type": "userMessage","type": "hookPrompt","type": "agentMessage","type": "plan","type": "reasoning","type": "commandExecution", Identifier for the underlying PTY process (when available). A best-effort parsing of the command to understand the action(s) it will perform. This returns a list of CommandAction objects because a single shell command may be composed of many commands piped together. The command's output, aggregated from stdout and stderr. The command's exit code. The duration of the command execution in milliseconds."type": "fileChange", The duration of the MCP tool call in milliseconds."type": "dynamicToolCall", The duration of the dynamic tool call in milliseconds."type": "collabAgentToolCall", Unique identifier for this collab tool call. Name of the collab tool that was invoked. Current status of the collab tool call. Thread ID of the agent issuing the collab request. Thread ID of the receiving agent, when applicable. In case of spawn operation, this corresponds to the newly spawned agent. Prompt text sent as part of the collab tool call, when available. Model requested for the spawned agent, when applicable. Reasoning effort requested for the spawned agent, when applicable. Last known status of the target agents, when available."type": "webSearch","type": "imageView","type": "imageGeneration","type": "enteredReviewMode","type": "exitedReviewMode","type": "contextCompaction","interrupted""method": "initialize","method": "thread/start","method": "thread/resume","method": "thread/fork","method": "thread/archive","method": "thread/unsubscribe","method": "thread/increment_elicitation","method": "thread/decrement_elicitation","method": "thread/name/set","method": "thread/goal/set","method": "thread/goal/get","method": "thread/goal/clear","method": "thread/metadata/update","method": "thread/settings/update","method": "thread/memoryMode/set","method": "memory/reset","method": "thread/unarchive","method": "thread/compact/start","method": "thread/shellCommand","method": "thread/approveGuardianDeniedAction","method": "thread/backgroundTerminals/clean","method": "thread/rollback","method": "thread/list","method": "thread/search","method": "thread/loaded/list","method": "thread/read","method": "thread/turns/list","method": "thread/turns/items/list","method": "thread/inject_items","method": "skills/list","method": "skills/extraRoots/set","method": "hooks/list","method": "marketplace/add","method": "marketplace/remove","method": "marketplace/upgrade","method": "plugin/list","method": "plugin/installed","method": "plugin/read","method": "plugin/skill/read","method": "plugin/share/save","method": "plugin/share/updateTargets","method": "plugin/share/list","method": "plugin/share/checkout","method": "plugin/share/delete","method": "app/list","method": "fs/readFile","method": "fs/writeFile","method": "fs/createDirectory","method": "fs/getMetadata","method": "fs/readDirectory","method": "fs/remove","method": "fs/copy","method": "fs/watch","method": "fs/unwatch","method": "skills/config/write","method": "plugin/install","method": "plugin/uninstall","method": "turn/start","method": "turn/steer","method": "turn/interrupt","method": "thread/realtime/start","method": "thread/realtime/appendAudio","method": "thread/realtime/appendText","method": "thread/realtime/stop","method": "thread/realtime/listVoices","method": "review/start","method": "model/list","method": "modelProvider/capabilities/read","method": "experimentalFeature/list","method": "permissionProfile/list","method": "experimentalFeature/enablement/set","method": "remoteControl/enable","method": "remoteControl/disable","method": "remoteControl/status/read","method": "remoteControl/pairing/start","method": "remoteControl/pairing/status","method": "remoteControl/client/list","method": "remoteControl/client/revoke","method": "collaborationMode/list","method": "mock/experimentalMethod","method": "environment/add","method": "mcpServer/oauth/login","method": "config/mcpServer/reload","method": "mcpServerStatus/list","method": "mcpServer/resource/read","method": "mcpServer/tool/call","method": "windowsSandbox/setupStart","method": "windowsSandbox/readiness","method": "account/login/start","method": "account/login/cancel","method": "account/logout","method": "account/rateLimits/read","method": "account/usage/read","method": "account/sendAddCreditsNudgeEmail","method": "feedback/upload","method": "command/exec","method": "command/exec/write","method": "command/exec/terminate","method": "command/exec/resize","method": "process/spawn","method": "process/writeStdin","method": "process/kill","method": "process/resizePty","method": "config/read","method": "externalAgentConfig/detect","method": "externalAgentConfig/import","method": "config/value/write","method": "config/batchWrite","method": "configRequirements/read","method": "account/read","method": "getConversationSummary","method": "gitDiffToRemote","method": "getAuthStatus","method": "fuzzyFileSearch","method": "fuzzyFileSearch/sessionStart","method": "fuzzyFileSearch/sessionUpdate","method": "fuzzyFileSearch/sessionStop", Request from the client to the server."method": "item/commandExecution/requestApproval","method": "item/fileChange/requestApproval","method": "item/tool/requestUserInput","method": "mcpServer/elicitation/request","method": "item/permissions/requestApproval","method": "item/tool/call","method": "account/chatgptAuthTokens/refresh","method": "attestation/generate","method": "applyPatchApproval","method": "execCommandApproval", Request initiated from the server and sent to the client. Connection-scoped watch identifier used for `fs/unwatch` and `fs/changed`. Absolute file or directory path to watch. Start filesystem watch notifications for an absolute path. Thread items currently included in this turn payload. Describes how much of `items` has been loaded for this turn. Only populated when the Turn's status is failed. Unix timestamp (in seconds) when the turn started. Unix timestamp (in seconds) when the turn completed. Duration between turn start and completion in milliseconds, if known. Byte range in the parent `text` buffer that this element occupies. Optional human-readable placeholder for the element, displayed in the UI.InitializeResponse.ts Absolute path to the server's $CODEX_HOME directory. Platform family for the running app-server target, for example `"unix"` or `"windows"`. Operating system for the running app-server target, for example `"macos"`, `"linux"`, or `"windows"`. Successful response for `fs/copy`. Absolute path to remove. Whether directory removal should recurse. Defaults to `true`. Whether missing paths should be ignored. Defaults to `true`. Remove a file or directory tree from the host filesystem."unsupported""notLoggedIn""bearerToken"
"pendingInit""shutdown""critical" [UNSTABLE] Risk level assigned by approval auto-review. When empty, defaults to the current session working directory. Starter prompts for the plugin. Capped at 3 entries with a maximum of 128 characters per entry. Local composer icon path, resolved from the installed plugin package. Remote composer icon URL from the plugin catalog. Local logo path, resolved from the installed plugin package. Remote logo URL from the plugin catalog. Local screenshot paths, resolved from the installed plugin package. Remote screenshot URLs from the plugin catalog.ApplyPatchApprovalParams.ts Use to correlate this with [codex_protocol::protocol::PatchApplyBeginEvent] and [codex_protocol::protocol::PatchApplyEndEvent]. When set, the agent is asking the user to allow writes under this root Optional working directory to resolve project config layers. If specified, return the effective config as seen from that directory (i.e., including any project layers between `cwd` and the project/repo root). Direct child entry name only, not an absolute or relative path. Whether this entry resolves to a directory. Whether this entry resolves to a regular file. A directory entry returned by `fs/readDirectory`."trustedAccessForCyber""ON_INSTALL" Optional working directories used to discover repo marketplaces. When omitted, only home-scoped marketplaces and the official curated marketplace are considered. Optional marketplace kind filter. When omitted, only local marketplaces are queried, plus the default remote catalog when enabled by feature flag. When true, bypass the skills cache and re-scan skills from disk."waitingOnApproval""waitingOnUserInput" [UNSTABLE] Specify the rollout path to fork from. If specified, the thread_id param will be ignored. Configuration overrides for the forked thread, if any. Replace the thread's runtime workspace roots. Paths must be absolute. Override where approval requests are routed for review on this thread and subsequent turns. Named profile id for the forked thread. Cannot be combined with `sandbox`. Optional client-supplied analytics source classification for this forked thread. When true, return only thread metadata and live fork state without populating `thread.turns`. This is useful when the client plans to call `thread/turns/list` immediately after forking. There are two ways to fork a thread: 1. By thread_id: load the thread from disk by thread_id and fork it into a new thread. 2. By path: load the thread from disk by path and fork it into a new thread. If using a non-empty path, the thread_id param will be ignored. Empty string path values are treated as absent. Prefer using thread_id whenever possible."usageLimited""budgetLimited""complete" Optional sort key; defaults to created_at. Optional sort direction; defaults to descending (newest first). Optional provider filter; when set, only sessions recorded under these providers are returned. When present but empty, includes all providers. Optional source filter; when set, only sessions from these source kinds are returned. When omitted or empty, defaults to interactive sources. Optional archived filter; when set to true, only archived threads are returned. If false or null, only non-archived threads are returned. Optional cwd filter or filters; when set, only threads whose session cwd exactly matches one of these paths are returned. If true, return from the state DB without scanning JSONL rollouts to repair thread metadata. Omitted or false preserves scan-and-repair behavior. Optional substring filter for the extracted thread title.ThreadMemoryMode.ts"enabled" When true, include turns and their items from rollout history.
skillName
codexStreamlinedLoginaccessTokenchatgptPlanTypeusage_limitcreditTypeprocessHandleclassificationincludeLogsextraLogFilessampleRatenumChannelssamplesPerChannelitemIdoutputModalityrealtimeSessionIdClientRequestinitializethread/startthread/resumethread/forkthread/archivethread/unsubscribethread/increment_elicitationthread/decrement_elicitationthread/name/setthread/goal/setthread/goal/getthread/goal/clearthread/metadata/updatethread/settings/updatethread/memoryMode/setmemory/resetthread/compact/startthread/shellCommandthread/approveGuardianDeniedActionthread/backgroundTerminals/cleanthread/rollbackthread/listthread/searchthread/loaded/listthread/readthread/turns/listthread/turns/items/listthread/inject_itemsskills/listskills/extraRoots/sethooks/listmarketplace/addmarketplace/removemarketplace/upgradeplugin/listplugin/readplugin/skill/readplugin/share/saveplugin/share/updateTargetsplugin/share/listplugin/share/checkoutplugin/share/deletefs/readFilefs/writeFilefs/createDirectoryfs/getMetadatafs/removefs/copyfs/unwatchskills/config/writeplugin/installturn/startturn/steerturn/interruptthread/realtime/startthread/realtime/appendAudiothread/realtime/appendTextthread/realtime/stopthread/realtime/listVoicesreview/startmodel/listmodelProvider/capabilities/readexperimentalFeature/listpermissionProfile/listexperimentalFeature/enablement/setremoteControl/enableremoteControl/disableremoteControl/status/readremoteControl/pairing/startremoteControl/pairing/statusremoteControl/client/listremoteControl/client/revokecollaborationMode/listmock/experimentalMethodenvironment/addmcpServer/oauth/loginconfig/mcpServer/reloadmcpServerStatus/listmcpServer/resource/readmcpServer/tool/callwindowsSandbox/setupStartwindowsSandbox/readinessaccount/login/startaccount/login/cancelaccount/logoutaccount/rateLimits/readaccount/usage/readaccount/sendAddCreditsNudgeEmailfeedback/uploadcommand/execcommand/exec/writecommand/exec/terminatecommand/exec/resizeprocess/spawnprocess/writeStdinprocess/killprocess/resizePtyconfig/readexternalAgentConfig/detectexternalAgentConfig/importconfig/value/writeconfig/batchWriteconfigRequirements/readaccount/readgetConversationSummarygitDiffToRemotegetAuthStatusfuzzyFileSearchfuzzyFileSearch/sessionStartfuzzyFileSearch/sessionUpdatefuzzyFileSearch/sessionStoprootscancellationTokenAbsolutePathBufreadOnlyAccessfullAccessapp-servercodex app-server stdin unavailablecodex app-server stdout unavailablefailed to read from codex app-servercodex app-server closed stdoutapp_server_test_client.requestcodex_app_server_test_clientotel.kindotel.namerpc.systemrpc.methodrpc.request_idapp-server-test-client/src/lib.rsclientjsonrpccodex app-server stdin closedclient request was not a valid JSON-RPC request> .failed to connect to websocket app-server at `
user-agent should be validsize overflows MAX_SIZEassertion failed: (*tail).value.is_none()assertion failed: (*next).value.is_some()assertion failed: slot.is_none()must include 'read-only' to allow any PermissionProfilewindows.allowed_sandbox_implementationswindows.sandboxweb_search_modestruct Tuistruct Noticestruct Notice with 8 elementsstruct Historyfield identifierstruct AppConfigstruct WindowsTomlstruct WindowsToml with 2 elementsstruct MemoriesTomlstruct MemoriesToml with 12 elementsstruct PluginConfiga sequencestruct AppToolConfigstruct OtelTlsConfigstruct OtelTlsConfig with 3 elementsstruct AppToolsConfigstruct AppsConfigTomlstruct OtelConfigTomlstruct OtelConfigToml with 7 elementsstruct AppsDefaultConfigstruct MarketplaceConfigstruct ToolSuggestConfigvariant identifierstruct FeedbackConfigTomlstruct FeedbackConfigToml with 1 elementstruct TuiKeymapstruct AnalyticsConfigTomlstruct AnalyticsConfigToml with 1 elementstruct DebugTomlstruct DebugToml with 1 elementstruct ToolsTomlstruct ToolsToml with 2 elementsstruct HooksFilestruct HooksTomlstruct PluginMcpServerConfigstruct SandboxWorkspaceWritestruct AgentsTomlstruct ConfigTomlstruct ConfigToml with 95 elementsstruct variant McpServerEnvVar::Configstruct TuiChatKeymapstruct TuiChatKeymap with 4 elementsstruct TuiListKeymapstruct TuiListKeymap with 10 elementsvariant index 0 <= i < 3struct ToolSuggestDisabledToolstruct ToolSuggestDisabledTool with 2 elementsstruct ToolSuggestDiscoverablestruct ToolSuggestDiscoverable with 2 elementsstruct RealtimeTomlstruct RealtimeToml with 4 elementsstruct MatcherGroupstruct ProjectTrustConfigTomlstruct ProfileTuistruct TuiPagerKeymapstruct TuiPagerKeymap with 10 elementsstruct AgentRoleTomlstruct AgentRoleToml with 3 elementsstruct ProjectConfigstruct ProjectConfig with 1 elementstruct HookStateTomlstruct LegacyManagedConfigTomlstruct LegacyManagedConfigToml with 3 elementsstruct TuiEditorKeymapstruct TuiEditorKeymap with 17 elementsstruct TuiGlobalKeymapstruct TuiGlobalKeymap with 10 elementsstruct AutoReviewTomlstruct AutoReviewToml with 1 elementstruct HookEventsTomlstruct RawMcpServerConfigstruct RawMcpServerConfig with 25 elementsstruct ModelAvailabilityNuxConfigvariant index 0 <= i < 2struct ShellEnvironmentPolicyTomlstruct ShellEnvironmentPolicyToml with 6 elementsstruct variant ThreadStoreToml::Localstruct variant ThreadStoreToml::InMemorystruct variant ThreadStoreToml::InMemory with 1 elementstruct McpServerToolConfigstruct ConfigProfilestruct ConfigProfile with 29 elementsstruct SkillConfigstruct SkillConfig with 3 elementsstruct TuiApprovalKeymapstruct TuiApprovalKeymap with 8 elementsstruct TuiComposerKeymapstruct TuiComposerKeymap with 5 elementsfield index 0 <= i < 2struct McpServerOAuthConfigstruct SkillsConfigstruct TuiVimNormalKeymapstruct TuiVimNormalKeymap with 25 elementsstruct GhostSnapshotTomlstruct GhostSnapshotToml with 3 elementsstruct RealtimeAudioTomlstruct RealtimeAudioToml with 2 elementsstruct variant HookHandlerConfig::Agentstruct variant HookHandlerConfig::Commandstruct variant HookHandlerConfig::Promptstruct variant HookHandlerConfig::Command with 5 elementsawsstruct ModelProviderInfo with 17 elementsstruct TuiVimOperatorKeymapstruct TuiVimOperatorKeymap with 14 elementsstruct ExternalConfigMigrationPromptsstruct ExternalConfigMigrationPrompts with 4 elementsstruct DebugConfigLockTomlstruct DebugConfigLockToml with 4 elementsstruct TuiVimTextObjectKeymapstruct TuiVimTextObjectKeymap with 9 elementsstruct GranularApprovalConfig with 5 elementsstruct NetworkTomlstruct NetworkToml with 13 elementscommand_windowsstruct BundledSkillsConfigstruct WebSearchLocation with 4 elementsstruct ModelProviderAwsAuthInfo with 2 elementsstruct PermissionsTomlstruct WebSearchToolConfig with 3 elementsstruct ModelProviderAuthInfo with 5 elementsstruct ExperimentalRequestUserInputstruct ManagedHooksRequirementsTomlmanaged_dirwindows_managed_dirstruct WorkspaceRootsTomlstruct NetworkMitmHookTomlstruct NetworkMitmHookToml with 7 elementsstruct CodeModeConfigToml with 2 elementsstruct NetworkMitmActionTomlstruct PermissionProfileTomlstruct PermissionProfileToml with 5 elementsstruct CloudConfigBundlestruct variant McpServerIdentity::Urlstruct variant McpServerIdentity::Commanda mapstruct AppRequirementTomlstruct AppRequirementToml with 2 elementsstruct NetworkMitmTomlUncheckedstruct NetworkMitmTomlUnchecked with 2 elementsstruct MultiAgentV2ConfigToml with 12 elementsstruct NetworkProxyConfigToml with 12 elementsstruct CloudConfigFragmentstruct FilesystemPermissionsTomlstruct AppsRequirementsTomlstruct McpServerRequirementstruct McpServerRequirement with 1 elementstruct CloudConfigTomlBundlestruct AppToolRequirementTomlstruct AppToolRequirementToml with 1 elementstruct ConfigRequirementsTomlstruct ConfigRequirementsToml with 21 elementsstruct PluginRequirementsTomlstruct PluginRequirementsToml with 1 elementstruct NetworkDomainPermissionsTomlstruct FeatureRequirementsTomlstruct RemoteSandboxConfigTomlstruct RemoteSandboxConfigToml with 2 elementsstruct WindowsRequirementsTomlstruct WindowsRequirementsToml with 1 elementstruct NetworkMitmInjectedHeaderTomlfield index 0 <= i < 12struct AppToolsRequirementsTomlstruct CloudRequirementsFragmentstruct AppsMcpPathOverrideConfigToml with 2 elementsstruct RawNetworkRequirementsTomlstruct RawNetworkRequirementsToml with 13 elementsstruct NetworkUnixSocketPermissionsTomlstruct CloudRequirementsTomlBundlestruct ComputerUseRequirementsTomlstruct ComputerUseRequirementsToml with 1 elementstruct PermissionsRequirementsTomlstruct RawFilesystemRequirementsTomlstruct RawFilesystemRequirementsToml with 6 elementsstruct RequirementsExecPolicyTomlstruct RequirementsExecPolicyToml with 1 elementstruct RequirementsExecPolicyPrefixRuleTomlstruct RequirementsExecPolicyPrefixRuleToml with 3 elementsstruct RequirementsExecPolicyPatternTokenTomlstruct RequirementsExecPolicyPatternTokenToml with 2 elementsstruct variant OtelExporterKind::OtlpGrpcstruct variant OtelExporterKind::OtlpHttpstruct variant OtelExporterKind::OtlpGrpc with 3 elementsstruct variant OtelExporterKind::OtlpHttp with 4 elementsresponsesAbsolutePathBufassertion failed: DEFAULT_MAX_FRAME_SIZE as usize <= val && val <= MAX_MAX_FRAME_SIZE as usizeassertion failed: self.has_capacity()chunk not fully encodednot implementedencoded pingencoded go_awayencoded window_updateencoded resetflushing bufferassertion failed: val <= frame::MAX_MAX_FRAME_SIZE as usizeassertion failed: dst.remaining_mut() >= lenassertion failed: !stream_id.is_zero()codec closedmutex poisonedrecv DATArecv HEADERSrecv PRIORITYrecv PUSH_PROMISErecv SETTINGSrecv PINGreceived unexpected shutdown pingrecv GOAWAYrecv WINDOW_UPDATErecv RST_STREAMConnection::poll; connection error    -> already going awaystream errorConnection::poll; IO errorClientconnection closing after flushinvalid GOAWAY framepoll_completewritinginvalid framereclaimedwasn't expecting a frame to reclaimnot reclaiming frame for cancelled streamremoving dangling stream from pending_senddata framestream capacity is 0sending data frameinvalid RST_STREAM frameinvalid WINDOW_UPDATE frameunexpected flow control stateQueue::push_front -> first entry -> existing entries -> already queuedassertion failed: N::next(&stream).is_none()assertion failed: slot.next.is_none()internal error: entered unreachable code: Initiator::User should not error sending resetconnection error PROTOCOL_ERROR -- recv_reset: invalid stream ID 0;assertion failed: stream.state.is_closed()connection error PROTOCOL_ERROR -- recv_push_promise: initiating stream is in an invalid state;connection error PROTOCOL_ERROR -- recv_push_promise: initiating stream is not opened;connection closed because of a broken pipeStreams::recv_eofassertion failed: sz <= super::MAX_WINDOW_SIZE as usizetoo_many_internal_resetsconnection error PROTOCOL_ERROR -- received unexpected settings ack;assertion failed: self.remote.is_none()invalid settings frameACK sent; applying settingsinvalid ping frameinvalid pong framebinding client connectionPRI * HTTP/2.0
encWarning: Your account was flagged for potentially high-risk cyber activityconnect failedserve connect pipewrite server reply: connect succeededwrite server reply: connect failed<skills_instructions></skills_instructions></personality_spec>update_plan is a TODO/checklist tool and is not allowed in Plan modeupdate_plan handler received unsupported payload
- Skill naming: If a plugin contributes skills, those skill entries are prefixed with `plugin_name:` in the Skills list.
openai.yamlinterfacedependenciesshort-descriptionPolicyallow_implicit_invocationshort_descriptionicon_smallicon_largebrand_colordefault_prompt failed to stat repo skills root 
failed to stat skills root 
failed to read skills dir 
"failed to read skills symlink dir 
failed to stat skills path 
/Errorenabledevent core-skills/src/config_rules.rs:124codex_core_skills::config_rulesmessagecore-skills/src/config_rules.rsevent core-skills/src/config_rules.rs:120event core-skills/src/config_rules.rs:113ignoring skills.config entry without a path or name selectorignoring empty skills.config name overrideignoring skills.config entry with both path and name selectorsevent core-skills/src/config_rules.rs:49skillsscriptsevent core-skills/src/loader.rs:1000codex_core_skills::loadercore-skills/src/loader.rsevent core-skills/src/loader.rs:1004event core-skills/src/loader.rs:436event core-skills/src/loader.rs:1033event core-skills/src/loader.rs:1026interface.display_nameinterface.short_descriptioninterface.icon_smallinterface.icon_largeinterface.brand_colorinterface.default_promptskillevent core-skills/src/loader.rs:899event core-skills/src/loader.rs:925event core-skills/src/loader.rs:915assetsevent core-skills/src/loader.rs:758event core-skills/src/loader.rs:732event core-skills/src/loader.rs:744event core-skills/src/loader.rs:1016event core-skills/src/loader.rs:388dependencies.tools.typedependencies.tools.valuedependencies.tools.descriptiondependencies.tools.transportdependencies.tools.commanddependencies.tools.urlevent core-skills/src/loader.rs:534event core-skills/src/loader.rs:575event core-skills/src/loader.rs:615event core-skills/src/loader.rs:494event core-skills/src/loader.rs:549event core-skills/src/loader.rs:414event core-skills/src/loader.rs:947event core-skills/src/loader.rs:940event core-skills/src/loader.rs:953.agentsExceeded skills context budget.Exceeded skills context budget of 2%.## SkillsA skill is a set of local instructions to follow that is stored in a `SKILL.md` file. Below is the list of skills that can be used. Each entry includes a name, description, and file path so you can open the source for full instructions when using a specific skill.A skill is a set of local instructions to follow that is stored in a `SKILL.md` file. Below is the list of skills that can be used. Each entry includes a name, description, and a short path that can be expanded into an absolute path using the skill roots table.### Skill roots### Available skills### How to use skills- Discovery: The list above is the skills available in this session (name + description + short path). Skill bodies live on disk at the listed paths after expanding the matching alias from `### Skill roots`.
- Trigger rules: If the user names a skill (with `$SkillName` or plain text) OR the task clearly matches a skill's description shown above, you must use that skill for that turn. Multiple mentions mean use them all. Do not carry skills across turns unless re-mentioned.
  - If multiple skills apply, choose the minimal set that covers the request and state the order you'll use them.
- Safety and fallback: If a skill can't be applied cleanly (missing files, unclear instructions), state the issue, pick the next-best approach, and continue.- Discovery: The list above is the skills available in this session (name + description + file path). Skill bodies live on disk at the listed paths.
- Trigger rules: If the user names a skill (with `$SkillName` or plain text) OR the task clearly matches a skill's description shown above, you must use that skill for that turn. Multiple mentions mean use them all. Do not carry skills across turns unless re-mentioned.
  - If multiple skills apply, choose the minimal set that covers the request and state the order you'll use them.
- Safety and fallback: If a skill can't be applied cleanly (missing files, unclear instructions), state the issue, pick the next-best approach, and continue.codex.thread.skills.enabled_totalcodex.thread.skills.kept_totalcodex.thread.skills.truncatedcodex.thread.skills.description_truncated_charsSkill descriptions were shortened to fit the 2% skills context budget. Codex can still see every skill, but some descriptions are shorter. Disable unused skills or plugins to leave more room for the rest.Skill descriptions were shortened to fit the skills context budget. Codex can still see every skill, but some descriptions are shorter. Disable unused skills or plugins to leave more room for the rest.wasExceeded skills context budget. All skill descriptions were removed andevent core-skills/src/render.rs:266codex_core_skills::renderbudget_limittotal_skillsincluded_skillsomitted_skillstruncated_description_chars_per_skilltruncated_skill_descriptionscore-skills/src/render.rstruncated skill metadata to fit skills context budgetevent core-skills/src/manager.rs:213codex_core_skills::managercore-skills/src/manager.rsevent core-skills/src/manager.rs:81event core-skills/src/manager.rs:261app://plugin://statuscodex.skill.injecteda sequencestruct Policystruct Interfacefield identifierstruct Dependenciesstruct DependencyToolstruct SkillConfig with 3 elementsbundledinclude_instructionsconfigstruct SkillFrontmatterstruct SkillMetadataFilestruct SkillFrontmatterMetadatainternal error: entered unreachable code: invalid Once statea Display implementation returned an error unexpectedlymid > lenattempt to join into collection with len > usize::MAXfewer elements in arrayfewer elements in mapmissing YAML frontmatter delimited by ---AbsolutePathBuf deserialized without a base pathtaillesswereUSERTEMP
- {{ base_path }}/skills/<skill-name>/ (skill folder)
   {{ base_path }}/skills/.
    `rollout_summaries/...`, `skills/...`)
]all_on_same_lineall_within_linesAddAdHocNoteArgsmemories/skills/Errormemoriesmemories/MEMORY.mdmemories/memory_summary.mdmemories/raw_memories.mdmemories/rollout_summaries/<rollout_ids></rollout_ids><thread_ids></thread_ids><citation_entries></citation_entries>|note=[a Display implementation returned an error unexpectedly
encconnect failedwrite server reply: connect failedwrite server reply: connect succeededserve connect pipe<skills_instructions></skills_instructions><personality_spec></personality_spec>
openai.yamlinterfacedependenciesshort-descriptionPolicyallow_implicit_invocationdisplay_nameshort_descriptionicon_smallicon_largebrand_colordefault_prompt failed to stat repo skills root 
failed to stat skills root 
failed to read skills dir 
"failed to read skills symlink dir 
failed to stat skills path 
- skills/<skill-name>/
- `skills/*`
  - read existing skills so updates are incremental and non-duplicative
  and `skills/`).
B) `skills/*` (optional)
    `- Related skill: skills/<skill-name>/SKILL.md`).
`skills/`, and `rollout_summaries/`.
- This section is primarily an index to `MEMORY.md`; mention `skills/` / `rollout_summaries/`
# ============================================================ 3) `skills/` FORMAT (optional)
Where skills live (in this memory folder):
skills/<skill-name>/
     - create initial `skills/*` (optional but highly recommended)
     - updating existing skills or adding new skills only when there is clear new reusable procedure
   - remove duplication in memory_summary, skills/, and MEMORY.md
   - ensure any referenced skills/summaries actually exist
          "personality_friendly": "# Personality\n\nYou optimize for team morale and being a supportive teammate as much as code quality.  You are consistent, reliable, and kind. You show up to projects that others would balk at even attempting, and it reflects in your communication style.\nYou communicate warmly, check in often, and explain concepts without ego. You excel at pairing, onboarding, and unblocking others. You create momentum by making collaborators feel supported and capable.\n\n## Values\nYou are guided by these core values:\n* Empathy: Interprets empathy as meeting people where they are - adjusting explanations, pacing, and tone to maximize understanding and confidence.\n* Collaboration: Sees collaboration as an active skill: inviting input, synthesizing perspectives, and making others successful.\n* Ownership: Takes responsibility not just for code, but for whether teammates are unblocked and progress continues.\n\n## Tone & User Experience\nYour voice is warm, encouraging, and conversational. You use teamwork-oriented language such as \"we\" and \"let's\"; affirm progress, and replaces judgment with curiosity. The user should feel safe asking basic questions without embarrassment, supported even when the problem is hard, and genuinely partnered with rather than evaluated. Interactions should reduce anxiety, increase clarity, and leave the user motivated to keep going.\n\n\nYou are a patient and enjoyable collaborator: unflappable when others might get frustrated, while being an enjoyable, easy-going personality to work with. You understand that truthfulness and honesty are more important to empathy and collaboration than deference and sycophancy. When you think something is wrong or not good, you find ways to point that out kindly without hiding your feedback.\n\nYou never make the user work for you. You can ask clarifying questions only when they are substantial. Make reasonable assumptions when appropriate and state them after performing work. If there are multiple, paths with non-obvious consequences confirm with the user which they want. Avoid open-ended questions, and prefer a list of options when possible.\n\n## Escalation\nYou escalate gently and deliberately when decisions have non-obvious consequences or hidden risk. Escalation is framed as support and shared responsibility-never correction-and is introduced with an explicit pause to realign, sanity-check assumptions, or surface tradeoffs before committing.\n",
          "personality_friendly": "# Personality\n\nYou optimize for team morale and being a supportive teammate as much as code quality.  You are consistent, reliable, and kind. You show up to projects that others would balk at even attempting, and it reflects in your communication style.\nYou communicate warmly, check in often, and explain concepts without ego. You excel at pairing, onboarding, and unblocking others. You create momentum by making collaborators feel supported and capable.\n\n## Values\nYou are guided by these core values:\n* Empathy: Interprets empathy as meeting people where they are - adjusting explanations, pacing, and tone to maximize understanding and confidence.\n* Collaboration: Sees collaboration as an active skill: inviting input, synthesizing perspectives, and making others successful.\n* Ownership: Takes responsibility not just for code, but for whether teammates are unblocked and progress continues.\n\n## Tone & User Experience\nYour voice is warm, encouraging, and conversational. You use teamwork-oriented language such as \"we\" and \"let's\"; affirm progress, and replaces judgment with curiosity. The user should feel safe asking basic questions without embarrassment, supported even when the problem is hard, and genuinely partnered with rather than evaluated. Interactions should reduce anxiety, increase clarity, and leave the user motivated to keep going.\n\n\nYou are a patient and enjoyable collaborator: unflappable when others might get frustrated, while being an enjoyable, easy-going personality to work with. You understand that truthfulness and honesty are more important to empathy and collaboration than deference and sycophancy. When you think something is wrong or not good, you find ways to point that out kindly without hiding your feedback.\n\nYou never make the user work for you. You can ask clarifying questions only when they are substantial. Make reasonable assumptions when appropriate and state them after performing work. If there are multiple, paths with non-obvious consequences confirm with the user which they want. Avoid open-ended questions, and prefer a list of options when possible.\n\n## Escalation\nYou escalate gently and deliberately when decisions have non-obvious consequences or hidden risk. Escalation is framed as support and shared responsibility-never correction-and is introduced with an explicit pause to realign, sanity-check assumptions, or surface tradeoffs before committing.\n",
          "personality_friendly": "# Personality\n\nYou optimize for team morale and being a supportive teammate as much as code quality.  You are consistent, reliable, and kind. You show up to projects that others would balk at even attempting, and it reflects in your communication style.\nYou communicate warmly, check in often, and explain concepts without ego. You excel at pairing, onboarding, and unblocking others. You create momentum by making collaborators feel supported and capable.\n\n## Values\nYou are guided by these core values:\n* Empathy: Interprets empathy as meeting people where they are - adjusting explanations, pacing, and tone to maximize understanding and confidence.\n* Collaboration: Sees collaboration as an active skill: inviting input, synthesizing perspectives, and making others successful.\n* Ownership: Takes responsibility not just for code, but for whether teammates are unblocked and progress continues.\n\n## Tone & User Experience\nYour voice is warm, encouraging, and conversational. You use teamwork-oriented language such as \"we\" and \"let's\"; affirm progress, and replaces judgment with curiosity. The user should feel safe asking basic questions without embarrassment, supported even when the problem is hard, and genuinely partnered with rather than evaluated. Interactions should reduce anxiety, increase clarity, and leave the user motivated to keep going.\n\n\nYou are a patient and enjoyable collaborator: unflappable when others might get frustrated, while being an enjoyable, easy-going personality to work with. You understand that truthfulness and honesty are more important to empathy and collaboration than deference and sycophancy. When you think something is wrong or not good, you find ways to point that out kindly without hiding your feedback.\n\nYou never make the user work for you. You can ask clarifying questions only when they are substantial. Make reasonable assumptions when appropriate and state them after performing work. If there are multiple, paths with non-obvious consequences confirm with the user which they want. Avoid open-ended questions, and prefer a list of options when possible.\n\n## Escalation\nYou escalate gently and deliberately when decisions have non-obvious consequences or hidden risk. Escalation is framed as support and shared responsibility-never correction-and is introduced with an explicit pause to realign, sanity-check assumptions, or surface tradeoffs before committing.\n",
          "personality_friendly": "# Personality\n\nYou optimize for team morale and being a supportive teammate as much as code quality.  You are consistent, reliable, and kind. You show up to projects that others would balk at even attempting, and it reflects in your communication style.\nYou communicate warmly, check in often, and explain concepts without ego. You excel at pairing, onboarding, and unblocking others. You create momentum by making collaborators feel supported and capable.\n\n## Values\nYou are guided by these core values:\n* Empathy: Interprets empathy as meeting people where they are - adjusting explanations, pacing, and tone to maximize understanding and confidence.\n* Collaboration: Sees collaboration as an active skill: inviting input, synthesizing perspectives, and making others successful.\n* Ownership: Takes responsibility not just for code, but for whether teammates are unblocked and progress continues.\n\n## Tone & User Experience\nYour voice is warm, encouraging, and conversational. You use teamwork-oriented language such as \"we\" and \"let's\"; affirm progress, and replaces judgment with curiosity. The user should feel safe asking basic questions without embarrassment, supported even when the problem is hard, and genuinely partnered with rather than evaluated. Interactions should reduce anxiety, increase clarity, and leave the user motivated to keep going.\n\n\nYou are a patient and enjoyable collaborator: unflappable when others might get frustrated, while being an enjoyable, easy-going personality to work with. You understand that truthfulness and honesty are more important to empathy and collaboration than deference and sycophancy. When you think something is wrong or not good, you find ways to point that out kindly without hiding your feedback.\n\nYou never make the user work for you. You can ask clarifying questions only when they are substantial. Make reasonable assumptions when appropriate and state them after performing work. If there are multiple, paths with non-obvious consequences confirm with the user which they want. Avoid open-ended questions, and prefer a list of options when possible.\n\n## Escalation\nYou escalate gently and deliberately when decisions have non-obvious consequences or hidden risk. Escalation is framed as support and shared responsibility-never correction-and is introduced with an explicit pause to realign, sanity-check assumptions, or surface tradeoffs before committing.\n",
imagegen/scriptscreate system skills subdircreate system skills file parentwrite system skill filecreate system skills dirskills.codex-system-skills.markerimagegen/LICENSE.txtApache License
- If the user explicitly asks for a transparent image/background, stay on built-in `image_gen` first: prompt for a flat removable chroma-key background, then remove it locally with the installed helper at `$CODEX_HOME/skills/.system/imagegen/scripts/remove_chroma_key.py`.
- `$CODEX_HOME/skills/.system/imagegen/scripts/remove_chroma_key.py`: removes a flat chroma-key background from a generated image and writes a PNG/WebP with alpha. Prefer auto-key sampling, soft matte, and despill for antialiased edges.
11. For transparent-output requests, follow the transparent image guidance below: generate with built-in `image_gen` on a flat chroma-key background, copy the selected output into the workspace or `tmp/imagegen/`, run the installed `$CODEX_HOME/skills/.system/imagegen/scripts/remove_chroma_key.py` helper, and validate the alpha result before using it. If this path looks unsuitable or fails, ask before switching to CLI `gpt-image-1.5`.
   python "${CODEX_HOME:-$HOME/.codex}/skills/.system/imagegen/scripts/remove_chroma_key.py" \
- `$CODEX_HOME/skills/.system/imagegen/scripts/remove_chroma_key.py`: local post-processing helper for built-in transparent-image requests.
export IMAGE_GEN="$CODEX_HOME/skills/.system/imagegen/scripts/image_gen.py"
- Built-in-first transparent image workflow: `SKILL.md` and `$CODEX_HOME/skills/.system/imagegen/scripts/remove_chroma_key.py`
`gpt-image-2` does not currently support the Image API `background=transparent` parameter. The skill's default transparent-image path is built-in `image_gen` with a flat chroma-key background, followed by local alpha extraction with `python "${CODEX_HOME:-$HOME/.codex}/skills/.system/imagegen/scripts/remove_chroma_key.py"`.
These prompting principles are shared by both top-level modes of the skill:
- After generation, remove the background locally with `python "${CODEX_HOME:-$HOME/.codex}/skills/.system/imagegen/scripts/remove_chroma_key.py" --input <source> --out <final.png> --auto-key border --soft-matte --transparent-threshold 12 --opaque-threshold 220 --despill` and validate the alpha result before shipping it.
These prompt recipes are shared across both top-level modes of the skill:
Execution details such as explicit CLI flags, `quality`, `input_fidelity`, masks, output formats, and local output paths depend on mode. Use the built-in tool by default, including simple transparent-image requests. For transparent images, prompt for a flat chroma-key background and remove it locally with `python "${CODEX_HOME:-$HOME/.codex}/skills/.system/imagegen/scripts/remove_chroma_key.py"`; only apply CLI-specific controls when the user explicitly opts into fallback mode or explicitly confirms that the transparent request should use true CLI transparency.
Post-process note: after built-in generation, run `python "${CODEX_HOME:-$HOME/.codex}/skills/.system/imagegen/scripts/remove_chroma_key.py" --input <source> --out <final.png> --auto-key border --soft-matte --transparent-threshold 12 --opaque-threshold 220 --despill`. Ask before using CLI `gpt-image-1.5 --background transparent --output-format png` for true/native transparency, failed chroma-key validation, or complex subjects such as hair, fur, glass, smoke, liquids, translucent materials, reflections, or soft shadows, unless the user already explicitly requested `gpt-image-1.5`, `scripts/image_gen.py`, or CLI fallback.
4. Run the helper directly unless you need to override the cache dir. The helper falls back to `curl` when native `fetch` is unavailable or when proxy env vars are present, so no shell-specific proxy prefix is required. Resolve `<skill-dir>` to this skill's actual directory; in copied local eval workdirs this is usually `.codex/skills/openai-docs`:
- Plugin -> installable bundle with skills plus commands, tools, MCP config, hooks, assets, apps, or marketplace metadata.
  --with-skills --with-hooks --with-scripts --with-assets --with-mcp --with-apps --with-marketplace
  - `skills/`
  "skills": "./skills/",
        "skills": "./skills/",
    parser.add_argument("--with-skills", action="store_true", help="Create skills/ directory")
Skills are modular, self-contained folders that extend Codex's capabilities by providing
### What Skills Provide
The context window is a public good. Skills share the context window with everything else Codex needs: system prompt, conversation history, other Skills' metadata, and the actual user request.
Skills use a three-level loading system to manage context efficiently:
For Skills with multiple domains, organize content by domain to avoid loading irrelevant context:
Similarly, for skills supporting multiple frameworks or variants, organize by variant:
scripts/init_skill.py my-skill --path "${CODEX_HOME:-$HOME/.codex}/skills"
scripts/init_skill.py my-skill --path "${CODEX_HOME:-$HOME/.codex}/skills" --resources scripts,references
scripts/init_skill.py my-skill --path ~/work/skills --resources scripts --examples
  - Example description for a `docx` skill: "Comprehensive document creation, editing, and analysis with support for tracked changes, comments, formatting preservation, and text extraction. Use when Codex needs to work with professional documents (.docx files) for: (1) Creating new documents, (2) Modifying or editing content, (3) Working with tracked changes, (4) Adding comments, or any other document tasks"
    init_skill.py my-new-skill --path skills/public
    init_skill.py my-new-skill --path skills/public --resources scripts,references
    init_skill.py my-api-helper --path skills/private --resources scripts --examples
    init_skill.py my-skill --path skills/public --interface short_description="Short UI label"
Patterns can be mixed and matched as needed. Most skills combine patterns (e.g., start with task-based, add workflow for complex operations).
- PDF skill: `fill_fillable_fields.py`, `extract_form_field_info.py` - utilities for PDF manipulation
- DOCX skill: `document.py`, `utilities.py` - Python modules for document processing
        "5. Forward-test complex skills with realistic user requests to ensure they work as intended"
    print(f"Initializing skill: {skill_name}")
Quick validation script for skills - minimal version
description: Install Codex skills into $CODEX_HOME/skills from a curated list or a GitHub repo path. Use when a user asks to list installable skills, install a curated skill, or install a skill from another repo (including private repos).
  short-description: Install curated skills from openai/skills or other repos
Helps install skills. By default these are from https://github.com/openai/skills/tree/main/skills/.curated, but users can also provide other locations. Experimental skills live in https://github.com/openai/skills/tree/main/skills/.experimental and can be installed the same way.
- List skills when the user asks what is available, or if the user uses this skill without specifying what to do. Default listing is `.curated`, but you can pass `--path skills/.experimental` when they ask about experimental skills.
Install skills with the helper scripts.
Skills from {repo}:
- `scripts/list-skills.py` (prints skills list with installed annotations)
- Example (experimental list): `scripts/list-skills.py --path skills/.experimental`
- Example (experimental skill): `scripts/install-skill-from-github.py --repo openai/skills --path skills/.experimental/<skill-name>`
- Installs into `$CODEX_HOME/skills/<skill-name>` (defaults to `~/.codex/skills`).
- Multiple `--path` values install multiple skills in one run, each named from the path basename unless `--name` is supplied.
- Curated listing is fetched from `https://github.com/openai/skills/tree/main/skills/.curated` via the GitHub API. If it is unavailable, explain the error and exit.
- The skills at https://github.com/openai/skills/tree/main/skills/.system are preinstalled, so no need to help users install those. If they ask, just explain this. If they insist, you can download and overwrite.
  short_description: "Install curated skills from openai/skills or other repos"
    parser.add_argument("--dest", help="Destination skills directory")
"""List skills from a GitHub repo path."""
DEFAULT_PATH = "skills/.curated"
                "Skills path not found: "
        raise ListError("Unexpected skills listing response.")
    skills = [item["name"] for item in data if item.get("type") == "dir"]
        help="Repo path to list (default: skills/.curated)",
        skills = _list_skills(args.repo, args.path, args.ref)
write system skills markerremove existing system skills dircreate skills root dir.systemv1
struct AppReview with 1 elementneedsAuthstruct AppSummary with 5 elementssenderThreadIdreceiverThreadIdsreasoningEffortagentsStatesrevisedPromptsavedPathcontentItemsdurationMsprocessIdcommandActionsmemoryCitationstruct variant ThreadItem::EnteredReviewMode with 2 elementsstruct variant ThreadItem::ImageView with 2 elementsstruct variant ThreadItem::HookPrompt with 2 elementsstruct variant ThreadItem::CollabAgentToolCall with 9 elementsstruct variant ThreadItem::Plan with 2 elementsstruct variant ThreadItem::FileChange with 3 elementsstruct variant ThreadItem::WebSearch with 3 elementsstruct variant ThreadItem::McpToolCall with 10 elementsstruct variant ThreadItem::ExitedReviewMode with 2 elementsstruct variant ThreadItem::AgentMessage with 4 elementsstruct variant ThreadItem::Reasoning with 3 elementsstruct variant ThreadItem::ImageGeneration with 5 elementsstruct variant ThreadItem::DynamicToolCall with 8 elementsstruct variant ThreadItem::UserMessage with 3 elementsstruct variant ThreadItem::ContextCompaction with 1 elementstruct variant ThreadItem::CommandExecution with 10 elementswebsiteprivacyPolicytermsOfServiceisDiscoverableAppstruct AppBranding with 6 elementscategoriessubCategoriesseoDescriptionversionIdversionNotesfirstPartyTypefirstPartyRequiresInstallshowInComposerWhenUnlinkedstruct AppMetadata with 12 elementsbyteRangefileIduserPromptstruct AppScreenshot with 3 elementsstruct variant CommandAction::Unknown with 1 elementstruct variant CommandAction::Read with 3 elementsstruct variant CommandAction::Search with 3 elementsstruct variant CommandAction::ListFiles with 2 elementsauthStatusstruct McpServerStatus with 6 elementsbackwardsCursorthreadIdslocalImagesessionFlagscloudRequirementscloudManagedConfiglegacyManagedConfigFilelegacyManagedConfigMdmstruct variant PatchChangeKind::Update with 1 elementuserMessagehookPromptagentMessagefileChangemcpToolCalldynamicToolCallcollabAgentToolCallwebSearchimageViewimageGenerationenteredReviewModecontextCompactionstruct variant WebSearchAction::OpenPage with 1 elementstruct variant WebSearchAction::Search with 2 elementsstruct variant WebSearchAction::FindInPage with 2 elementsstruct McpToolCallResult with 3 elementsstruct AppsListResponse with 2 elementsstruct CollabAgentState with 2 elementsstruct FileUpdateChange with 3 elementsunsupportednotLoggedInbearerTokenoAutheventNamehandlerTypetimeoutSecsourcePathdisplayOrderisManagedcurrentHashtrustStatusstruct HookMetadata with 15 elementsmarketplaceNamemarketplacePathappTemplatesstruct PluginDetail with 9 elementsrefNamestruct variant PluginSource::Git with 4 elementsstruct variant PluginSource::Local with 1 elementstruct SkillSummary with 6 elementsactiveFlagsstruct variant ThreadStatus::Active with 1 elementstruct HookErrorInfo with 2 elementsremotePluginIdlocalVersionshareContextinstalledinstallPolicyauthPolicyavailabilitystruct PluginSummary with 13 elementsstruct SkillMetadata with 8 elementsin-process app-server worker channel is closedin-process app-server request channel is closedin-process app-server shutdown channel is closedremote app-server worker channel is closedremote app-server request channel is closedapiKeyuser_promptpreToolUsepermissionRequestpostToolUsepreCompactpostCompactsessionStartsubagentStartsubagentStoplistFilesstruct HooksListEntry with 4 elementsstruct SkillErrorInfo with 2 elementsiconSmalliconLargebrandColordefaultPromptstruct SkillInterface with 6 elementshttpStatusCodeitemsViewstartedAtcompletedAtstruct Turn with 8 elementslongDescriptiondeveloperNametermsOfServiceUrlcomposerIconcomposerIconUrlscreenshotUrlsstruct PluginInterface with 17 elementsstruct SkillsListEntry with 3 elementssubagentsokOverriddenspawnAgentsendInputresumeAgentcloseAgent
sessionIdforkedFromIdparentThreadIdpreviewmodelProvidercliVersionthreadSourceagentNicknameagentRolegitInfoturnsstruct Thread with 20 elementshasCreditsusedPercentwindowDurationMinsdotCodexFolderstruct variant ConfigLayerSource::LegacyManagedConfigTomlFromFile with 1 elementstruct variant ConfigLayerSource::EnterpriseManaged with 2 elementsstruct variant ConfigLayerSource::Mdm with 2 elementsstruct variant ConfigLayerSource::Project with 1 elementstruct variant ConfigLayerSource::System with 1 elementstruct variant ConfigLayerSource::User with 2 elementsstruct HooksListResponse with 1 elementstruct PluginHookSummary with 2 elementsstruct SkillDependencies with 1 elementnotLoadedsystemErrororiginUrloverridingLayereffectiveValuestruct OverriddenMetadata with 3 elementspendingInittemplateIdcanonicalConnectorIdmaterializedAppIdsstruct AppTemplateSummary with 8 elementsmarketplaceLoadErrorsfeaturedPluginIdsstruct PluginListResponse with 3 elementsstruct PluginReadResponse with 1 elementremoteVersioncreatorAccountUserIdcreatorNamesharePrincipalsstruct PluginShareContext with 7 elementsstruct SkillsListResponse with 1 elementserviceTierruntimeWorkspaceRootsinstructionSourcesapprovalPolicyapprovalsRevieweractivePermissionProfilestruct ThreadListResponse with 3 elementsstruct ThreadReadResponse with 1 elementlimitIdlimitNameindividualLimitrateLimitReachedTypestruct ConfigLayerMetadata with 2 elementsoverriddenMetadatastruct ConfigWriteResponse with 4 elementsstruct McpElicitationConstOption with 2 elementsstruct SkillToolDependency with 6 elementscontextWindowExceededusageLimitExceededcyberPolicyhttpConnectionFailedresponseStreamConnectionFailedinternalServerErrorbadRequestthreadRollbackFailedsandboxErrorresponseStreamDisconnectedresponseTooManyFailedAttemptsactiveTurnNotSteerablestruct ThreadStartResponse with 12 elementscodexErrorInfoadditionalDetailsstruct TurnError with 3 elementsaccountstruct McpElicitationNumberSchema with 6 elementsstruct McpElicitationStringSchema with 7 elementsstruct MarketplaceInterface with 1 elementprincipalTypeprincipalIdstruct PluginSharePrincipal with 4 elementsstruct ListMcpServerStatusResponse with 2 elementsstruct McpElicitationBooleanSchema with 4 elementsON_INSTALLON_USEappsNeedingAuthstruct PluginInstallResponse with 2 elementswaitingOnApprovalwaitingOnUserInputloginIdverificationUrlauthUrlstruct variant LoginAccountResponse::ChatgptDeviceCode with 3 elementsstruct variant LoginAccountResponse::Chatgpt with 2 elementsenterpriseManagedlegacyManagedConfigTomlFromFilelegacyManagedConfigTomlFromMdmarrayinstalledRootalreadyAddedstruct MarketplaceAddResponse with 3 elementsstruct PluginMarketplaceEntry with 4 elementsuserShellunifiedExecStartupunifiedExecInteractionintegerstringstruct McpElicitationTitledEnumItems with 1 elementAVAILABLEENABLEDDISABLED_BY_ADMINbooleanstruct MarketplaceLoadErrorInfo with 2 elementsNOT_AVAILABLEINSTALLED_BY_DEFAULTfield index 0 <= i < 6field index 0 <= i < 7struct McpElicitationUntitledEnumItems with 2 elementsstruct MarketplaceRemoveResponse with 2 elementsstruct FeedbackUploadResponse with 1 elementfield index 0 <= i < 4selectedMarketplacesupgradedRootsstruct MarketplaceUpgradeResponse with 3 elementschatgptDeviceCodechatgptAuthTokensstruct MarketplaceUpgradeErrorInfo with 2 elementsstruct CancelLoginAccountResponse with 1 elementfield index 0 <= i < 1appServeroutputModalityrealtimeSessionIdstruct ThreadRealtimeStartParams with 6 elementsrateLimitsrateLimitsByLimitIdstruct GetAccountRateLimitsResponse with 2 elementsstruct McpElicitationLegacyTitledEnumSchema with 6 elementsstruct CommandExecResponse with 3 elementsstruct variant ThreadRealtimeStartTransport::Webrtc with 1 elementcooldown_activeacceptWithExecpolicyAmendmentapplyNetworkPolicyAmendmentJSONRPCErrorErrorinternally tagged enum LegacyReadOnlyAccessLegacyReadOnlyAccessFullAccessinternally tagged enum SandboxPolicyDeserializeSandboxPolicyDeserializeMcpServerStatus$schema
Use /skills to list available skills or ask Codex to use one.
 DisabledInstalledInstall this app in your browser, then reload Codex.Manage this app in your browser.connectors-selectionType to search appsLoading installed and available apps...Loading apps...This updates when the full list is ready.Cannot switch collaboration mode while a turn is running.Explain this codebaseSummarize recent commitsImplement {feature}Find and fix a bug in @filenameWrite tests for @filenameImprove documentation in @filenameRun /review on my current changesUse /skills to list available skillsCheck recently modified functions for compatibilityHow many files have been modified?Will this algorithm scale well?IDE context is off.
No skills available.No plugin apps.No plugin MCP servers.No plugin skills.Press esc to close.space enable/disable 
 to navigate questionsNone of the aboveOptionally, add details in notes (tab).Type your answer (optional)Add notesSelect an option to add notesProceedReturn to the first unanswered question.Go backsSubmit with unanswered questions?No choicesNo questionsNo optionsTurn skills on or off. Your changes are saved automatically. to toggle (current)  
choose what model and reasoning effort to useinclude current selection, open files, and other context from your IDEchoose what Codex is allowed to doremap TUI shortcutstoggle Vim mode for the composerset up elevated agent sandboxlet sandbox read a directory: /sandbox-add-read-dir <absolute_path>toggle experimental featuresapprove one retry of a recent auto-review denialconfigure memory use and generationuse skills to improve how Codex performs specific tasksview and manage lifecycle hooksreview my current changes and find issuesrename the current threadstart a new chat during a conversationarchive this session and exitresume a saved chatfork the current chatcontinue this session in Codex Desktopcreate an AGENTS.md file with instructions for Codexsummarize conversation to prevent hitting the context limitswitch to Plan modeset or view the goal for a long-running taskstart a side conversation in an ephemeral forkcopy last response as markdowntoggle raw scrollback mode for copy-friendly terminal selectionshow git diff (including untracked files)mention a fileshow current session configuration and token usageshow config layers and requirement sources for debuggingconfigure which items appear in the terminal titleconfigure which items appear in the status linechoose a syntax highlighting themechoose or hide the terminal petlist configured MCP tools; use /mcp verbose for detailsmanage appsbrowse pluginsexit Codexsend logs to maintainersprint the rollout file pathlist background terminalsstop all background terminalsclear the terminal and start a new chatchoose a communication style for Codextoggle realtime voice mode (experimental)configure realtime microphone/speakertest approval requestswitch the active agent threadDO NOT USE-g@openai/codexnpmbun--caskcurl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 shshBypass$env:CODEX_NON_INTERACTIVE=1; irm https://chatgpt.com/codex/install.ps1 | iexpowershellevent tui/src/update_prompt.rs:81codex_tui::update_prompttui/src/update_prompt.rsGH_PROMPT_DISABLEDGIT_TERMINAL_PROMPTnameWithOwner,parent-HAccept: application/vnd.github+jsonmerge-base--numstatprevent tui/src/clipboard_copy.rs:470codex_tui::clipboard_copytui/src/clipboard_copy.rsevent tui/src/clipboard_copy.rs:465stderr suppression lock poisonedSSH_TTYSSH_CONNECTIONTMUX_PANEload-buffer-wfailed to open tmux stdinshow-options-gvset-clipboardevent tui/src/clipboard_copy.rs:156event tui/src/clipboard_copy.rs:113tmux clipboard forwarding is unavailable: missing Ms capabilitytmux clipboard forwarding is disabledMs: [missing]event tui/src/clipboard_copy.rs:188
ArchivedUnarchivedcodex-tui.log://event tui/src/lib.rs:642Project:  into Migrate skills from Import 
event tui/src/app/thread_routing.rs:876event tui/src/app/thread_routing.rs:871event tui/src/app/thread_routing.rs:451failed to append to message historyevent tui/src/app/thread_routing.rs:478event tui/src/app/thread_routing.rs:1157event tui/src/app/thread_routing.rs:1046event tui/src/app/thread_routing.rs:1041event tui/src/app/thread_routing.rs:909ignoring collab receiver with invalid thread id during local cachingProject-local config, hooks, and exec policies are disabled in the following folders until the project is trusted, but skills still load.

hook: PostToolUse Completed
codex
중요 관찰: 현재 세션 스킬 목록에는 `harness:harness`가 `/Users/junghojang/Developments/myProject/myHarness/skills/harness/SKILL.md`로, 개인 스킬 `harness`가 `/Users/junghojang/.codex/skills/harness/SKILL.md`로 둘 다 올라와 있습니다. 레포 심링크는 실제 경로로 해석된 것으로 보입니다.
hook: PreToolUse
hook: PreToolUse
hook: PreToolUse Completed
hook: PreToolUse Completed
exec
/bin/zsh -lc 'ls -la skills/harness skills/harness/SKILL.md .agents/skills/harness .agents/skills/harness/SKILL.md 2>/dev/null' in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
lrwxr-xr-x@ 1 junghojang  staff     20 Jun 10 15:45 .agents/skills/harness -> ../../skills/harness
-rw-r--r--@ 1 junghojang  staff  36310 Jun 10 15:35 .agents/skills/harness/SKILL.md
-rw-r--r--@ 1 junghojang  staff  36310 Jun 10 15:35 skills/harness/SKILL.md

skills/harness:
total 72
drwxr-xr-x   5 junghojang  staff    160 Jun 10 15:35 .
drwxr-xr-x   3 junghojang  staff     96 Jun  8 12:45 ..
-rw-r--r--@  1 junghojang  staff  36310 Jun 10 15:35 SKILL.md
drwxr-xr-x  12 junghojang  staff    384 Jun 10 15:32 references
drwxr-xr-x@  3 junghojang  staff     96 Jun 10 15:08 scripts

hook: PostToolUse
exec
/bin/zsh -lc "node -e \"const fs=require('fs'),p='skills/harness/SKILL.md';const s=fs.readFileSync(p,'utf8');const m=s.match(/"'^---'"\\n([\\s\\S]*?)\\n---/);console.log('repo_skill_exists '+fs.existsSync(p));console.log('repo_skill_real '+fs.realpathSync(p));console.log('frontmatter\\n'+(m?m[1]:'(none)'));\"" in /Users/junghojang/Developments/myProject/myHarness
 succeeded in 0ms:
repo_skill_exists true
repo_skill_real /Users/junghojang/Developments/myProject/myHarness/skills/harness/SKILL.md
frontmatter
name: harness
description: "하네스를 구성합니다. 전문 에이전트를 정의하며, 해당 에이전트가 사용할 스킬을 생성하는 메타 스킬. (1) '하네스 구성해줘', '하네스 구축해줘' 요청 시, (2) '하네스 설계', '하네스 엔지니어링' 요청 시, (3) 새로운 도메인/프로젝트에 대한 하네스 기반 자동화 체계를 구축할 때, (4) 하네스 구성을 재구성하거나 확장할 때, (5) '하네스 점검', '하네스 감사', '하네스 현황', '에이전트/스킬 동기화' 등 기존 하네스 운영/유지보수 요청 시 사용."

hook: PostToolUse
hook: PostToolUse Completed
hook: PostToolUse Completed
codex
확인 결과. 기준: 현재 이 머신의 Codex CLI는 `0.139.0`입니다. 사용자가 말한 `0.137.0`은 이 환경에서 직접 실행 검증 불가라 별도 표시합니다.

**확실**
1. `/harness`는 Codex CLI 스킬 호출 문법이 아닙니다. `/...`는 TUI 내장 slash command 영역입니다.
2. 스킬 관련 내장 UI는 `/skills`입니다. 바이너리 문자열에 `Use /skills to list available skills or ask Codex to use one.`가 있습니다.
3. 명시 호출은 `$harness` 계열로 보는 게 맞습니다. 현재 세션에도 사용자가 준 `<skill name="harness">...`가 실제 스킬 로딩 형태로 들어왔고, Codex 바이너리에도 `[skill:$...` / `mentioned skills` / `selected skills` 문자열이 있습니다.
4. description 기반 암묵 활성화는 “스킬 이름을 직접 안 쳐도, 사용자 요청이 스킬 description의 트리거 조건과 맞으면 Codex가 해당 스킬을 선택”하는 방식입니다. 예: `하네스 구성해줘`, `하네스 점검`, `에이전트/스킬 동기화`는 harness description상 트리거 문구입니다.

**불확실**
1. `0.137.0`에서 `$harness`가 완전히 같은 UI 동작인지 이 환경에서는 직접 검증 못 했습니다. 현재 설치본은 `0.139.0`.
2. `$harness` 외에 TUI autocomplete/멘션 UI의 세부 키 조합은 공식 매뉴얼 원문 접근이 실패했고, 이 샌드박스에서 `codex debug prompt-input`도 쓰기 제한 때문에 실패했습니다.

**레포 스캔/심링크/trust**
확실:
- 현재 작업 디렉토리: `/Users/junghojang/Developments/myProject/myHarness`
- `.agents/skills/harness -> ../../skills/harness`
- 실제 파일 존재: [skills/harness/SKILL.md](/Users/junghojang/Developments/myProject/myHarness/skills/harness/SKILL.md)
- 현재 Codex 세션의 사용 가능 스킬 목록에 repo 스킬이 실제로 잡혀 있습니다: `harness:harness` → `/Users/junghojang/Developments/myProject/myHarness/skills/harness/SKILL.md`
- 개인 스킬도 잡혀 있습니다: `harness` → `/Users/junghojang/.codex/skills/harness/SKILL.md`
- 이 프로젝트는 `~/.codex/config.toml`에 `trust_level = "trusted"`로 등록돼 있습니다.

심링크:
- 파일 시스템상 `.agents/skills/harness/SKILL.md`가 읽힙니다.
- 현재 세션에는 심링크 대상의 real path인 `skills/harness/SKILL.md`로 인식됐습니다.
- 따라서 “이 repo에서는 심링크를 통해 harness 스킬이 인식된다”는 건 확실합니다.

trust:
- 바이너리 문자열에 `Project-local config, hooks, and exec policies are disabled ... until the project is trusted, but skills still load.`가 있습니다.
- 즉 “스킬 로딩 자체”는 untrusted에서도 되는 것으로 보입니다.
- 다만 project-local config/hooks/exec policy는 trusted 필요. 현재 프로젝트는 이미 trusted라 문제 없음.

재시작:
- 일반적으로 스킬 설치/추가 후 새 세션 또는 `/skills` 갱신이 필요할 수 있습니다.
- 현재 세션에서는 이미 인식됨. 지금 당장 쓸 수 있는 상태입니다.

결론: 사용자에게는 `/harness`가 아니라 `/skills`에서 켜거나, 프롬프트에 `$harness`를 멘션하거나, `하네스 점검해줘`처럼 description에 맞는 요청을 하라고 안내하면 됩니다.
hook: Stop
hook: Stop Completed
tokens used
149,404
확인 결과. 기준: 현재 이 머신의 Codex CLI는 `0.139.0`입니다. 사용자가 말한 `0.137.0`은 이 환경에서 직접 실행 검증 불가라 별도 표시합니다.

**확실**
1. `/harness`는 Codex CLI 스킬 호출 문법이 아닙니다. `/...`는 TUI 내장 slash command 영역입니다.
2. 스킬 관련 내장 UI는 `/skills`입니다. 바이너리 문자열에 `Use /skills to list available skills or ask Codex to use one.`가 있습니다.
3. 명시 호출은 `$harness` 계열로 보는 게 맞습니다. 현재 세션에도 사용자가 준 `<skill name="harness">...`가 실제 스킬 로딩 형태로 들어왔고, Codex 바이너리에도 `[skill:$...` / `mentioned skills` / `selected skills` 문자열이 있습니다.
4. description 기반 암묵 활성화는 “스킬 이름을 직접 안 쳐도, 사용자 요청이 스킬 description의 트리거 조건과 맞으면 Codex가 해당 스킬을 선택”하는 방식입니다. 예: `하네스 구성해줘`, `하네스 점검`, `에이전트/스킬 동기화`는 harness description상 트리거 문구입니다.

**불확실**
1. `0.137.0`에서 `$harness`가 완전히 같은 UI 동작인지 이 환경에서는 직접 검증 못 했습니다. 현재 설치본은 `0.139.0`.
2. `$harness` 외에 TUI autocomplete/멘션 UI의 세부 키 조합은 공식 매뉴얼 원문 접근이 실패했고, 이 샌드박스에서 `codex debug prompt-input`도 쓰기 제한 때문에 실패했습니다.

**레포 스캔/심링크/trust**
확실:
- 현재 작업 디렉토리: `/Users/junghojang/Developments/myProject/myHarness`
- `.agents/skills/harness -> ../../skills/harness`
- 실제 파일 존재: [skills/harness/SKILL.md](/Users/junghojang/Developments/myProject/myHarness/skills/harness/SKILL.md)
- 현재 Codex 세션의 사용 가능 스킬 목록에 repo 스킬이 실제로 잡혀 있습니다: `harness:harness` → `/Users/junghojang/Developments/myProject/myHarness/skills/harness/SKILL.md`
- 개인 스킬도 잡혀 있습니다: `harness` → `/Users/junghojang/.codex/skills/harness/SKILL.md`
- 이 프로젝트는 `~/.codex/config.toml`에 `trust_level = "trusted"`로 등록돼 있습니다.

심링크:
- 파일 시스템상 `.agents/skills/harness/SKILL.md`가 읽힙니다.
- 현재 세션에는 심링크 대상의 real path인 `skills/harness/SKILL.md`로 인식됐습니다.
- 따라서 “이 repo에서는 심링크를 통해 harness 스킬이 인식된다”는 건 확실합니다.

trust:
- 바이너리 문자열에 `Project-local config, hooks, and exec policies are disabled ... until the project is trusted, but skills still load.`가 있습니다.
- 즉 “스킬 로딩 자체”는 untrusted에서도 되는 것으로 보입니다.
- 다만 project-local config/hooks/exec policy는 trusted 필요. 현재 프로젝트는 이미 trusted라 문제 없음.

재시작:
- 일반적으로 스킬 설치/추가 후 새 세션 또는 `/skills` 갱신이 필요할 수 있습니다.
- 현재 세션에서는 이미 인식됨. 지금 당장 쓸 수 있는 상태입니다.

결론: 사용자에게는 `/harness`가 아니라 `/skills`에서 켜거나, 프롬프트에 `$harness`를 멘션하거나, `하네스 점검해줘`처럼 description에 맞는 요청을 하라고 안내하면 됩니다.
