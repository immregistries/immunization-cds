# Adoption and Boundaries

ImmDS + HALO should be usable incrementally. A basic service may support the
baseline forecast interaction before it supports every Contextual Condition,
Knowledge Base option, recommendation category, or discovery feature. Partial
support must be declared rather than assumed.

The project aims to standardize an interoperable exchange contract, not:

- clinical policy or which recommendation should apply;
- the internal structure of a CDS engine or its rule authoring tools;
- a clinician-facing workflow or user interface;
- persistence of patient state by the forecast service;
- inference of Contextual Conditions from arbitrary clinical records;
- one universal list of conditions or one universal Knowledge Base;
- dynamic mixing of guidance sources in an individual request; or
- detailed behavior owned by CDS Hooks, HL7 v2, IVC, or another related effort.

An international conceptual baseline may be constrained by national programs,
jurisdictions, or implementation communities. Such constraints should identify
their relationship to the baseline rather than silently redefining shared
terms.

Version 0.1.0 is successful if it gives implementers and subject-matter experts
a shared map of the work, makes disagreements visible, and supports the next
round of InteropHub discussion. It is not expected to settle every technical
question.
