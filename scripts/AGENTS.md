# AGENTS.md (scripts/)

`check.sh` is the only script. Run it from the repository root with `bash scripts/check.sh`. It
prints `FAIL <file>: <reason>` for each failing check and keeps going; it exits non-zero if any entry failed.

- It needs `opam` on the PATH (for `opam lint`).
- A failure in a new entry is a real failure: fix the entry, do not relax the check.
