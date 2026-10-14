# AGENTS.md (ci/)

`ci-deps.opam` is not a package. It lists the third-party dependencies the packages need, and CI
installs them into a cached switch with the infra `ox-setup` action, so the packages install
without pins. Keep the list in step with the `depends` of the packages in `packages/`.
