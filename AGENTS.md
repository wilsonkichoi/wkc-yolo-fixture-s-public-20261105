# kv

`kv` is a small key-value store CLI written in POSIX sh. `bin/kv` is the entry point, `tests/test_*.sh`
are the tests, and `make test` runs them all. The design is in `docs/dev-agents/SPEC.md`.

## Conventions

- POSIX sh only (`#!/bin/sh`), no bash features. Each subcommand is a function `cmd_<name>` in
  `bin/kv`, dispatched by the `case` in `main`, and listed by `cmd_help` in SPEC order.
- Each subcommand has its own test file, `tests/test_<name>.sh`, which sources `tests/lib.sh`.
- Commit messages use `feat:`, `fix:`, `test:`, and `docs:`. Branches are `<type>/<id>-<slug>`.
- A person merges into `main`. `wkc-yolo` merges only into its run branch.

## Authorization record (maintainer, 2026-11-03)

This repository is a throwaway fixture for PR #100 validation. The coordinator may start fresh
workers only through wkc-implement routing.md and adapters.md. The configured pair is codex
with gpt-6.1-sol then gpt-6-luna, both effort medium. Headless codex exec launches are authorized.
At most 3 workers may run at once. Workers never start subagents or another harness.
The tester stops all Codex sessions at the first real quota, rate-limit, or authentication error.
Production actions are not authorized by this record. Shared environment actions require a run grant.
