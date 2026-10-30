# Contributing

Immunization CDS (ImmDS + HALO) is developed in the open, and discussion is the main way it improves.
Questions, objections, examples from implementation, and proposed wording are
all welcome.

## Ways to take part

- **Open an issue** to raise a question, challenge a working decision, or share
  an implementation experience. Issue templates are provided for general
  feedback and for proposing or challenging a working decision.
- **Join the community discussion** on InteropHub,
  [Immunization CDS (ImmDS + HALO), topic 1](https://informatics.immregistries.org/hub/es/topic/1), where meetings and
  discussion notes are tracked.
- **Comment on the [Topic Reference](https://immregistries.github.io/immunization-cds/latest/).** Comments stay in
  your browser until you download them. Share the downloaded file with the
  maintainers, for example by attaching it to an issue.
- **Propose a change** with a pull request against the Markdown in `content/`.
  Explain the reasoning in the pull request description. Substantive changes
  are usually easier to agree on in an issue first.

## How changes are decided

The maintainers consider feedback, discuss it with the community where needed,
and record the outcome in `content/90-working-decisions.md`. A working decision
is the current position for discussion, and it can be revisited.

Detailed FHIR conformance proposals and detailed Contextual Conditions semantics
may be routed to their related projects. When proposing a change, identify the
source and status of a claim, distinguish a proposed change from a settled
working decision, and preserve visible uncertainty.

## Pull request checklist

- Edit files in `content/`, not `CoreDocument.md` or anything under `process/`.
- Regenerate the reading copy:
  `python process/tools/build_core_markdown.py --assembly ImmunizationCDS.qmd`.
- Run `validate.ps1`, or let GitHub Actions run the same checks.
- Do not include private, unpublished, or personal information.

By contributing, you agree that your contribution is licensed under this
repository's licenses: CC BY 4.0 for content and Apache 2.0 for code.

## Conduct

Participation is governed by the [Code of Conduct](CODE_OF_CONDUCT.md).
