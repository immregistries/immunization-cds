# Immunization CDS (ImmDS + HALO)

This repository is the Topic Reference for
[Immunization CDS (ImmDS + HALO), InteropHub topic 1](https://informatics.immregistries.org/hub/es/topic/1).
It brings the conceptual architecture, terminology, examples, open questions,
and implementation direction into one source-controlled document.

Immunization CDS (ImmDS + HALO) defines one common service interface for
immunization clinical decision support engines. It standardizes the exchange
between systems that request immunization guidance and the engines that
provide it, not the clinical logic. It is an HL7 project; its scope follows the
language on the HL7 Public Health
[Immunization Decision Support](https://confluence.hl7.org/spaces/PHWG/pages/230556918/Immunization+Decision+Support)
page.

Version 0.2.0 is a working preview for community reaction. It is not a
standard, a ballot artifact, clinical guidance, or a final design. Corrections
are welcome.

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

The [FHIR IG working draft](https://github.com/immregistries/immds-halo-fhir-ig-working-draft)
is the September 2026 technical draft; it is to become a product of this Topic
Reference. The separate
[Contextual Conditions Topic Reference](https://immregistries.github.io/contextual-conditions/latest/)
(topic 7) defines Contextual Conditions; this one covers how they are exchanged
and how engines report support for them.

Presentations are planned when a specific need arises, as products under
`products/`, using the shared template's presentation option. A deck is a
review aid, not a release or a parallel source of project knowledge.

## Licensing

Code is intended to use the Apache License 2.0. Content is licensed under
CC BY 4.0 as described in [LICENSE-CONTENT.md](LICENSE-CONTENT.md).
