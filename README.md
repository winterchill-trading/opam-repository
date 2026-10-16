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
| `service-kit` | 0.1.3 | `5d369b4` | no |  |
| `otp-mail` | 0.1.0 | `65f0b50` | no | Needs OpenSSL (async_ssl). |
| `otp-mail` | 0.1.2 | `b64a0be` | no | Needs OpenSSL (async_ssl). |
| `auth-kit` | 0.1.0 | `c1fc2d3` | no | Needs libargon2 (pkg-config). |
| `webauthn` | 0.1.0 | `cff2297` | yes |  |
| `kyc-core` | 0.1.0 | `ceba7ca` | no |  |
| `payments-core` | 0.1.0 | `b315028` | yes (through `money`) |  |
| `payments-core` | 0.1.3 | `9b06ffe` | yes (through `money`) |  |
| `card-core` | 0.1.0 | `1c6ea5a` | yes (through `money`) |  |
| `risk-rules` | 0.1.0 | `a444aad` | yes (through `money`) |  |
| `banking-provider` | 0.1.0 | `61aa5ef` | yes (through `money`) |  |
| `banking-provider` | 0.1.2 | `b128b13` | yes (through `money`) |  |
| `fx-core` | 0.1.2 | `b82ceac` | yes |  |
| `scheduler-core` | 0.1.2 | `0784717` | yes |  |
| `requests-core` | 0.1.2 | `ee21de9` | yes (through `money`) |  |
| `rewards-core` | 0.1.1 | `268c2b7` | yes |  |
| `statements` | 0.1.1 | `4d1ea05` | yes |  |
| `investing-core` | 0.1.1 | `e0e60ed` | yes |  |
| `org-access` | 0.1.0 | `8e14969` | yes |  |
| `org-access-cli` | 0.1.0 | `8e14969` | yes | The `org-access` command. |
| `accounting-sync` | 0.1.0 | `c87bc80` | yes |  |
| `treasury-rules` | 0.1.0 | `ae57a1e` | yes |  |
| `treasury-rules-cli` | 0.1.0 | `ae57a1e` | yes | The `treasury-rules` command. |
| `billing-core` | 0.1.0 | `02aaa35` | yes |  |
| `striga-client` | 0.1.0 | `dfc68b7` | no | Needs OpenSSL (async_ssl). |
| `striga-provider` | 0.1.0 | `de1a94b` | yes (through `money`) |  |
| `griffin-client` | 0.1.0 | `2864fd9` | no | Needs OpenSSL (async_ssl). |
| `griffin-provider` | 0.1.0 | `e5e5a5c` | yes (through `money`) |  |
| `lightspark-client` | 0.1.0 | `2bc841a` | no | Needs OpenSSL (async_ssl). |
| `lightspark-provider` | 0.1.0 | `bc8c45c` | yes (through `money`) |  |
| `pots-and-insights` | 0.1.1 | `891e05d` | yes |  |
| `payouts-core` | 0.1.0 | `798e831` | yes |  |
| `exchange-core` | 0.1.0 | `f492a19` | yes (through `fixed-decimal`) |  |
| `exchange-core-engine` | 0.1.0 | `f492a19` | yes | Second package of the `exchange-core` repository. |
| `order-book` | 0.1.0 | `0b4a76e` | yes |  |
| `hl-protocol` | 0.1.0 | `fbcd0ce` | yes (through `fixed-decimal`) |  |
| `chain-books` | 0.1.0 | `310f4a0` | yes |  |
| `market-data` | 0.1.0 | `c821ba8` | yes (through `fixed-decimal`) | Needs libzstd (through `parquet`). |
| `hl-client` | 0.1.0 | `4dd0ff5` | yes (through `fixed-decimal`) | Needs OpenSSL (async_ssl) and libsecp256k1. |
| `leader-scoring` | 0.1.0 | `4f4b823` | yes | Needs libzstd (through `market-data`). |
| `leader-scoring-hl` | 0.1.0 | `4f4b823` | yes | Second package of the `leader-scoring` repository. Needs OpenSSL (async_ssl) and libsecp256k1 (through `hl-client`). |

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
  `opam repo add`, dry-runs an install of every package in the tree together, then
  really installs `pg-async`, `fixed-decimal` and `money`. A few more packages are
  installed one at a time in a step that reports failures without failing the job.

Tests are not run on install (`--with-test`): `pg-async`'s tests start PostgreSQL
clusters and `parquet`'s use the DuckDB CLI, neither of which is an opam package. Docs
(`--with-doc`) wait for `odoc` on the CI switch.

## License

MIT. Each package carries its own license, also MIT.
