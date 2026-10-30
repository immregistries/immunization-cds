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
