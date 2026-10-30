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
