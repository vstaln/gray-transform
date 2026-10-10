<div align="center">
  <img alt="gray-transform" src="assets/icon.svg" width="120" height="120" />
  <h1>gray-transform</h1>
  <p><strong>Rewrite or intercept submitted input, such as ?quick and ?verbose prefixes.</strong></p>
  <p>
    <a href="https://gray.alignment.id">Website</a> ·
    <a href="https://gray.alignment.id/plugins/gray-transform">Store</a> ·
    <a href="https://github.com/vstaln/gray-transform">Source</a> ·
    <a href="https://github.com/vstaln/gray">gray</a>
  </p>
  <p>
    <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-1c1c20?style=flat-square&labelColor=0a0a0b" /></a>
    <a href="https://www.rust-lang.org"><img alt="Built with Rust" src="https://img.shields.io/badge/built%20with-rust-1c1c20?style=flat-square&labelColor=0a0a0b&logo=rust&logoColor=d4a373" /></a>
    <a href="https://gray.alignment.id/plugins/gray-transform"><img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-1c1c20?style=flat-square&labelColor=0a0a0b&color=7aa2f7" /></a>
  </p>
</div>

<br/>

```bash
gray plugin install gray-transform
```

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

## Tags

`gray` `plugin` `transform` `rust`

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
