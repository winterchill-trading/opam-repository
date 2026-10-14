# AGENTS.md (packages/)

One directory per package, and inside it one directory per version: `packages/<name>/<name>.<version>/opam`.

- Current entries: `fixed-decimal`, `ledger`, `money`, `money-cli`, `parquet`, `pg-async`, `venue-net`, all at 0.1.0.
- The directory name must equal `<name>.<version>`, and the version must be semver. `scripts/check.sh` enforces this.
- Copy the file from the library repository at the pinned commit; do not hand-edit its dependencies beyond
  the bounds on our own packages.
- Run `bash ../scripts/check.sh` after every change.
