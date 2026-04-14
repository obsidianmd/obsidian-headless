# Maintainer Notes

## `--only-folder` Design

`ob sync --only-folder <folder>` was added as a runtime flag rather than persisted config.

Reasoning:

- It behaves more like an execution scope than a vault-level sync policy.
- It allows the same configured vault to be synced fully or partially depending on the environment.
- It avoids changing stored sync behavior for future runs by accident.
- It fits headless and automation workflows where the caller decides sync scope at invocation time.

If upstream prefers, this could later be extended into persisted config, but the runtime flag is the safer minimal change.

## Interaction With `excluded-folders`

`--only-folder` narrows sync scope first, then existing excluded-folder rules still apply within that subtree.

Effective behavior:

1. Restrict sync to the selected folder.
2. Continue honoring existing excluded-folder rules inside that folder.

This keeps the behavior consistent with current sync configuration semantics instead of introducing a separate exclusion model.

Fork-specific maintainer note authored for changes attributed to `B.Newbold`.
