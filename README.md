<p align="center">
  <img src="assets/gray-logo.svg" alt="gray" width="96">
</p>
<h1 align="center">gray-transform</h1>
<p align="center">Rewrite or intercept submitted user input — prefix rules and built-in intercepts.</p>
<p align="center">
  <a href="https://github.com/vstaln/gray-transform/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-7aa2f7.svg">
  <img alt="rust" src="https://img.shields.io/badge/built%20with-rust-orange.svg">
</p>

Rewrite or intercept submitted user input — a gray sidecar.

## What it does

Hooks `input/submit` (protocol 2.0) before each user turn:

| input | effect |
|---|---|
| `?quick <q>` | rewritten to `Respond briefly in 1-2 sentences: <q>` |
| `?verbose <q>` | rewritten to `Answer thoroughly with examples: <q>` |
| `ping` | `host/say` "pong", input swallowed (no turn) |
| `time` | `host/say` the local time, input swallowed |

Custom rules: `~/.gray/transform/rules.json` holds
`[{"prefix": "?x", "rewrite": "Do X with {rest}"}]` — `{rest}` is the text
after the prefix (appended when the placeholder is absent). Missing or
malformed file = built-ins only. `/transform` lists the active rules.

## Wire methods

- `plugin/manifest`, `plugin/shutdown`
- `input/submit` — `{text}` rewrite / `{handled:true}` swallow / `{}` pass
- `command/run` — `/transform`, `/transform list`
- sidecar→host `host/say` — capability `host.say` (a failed say never leaks
  the input through: `ping`/`time` still swallow)

## Install / consent

```sh
gray plugin install transform
gray plugin capabilities transform --all   # grants host.say
```

## Develop

```sh
cargo test
gray account check      # entry point + manifest handshake
gray account publish    # check → build → release → publish to the gray registry
```

Bump `version` in `Cargo.toml` before each `publish`; the registry refuses to
republish a version.

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
