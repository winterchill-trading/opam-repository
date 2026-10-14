# AGENTS.md (.github/)

`workflows/ci.yml` has two jobs: `lint` (`scripts/check.sh`) and `install` (a cached OxCaml switch
built from `ci/ci-deps.opam`, then the packages added with `opam repo add`).

- The `install` job's cheap tier (`pg-async`, `fixed-decimal`, `money`) must pass; the rest report
  failures without failing the job.
- Check a run with `gh run list --limit 1`; at most one `gh run watch <id> --exit-status`.
