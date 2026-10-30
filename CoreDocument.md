<!--
GENERATED FILE. DO NOT EDIT DIRECTLY.

The authoritative source is in content/. Regenerate this reading copy with:
    python process/tools/build_core_markdown.py --assembly ImmunizationCDS.qmd
-->

# Immunization CDS (ImmDS + HALO)

*Working Proposal for Community Discussion — Not a Standard or Final Decision*

> This is a generated reading copy for GitHub. For review and editing, use the
> [canonical section files](content/README.md).

---

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

---

# Related Work

This Topic Reference is the working document for
[Immunization CDS (ImmDS + HALO), InteropHub topic 1](https://informatics.immregistries.org/hub/es/topic/1).
InteropHub remains the community index for meetings, outcomes, relationships,
and participation. This repository is intended to hold the maintained Topic Reference
that those discussions review.

| Work | Relationship |
|---|---|
| Original ImmDS implementation guide | Compatibility baseline for the forecast interaction. The project must decide which parts remain compatible and which require a revised international model. |
| ImmDS + HALO FHIR implementation-guide draft | Current concrete technical exploration of an operation, profiles, extensions, terminology, capability statements, and examples. It is a source and downstream technical product, not yet the authority for the whole Topic Reference. |
| [CDS Contextual Conditions, topic 7](https://informatics.immregistries.org/hub/es/topic/7) | Defines Contextual Conditions independently of a specific transport. This project consumes that concept and should not reproduce its detailed specification. |
| [HL7 v2 Contextual Conditions Exchange, topic 137](https://informatics.immregistries.org/hub/es/topic/137) | Develops the HL7 v2 representation of the same contextual input concept. |
| CDS Hooks | A possible workflow integration that can invoke or present CDS results. ImmDS + HALO defines a forecast interaction and is not itself CDS Hooks. |
| Step Into CDSi | Demonstration and testing environment that can expose proposed behavior and make implementation questions concrete. |
| Immunization Vocabularies Collaborative | Possible publication and coordination mechanism for externally governed terminology. It does not own clinical guidance or executable forecast logic merely by publishing codes. |

<!-- CONFIRM: Add canonical public links for the original ImmDS guide and current FHIR implementation-guide working location once their publication status is settled. -->

---

# Problem and Working Principles

Immunization forecasting often depends on more than date of birth and
immunization history. Pregnancy, immune status, prior disease, occupational
exposure, travel, living circumstances, and maternal vaccination may change
which guidance applies. Systems also need to know which executable rules were
used and whether submitted information was understood.

Traditional forecast exchanges can return an answer without enough detail to
distinguish missing context, unsupported context, differing clinical guidance,
or a particular implementation of that guidance. ImmDS + HALO explores a more
explicit contract.

The current working principles are:

- Forecasting is stateless: each request contains the information needed for
  that evaluation.
- The CDS service evaluates the supplied data rather than searching external
  patient records or remembering prior requests.
- Date of birth is expected to remain the only required patient fact beyond the
  assessment date; other patient context is optional.
- Omission of a Contextual Condition means unknown, not No.
- The requesting system asserts Contextual Conditions; the CDS service does
  not infer them from arbitrary clinical data as part of the forecast call.
- One coherent executable Knowledge Base is applied to a request.
- The response makes important limitations visible.
- General capability discovery is separate from the patient-specific forecast.
- The conceptual model is international first and may be constrained by later
  national or implementation-specific guides.

These are working positions. Their precise technical representation remains
open where identified later in this document.

---

# Architecture

ImmDS + HALO is a machine-to-machine forecast interface. It can support an IIS,
clinical application, workflow system, testing tool, or CDS Hooks integration,
but it does not define the user experience of those systems.

The conceptual flow is:

```text
Requesting system
  assessment date + patient + immunization history + optional context
                              |
                              v
CDS service applies one executable Knowledge Base
                              |
                              v
evaluations + recommendations + transparency + provenance
```

## Responsibilities

The requesting system assembles the patient facts, immunization history, and
asserted Contextual Conditions needed for the call.

The CDS service validates the request, applies one coherent Knowledge Base, and
produces the requested evaluations and recommendations. The interaction does
not require the service to inspect other patient records, maintain a session,
or dynamically combine individual sources of guidance at runtime.

The response identifies material limitations: for example, data that was not
recognized or supported, context that was ignored, incomplete results, or an
issue that prevented a reliable forecast.

## Guidance and executable logic

Organizations or expert bodies publish clinical guidance. Software implements
guidance as executable rules. These are related but not identical artifacts.
Section 6 distinguishes the publisher or source of guidance from the Knowledge
Base actually executed by a CDS service.

---

# Forecast Interaction

The conceptual request contains:

| Input | Purpose | Current status |
|---|---|---|
| Assessment date | Date for which the forecast is calculated | Required |
| Patient | Identifies the patient and supplies demographics, with date of birth expected to be the minimum required fact | Required |
| Immunization history | Administered and historical vaccination events | Optional collection; may be empty |
| Contextual Conditions | Assertions needed by forecast logic beyond demographics and immunization history | Optional collection |
| Requested Knowledge Base and version | Selects one executable rule set offered by the service | Proposed optional input |

The conceptual response contains:

| Output | Purpose |
|---|---|
| Dose evaluations | Assessment of supplied immunization events |
| Recommendations | Patient-specific forecast results |
| Knowledge Base used | Identifies the executable rules actually applied |
| Context handling | Discloses submitted conditions that were used, ignored, unsupported, or not understood |
| Additional context suggested | Identifies information that could improve the forecast if available |
| Warnings or errors | Explains informational, partial, or blocked results |

The interaction does not change server state. Every result applies to the
submitted information and requested assessment date.

<!-- CONFIRM: The current FHIR draft makes assessment date and patient required, allows zero or more immunizations and conditions, and returns exactly one ImmunizationRecommendation resource. Those cardinalities remain technical design questions. -->

---

# Contextual Conditions

Contextual Conditions provide the forecast service with operational inputs that
may change an evaluation or recommendation but are not adequately conveyed by
demographics and immunization history alone. Examples include a supplied
assertion that the patient is pregnant, has a relevant immune status, plans
international travel, or that the birth mother received RSV vaccine during
pregnancy.

This project uses the concept defined by the separate
[Contextual Conditions Topic Reference](https://github.com/immregistries/contextual-conditions).
That Topic Reference owns the detailed definition, datatypes, relationship to clinical
information, evaluation-time semantics, and representation principles.

For ImmDS + HALO:

- conditions are supplied by the requesting system;
- omission means unknown rather than No;
- the service reports whether submitted conditions were recognized and used;
- capability discovery can describe which conditions a service or Knowledge
  Base supports; and
- questionnaires may help collect assertions upstream but are not required by
  the forecast interaction.

The earlier FHIR draft uses `Observation` for assertions and
`ObservationDefinition` to describe supported or suggested conditions. These
are current binding proposals rather than the definition of the concept.

<!-- CONFIRM: The September FHIR draft says Observation.effective[x] may carry timing when it matters. The current Contextual Conditions working decision says a meaningful date is a separate date-valued condition and not an Observation date element. The FHIR binding must be reconciled before this detail is reused. -->

---

# Knowledge Bases and Guidance Provenance

The working model distinguishes clinical guidance from its executable
implementation.

## Source of guidance

An organization or expert body publishes immunization recommendations for
clinical or public-health use. Earlier drafts call this body a **Schedule
Authority**. That term is provisional and may be replaced because the role can
publish guidance that is broader, narrower, or less formally versioned than a
single schedule.

## Knowledge Base

A **Knowledge Base** is an identifiable executable operationalization of
guidance from one or more such bodies, possibly including jurisdictional or
local adaptations. It is the coherent rule set a CDS service actually runs.

A client may request one Knowledge Base from those offered by a service. The
service applies one Knowledge Base to a forecast and reports the one actually
used. If combinations of guidance are supported, the service defines them as
coherent Knowledge Bases rather than allowing a requestor to mix individual
guidance sources dynamically.

This distinction answers two different questions:

| Question | Concept |
|---|---|
| Whose clinical guidance or intent is relevant? | Guidance source / provisional “Schedule Authority” role |
| Which executable rules did the service run? | Knowledge Base |

A Knowledge Base may draw on multiple guidance sources, and different
Knowledge Bases may operationalize the same published guidance differently.
Provenance therefore needs to identify the executable artifact without implying
that it is identical to the publisher or the publication.

<!-- CONFIRM: Replace “Schedule Authority” after the community agrees on a term and map it to the earlier four-role governance vocabulary. -->
<!-- CONFIRM: Decide the identifier, version, documentation, and provenance model for Knowledge Bases and guidance sources. -->

---

# Results and Transparency

## Dose evaluations

Dose evaluation results describe how the service treated supplied vaccination
events. The working model needs to express dose validity, the reason for the
status, whether a dose was valid but did not count toward a series, and the
relevant provenance or warning information.

## Recommendations

Patient-specific recommendations need to keep several ideas distinct:

- **forecast status:** where the patient stands relative to protection or a
  vaccination path;
- **forecast reason:** why that patient-specific status applies; and
- **recommendation category:** how the applicable clinical guidance classifies
  the recommendation, such as a routine or risk-based category.

Conflating these ideas can make a conditional recommendation look like no
recommendation, or make the reason for a patient-specific result look like a
policy category.

## Transparency for the current call

The response should disclose material facts about the current forecast,
including:

- Contextual Conditions supplied and used;
- supplied conditions ignored, unsupported, or not understood;
- vaccine codes not recognized or recognized but not forecasted;
- additional context that could improve the result;
- the Knowledge Base used; and
- informational notes, warnings, partial results, or blocking errors.

The current FHIR exploration uses `OperationOutcome` for messages and also
proposes a response-level status. It remains open whether both are needed and
how a client can reliably distinguish complete, partial, and blocked results.

---

# Capability Discovery

Patient-specific transparency answers what happened in one forecast call.
Capability discovery answers what a service can generally do before a client
sends patient data. Keeping these concerns separate avoids overloading the
forecast response.

A useful discovery mechanism may describe:

- supported vaccines and target diseases;
- recognized vaccines that are not forecasted;
- available Knowledge Bases and versions;
- relevant guidance sources;
- supported Contextual Conditions;
- which conditions affect recommendations and which only identify missing
  context;
- update cadence, documentation, provenance, and contact information; and
- supported operation versions and profiles.

The September FHIR draft includes a basic `CapabilityStatement` and one
`ObservationDefinition` example. Candidate FHIR approaches also include a
dedicated operation, `ValueSet`, `ConceptMap`, `Library`, and `PlanDefinition`.
No complete discovery contract has been selected.

<!-- CONFIRM: Define the smallest capability artifact needed for the first interoperable implementation rather than attempting to settle every discovery question at once. -->

---

# FHIR Working Model

The current technical draft is authored against FHIR R4 and explores a
stateless operation named `$immds-halo-forecast`. It preserves the original
ImmDS request/response shape while adding optional context, Knowledge Base
selection, and response transparency.

The draft currently maps:

| Concept | FHIR exploration |
|---|---|
| Forecast interaction | `OperationDefinition` on a system endpoint |
| Patient | `Patient` |
| Immunization history | `Immunization` |
| Contextual Condition assertion | Profiled `Observation` |
| Supported or suggested condition | `ObservationDefinition` |
| Dose evaluation | `ImmunizationEvaluation` |
| Recommendation | `ImmunizationRecommendation` |
| Warnings and errors | `OperationOutcome` |
| Service declaration | `CapabilityStatement` |

Profiles, extensions, example instances, temporary code systems, and proposed
parameters make the questions testable, but they are not approved conformance
requirements. In particular, the project still needs to decide:

- whether to retain `$immds-forecast` or introduce a new operation name;
- whether to depend on the original ImmDS guide or define an international
  baseline;
- cardinalities and the shape of recommendation output;
- provenance placement on evaluations and recommendations;
- representation of recommendation category;
- capability discovery;
- complete, partial, and blocked response semantics;
- alignment with the separate Contextual Conditions concept; and
- implications of FHIR R6 while initial implementation work uses R4.

The FHIR implementation guide should eventually become a traceable technical
product of reviewed concepts in this repository, while retaining the precision
and computable examples needed by implementers.

---

# Discussion Examples

Examples are used to test the architecture and expose ambiguity. They are not
clinical guidance.

## Baseline forecast

A client supplies an assessment date, patient date of birth, and immunization
history with no Contextual Conditions. The service applies its default
Knowledge Base and returns evaluations and recommendations. The result must not
pretend that omitted optional conditions are false.

## Supported condition

A client supplies a pregnancy assertion in addition to the baseline data. The
selected Knowledge Base recognizes and uses the condition. The response shows
that the assertion was used and identifies the Knowledge Base applied.

## Unsupported condition

A client supplies an international-travel assertion that the selected
Knowledge Base does not support. The response discloses that the condition was
unsupported and makes the consequence for result completeness visible.

## Knowledge Base selection

A service offers more than one coherent Knowledge Base. The client requests a
known identifier and optional version. The response confirms the Knowledge Base
actually executed or returns a clear error if the requested option is not
available.

## Multiple sources of guidance

A Knowledge Base incorporates guidance from more than one expert body. The
client still selects one executable Knowledge Base rather than assembling
guidance sources at runtime. Results preserve useful provenance without
confusing the rule implementation with the organizations that published the
underlying guidance.

## Example backlog

Later versions need examples for contraindication, missing context, unknown
codes, recognized-but-not-forecasted vaccines, partial results, a blocked
forecast, recommendation categories, and guidance that differs by vaccine or
jurisdiction.

---

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

---

# Working Decisions and Open Questions

Working decisions are current positions for discussion, not final approval.

## Working decisions

| ID | Working decision | Basis |
|---|---|---|
| WD-1 | The project maintains one complete conceptual Topic Reference, with detailed FHIR conformance as a related technical product. | The community needs a reviewable document broader than the current FHIR publication format. |
| WD-2 | The forecast interaction is stateless and evaluates the data supplied in the current request. | Repeated across the narrative draft and FHIR IG. |
| WD-3 | Omission of a Contextual Condition means unknown, not No. | Shared with the Contextual Conditions project. |
| WD-4 | The requesting system asserts Contextual Conditions; the forecast operation does not infer them from arbitrary clinical records. | Establishes a bounded machine-to-machine contract. |
| WD-5 | One coherent Knowledge Base is applied to a forecast and the response identifies the one used. | Separates executable behavior from underlying guidance. |
| WD-6 | General capability discovery is separate from patient-specific response transparency. | The two answer different questions and have different lifecycles. |
| WD-7 | Version 0.1.0 carries unresolved design choices explicitly rather than waiting for a complete specification. | This release is a discussion baseline. |

## Open questions

| ID | Question | Current context |
|---|---|---|
| OQ-1 | What term should replace “Schedule Authority”? | The role publishes clinical guidance, but “schedule” may be too narrow and “authority” may imply governance that does not exist. |
| OQ-2 | How does the current role vocabulary map to earlier Code System, Publishing, Namespace, and CDS Authority roles? | The Contextual Conditions project records the same unresolved vocabulary issue. |
| OQ-3 | Should the FHIR operation remain `$immds-forecast` or become `$immds-halo-forecast`? | Compatibility and signaling a broader model pull in different directions. |
| OQ-4 | Does the technical guide depend on the original ImmDS IG or define a clean international baseline? | The September FHIR draft treats the original as a compatibility baseline. |
| OQ-5 | How are Knowledge Bases identified, versioned, discovered, requested, and echoed in a response? | Current parameters and identifiers are placeholders for review. |
| OQ-6 | Where and at what granularity is guidance provenance attached? | A result may need the Knowledge Base, documentation, and one or more sources of guidance. |
| OQ-7 | What is the minimum useful transparency contract? | Used, ignored, unsupported, unrecognized, partial, and blocked states need precise semantics. |
| OQ-8 | How should capability discovery be represented? | Several FHIR resources or a dedicated operation are candidates. |
| OQ-9 | How should recommendation category be represented and governed? | It must remain distinct from forecast status and reason. |
| OQ-10 | How should the FHIR binding align with the current Contextual Conditions date rule? | The older draft permits `Observation.effective[x]`; the Contextual Conditions Topic Reference models a meaningful date as a separate condition. |
| OQ-11 | Which parts of FHIR R6 should influence an R4 first implementation? | The project needs a deliberate compatibility path. |
| OQ-12 | What examples are required before broad implementation review? | The current examples cover only a small portion of the proposed behavior. |
