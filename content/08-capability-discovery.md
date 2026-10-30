# Capability Discovery

Patient-specific transparency answers what happened in one forecast call.
Capability discovery answers what a service can generally do before a client
sends patient data. Keeping these concerns separate avoids overloading the
forecast response.

A useful discovery mechanism may describe:

- supported vaccines and target diseases;
- recognized vaccines that are not forecasted;
- available Knowledge Bases and versions;
- relevant guidance sources;
- supported Contextual Conditions;
- which conditions affect recommendations and which only identify missing
  context;
- update cadence, documentation, provenance, and contact information; and
- supported operation versions and profiles.

The September FHIR draft includes a basic `CapabilityStatement` and one
`ObservationDefinition` example. Candidate FHIR approaches also include a
dedicated operation, `ValueSet`, `ConceptMap`, `Library`, and `PlanDefinition`.
No complete discovery contract has been selected.

<!-- CONFIRM: Define the smallest capability artifact needed for the first interoperable implementation rather than attempting to settle every discovery question at once. -->
