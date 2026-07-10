# okdp-packages

KuboCD packages compatible with [OKDP](https://okdp.io), maintained outside the OKDP organization.

This repository follows the same conventions as [`OKDP/platform-packages`](https://github.com/OKDP/platform-packages): it is **packages-only** — it owns the package definitions under `packages/` and the CI that builds and publishes them as OCI artifacts. Deployment (releases, contexts) belongs to the consuming environment, e.g. a fork of [`OKDP/okdp-sandbox`](https://github.com/OKDP/okdp-sandbox).

## Packages

| Package | Role | Notes |
|---|---|---|
| [`rustfs`](./packages/services/rustfs/rustfs.yaml) | S3-compatible object storage | Binds the OKDP `defaultStorage` provider contract |

## Structure

```
packages/
└── services/
    └── rustfs/
okdp-packages-values.yaml   # OCI publish target (packageRepository), read by CI
```

## Registry layout

- **Publish path** (what releases consume, pushed by `publish.yml` on merge to `main`):
  `ghcr.io/alex-mabrouk/okdp-packages/{package}:{tag}`
- **CI path** (throwaway validation builds on every push/PR):
  `ghcr.io/alex-mabrouk/okdp-packages/okdp-packages/{package}:{tag}`

> ⚠️ GHCR packages are **private on first push**. After the first publish of a new package, set its visibility to *public* in GitHub → Packages, otherwise the cluster cannot pull it anonymously.

## Building locally

```bash
kubocd package ./packages/services/rustfs/rustfs.yaml --ociRepoPrefix ghcr.io/alex-mabrouk/okdp-packages
```

## License

[Apache License 2.0](./LICENSE). Portions of the CI tooling are adapted from `OKDP/platform-packages`.
