# AGENTS.md

Guide for AI coding agents working in this repository. Read this first; the subdirectory
`AGENTS.md` files add detail for `packages/`, `scripts/`, `ci/` and `.github/`. The workspace-wide
guide is `../oxcaml-claude-skills/AGENTS.md`.

## Purpose

This is an opam repository for the winterchill-trading libraries. It sits next to the OxCaml
repository in a switch, so the packages install by name and version with no `opam pin`. Each
package entry pins an exact commit of a library repository. Merging into `main` publishes.

This repository is not built with dune. There is no OCaml code here.

## Layout

| Path | Holds |
| --- | --- |
| `repo` | The repository marker file (`opam-version: "2.0"`) |
| `packages/<name>/<name>.<version>/opam` | One entry per published version; forty-one packages at 0.1.0, some also at 0.1.1, 0.1.2 and 0.1.3 (the README table gives each package's latest) |
| `scripts/check.sh` | The lint: `opam lint` on every entry, the directory layout, the exact-commit url rule, no `pin-depends`, a maintenance intent |
| `ci/ci-deps.opam` | Third-party dependencies of the packages, installed by CI into a cached switch. It is not a package of this repository |
| `.github/workflows/ci.yml` | `lint` and `install` jobs |
| `README.md` | Usage, the package table, the rules, the CI description |

## Check, test, install

From the repository root, with `opam` installed:

```sh
bash scripts/check.sh
```

It prints `Passed.` per entry and exits 0 when every entry is valid. There are no unit tests.
Install checks run only in CI, against a fresh OxCaml switch. Locally, after adding this repository
to an existing `5.2.0+ox` switch: `opam repo add winterchill <path-to-this-repo>`, then
`opam install --dry-run <package>`.

## Conventions

- Every url is `git+https://github.com/winterchill-trading/<repo>.git#<40-hex commit>`. No branch
  names, tags, or `pin-depends`.
- Each `opam` file is the one dune generated in the library repository, with the header comment
  removed, the `url` section added, and bounds on our own packages (`{>= "0.1.0" & < "0.2~"}`).
  No `name` or `version` fields: they come from the directory.
- Versions are semver. Below 1.0.0 a minor bump may break the API; a patch bump never does.
- Only our own packages. Never a fork or patched copy of someone else's package.
- Add a version by copying the entry into `packages/<name>/<name>.<version>/opam` and running the check.

## Dependencies and dependents

- The packages depend on each other by name and on third-party packages from the OxCaml repository.
- `ci/ci-deps.opam` lists the third-party dependencies; keep it in step with what the packages need.

## CI

`.github/workflows/ci.yml`:

- `lint` runs `scripts/check.sh`.
- `install` sets up a switch with the infra `ox-setup` action from `ci/ci-deps.opam` (cached, no pins),
  adds this tree with `opam repo add`, dry-runs every package together, installs `pg-async`, `fixed-decimal` and `money`,
  then installs the rest one at a time and reports failures without failing the job.

Tests are not run on install. Check a run with `gh run list --limit 1`, then at most one
`gh run watch <id> --exit-status`.

## Pitfalls

- A package that depends on an OxCaml-only library fails with instructions when the OxCaml repository
  is missing. Keep `oxcaml` in the depends list of OxCaml-only packages.
- The exact-commit url rule is enforced by `scripts/check.sh`, not by `opam lint`, so run the script after every entry change.
- `pg-async` needs libpq and `parquet` needs libzstd on the machine that installs them.

## Where to read more

- `README.md`: usage, package table, rules, adding a version, CI.
- `../specs/research/opam-readiness/`: the audits behind each package entry.
- `../oxcaml-claude-skills/GOTCHAS.md`, section "Fiat rails: pg-async".

## Never do

- Merge into `main` or add a package version unless the user asks for a release: merging publishes.
- Add a `pin-depends`, a fork, or a patched copy of someone else's package.
- Commit credentials, print secrets, or poll CI in a loop.
- Install or upgrade opam packages that change the compiler, `core`, `base`, `async` or `ppx_jane`
  on the shared switch. Run `opam install --switch 5.2.0+ox --dry-run <pkg>` first.
