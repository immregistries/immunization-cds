# Contextual Conditions

Contextual Conditions provide the forecast service with operational inputs that
may change an evaluation or recommendation but are not adequately conveyed by
demographics and immunization history alone. Examples include a supplied
assertion that the patient is pregnant, has a relevant immune status, plans
international travel, or that the birth mother received RSV vaccine during
pregnancy.

This project uses the concept defined by the separate
[Contextual Conditions Topic Reference](https://github.com/immregistries/contextual-conditions).
That Topic Reference owns the detailed definition, datatypes, relationship to clinical
information, evaluation-time semantics, and representation principles.

For ImmDS + HALO:

- conditions are supplied by the requesting system;
- omission means unknown rather than No;
- the service reports whether submitted conditions were recognized and used;
- capability discovery can describe which conditions a service or Knowledge
  Base supports; and
- questionnaires may help collect assertions upstream but are not required by
  the forecast interaction.

The earlier FHIR draft uses `Observation` for assertions and
`ObservationDefinition` to describe supported or suggested conditions. These
are current binding proposals rather than the definition of the concept.

<!-- CONFIRM: The September FHIR draft says Observation.effective[x] may carry timing when it matters. The current Contextual Conditions working decision says a meaningful date is a separate date-valued condition and not an Observation date element. The FHIR binding must be reconciled before this detail is reused. -->
