# renovate-config

Shared [Renovate](https://docs.renovatebot.com/) preset for furedea repositories.

## Usage

Add one line to the repository's `renovate.json`:

```json
{
    "$schema": "https://docs.renovatebot.com/renovate-schema.json",
    "extends": ["github>furedea/renovate-config"]
}
```

Repository-specific settings (custom managers, extra package rules) stay in that repository's `renovate.json`, next to the `extends` line.

## What the preset sets

- `config:recommended`, a weekly schedule, pinned dependencies, and pinned GitHub Action digests
- Vulnerability alerts that open immediately and pick the lowest fixed version
- A 7-day `minimumReleaseAge` for PyPI, crates.io, and npm packages, matching uv `exclude-newer` and pnpm `minimumReleaseAge`
- No updates to `requires-python`; the lower bound is chosen by hand, and the exact version lives in `.python-version` and Nix
- Nix and lock file maintenance
- The Dependency Dashboard

## Validation

CI runs `renovate-config-validator --strict` on `default.json` and `renovate.json`. The validator comes from the Nix dev shell, so `flake.lock` pins its version.
