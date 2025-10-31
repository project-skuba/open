# Skuba Open Datasets Documentation

Welcome! This guide will help you understand and contribute to the Skuba Open diving certification datasets. No technical expertise required!

## Table of Contents

- [What are these datasets?](#what-are-these-datasets)
- [Understanding the Data](#understanding-the-data)
  - [Agencies Dataset](#agencies-dataset)
  - [Certifications Dataset](#certifications-dataset)
- [How to Read the Data](#how-to-read-the-data)
- [How to Contribute](#how-to-contribute)
- [Examples](#examples)
- [Common Questions](#common-questions)

## What are these datasets?

The Skuba Open project maintains two main datasets:

1. **Agencies** - A list of all scuba diving certification agencies (like PADI, SSI, NAUI)
2. **Certifications** - A comprehensive list of diving certifications offered by these agencies

These datasets help developers, dive shops, and diving platforms standardize certification information across the diving industry.

## Understanding the Data

### Agencies Dataset

The agencies dataset (`datasets/agencies.json`) contains information about diving certification agencies.

Each agency entry includes:

- **id**: A unique identifier (e.g., "agency-padi")
- **name**: The official agency name (e.g., "Professional Association of Diving Instructors")
- **abbr**: The common abbreviation (e.g., "PADI")
- **website**: The agency's official website
- **status**: Whether the agency is "active", "merged", or "defunct"
- **logo**: Each agency has a logo file in `assets/agency-logos/`

### Certifications Dataset

The certifications dataset (`datasets/certifications.json`) contains all diving certifications.

Each certification entry includes:

- **id**: A unique identifier (e.g., "cert-padi-ow")
- **agency**: Which agency issues this cert (e.g., "agency-padi" or "PADI")
- **name**: The official certification name (e.g., "Open Water Diver")
- **abbr**: Common abbreviation (e.g., "OW")
- **category**: Type of certification:
  - `recreational` - Basic diving certifications
  - `technical` - Advanced/deep diving
  - `cave` - Cave diving specialties
  - `rescue` - Emergency/rescue training
  - `professional` - Instructor/divemaster levels
  - `freediving` - Breath-hold diving
  - `specialty` - Specific skills (photography, wreck, etc.)
- **prerequisites**: What you need before taking this course
- **limits**: What you can do with this certification
- **equivalent_to**: Similar certifications from other agencies

## How to Read the Data

The data is stored in JSON format, which looks like this:

```json
{
  "id": "cert-padi-ow",
  "agency": "agency-padi",
  "name": "Open Water Diver",
  "abbr": "OW",
  "category": "recreational",
  "status": "active"
}
```

Think of it like a form where:

- Each line is a field name followed by its value
- Text values are in quotes
- The whole entry is wrapped in curly braces `{}`

### Understanding References

When you see a value starting with:

- `agency-` → This refers to an agency in the agencies dataset
- `cert-` → This refers to another certification

If a value doesn't start with these prefixes, it's just plain text.

For example:

- `"agency": "agency-padi"` → Links to PADI in the agencies dataset
- `"agency": "PADI"` → Just the text "PADI"

## How to Contribute

We welcome contributions! Here's how to help:

### 1. Reporting Issues

If you find incorrect information:

1. Go to the [GitHub repository](https://github.com/skuba-app/skuba-open)
2. Click "Issues" → "New Issue"
3. Describe what's wrong (e.g., "PADI Advanced Open Water max depth is 30m, not 40m")

### 2. Adding New Agencies

To add a new agency:

1. **Check if it already exists** - Search the `agencies.json` file
2. **Prepare the information**:

   - Official agency name
   - Common abbreviation
   - Official website
   - Logo image (PNG or SVG preferred)

3. **Add the agency entry** to `datasets/agencies.json`:

```json
{
  "id": "agency-example",
  "name": "Example Diving Agency",
  "abbr": "EDA",
  "website": "https://example-diving.org",
  "status": "active"
}
```

4. **Add the logo** to `assets/agency-logos/` named `agency-example.png`

### 3. Adding New Certifications

To add a new certification:

1. **Check if it already exists** - Search the `certifications.json` file
2. **Gather information**:

   - Official certification name
   - Which agency issues it
   - Prerequisites (if any)
   - Maximum depth/limits
   - Equivalent certifications from other agencies

3. **Add the certification** to `datasets/certifications.json`:

```json
{
  "id": "cert-example-advanced",
  "agency": "agency-example",
  "name": "Advanced Diver",
  "abbr": "AD",
  "category": "recreational",
  "status": "active",
  "prerequisites": {
    "certifications": ["cert-example-open-water"],
    "general": ["Minimum age 15 years", "10 logged dives"]
  },
  "limits": ["Maximum depth 30m", "No decompression diving"]
}
```

### 4. Updating Existing Data

To fix or update existing information:

1. Find the entry in the appropriate file
2. Make your changes
3. Ensure the format stays the same (quotes, commas, etc.)
4. Submit your changes

### 5. Validation

After making changes, validate your data:

1. Make sure all quotes and commas are in the right places
2. Check that IDs follow the format: `agency-` or `cert-` plus lowercase letters and hyphens
3. Verify that referenced agencies/certifications exist

## Examples

### Example: Finding Equivalent Certifications

Let's say you have a PADI Open Water certification and want to know the SSI equivalent:

1. Find the PADI Open Water entry in `certifications.json`
2. Look at the `equivalent_to` field
3. You'll see it lists "SSI Open Water Diver"

### Example: Understanding Prerequisites

To see what you need for PADI Advanced Open Water:

```json
{
  "id": "cert-padi-aow",
  "prerequisites": {
    "certifications": ["cert-padi-ow"],
    "general": ["Minimum age 12 years"]
  }
}
```

This means you need:

- PADI Open Water certification (or equivalent)
- To be at least 12 years old

### Example: Agency Status

Some agencies have merged or closed:

```json
{
  "id": "agency-example",
  "status": "merged",
  "replaced_by": "agency-other"
}
```

This tells you that this agency merged with another one.

## Common Questions

### Q: Why do some fields have null or empty values?

A: Not all information is available for every certification or agency. We add data as we verify it.

### Q: Can I add certifications from my local dive shop?

A: No, we only include certifications from recognized training agencies that issue official certification cards.

### Q: What's the difference between "deprecated" and "renamed" status?

A:

- **Deprecated**: The certification is no longer offered but existing certs are still valid
- **Renamed**: The certification still exists but under a new name

### Q: How often is the data updated?

A: We review and update the data regularly. Check the `meta.version` field in each file to see when it was last updated.

### Q: Can I use this data in my own project?

A: Yes! Check the LICENSE.md file for details. The data is open source.

### Q: What if I find conflicting information?

A: Please report it as an issue. Include links to official sources so we can verify the correct information.

## Need More Help?

- **Questions?** Open a discussion on [GitHub](https://github.com/skuba-app/skuba-open/discussions)
- **Found a bug?** Report it in [Issues](https://github.com/skuba-app/skuba-open/issues)
- **Want to contribute code?** See [CONTRIBUTING.md](../CONTRIBUTING.md)

Remember: Every contribution helps make diving certification information more accessible to everyone! 🤿
