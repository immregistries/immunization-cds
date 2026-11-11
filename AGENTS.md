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

- This repository is public, and the work is an open HL7 project. Treat every
  tracked file as public; that is intended. Visibility is how the community
  corrects the content.
- Products, engines, and organizations taking part in the HL7 work (for
  example ICE, Step Into CDSi, CDC CDSi, EUVABECO) may be named where it helps
  the technical content. Leave individual attendees' names out of the content.
- Do not add credentials, private URLs, recordings, or personal metadata from
  Office files. Source documents are listed in `sources/README.md`, not copied.

## Authority

- Markdown in `content/`, together with `ImmunizationCDS.qmd`, `_quarto.yml`,
  and cited assets, is the canonical source for the complete Topic Reference.
- `content/infographic.yml` is the canonical source of the primary
  infographic. Each label condenses the section its `ref` names and adds
  nothing to it; when a section changes, check the labels that refer to it.
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

- Scope follows the "Latest Proposed Language" on the HL7 Public Health
  Immunization Decision Support Confluence page (WD-8). PSS-2764 is not being
  revised.
- HALO is implemented as Contextual Conditions. What a Contextual Condition is
  belongs to the `contextual-conditions` project (topic 7). Link to its
  definitions; do not restate them. This project owns the FHIR exchange of
  conditions and how support is reported.
- This project defines Schedule Authority and Knowledge Base (WD-11), because
  the interface uses them whether or not conditions are sent. Topic 7 links
  here for them and keeps the terminology steward role.
- How the Topic References are organized, including which topic defines a
  term, is the author's decision, made before content goes to the community.
  Do not raise it as a community question.
- FHIR R6 is the target (WD-9). Do not add R4 compatibility requirements.
- The FHIR IG working draft will become a product of this Topic Reference
  (WD-1). Until then, it is a source.
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
