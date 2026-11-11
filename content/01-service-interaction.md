# Service Interaction

## The interaction at a glance

A requesting system sends one stateless request. The CDS engine evaluates it
against one Knowledge Base and returns the results. Nothing is remembered
between requests.

```{mermaid}
%%{init: {"flowchart": {"wrappingWidth": 400}}}%%
flowchart TB
  R["<b>Request</b><br/><br/>Assessment date<br/>Patient: date of birth and other demographics<br/>Immunization history<br/>Contextual Conditions (optional)<br/>Requested Knowledge Base (optional)"]
  E["<b>CDS engine</b><br/><br/>Applies one Knowledge Base"]
  O["<b>Response</b><br/><br/>Dose evaluations<br/>Recommendations<br/>Knowledge Base used<br/>Support report: conditions used, ignored, unsupported, or invalid<br/>Additional context suggested<br/>Messages: warnings, partial results, errors"]
  R -->|"one request"| E -->|"one response"| O
```

*Figure 1. One stateless request and response, from a requesting system or testing platform. The engine sees only what the request contains.*

## Terms {#terms}

Each term is defined once here and linked from elsewhere. Terms owned by
[topic 7](https://informatics.immregistries.org/hub/es/topic/7) link to its
definitions rather than repeating them.

| Term | Working definition |
|---|---|
| **Requesting system** | The system that assembles the patient information and asks for evaluations and recommendations: an IIS, EHR, pharmacy system, public health application, CDS Hooks service, or testing platform. |
| **CDS engine** | The service that evaluates the request against a Knowledge Base and returns evaluations and recommendations. Also called a forecaster. |
| **Testing platform** | A requesting system that sends test cases and compares the engine's results with expected outcomes. |
| **Assessment date** | The date for which the evaluation and forecast are calculated. It is normally today, and may be another date for testing or review. Contextual Conditions are asserted as applying on this date. |
| **Immunization history** | The vaccination events supplied in the request, as recorded. |
| **Evaluated history** | The immunization history after the engine has judged each dose against the guidance, expressed as dose evaluations. |
| **Dose evaluation** | The engine's judgment of one supplied dose for one target disease: for example valid, not valid, or valid but not counted toward the series, with a reason. |
| **Recommendation** | The engine's patient-specific forecast for one target disease, or for one vaccine where a specific vaccine is recommended: status, reason, dates, and related details. |
| **Target disease** | The disease a dose or recommendation protects against. It is the organizing key of a recommendation, replacing the undefined idea of a "vaccine group" ([WD-13](90-working-decisions.md#working-decisions)). |
| **Forecast status** | Where the patient stands for a target disease, such as due, overdue, complete, or not recommended. Proposed as a standardized code set ([WD-14](90-working-decisions.md#working-decisions)). |
| **Forecast reason** | Why that status applies to this patient, such as a contraindication or a risk condition. More open than status, and may carry several codes. |
| **Recommendation category** | How the Schedule Authority classifies the recommendation, such as routine, risk-based, shared clinical decision-making, or mandatory. It is not patient-specific. See [Recommendation category](03-evaluations-and-recommendations.md#recommendation-category). |
| **Contextual Condition** | A coded, neutral fact about the patient's circumstances that may affect a recommendation. Defined by [topic 7](https://immregistries.github.io/contextual-conditions/latest/). HALO factors are Contextual Conditions. |
| **Schedule Authority** | An organization or expert body that publishes immunization recommendations for clinical or public health use, such as a national advisory committee. It decides which factors affect its guidance and defines the Contextual Conditions its guidance needs, as described by [topic 7](https://immregistries.github.io/contextual-conditions/latest/#authorities). See [Knowledge Bases](02-knowledge-bases-and-capabilities.md#knowledge-bases). |
| **Knowledge Base** | An identifiable, versioned, executable rule set that puts into operation guidance from one or more Schedule Authorities, possibly with jurisdictional or local adaptations. A CDS engine applies one Knowledge Base per request. See [Knowledge Bases](02-knowledge-bases-and-capabilities.md#knowledge-bases). |
| **Support report** | The part of a response that says which submitted conditions and vaccine codes the engine used, ignored, did not support, or found invalid. |
| **Capability discovery** | Finding out what an engine supports before sending patient data. See [Capability discovery](02-knowledge-bases-and-capabilities.md#capability-discovery). |

<!-- CONFIRM: These definitions are first drafts for the 12 November 2026 discussion. Expect them to change. -->

## Responsibilities {#responsibilities}

<!-- anchor: requester-responsibility -->

**The requesting system** supplies the best patient information it has:
demographics, immunization history, and any known Contextual Conditions. It
decides how that information is gathered. It is responsible for reading the
support report and accounting for anything the engine did not consider.

<!-- anchor: engine-responsibility -->

**The CDS engine** produces results only from the request. It does not
retrieve data from other systems, interpret medical records, infer missing
information, or keep patient data between requests. It reports what it did
and did not consider, because safety comes from making limits visible, not
from assuming the engine handles everything.

<!-- anchor: clinician-responsibility -->

**Clinicians and programs** remain responsible for decisions. The results are
machine-readable data for downstream systems, not text meant to be shown
directly to a clinician.

## Request {#request}

| Input | Purpose | Status |
|---|---|---|
| Assessment date | The date the forecast is calculated for | Required |
| Patient | Date of birth is the minimum; other demographics are optional | Required |
| Immunizations | The immunization history | Zero or more |
| Contextual Conditions | Asserted facts beyond demographics and history | Zero or more |
| Knowledge Base and version | Selects one Knowledge Base the engine offers | Optional; the engine's default if absent |

## Response {#response}

| Output | Purpose |
|---|---|
| Dose evaluations | One per supplied dose and target disease |
| Recommendations | The patient-specific forecast |
| Knowledge Base used | The rule set actually applied |
| Support report | Submitted conditions and vaccine codes used, ignored, unsupported, or invalid |
| Additional context suggested | Conditions the engine could use if they were supplied |
| Messages | Informational notes, warnings, partial results, and blocking errors |

Results are temporary. They apply to the request that produced them and are
replaced by the next evaluation, not updated in place. A requesting system may
keep them for its own audit or legal reasons, which is outside this interface.

## Contextual Conditions in the request {#contextual-conditions}

<!-- anchor: cc-boundary -->

What a Contextual Condition is, including datatypes, the meaning of absence,
evaluation dates, and who defines conditions, belongs to
[topic 7](https://immregistries.github.io/contextual-conditions/latest/).
That topic leaves three things to this interface. This section covers them.

```{mermaid}
flowchart TB
  subgraph T7["Topic 7: CDS Contextual Conditions"]
    direction TB
    A["What a condition means, its datatype, and who defines it"]
    B["Absence is unknown, never No"]
    C["A meaningful date is its own condition"]
  end
  subgraph T1["Topic 1: this interface"]
    direction TB
    D["How conditions travel in the FHIR request"]
    E["How an engine declares which conditions it supports"]
    F["How a response reports used, ignored, unsupported, and invalid conditions"]
  end
  T7 -->|"concept used by"| T1
```

*Figure 2. Topic 7 owns the concept. This topic owns how it is exchanged and how support is reported.*

1. **How conditions travel.** Each asserted condition is sent as a coded fact
   with a value. The condition is identified by its Schedule Authority's code
   system. Only asserted conditions are sent. The FHIR representation is in
   [FHIR model](04-fhir-and-testing.md#fhir-model).
2. **How support is declared.** See
   [Capability discovery](02-knowledge-bases-and-capabilities.md#capability-discovery).
3. **How support is reported.** Each response says, for every submitted
   condition, whether the selected Knowledge Base used it, ignored it, does not
   support it, or found it invalid. "Unsupported" does not mean wrong. It means
   the engine could not act on it and the requesting system must consider it
   another way. These states are defined in topic 7's
   [distinct input states](https://immregistries.github.io/contextual-conditions/latest/#distinct-input-states).

<!-- anchor: suggested-context -->

An engine may also return **additional context suggested**: conditions it
could use if they were supplied. A broad condition such as "planning
international travel" may lead an engine to suggest more specific ones, such
as destination or departure date. The requesting system chooses whether to
gather them and resubmit. The engine does not know or care which pattern the
caller follows; each request stands alone.

<!-- anchor: questionnaire -->

**Questionnaires are optional extras.** An engine may publish a FHIR
`Questionnaire` whose answers map directly to the Contextual Conditions it
supports, so that requesting systems can reuse the questions to collect
information from patients or clinicians. The forecast request itself carries
conditions, not questionnaire responses.
