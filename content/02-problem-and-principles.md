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
