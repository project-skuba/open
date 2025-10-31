# <img src="assets/skuba/favicon.png" alt="Skuba" width="32" height="32" align="center" /> Project Skuba — Open Data & Standards

**Welcome to the open data, schemas, and public standards hub of the Skuba ecosystem.**  
This repository powers [open.skuba.app](https://open.skuba.app) — the canonical home for all open, machine-readable resources maintained by the Skuba project.

---

## 🧭 Purpose

`project-skuba/open` provides:

- **Public Datasets** – Canonical, versioned JSON datasets for dive certifications, agencies, and other scuba-related information.
- **Schemas & Standards** – JSON Schema definitions for validating and interoperating with Skuba's open data formats.
- **Visual Assets** – Agency logos (third-party trademarks) and Skuba branding.
- **Documentation** – Design guidelines, contributor guidelines, and open-data governance notes.

Our goal is to make diving data **accessible, standardized, and developer-friendly**, so apps, researchers, and training platforms can all share a common foundation.

---

## 📁 Repository Structure

```
open/
├── datasets/
│ ├── certifications.json
│ ├── agencies.json
│ └── LICENSE.md
│
├── schemas/
│ ├── certifications/
│ │ └── dive-certifications.schema.v1.0.0.json
│ ├── agencies/
│ │ └── agencies.schema.v1.0.0.json
│ └── LICENSE.md
│
├── assets/
│ ├── hand-signals/       # CC BY 4.0 licensed
│ │ └── LICENSE.md
│ ├── agency-logos/       # Third-party trademarks
│ │ └── ...
│ ├── skuba/              # Skuba brand assets
│ │ ├── logo.png
│ │ ├── logo-circle-light.png
│ │ ├── logo-circle-dark.png
│ │ └── favicon.png
│
├── docs/
│ ├── DATASETS.md
│ ├── COLORS.md
│ ├── NEOBRUTALIST_DESIGN.md
│ └── LICENSE.md
│
├── scripts/
│ ├── validate.sh
│ └── test-local.sh
│
├── index.html
├── 404.html
├── CONTRIBUTING.md
├── LICENSE.md
└── CNAME (→ open.skuba.app)

```

---

## 🧩 Key Resources

| Resource                        | Description                                                        | URL                                                                                                   |
| ------------------------------- | ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| **Dive Certifications Dataset** | Comprehensive global database of scuba certifications and agencies | [View JSON →](https://open.skuba.app/datasets/certifications.json)                                    |
| **Dive Certifications Schema**  | JSON Schema for validating certification data                      | [View Schema →](https://open.skuba.app/schemas/certifications/dive-certifications.schema.v1.0.0.json) |
| **Agencies Dataset**            | List of recognized certifying agencies                             | [View JSON →](https://open.skuba.app/datasets/agencies.json)                                          |
| **Agencies Schema**             | JSON Schema for validating agencies data                           | [View Schema →](https://open.skuba.app/schemas/agencies/agencies.schema.v1.0.0.json)                  |
| **Agency Logos**                | Collection of scuba diving agency logos                            | [View Logos →](https://open.skuba.app/assets/agency-logos/)                                           |
| **Dataset Documentation**       | Beginner-friendly guide to understanding and contributing          | [View Guide →](https://open.skuba.app/docs/DATASETS.md)                                               |
| **Docs**                        | Design guidelines and documentation                                | [View Docs →](https://open.skuba.app/docs/)                                                           |

---

## 🧠 How to Use

### For Everyone

If you're new to working with data or just want to understand what's in these datasets, check out our [Dataset Documentation](https://open.skuba.app/docs/DATASETS.md) for a beginner-friendly guide.

### For Developers

You can consume the datasets directly from the web:

```bash
curl https://open.skuba.app/datasets/certifications.json
```

Validate them against the corresponding schema:

```bash
npx ajv validate \
  -s https://open.skuba.app/schemas/certifications/dive-certifications.schema.v1.0.0.json \
  -d https://open.skuba.app/datasets/certifications.json
```

### For Designers / Educators

Explore the agency logos from [`assets/agency-logos`](https://open.skuba.app/assets/agency-logos/).
These are third-party trademarks and should be used for reference purposes only.

---

## ✅ Validation

Before submitting changes, you can validate the datasets locally:

```bash
./scripts/validate.sh
```

This script will:

- ✅ Validate schema files against JSON Schema specifications
- ✅ Validate each JSON dataset file against its referenced schema
- ✅ Check for duplicate IDs within datasets
- ✅ Report detailed errors if validation fails

**Requirements:**

- [Bun](https://bun.sh) (recommended) or Node.js
- [jq](https://jqlang.github.io/jq/) (JSON processor)

All pull requests are automatically validated via GitHub Actions.

---

## 🤝 Contributing

We welcome contributions of:

- New or corrected certification data
- Updated equivalencies or limits
- Additional recognized agencies
- Translations or metadata
- Documentation improvements

📚 **New to contributing?** Start with our [Dataset Documentation](docs/DATASETS.md) for a step-by-step guide on how to add or update data.

For technical details, see [`CONTRIBUTING.md`](CONTRIBUTING.md) for workflow and validation rules.

All JSON datasets must pass schema validation via CI before merging.

---

## 🧾 License

Unless otherwise noted:

| Type                   | License                                                   | Notes                                            |
| ---------------------- | --------------------------------------------------------- | ------------------------------------------------ |
| **Datasets & Docs**    | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) | Free to share/remix with attribution             |
| **Schemas & Code**     | [MIT](https://opensource.org/licenses/MIT)                | Free to use in software projects                 |
| **Agency Logos**       | Third-party trademarks                                    | Owned by respective agencies, reference use only |
| **Skuba Brand Assets** | All rights reserved                                       | Skuba trademark, permission required for use     |

See [LICENSE.md](LICENSE.md) for full details.

---

## 🗓️ Versioning & Governance

Each dataset and schema is versioned semantically (`v1.0.0`, `v1.1.0`, …).
Breaking changes will increment the major version.

All changes are tracked via pull requests and validated in CI.
Community suggestions are discussed in [Discussions](https://github.com/project-skuba/open/discussions).

---

## 🧭 Mission

> Skuba Open exists to unify how the diving world represents, shares, and understands its data — safely, transparently, and for everyone.

---

**Maintained by:** [Project Skuba](https://github.com/project-skuba)
**Canonical URL:** [https://open.skuba.app](https://open.skuba.app)
