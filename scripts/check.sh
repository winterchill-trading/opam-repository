#!/usr/bin/env bash
# Checks every package entry: opam lint, the directory layout, and the
# repository rules (the url pins an exact commit of one of our repositories,
# no pin-depends, a maintenance intent). Run from the repository root.
set -euo pipefail

status=0
fail() { echo "FAIL $1: $2"; status=1; }

[[ $(cat repo) == 'opam-version: "2.0"' ]] || fail repo 'want opam-version: "2.0"'

shopt -s nullglob
files=(packages/*/*/opam)
[[ ${#files[@]} -gt 0 ]] || fail packages "no package entries"
for f in "${files[@]}"; do
  dir=$(dirname "$f")
  name=$(basename "$(dirname "$dir")")
  version=$(basename "$dir")
  version=${version#"${name}".}
  [[ $(basename "$dir") == "${name}.${version}" ]] || fail "$f" "directory is not <name>.<version>"
  [[ ${version} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || fail "$f" "version ${version} is not semver"
  grep -Eq '^ +"git\+https://github\.com/winterchill-trading/[a-z0-9-]+\.git#[0-9a-f]{40}"$' "$f" \
    || fail "$f" "url must be git+https://github.com/winterchill-trading/<repo>.git#<40-hex commit>"
  ! grep -q '^pin-depends' "$f" || fail "$f" "pin-depends is not allowed"
  ! grep -Eq '^(name|version):' "$f" || fail "$f" "name and version come from the directory"
  grep -q '^x-maintenance-intent:' "$f" || fail "$f" "missing x-maintenance-intent"
  opam lint "$f" || fail "$f" "opam lint"
done
exit "${status}"
