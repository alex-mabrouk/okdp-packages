# okdp-packages

KuboCD packages compatible with [OKDP](https://okdp.io), maintained outside the OKDP organization.

This repository follows the same conventions as [`OKDP/platform-packages`](https://github.com/OKDP/platform-packages): it is **packages-only** — it owns the package definitions under `packages/` and the CI that builds and publishes them as OCI artifacts. Deployment (releases, contexts) belongs to the consuming environment, e.g. a fork of [`OKDP/okdp-sandbox`](https://github.com/OKDP/okdp-sandbox).

## Packages

| Package | Role | Notes |
|---|---|---|
| [`rustfs`](./packages/services/rustfs/rustfs.yaml) | S3-compatible object storage | Binds the OKDP `defaultStorage` provider contract |
| [`okdp-server`](./packages/system/okdp-server/okdp-server.yaml) | New OKDP console backend | Built from the fork pending upstream integration; image + chart under `ghcr.io/alex-mabrouk` |
| [`ollama`](./packages/services/ollama/ollama.yaml) | Local LLM inference server | CPU mode, no GPU; the model is a parameter |
| [`ollama-ui`](./packages/services/ollama-ui/ollama-ui.yaml) | Chat interface for `ollama` | Points at an `ollama` release in the same project |

## Structure

```
packages/
├── services/               # Data/application services (catalog)
│   ├── ollama/
│   ├── ollama-ui/
│   └── rustfs/
└── system/                 # Platform components
    └── okdp-server/
okdp-packages-values.yaml   # OCI publish target (packageRepository), read by CI
```

Companion artifacts consumed by the packages live under the same account:

- `ghcr.io/alex-mabrouk/okdp-images/*` — container images (e.g. the new okdp-server,
  built from the [`okdp-control-plane-server`](https://github.com/alex-mabrouk/okdp-control-plane-server) fork)
- `ghcr.io/alex-mabrouk/okdp-charts/*` — Helm charts pushed as OCI artifacts

## Registry layout

- **Publish path** (what releases consume, pushed by `publish.yml` on merge to `main`):
  `ghcr.io/alex-mabrouk/okdp-packages/{package}:{tag}`
- **CI path** (throwaway validation builds on every push/PR):
  `ghcr.io/alex-mabrouk/okdp-packages/okdp-packages/{package}:{tag}`

> ⚠️ GHCR packages are **private on first push**. After the first publish of a new package, set its visibility to *public* in GitHub → Packages, otherwise the cluster cannot pull it anonymously.

## Building locally

```bash
# A service package
kubocd package ./packages/services/rustfs/rustfs.yaml --ociRepoPrefix ghcr.io/alex-mabrouk/okdp-packages

# A system package
kubocd package ./packages/system/okdp-server/okdp-server.yaml --ociRepoPrefix ghcr.io/alex-mabrouk/okdp-packages
```

> ⚠️ Reminder: after the first publish of any new package (or after recreating
> one), set its visibility to *public* in GitHub → Packages so the cluster can
> pull it anonymously.

## License

[Apache License 2.0](./LICENSE). Portions of the CI tooling are adapted from `OKDP/platform-packages`.
