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
