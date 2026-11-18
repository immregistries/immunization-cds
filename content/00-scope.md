# Scope

This Topic Reference defines one common service interface between systems that
request immunization decision support and the engines that provide it.

## In scope {#in-scope}

- The stateless request and response between a requesting system and a CDS
  engine: assessment date, patient, immunization history, and Contextual
  Conditions in; dose evaluations and recommendations out.
- **Communicating Contextual Conditions** in the request, and how an engine
  **indicates support** for them, both in advance and in each response.
- Identifying the [Knowledge Base](02-knowledge-bases-and-capabilities.md#knowledge-bases)
  an engine applied, and the guidance behind each recommendation.
- How evaluations and recommendations are expressed: target disease, forecast
  status and reason, recommendation category, series, season, and similar
  elements.
- Identifying the CDS engine itself, separately from its Knowledge Base, and
  capability discovery: asking an engine what it supports before any patient
  data is sent.
- A FHIR R6 representation, with the changes to FHIR resources it needs, plus
  examples, terminology guidance, and support for testing.

## Out of scope {#out-of-scope}

<!-- CONFIRM: Items marked "(not covered by any current topic)" were added
to meet the new Scope rule; confirm that no InteropHub topic covers each. -->

- Clinical decision logic, vaccination schedules, forecasting methods, and how
  an engine computes its results (not covered by any current topic).
- How Contextual Conditions are collected, inferred, maintained, or governed,
  and how an engine uses them. What a Contextual Condition *is* belongs to
  [topic 7](https://informatics.immregistries.org/hub/es/topic/7).
- Engines retrieving data from other systems, interpreting medical records, or
  inferring missing information (not covered by any current topic).
- Clinician workflow, user interface, and presentation of results. This
  includes calling CDS at points in an EHR workflow, which is the role of CDS
  Hooks (see [Related work](00-background.md#related-work)).
- Persisting patient data in the engine between requests (not covered by any
  current topic).
- Who may send or receive this information, and how it is used, disclosed, or
  protected (not covered by any current topic).
