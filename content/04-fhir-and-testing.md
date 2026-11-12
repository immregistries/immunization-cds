# FHIR Model and Testing

## FHIR R6 is the target {#fhir-version}

<!-- anchor: r6-target -->

This work proposes an R6 solution ([WD-9](90-working-decisions.md#wd-9)).
No R4 implementation needs backward compatibility; the only known R4 work is a
partial implementation by NIST, under the former NIST Health IT Program, that
was never fully tested. If an R4 version is
needed later, a back-port will be proposed then; the project does not expect
one to be needed. Implementers working ahead of publication are targeting R6.

## FHIR model {#fhir-model}

The interaction is a FHIR operation that takes the request as input parameters
and returns the response as output parameters. It does not change server
state.

| Concept | FHIR resource | Notes |
|---|---|---|
| Forecast interaction | `OperationDefinition` | ImmDS 1.0.0 used `$immds-forecast`; the September draft uses `$immds-halo-forecast` ([OQ-3](90-working-decisions.md#oq-3)) |
| Patient | `Patient` | Date of birth is the minimum |
| Immunization history | `Immunization` | |
| Contextual Condition | `Observation` | Code from the Schedule Authority's code system, value in `value[x]`. A meaningful date is a separate condition, not `effective[x]` ([WD-12](90-working-decisions.md#wd-12)) |
| Supported or suggested condition | `ObservationDefinition` | |
| Optional question set | `Questionnaire` | Answers map directly to conditions |
| Dose evaluation | `ImmunizationEvaluation` | |
| Recommendation | `ImmunizationRecommendation` | The September draft keeps one resource with many recommendation entries, as in ImmDS 1.0.0 |
| Messages | `OperationOutcome` | |
| Service declaration | `CapabilityStatement` | See [Capability discovery](02-knowledge-bases-and-capabilities.md#capability-discovery) |
| Rule documentation | `PlanDefinition`, `Library`, or `DeviceDefinition` | Candidates only; see [rule documentation](02-knowledge-bases-and-capabilities.md#rule-documentation) |

The operation's parameters in the September draft are:

- **In:** `assessmentDate`, `patient`, `immunization`, `contextualCondition`,
  `knowledgeBase`, and `knowledgeBaseVersion`.
- **Out:** `evaluation`, `recommendation`, `operationOutcome`,
  `knowledgeBaseUsed`, `contextualConditionUsed`, `contextualConditionIgnored`,
  `contextualConditionUnsupported`, and `additionalContextSuggested`.

## Changing the resources rather than extending them {#change-requests}

<!-- anchor: extensions-into-resources -->

Several needs are met today with extensions. The working direction is to move
them into the base resources through FHIR change requests, rather than keep
permanent extensions ([WD-15](90-working-decisions.md#wd-15)).
`ImmunizationEvaluation` and `ImmunizationRecommendation` are not normative, so
they can still change.

| Change request | Summary | Status (10 Nov 2026) |
|---|---|---|
| [FHIR-56989](https://jira.hl7.org/browse/FHIR-56989) | `ImmunizationEvaluation.authority`: allow more than one | Submitted |
| [FHIR-56990](https://jira.hl7.org/browse/FHIR-56990) | `ImmunizationRecommendation.authority`: allow more than one | Submitted |
| [FHIR-57247](https://jira.hl7.org/browse/FHIR-57247) | Move `ImmunizationRecommendation.authority` under the recommendation element | Submitted |
| [FHIR-58655](https://jira.hl7.org/browse/FHIR-58655) | `ImmunizationRecommendation` vaccine code has a mixed definition | Submitted |
| [FHIR-58952](https://jira.hl7.org/browse/FHIR-58952) | Allow several target diseases in `ImmunizationEvaluation` | Submitted |
| [FHIR-59485](https://jira.hl7.org/browse/FHIR-59485) | `ImmunizationEvaluation.series`: string to CodeableConcept | Submitted |
| [FHIR-59486](https://jira.hl7.org/browse/FHIR-59486) | `ImmunizationRecommendation` series: string to CodeableConcept | Submitted |
| [FHIR-59487](https://jira.hl7.org/browse/FHIR-59487) | `ImmunizationEvaluation`: add season | Submitted |
| [FHIR-59488](https://jira.hl7.org/browse/FHIR-59488) | `ImmunizationRecommendation`: add season | Submitted |
| [FHIR-59489](https://jira.hl7.org/browse/FHIR-59489) | `ImmunizationRecommendation`: add doses remaining in the series | Submitted |

<!-- CONFIRM: Add any other open change requests the group is tracking, such as the rest of the seven tickets discussed on 1 October 2026, and the forecast status code set. -->

<!-- anchor: incubator -->

These resources are being developed in an R6 incubator. Implementers have to
decide whether to stay conformant with the current incubator or build to where
the change requests are heading. At least one implementer prefers to build as
close to the expected final form as possible, so as not to split its interface
twice ([OQ-16](90-working-decisions.md#oq-16)).

## Testing and validation {#testing}

Testing is the second use case in [Use cases](00-status-and-scope.md#use-cases).
Labeling a result with its authority shows where the guidance came from, but
not whether the engine applied it correctly. Only systematic, repeated testing
shows that.

```{mermaid}
flowchart LR
  TC["Published test case<br/>assessment date, patient, history,<br/>Contextual Conditions, expected results"]
  TP["Testing platform"]
  ENG["CDS engine under test"]
  CMP["Compare actual with expected"]
  TC --> TP -->|"standard request"| ENG -->|"standard response"| TP --> CMP
```

*Figure 4. The same interface that serves care also lets one testing platform test any engine.*

<!-- anchor: shared-testing -->

- A common interface lets one testing platform, such as SITT FITS, test any
  conformant engine, and lets test case libraries be shared rather than
  rebuilt for each engine's interface.
- Testing can be repeated whenever schedules, codes, or engines change.
- Expected results may need to allow more than one recommendation per target
  disease (see [More than one recommendation for a target disease](03-evaluations-and-recommendations.md#multiple-recommendations)).
- The interface tests communication and results; it does not certify that an
  engine is clinically correct. Jurisdictions and programs decide what
  performance they require.

### Testing platform: SITT FITS {#sitt-fits}

The Forecasting and Immunization Test Suite (FITS) was built by the NIST
Health IT Program. As that program ends, its conformance and testing tools are
moving to outside organizations, mainly Prometheus Computing, LLC, so they stay
maintained and publicly available. FITS is now part of the Standards &
Interoperability Testing Tools (SITT) at [Valitheus](https://valitheus.com/),
and runs at [tools.valitheus.com/fits](https://tools.valitheus.com/fits/#/home).

- **Past work.** Earlier NIST work on FITS and the R4 ImmDS interface is
  history. It informs this work but sets no compatibility requirement
  ([WD-9](90-working-decisions.md#wd-9)).
- **Future work.** SITT FITS is a primary target for ImmDS + HALO support. It
  is expected to be used to test how the new CDS engines support HALO, that
  is, how they use Contextual Conditions and report the ones they do not
  support ([WD-19](90-working-decisions.md#wd-19)).

<!-- CONFIRM: Check how SITT FITS plans to support the R6 interface and Contextual Conditions, and its timeline, with Prometheus Computing. -->

<!-- anchor: test-case-format -->

Test cases take a lot of work to write, so a standard way to export and import
them between tools would help. Most existing test cases use relative dates,
such as "two months after birth", rather than fixed dates. FHIR resources
expect fixed dates, so a test case format may need extensions or a separate
structure ([OQ-17](90-working-decisions.md#oq-17)).

## Discussion examples {#examples}

These scenarios test the design. They are not clinical guidance.

| Scenario | What the response must show |
|---|---|
| Baseline: date of birth and history, no conditions | Results from the default Knowledge Base. Conditions that were not sent are unknown, not No |
| Supported condition: pregnancy asserted | The condition is reported as used. The Knowledge Base used is named |
| Unsupported condition: international travel asserted | The condition is reported as unsupported, and the effect on completeness is visible |
| Broad condition leads to suggestions | Additional context suggested, such as destination and departure date |
| Knowledge Base selected by identifier and version | The Knowledge Base actually used, or a clear error |
| Two authorities for one patient: influenza from one, tuberculosis from another | Each recommendation names its authority within one Knowledge Base |
| Combination vaccine: measles, mumps, and rubella | One recommendation with three target diseases |
| Target disease not handled, such as rabies | Reported as not handled, not as a patient status |
| Contraindication | Status and the specific reason |
| Seasonal vaccine | The season the recommendation is for |
| Dates differ by product: COVID-19, next dose at 4 or 8 weeks | Which dates apply to which product ([OQ-20](90-working-decisions.md#oq-20)) |
| Risk-based and routine recommendations for MMR at 6 months | Both recommendations, each with its category, without appearing to conflict ([OQ-21](90-working-decisions.md#oq-21)) |

Examples still needed include unknown vaccine codes, partial and blocked
results, recommendation categories, and guidance that differs by jurisdiction.
