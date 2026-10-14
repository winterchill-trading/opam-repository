# opam-repository

The opam repository for the winterchill-trading libraries. It sits next to the OxCaml
repository in a switch, so our packages install by name and version, with no
`opam pin`. This is the only place these packages are published.

## Use it

On an existing OxCaml switch (`5.2.0+ox`, with the OxCaml repository already added):

```sh
opam repo add winterchill https://github.com/winterchill-trading/opam-repository.git
opam install fixed-decimal money pg-async
```

On a new switch, with all three repositories in one command:

```sh
opam switch create 5.2.0+ox \
  --repos winterchill=git+https://github.com/winterchill-trading/opam-repository.git,ox=git+https://github.com/oxcaml/opam-repository.git,default
```

`opam update winterchill` picks up new entries.

## Packages

| Package | Version | Source commit | OxCaml-only | Notes |
| --- | --- | --- | --- | --- |
| `pg-async` | 0.1.0 | `65fda87` | no | Also builds on upstream OCaml 5.2 with Jane Street v0.17. Needs libpq. |
| `fixed-decimal` | 0.1.0 | `7efc3ae` | yes | |
| `money` | 0.1.0 | `53e2d0f` | yes | |
| `money-cli` | 0.1.0 | `53e2d0f` | yes | The `money` command. |
| `ledger` | 0.1.0 | `e2822f9` | yes (through `money`) | |
| `venue-net` | 0.1.0 | `97fc083` | yes (Jane Street v0.18 previews) | |
| `parquet` | 0.1.0 | `b3141c1` | yes | Needs libzstd. |
| `service-kit` | 0.1.0 | `1bf7076` | no |  |
| `otp-mail` | 0.1.0 | `65f0b50` | no | Needs OpenSSL (async_ssl). |
| `auth-kit` | 0.1.0 | `c1fc2d3` | no | Needs libargon2 (pkg-config). |
| `webauthn` | 0.1.0 | `cff2297` | yes |  |
| `kyc-core` | 0.1.0 | `ceba7ca` | no |  |
| `payments-core` | 0.1.0 | `b315028` | yes (through `money`) |  |
| `card-core` | 0.1.0 | `1c6ea5a` | yes (through `money`) |  |
| `risk-rules` | 0.1.0 | `a444aad` | yes (through `money`) |  |
| `banking-provider` | 0.1.0 | `61aa5ef` | yes (through `money`) |  |
| `fx-core` | 0.1.0 | `7b33240` | yes |  |
| `scheduler-core` | 0.1.0 | `9a85ee2` | yes |  |

Not here yet: `order-book`. It depends on `exchange-core`, which is not in this
repository, and `exchange-core`'s second package `exchange-core-engine` depends back on
`order-book`. It can be added once `exchange-core` (the library package alone) is audited
and listed, or once the primitives `order-book` uses move into a package of their own.

## Rules

- Every entry pins an exact commit: `url { src: "git+https://github.com/winterchill-trading/<repo>.git#<40-hex commit>" }`.
  The library repositories are not tagged; the commit is the audited head named in that
  library's opam-readiness audit.
- Each `opam` file is the one dune generated at that commit, with the header comment
  removed, the `url` section added and bounds on our own packages
  (`{>= "0.1.0" & < "0.2~"}`). No `name`, `version` or `pin-depends` fields: name and
  version come from the directory.
- Packages are OxCaml-only unless the table above says otherwise. OxCaml-only packages
  depend on `oxcaml`; without the OxCaml repository that resolves to a package that
  fails with instructions for adding it.
- Versions follow semver. Below `1.0.0` a minor bump may break the API and a patch bump
  never does. The first entry of every package is `0.1.0`.
- Only our own packages. Never a fork or a patched copy of someone else's package.
- `main` is the published state: merging into it is publishing.

## Adding a version

1. Pick the commit in the library repository (its `main`, after the release checklist).
2. Copy `<name>.opam` from that commit to `packages/<name>/<name>.<version>/opam`, drop
   the generated-file comment, add the `url` section with the full commit hash, and bound
   dependencies on our other packages.
3. `scripts/check.sh` must pass (`opam lint`, the directory layout, an exact-commit url,
   no `pin-depends`, an `x-maintenance-intent`).
4. Push or open a pull request; CI does the rest.

## CI

- `lint` runs `scripts/check.sh` over every entry.
- `install` builds a fresh OxCaml switch with the infra `ox-setup` action (third-party
  dependencies from `ci/ci-deps.opam`, cached between runs, no pins), adds this tree with
  `opam repo add`, runs `opam install --dry-run` and then a real install of `pg-async`,
  `fixed-decimal` and `money`. The remaining packages are installed one at a time in a
  step that reports failures without failing the job.

Tests are not run on install (`--with-test`): `pg-async`'s tests start PostgreSQL
clusters and `parquet`'s use the DuckDB CLI, neither of which is an opam package. Docs
(`--with-doc`) wait for `odoc` on the CI switch.

## License

MIT. Each package carries its own license, also MIT.
