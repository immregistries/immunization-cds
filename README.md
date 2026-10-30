# Immunization CDS (ImmDS + HALO)

This repository is the Topic Reference for
[Immunization CDS (ImmDS + HALO), InteropHub topic 1](https://informatics.immregistries.org/hub/es/topic/1).
It brings the conceptual architecture, terminology, examples, open questions,
and implementation direction into one source-controlled document.

Version 0.1.0 is an initial working synthesis. It is not a standard, an HL7
ballot artifact, clinical guidance, or a final design. It starts from the
existing ImmDS + HALO FHIR implementation-guide draft and related project
material so the community has something concrete to review and improve.

## Read and edit

- The [Topic Reference](https://immregistries.github.io/immunization-cds/latest/)
  is the published page, where you can also leave comments.
- [CoreDocument.md](CoreDocument.md) is the generated single-file reading copy.
- [content/](content/) contains the canonical Markdown sections.
- [ImmunizationCDS.qmd](ImmunizationCDS.qmd) defines their assembly order.
- [Working decisions](content/90-working-decisions.md) records provisional
  positions, conflicts, and open questions.

Do not edit `CoreDocument.md` or generated files in `output/` directly.

## Build

Initialize the shared templates after cloning:

```powershell
git submodule update --init
```

Then run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\build.ps1
```

This generates the reading copy, Word and HTML review copies, and the web
guide in `output/`. The web guide, `output/guide/index.html`, is the published
Topic Reference.

Validate source and generated files with:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\validate.ps1
```

## Related products

The existing FHIR implementation guide is a detailed technical working draft.
It remains a related implementation artifact while this repository develops
the complete discussion-oriented Topic Reference. The separate Contextual
Conditions Topic Reference owns that concept in detail; this one explains how
ImmDS + HALO uses
it and links to the related work.

Presentation requirements and the initial review deck source are under
`products/presentation/`. To prepare the pinned shared PowerPoint generator and
build the editable deck:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\setup-presentation.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\build-presentation.ps1
```

The generated deck is a review aid, not a release or a parallel source of
project knowledge.

## Licensing

Code is intended to use the Apache License 2.0. Content is licensed under
CC BY 4.0 as described in [LICENSE-CONTENT.md](LICENSE-CONTENT.md).
