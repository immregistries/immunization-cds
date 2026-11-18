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

## Writing the source

- `content/00-executive-summary.md` is the one section that may repeat the
  chapters, for a reader who reads nothing else. Keep it to 150–550 words;
  the build fails above 650. `content/00-scope.md` has only In scope, Out of
  scope, and optionally Not yet decided. See "Executive Summary and Scope" in
  `process/guidance/TopicReference.md`.
- When the Author asks to mark a change for readers, put
  `<!-- changed vX.Y.Z: note -->` (add `feedback` after the version when
  feedback is wanted) on its own line before the block, using `version` in
  `guide.json`, the version being prepared. Delete markers the content check
  reports as stale after the Author raises `version` for the next release.
  See "Change markers" in `process/guidance/TopicReference.md`.

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
- Presentations are created only when the author identifies a need. Plan each
  one as its own product under `products/` with a brief, using the shared
  presentation tools; do not invent a local generator or duplicate shared
  templates.

## Validation

- After editing `content/` or `ImmunizationCDS.qmd`, run
  `python process/tools/build_core_markdown.py --assembly ImmunizationCDS.qmd`,
  then `validate.ps1`.
- Run `build.ps1` and open `output/guide/index.html` before release.
- Review every `CONFIRM` item printed by content checks.
- Successful generation is a mechanical check, not editorial approval.
- Do not commit, push, publish, or update InteropHub without explicit direction.

## Publishing to InteropHub

InteropHub (https://informatics.immregistries.org/hub) links this guide from its topic and keeps its
comments. A guide is not published until InteropHub has saved its build
manifest.

- **The token.** Every call to InteropHub uses a personal access token in
  `INTEROPHUB_TOKEN`: an environment variable on the author's machine, and a
  repository secret of the same name for the publishing workflow. Never
  print, log, or commit it, and never ask the author to paste it into the
  conversation.
- **First call.** Check the token, and stop to relay a step below if it
  reports a problem:

  ```powershell
  python process/tools/publish_guide_to_hub.py --check-token --hub https://informatics.immregistries.org/hub
  ```

- **Publishing.** Pushing to `main` publishes `/main/` on GitHub Pages, and
  pushing a `vX.Y.Z` tag publishes that version and `/latest/`. The
  `publish-guide.yml` workflow then saves the build manifest.
- **Version settings.** Only when the author asks, set how InteropHub shows a
  published release:

  ```powershell
  python process/tools/publish_guide_to_hub.py --settings-only --hub https://informatics.immregistries.org/hub `
      --label v0.4.0 --display current --comment-mode release
  ```

  `--display` is `current` (the one version readers are pointed to),
  `listed`, `unlisted` (the default), `authors_only`, or `retired`.
  `--comment-mode` is `open` (the default), `release` (only comments made on or
  before this release), or `closed`.

Only the author can do these steps. Pass them on as written:

- No token, or it is expired or lacks `topics:write`: "Please create a
  personal access token on your InteropHub account page
  (https://informatics.immregistries.org/hub/account, Access tokens) with the Author preset. Set it as the
  INTEROPHUB_TOKEN environment variable yourself, then start me again from a
  new terminal. Please don't paste it into this chat."
- The workflow stops for want of the secret: "Please run
  `gh secret set INTEROPHUB_TOKEN` in this repository and paste the token
  when gh asks for it."
- This guide is not among the account's guides: "Please ask the champions
  of the topic Immunization CDS (ImmDS + HALO) (https://informatics.immregistries.org/hub/es/topic/1) or its space admin to make you
  an editor of the topic. Then register this guide on the topic's guide
  settings page if it is not registered yet."

Errors from the tool carry a link to their entry on the help page for
authors and their agents: https://informatics.immregistries.org/hub/help/topic-reference-authors.
