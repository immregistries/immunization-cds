# Appendix: Working Decisions and Open Questions

A working decision is the current position for discussion, not a final or
approved decision. Each one records where it came from, so it can be
revisited. IDs are kept stable. A resolved question stays listed with what
resolved it.

## Working decisions {#decisions}

| ID | Working decision | Basis |
|---|---|---|
| WD-1 | This Topic Reference is the single maintained source for the topic. The ImmDS + HALO FHIR IG working draft will become one of its products. | Project direction, November 2026 |
| WD-2 | The interaction is stateless. The engine evaluates only what the current request contains. | ImmDS 1.0.0; scope statement |
| WD-3 | Leaving out a Contextual Condition means unknown, not No, as defined by topic 7. | Topic 7 |
| WD-4 | The requesting system asserts Contextual Conditions. The engine does not retrieve, infer, or interpret them from medical records. | Scope statement; February 2026 narrative draft |
| WD-5 | One whole Knowledge Base is applied per request, and the response names it. Combinations of authorities are published by the engine as their own Knowledge Bases. | February 2026 narrative draft; topic 7 |
| WD-6 | Capability discovery is separate from the per-request support report. | Capability and transparency concept, 2025 |
| WD-7 | Releases carry unresolved design choices openly rather than wait for a complete specification. The community corrects the content. | Project direction, November 2026 |
| WD-8 | Scope follows the "Latest Proposed Language" on the HL7 Public Health Immunization Decision Support page. PSS-2764 is not being revised; this Topic Reference states the scope. | HL7 Public Health, 3 September 2026; project direction, November 2026 |
| WD-9 | FHIR R6 is the target. There is no requirement for backward compatibility with ImmDS 1.0.0 on R4. An R4 back-port would be proposed later only if needed. Resolves OQ-4 and OQ-11. | Meetings of 3 and 17 September and 29 October 2026; project direction, November 2026 |
| WD-10 | HALO is implemented as Contextual Conditions, defined by topic 7. This topic defines how conditions are exchanged in FHIR and how an engine reports support for them. | Topic 7 WD-5 and WD-6 |
| WD-11 | Role names follow topic 7: Schedule Authority, terminology steward, and Knowledge Base. Resolves OQ-2. | Topic 7 WD-10 |
| WD-12 | A date that matters to a condition is sent as its own date-valued condition, not in `Observation.effective[x]`. Resolves OQ-10. | Topic 7 WD-8 |
| WD-13 | Results are organized by target disease. Target disease is always given and may repeat, one disease per repeat. "Vaccine group" is not used. The vaccine code is given only for a specific vaccine. | Meeting of 17 September 2026; FHIR-58655, FHIR-58952 |
| WD-14 | Forecast status gets a standardized code set. Forecast reason stays more open and may carry several codes, such as a standard code with a legacy one. | Meeting of 3 September 2026 |
| WD-15 | Needs met today with extensions are proposed as changes to the base FHIR resources. | Meeting of 3 September 2026; change requests listed in the FHIR chapter |
| WD-16 | Testing platforms are first-class requesting systems. Testing and validation is one of the two primary use cases. | Scope statement |
| WD-17 | Questionnaires are optional extras that an engine may publish. They are not part of the forecast request. | February 2026 narrative draft; meeting of 29 October 2026 |
| WD-18 | CDS Hooks is complementary. Calling CDS from EHR workflow, and gathering patient data from other systems, are outside this interface. | 2025 CDS Hooks comparison; meeting of 29 October 2026 |
| WD-19 | SITT FITS, formerly NIST FITS and now maintained by Prometheus Computing, is the primary target testing platform. It is expected to test how CDS engines support HALO through Contextual Conditions. Earlier NIST R4 work is treated as history. | Project direction, November 2026; NIST Health IT Program transition |

## Open questions {#open-questions}

| ID | Question | Context | Status |
|---|---|---|---|
| OQ-1 | Should "Schedule Authority" be renamed? | "Schedule" may be too narrow, and "authority" may suggest governance that does not exist. Topic 7 kept the name in its WD-10. | Referred to topic 7 |
| OQ-2 | How do the role names map to the earlier four roles? | | Resolved by WD-11 |
| OQ-3 | Should the operation keep the name `$immds-forecast` or use `$immds-halo-forecast`? | With no compatibility requirement (WD-9), the choice is about what the name signals. | Open |
| OQ-4 | Does the guide depend on the ImmDS 1.0.0 R4 guide? | | Resolved by WD-9 |
| OQ-5 | How are Knowledge Bases identified, versioned, discovered, requested, and named in the response? | Identifiers are local to each engine. Parameters are placeholders. | Open |
| OQ-6 | Where is the authority recorded: on the Knowledge Base, on each recommendation, or both? As an organization or as a code? | FHIR-56989, FHIR-56990, FHIR-57247. Concern about confusing readers with the same information in several places. Raised 29 October 2026. | Open |
| OQ-7 | What is the minimum support report, and how does a requesting system tell complete, partial, and blocked results apart? | `OperationOutcome` alone, or with a response-level status. Draft list of message types. | Open |
| OQ-8 | How is capability discovery delivered? | A dedicated operation, or published artifacts with an index. | Open |
| OQ-9 | How is recommendation category represented in FHIR, and who governs its values? | A LOINC concept has been proposed for HL7 v2. | Open |
| OQ-10 | How does the FHIR binding handle condition dates? | | Resolved by WD-12 |
| OQ-11 | Which FHIR version? | | Resolved by WD-9 |
| OQ-12 | Which examples are needed before broad implementation review? | See the example list in the FHIR chapter. | Open |
| OQ-13 | How does a recommendation point to the rule behind it? | A URL, or a reference to a `PlanDefinition`, `Library`, or `DeviceDefinition`. Raised 17 September and 1 October 2026. | Open |
| OQ-14 | What are the standard forecast status values, and where are they published? | "Conditional" and "Not available" are in use but not in the LOINC list. "Not available" may belong in capability discovery instead. Values could be hosted at hl7.org. | Open |
| OQ-15 | How are seasons identified, so that a season on an evaluation or recommendation is unambiguous? | Raised 17 September 2026; FHIR-59487, FHIR-59488. A group may be convened on seasons. | Open |
| OQ-16 | Should implementers stay conformant with the current R6 incubator, or build to where the change requests are heading? Can the change requests be fast-tracked? | Raised 1 October 2026. | Open |
| OQ-17 | Should there be a standard format for exchanging test cases between testing tools, and how are relative dates represented? | Notes on the HL7 Public Health Immunization Decision Support page. | Open |
| OQ-18 | How should this work align with the European Vaccination CDS guide (EUVABECO)? | Similar functions, including a questionnaire for patient context. | Open |
| OQ-19 | How should vaccine codes be reported as recognized, not evaluated, or unknown, in discovery and in each response? | Proposed in the 2025 difference summary and the capability concept. | Open |
