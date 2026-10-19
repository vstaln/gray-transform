#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-transform.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-transform" ;;
    *) rel="x86_64-apple-darwin/gray-transform" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-transform" ;;
    *) rel="x86_64-unknown-linux-musl/gray-transform" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-transform.exe" "$here/target/release/gray-transform" "$here/target/debug/gray-transform.exe" "$here/target/debug/gray-transform"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-transform binary not found in $here" >&2
exit 1
