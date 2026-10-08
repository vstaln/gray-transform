# gray-transform

Rewrite or intercept submitted user input — a gray sidecar. Port of pi's
`input-transform` + `input-transform-streaming` extensions.

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
