# 🤝 Contributing to Project Skuba Open

Thank you for your interest in contributing!  
This repository hosts the **open data, schemas, and public standards** that power the [Skuba](https://skuba.app) ecosystem.  
Everything here is published at [open.skuba.app](https://open.skuba.app) for use by the community.

We welcome contributions of all kinds — from fixing a typo to adding new datasets, improving schemas, or refining visuals.

---

## 🧭 What This Repo Contains

This repository is structured into several areas:

| Folder      | Purpose                                                     |
| ----------- | ----------------------------------------------------------- |
| `datasets/` | JSON datasets for dive certifications and agencies          |
| `schemas/`  | JSON Schema definitions for validation and interoperability |
| `assets/`   | Visual assets (agency logos and Skuba branding)             |
| `docs/`     | Design guidelines and documentation                         |
| `scripts/`  | Validation and testing scripts                              |

If you're contributing to a specific folder, please follow the corresponding section below.

---

## 📋 General Contribution Steps

1. **Fork** the repository and create a new branch.
2. **Make your changes** in the appropriate folder:
   - Update or add a dataset (`datasets/`)
   - Update or add a schema (`schemas/`)
   - Add new or improved visuals (`assets/`)
3. **Validate your data** (see below).
4. **Commit** with a clear message (e.g. `Add CMAS Trimix certifications`).
5. **Open a Pull Request** to `main` describing what you changed and why.
6. Our CI will automatically validate your JSON and schema files.
7. Once approved, your change will appear on [open.skuba.app](https://open.skuba.app).

---

## ✅ Validation & Formatting

All JSON data must:

- Be **valid JSON** (use 2-space indentation).
- Conform to the **matching schema** (in `/schemas`).
- Include `"$schema"` and `meta` fields in top-level JSON files:
  ```json
  {
    "$schema": "https://open.skuba.app/schemas/certifications/dive-certifications.schema.v1.0.0.json",
    "meta": {
      "version": "2025.10",
      "generated_at": "2025-10-31T00:00:00Z"
    },
    "certifications": [...]
  }
  ```

* Use UTF-8 encoding.
* Avoid trailing commas.

You can validate locally with:

```bash
./scripts/validate.sh
```

Or validate individual files with:

```bash
npx ajv validate \
  -s schemas/certifications/dive-certifications.schema.v1.0.0.json \
  -d datasets/certifications.json
```

---

## 🧩 Dataset Contributions

For new or updated datasets:

- Include all required fields as defined in the schema.
- Keep **data factual** and verifiable.
- For certifications:
  - Include agency, prerequisites, equivalencies, and limits.
  - Use plain text for limits (free-form list).
- For agencies:
  - Include full name, abbreviation, website, and region.
  - **IMPORTANT:** When adding a new agency, you must also add the corresponding agency logo to `assets/agency-logos/`. Logo files should be named using the pattern `agency-{id}.{svg|png}` (e.g., `agency-padi.svg`).

Refer to the schema files in `/schemas` for detailed field requirements and examples.

---

## 🧱 Schema Contributions

For schema updates or new schemas:

- Follow [JSON Schema Draft 2020-12](https://json-schema.org/draft/2020-12/schema).
- Include a top-level `$id` and `$schema` URL referencing `open.skuba.app`.
- Include `"version"` and `"title"` fields.
- Keep schemas backward-compatible where possible.
  Breaking changes require a new major version (e.g. `v2.0.0`).
- Schema files should be versioned and placed in appropriate subdirectories (e.g., `schemas/certifications/dive-certifications.schema.v1.0.0.json`).

Pull requests that modify schemas will trigger stricter validation checks.

---

## 🎨 Visual Contributions

### Agency Logos

When adding or updating agency logos in `assets/agency-logos/`:

- Format: **SVG** preferred, **PNG** accepted (with transparent background).
- File naming: Use the pattern `agency-{id}.{svg|png}` where `{id}` matches the agency ID in the dataset (e.g., `agency-padi.svg`, `agency-ssi.svg`).
- Keep file sizes reasonable (< 100KB preferred).
- Ensure logos are clear and recognizable at various sizes.
- **Note:** Agency logos are third-party trademarks. Only include official logos for reference purposes.

### Design Guidelines

For any visual assets:

- Use consistent styling where applicable.
- Run SVG files through an optimizer before committing (`svgo` recommended).
- Include appropriate licensing information (see `assets/*/LICENSE.md` files).

---

## 🔎 Quality & Style Guidelines

- **No personal or unverifiable data.** Only publish information confirmed via reputable training agency sources.
- **Neutral tone.** Avoid opinions, marketing, or subjective commentary.
- **Keep changes atomic.** Each PR should cover one focused topic (e.g., one schema or one dataset).

---

## 🧪 Testing Changes Locally

You can preview the site locally using any static file server:

```bash
# Using Python
python3 -m http.server
# then open http://localhost:8000

# Or using the provided test script
./scripts/test-local.sh
```

---

## 📜 Licensing

By contributing to this repository, you agree that:

- All datasets and visuals you contribute are licensed under **CC BY 4.0**.
- All schemas and code you contribute are licensed under **MIT**.
- You own or have the rights to any content you submit.

Full license details: [LICENSE.md](LICENSE.md)

---

## 💬 Community & Support

- **Discussions:** [GitHub Discussions →](https://github.com/project-skuba/open/discussions)
- **Issues:** Use GitHub Issues for bugs, schema suggestions, or data corrections.
- **Website:** [open.skuba.app](https://open.skuba.app)

---

## 🧭 Mission

> Project Skuba Open exists to unify how the diving world represents, shares,
> and understands its data — safely, transparently, and for everyone.

Thank you for helping make that vision real 🌊

```

```
