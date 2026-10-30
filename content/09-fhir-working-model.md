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
