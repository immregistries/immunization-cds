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
