# Changelog

Entries added to this repository, newest first. Each version's source commit is in the
README's package table.

## 2026-10-16

- `market-data` 0.1.1 (`34d1b31`): bars, labels, directional change and CUSUM event
  clocks, VPIN toxicity (`Toxicity`, `Toxicity_feed`), feature tables. Additive.
- `mm-core` 0.1.0 (`4ab682b`): first entry, with the toxicity gate and the reference
  guard. The library repository has no `mm-core.opam.template`, so the generated opam
  file carries no `x-maintenance-intent`; this entry adds it by hand. Later: give
  mm-core an `mm-core.opam.template` with `x-maintenance-intent: ["(latest)"]` so the
  next entry is the generated file unchanged. `mm-core-replay`, its second package, is
  not published.
- `exchange-core-engine` 0.2.0 (`cfbfe40`): price collar, halt rule, guard event log and
  their journal inputs. The `exchange-core` package did not change since 0.1.0
  (`f492a19`), so it stays at 0.1.0.
- `sim-scorecard` 0.1.0 (`941ad9e`): first entry. It uses no engine API added in 0.2.0,
  so it accepts `exchange-core-engine` 0.1 and 0.2.
