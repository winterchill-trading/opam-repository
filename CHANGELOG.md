# Changelog

Entries added to this repository, newest first. Each version's source commit is in the
README's package table.

## 2026-10-16

- `risk-models` 0.1.1 (`9eda36d`): `Tree_shap` (exact path-dependent and
  interventional attributions), `Explanation` (bin_io and JSON format 1), `Explainer`,
  `Abstain` (accuracy-coverage curves) and the `explain` command; `Forest.create` takes
  an optional `?cover`. Additive. The bundled `txn-fraud-gbdt` export gains node counts,
  which changes its version string.
- `transaction-monitoring` 0.1.1 (`7a6ca8b`): decisions and alerts carry the model's
  feature contributions (`Decision.Stable.V2`, `Alert.Stable.V2`; V1 still read),
  `Policy.abstain`, migration `0002_explanations`. Needs `risk-models` 0.1.1. Code that
  builds `Decision.t`, `Alert.t` or `Policy.t` with a record literal needs the new
  fields.

- `leader-scoring` 0.1.1 and `leader-scoring-hl` 0.1.1 (`2c06814`): `Persistence`
  (rank persistence with a random-pick baseline), `Leader_stats` (PSR, DSR, PBO and SPA
  from `backtest-stats`, a new dependency), `Integrity` flags; `Report.t` gains
  `persistence`, `stats` and `integrity`, and the CLI a `persistence` command. Additive
  for users of `Report.create` and `Report.rank`.

- `hl-copy-core` 0.1.1 (`57cc660`): `No_trade_band`, `Follower_config.Stable.V3` with
  an optional band, `Plan.Stable.V2` (`Within_band`), `Mirror.Config.Stable.V2` and
  `Mirror.Stable.V2`. Code that builds `Follower_config.t`, `Mirror.Config.t` or
  `Mirror.t` with a record literal needs the new field; `create` and `{ x with ... }`
  are unchanged.
- `hl-copy-engine` 0.1.0 (`22e8afe`): first entry (copy-backtest reads its journal
  format). Journal entries version 3, band metrics. Its tests use `hl-sim`, which is not
  published, so `--with-test` installs do not resolve.
- `copy-backtest` 0.1.1 (`5654694`): backtest-stats reports and `-gate`, no-trade bands,
  `attribute`; new dependencies on `backtest-stats` and `hl-copy-engine`, and on
  `hl-copy-core` 0.1.1.
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
