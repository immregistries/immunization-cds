# Status and Scope

## Status

**Version 0.1.0 — Draft Topic Reference for community discussion.**

This document is an initial synthesis, not a standard, approved specification,
clinical recommendation, HL7 ballot artifact, or final project decision. It is
intentionally incomplete. Its purpose is to give participants something
coherent and concrete to review, correct, and extend.

## In brief

Immunization CDS (ImmDS + HALO) is a proposed machine-to-machine approach for
requesting immunization clinical decision support evaluations and
recommendations. A requesting system supplies an assessment date, patient
information, immunization history, and optional Contextual Conditions. A CDS
service applies an identifiable executable Knowledge Base and returns dose
evaluations, patient-specific recommendations, and information about the data
and rules used or not used.

## Purpose

This Topic Reference brings the project's conceptual architecture, working terminology,
examples, implementation direction, and open questions into one maintained
source. It is meant to support discussion in
[InteropHub topic 1](https://informatics.immregistries.org/hub/es/topic/1) and
provide a conceptual foundation for technical products such as a FHIR
implementation guide.

## Scope

The Topic Reference covers:

- the stateless forecast interaction and system boundary;
- inputs, including Contextual Conditions;
- executable Knowledge Bases and provenance of guidance;
- dose evaluations, recommendations, and recommendation meaning;
- transparency about limitations and handling of submitted information;
- capability discovery; and
- the relationship to the current FHIR working model and related projects.

The Topic Reference does not define clinical policy, mandate an internal CDS rules
engine, specify a user interface, or claim that the current FHIR design is
final.
