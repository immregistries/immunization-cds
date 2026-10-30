# Repository Instructions

## What this repository is

- This is the Topic Reference for InteropHub topic 1,
  [Immunization CDS (ImmDS + HALO)](https://informatics.immregistries.org/hub/es/topic/1):
  the current, versioned statement of the topic's architecture, terminology,
  working decisions, and open questions. See the shared Topic Reference
  guidance in `process/guidance/TopicReference.md`.
- The published Topic Reference is the web guide, `output/guide/index.html`,
  built by `process/tools/build_guide.py` with the shared AIRA Web template and
  published to https://immregistries.github.io/immunization-cds/latest/ by
  `.github/workflows/publish-guide.yml`. Do not write a separate HTML page,
  stylesheet, or site generator. `output/ImmunizationCDS.html` is Quarto's
  review copy, not the published page.

## Public working repository

- This repository is intended to be public. Treat every tracked file as public.
- Do not add internal plans, funding or partner proposals, contact information,
  email, recordings, unpublished partner data, credentials, private URLs, or
  personal metadata from Office files.
- Private source material is review input only. Adjudicate public-safe substance
  into canonical Markdown rather than copying private files here.

## Authority

- Markdown in `content/`, together with `ImmunizationCDS.qmd`, `_quarto.yml`,
  and cited assets, is the canonical source for the complete Topic Reference.
- `ImmunizationCDS.qmd` defines section order. `CoreDocument.md` is generated;
  never edit it directly.
- Files in `output/` are generated artifacts, not source.
- The FHIR implementation guide, InteropHub, presentations, meeting notes, and
  comments are review inputs or related products. Accepted substantive changes
  must be adjudicated into `content/`.

## Status and certainty

- This is a working proposal. Never describe ImmDS + HALO, this Topic Reference, or its
  technical details as approved, balloted, adopted, normative, or final.
- Record working decisions and open questions in
  `content/90-working-decisions.md`.
- Do not silently add a claim, decision, commitment, number, owner, date, or
  change in certainty. Add `<!-- CONFIRM: ... -->` beside unresolved text.
- Later sources are not automatically more authoritative. Record conflicts.

## Project boundaries

- This project owns the overall ImmDS + HALO conceptual Topic Reference and its
  relationship to implementable interfaces.
- Detailed Contextual Conditions semantics belong in the separate
  `contextual-conditions` project. Link to it and keep shared concepts aligned.
- Detailed FHIR conformance artifacts remain in the FHIR implementation guide
  until the community decides otherwise. This Topic Reference may explain their intent.
- Do not create clinical policy or silently settle open FHIR design questions.

## Shared templates

- `process/` is the `immregistries/content-publishing-templates` Git submodule.
- Do not edit or copy files under `process/`. Adopt template changes by moving
  the submodule pointer, rebuilding, reviewing output, and committing later.
- Presentation support is evolving in the template project. Keep presentation
  requirements in `products/presentation/brief.yml`; do not invent a local
  generator or duplicate shared templates.

## Validation

- After editing `content/` or `ImmunizationCDS.qmd`, run
  `python process/tools/build_core_markdown.py --assembly ImmunizationCDS.qmd`,
  then `validate.ps1`.
- Run `build.ps1` and open `output/guide/index.html` before release.
- Review every `CONFIRM` item printed by content checks.
- Successful generation is a mechanical check, not editorial approval.
- Do not commit, push, publish, or update InteropHub without explicit direction.
