# Production-Grade DevOps CRUD Application

A concise, production-minded reference for building, testing, and deploying the FastAPI CRUD backend for a book‑store service. Everything needed for local development, image builds, Helm chart deployment, and GitOps is in this repo.

Contents
- `Dockerfile`, `.dockerignore` — production-ready container image definition
- `docker-compose.yaml` — local multi-service orchestraton (backend + Postgres)
- `crud-app/` — Helm chart for Kubernetes deployments (includes namespace template)
- `.github/workflows/` — CI/CD pipelines (`build.yaml` for main and `dynamic.yaml` for features)
- `terraform/` — IaC modules and top-level configs
- `kubernetes/` — Kubernetes manifests (reference/backups)

Quick start — Local (Docker)
1. Build image:
```bash
docker build -t aniket036/fastapi-production:local .
```
2. Run with Docker Compose:
```bash
docker compose up -d
docker compose logs -f
```

Kubernetes & Helm (quick)
- Lint the chart:
```bash
helm lint crud-app
```
- Render templates locally:
```bash
helm template crud-app crud-app -f crud-app/values.yaml
```
- Install / upgrade:
```bash
helm upgrade --install crud crud-app -f crud-app/values.yaml
```

CI/CD (GitHub Actions)
- Workflows:
  - `build.yaml` — triggers on `push` to `main`, builds and pushes production images.
  - `dynamic.yml` — triggers on feature branches (e.g. `feat/*`, `feature/*`) and relevant path changes; builds images, pushes, and optionally auto‑updates `crud-app/values.yaml` with the new image tag.
- Required repository secrets:
  - `DOCKER_USERNAME` — Docker registry username
  - `DOCKER_PASSWORD` — Docker registry password or token

🔄 **GitOps Deployment (ArgoCD)**

This repository is designed to support a GitOps workflow powered by ArgoCD. The
basic expectations are:

1. Install ArgoCD into your cluster with the official manifests:
   ```sh
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```
2. Create an **ArgoCD Project** (e.g. `default` or `crud-app`) that scopes the
   repository/destination combinations you need.
3. Create an **ArgoCD Application** pointing at this repo's `crud-app` Helm
   chart path. Example snippet (see `argocd/fastapi.yaml` in this repo):
   ```yaml
   apiVersion: argoproj.io/v1alpha1
   kind: Application
   metadata:
     name: fastapi
     namespace: argocd
   spec:
     project: default
     source:
       repoURL: https://github.com/aniketmehta03/Production-Grade-GitOps-DevOps-Platform.git
       targetRevision: main          # or feature branch for testing
       path: crud-app
       helm:
         valueFiles:
           - values.yaml
         parameters:
           - name: namespace
             value: production
     destination:
       server: https://kubernetes.default.svc
       namespace: production
     syncPolicy:
       automated:
         prune: true
         selfHeal: true
   ```

The application is expected to manage all the resources for the service including
its own namespace (see `crud-app/templates/namespace.yaml`).

ArgoCD must be configured so that:
- ✅ **Auto‑sync** is enabled – changes pushed to Git trigger deployments.
- ✅ **Self‑heal** (auto‑heal) is enabled – drift in cluster state is corrected.
- ✅ **Auto‑rollback** is enabled (via the `rollback` option in sync policy)
- ❌ **No manual `kubectl apply`** commands are used for production objects; all
  desired state lives in Git and ArgoCD applies it automatically.
  (You may still use `kubectl` for debugging or cluster bootstrap.)

When a feature branch is pushed, ArgoCD can target that branch for preview
deployments; merging to `main` then becomes the production release path.

The `dynamic.yml` workflow helps by updating `crud-app/values.yaml` with the
new image tag on each build, effectively locking the desired container image to
the Git state that ArgoCD watches.

Infrastructure (Terraform)
- Location: `terraform/` with modular layout under `terraform/modules/` (network, ec2, eks, iam, s3, ecr).
- IMPORTANT: If a module variable has no default, create a `terraform.tfvars` in the `terraform/` root or pass `-var-file` at apply time.

Example `terraform.tfvars` snippet (fill before `terraform apply`):
```hcl
region = "ap-south-1"
bucket_name = "my-crud-app-bucket-unique"
repository_name = "crud-api"
eks_cluster_name = "crud-eks-cluster"
```

Monitoring & Observability
- Recommended stack (Helm): `kube-prometheus-stack` (Prometheus + Alertmanager + Grafana) and `loki-stack` (Loki + Promtail).
- Example PrometheusRule alerts include high CPU and Pod crash-loop detection. Install these into a `monitoring` namespace.

Diagrams & Documentation
- Architecture diagram: `docs/architecture.png` (rendered architecture overview)
- CI/CD flow diagram: `docs/cicd-flow.png`

If you need editable sources, I can export the Excalidraw JSON into `diagrams/` and produce PNG/SVG exports.

Contributing
- Open a PR for changes. For CI/CD and infra changes, include validation steps (Helm lint, Terraform plan).

What I can do next
- Export the architecture and CI/CD diagrams as PNG/SVG and add them to `docs/` for immediate viewing.
- Run quick validation steps (helm lint, terraform fmt) locally and report output.

---

