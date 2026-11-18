# Background

## Use cases {#use-cases}

The interface serves two primary use cases.

<!-- anchor: use-case-access -->

1. **Access to CDS from any provider.** An immunization information system
   (IIS), electronic health record (EHR), pharmacy system, public health
   application, or any other health information system calls immunization CDS
   services from different vendors and organizations through one common
   integration. It can change or add engines without building a new interface.

<!-- anchor: use-case-testing -->

2. **Testing and validation.** A testing platform sends published test cases
   to a CDS engine through the same interface and compares the results with the
   expected outcomes. See [Testing and validation](04-fhir-and-testing.md#testing).

## International by design {#international}

Early work came from the United States immunization community. Collaboration
with international participants has shown that the concepts do not depend on
any one country, schedule, or terminology system. The interface therefore
supports jurisdiction-specific policies, schedules, and coding systems without
requiring a particular forecasting method. National or system-level guides may
later constrain it, for example by requiring certain code systems or Contextual
Conditions.

## Basis and history {#basis}

<!-- anchor: builds-on-immds-1 -->

This work builds on the published
[ImmDS 1.0.0 Implementation Guide](https://hl7.org/fhir/us/immds/) (STU1,
FHIR R4, US Realm). It keeps that guide's stateless request-and-response model,
built on the `$immds-forecast` operation, and extends what the request and
response can carry. It targets FHIR R6 and does not need to remain
wire-compatible with the R4 guide ([WD-9](90-working-decisions.md#wd-9)).

<!-- anchor: scope-statement -->

The [Scope](00-scope.md#scope) follows the "Latest Proposed Language" on the
HL7 Public Health Work Group's
[Immunization Decision Support](https://confluence.hl7.org/spaces/PHWG/pages/230556918/Immunization+Decision+Support)
page. HL7 Public Health, the sponsoring work group, judged that the expanded
scope fits within the existing project scope statement,
[PSS-2764](https://jira.hl7.org/browse/PSS-2764), so the PSS is not being
revised. This Topic Reference is where the scope is stated in full
([WD-8](90-working-decisions.md#wd-8)).

## Related work {#related-work}

| Work | Relationship |
|---|---|
| [ImmDS 1.0.0](https://hl7.org/fhir/us/immds/) | The published R4 interface this work extends. |
| [CDS Contextual Conditions, topic 7](https://informatics.immregistries.org/hub/es/topic/7) ([Topic Reference](https://immregistries.github.io/contextual-conditions/latest/)) | Defines what a Contextual Condition is, how Schedule Authorities define conditions, and how condition code systems are published. This topic defines how conditions travel in the FHIR request and how support is reported; see [Contextual Conditions in the request](01-service-interaction.md#contextual-conditions). |
| [HL7 v2 Contextual Conditions Exchange, topic 137](https://informatics.immregistries.org/hub/es/topic/137) | The HL7 v2 representation of Contextual Conditions. |
| CDS Hooks | Calls decision support at points in an EHR workflow and turns results into clinician-facing cards. A CDS Hooks service can call an ImmDS + HALO engine rather than rebuild forecasting logic, and can gather patient information from other systems, which this interface leaves out. The two are complementary layers. |
| CDC Clinical Decision Support for Immunization (CDSi) and other forecasting methods | CDSi and the methods behind other national and commercial engines are complementary. This interface is a common layer through which they can be reached; it does not replace them. |
| [Vaccination CDS guide (EUVABECO)](https://build.fhir.org/ig/EUVABECO/VCDS/) | A European FHIR guide with similar functions, including a questionnaire for patient context. The two efforts should stay aligned ([OQ-18](90-working-decisions.md#oq-18)). |
| [SITT Forecasting and Immunization Test Suite (FITS)](https://tools.valitheus.com/fits/#/home), formerly NIST FITS | The primary target testing platform for the [testing use case](04-fhir-and-testing.md#testing). It moved from NIST to Prometheus Computing, LLC, and is now part of the Standards & Interoperability Testing Tools (SITT) at [Valitheus](https://valitheus.com/). See [Testing platform: SITT FITS](04-fhir-and-testing.md#sitt-fits). |
| Step Into CDSi | A demonstration engine and client that use the draft interface. |
| Immunization Vocabularies Collaborative (IVC) | A possible publisher of code systems, such as forecast status values and Contextual Condition code systems. |
| [ImmDS + HALO FHIR IG working draft](https://github.com/immregistries/immds-halo-fhir-ig-working-draft) | The September 2026 technical draft. It is to become a product of this Topic Reference ([WD-1](90-working-decisions.md#wd-1)). |
