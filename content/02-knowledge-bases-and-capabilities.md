# Knowledge Bases, Engines, and Capabilities

## Knowledge Bases {#knowledge-bases}

Schedule Authorities publish guidance. CDS engines run Knowledge Bases that put
that guidance into operation. Both are defined in
[Terms](01-service-interaction.md#terms). This section covers how they appear in
the interface.

```{mermaid}
flowchart LR
  SA1["Schedule Authority A<br/>e.g., a national advisory committee"]
  SA2["Schedule Authority B<br/>e.g., a travel medicine body"]
  SA3["Local or jurisdictional adaptation"]
  subgraph ENG["CDS engine"]
    direction TB
    KB1["Knowledge Base 1<br/>guidance from A"]
    KB2["Knowledge Base 2<br/>guidance from A and B, plus local adaptation"]
  end
  SA1 -->|"published guidance"| KB1
  SA1 --> KB2
  SA2 --> KB2
  SA3 --> KB2
  REQ["Request<br/>selects Knowledge Base 2"] --> KB2
  KB2 --> RES["Response<br/>Knowledge Base used: 2<br/>each recommendation names<br/>the authority behind it"]
```

*Figure 3. A Knowledge Base may combine guidance from several Schedule Authorities. A request selects one whole Knowledge Base; it never mixes authorities itself.*

<!-- CONFIRM: Figure 3 is the first version of the Knowledge Base graphic requested at the 29 October 2026 meeting. It needs review. -->

<!-- anchor: one-knowledge-base -->

- **One Knowledge Base per request.** A request may name a Knowledge Base, and
  a version, from those the engine offers. The engine applies that one
  Knowledge Base, or its default, and says which one it used.
- **No mixing at request time.** If guidance from several authorities must be
  combined, the engine publishes that combination as its own Knowledge Base.
  The requesting system cannot assemble authorities in a request.
- **Locally defined identifiers.** Each engine names its own Knowledge Bases.
  There is no global registry.
- **Local changes.** Whether a response should say when a Knowledge Base has
  been configured or modified locally, and how, is open
  ([OQ-22](90-working-decisions.md#oq-22)).
- **Authority behind each result.** Within one Knowledge Base, different
  recommendations may come from different authorities. For example, influenza
  guidance from one authority and tuberculosis guidance from another, for the
  same patient. A result can name the authority that applies to it.

<!-- anchor: roles -->

**Roles.** This interface uses two roles, the Schedule Authority and the
Knowledge Base. Publishing Contextual Condition code systems adds a third, the
terminology steward, defined by
[topic 7](https://immregistries.github.io/contextual-conditions/latest/#authorities)
together with how these three replace the four roles of earlier sources
([WD-11](90-working-decisions.md#wd-11)). Whether "Schedule
Authority" is the right name is open
([OQ-1](90-working-decisions.md#oq-1)).

<!-- anchor: authority-placement -->

Where the authority is recorded is under discussion
([OQ-6](90-working-decisions.md#oq-6)). FHIR currently allows at most
one `authority` on `ImmunizationEvaluation` and on `ImmunizationRecommendation`,
at the resource level, as a reference to an organization. Change requests
propose allowing several, moving the recommendation's authority down to each
recommendation, and possibly allowing a code rather than an organization
reference (see [FHIR change requests](04-fhir-and-testing.md#change-requests)).
Discussion so far has raised two concerns: whether authority is an attribute of
the Knowledge Base, of each recommendation, or both, and whether recording it
in several places will confuse readers.

## Documentation of the rule behind a result {#rule-documentation}

Implementers asked for a way to point from a recommendation to the rule that
produced it: the specific decision support logic for that target disease. At
least one engine already returns a URL for this. Useful content could include
a link, a version, and a date. It complements, but differs from:

- the recommendation's description, which carries clinical information for the
  user; and
- the Knowledge Base used, which identifies the rule set as a whole.

Candidate FHIR approaches include an element or extension on the
recommendation that references a `PlanDefinition`, `Library`, or
`DeviceDefinition`, or simply carries a URL. Whether to expose rule URLs is
each engine's choice; the interface only needs a place to put them
([OQ-13](90-working-decisions.md#oq-13)).

## Engine identity {#engine-identity}

<!-- CONFIRM: Engine identity has been discussed by the group but not agreed. This section is a placeholder for discussion (OQ-23). -->

The CDS engine is the software that runs a Knowledge Base. It is distinct from
the Knowledge Base it applies and from the Schedule Authorities whose guidance
that Knowledge Base puts into operation. One engine may offer several
Knowledge Bases, and one Knowledge Base may run on more than one release of an
engine.

Identifying the engine itself, such as its product name, version, and release,
has been discussed as useful alongside the Knowledge Base used. For example, it
could show whether a change in results came from new software or from changed
rules. Whether a response must identify the engine, and how, is open
([OQ-23](90-working-decisions.md#oq-23)).

## Capability discovery {#capability-discovery}

A response's support report says what happened in one request. Capability
discovery lets a requesting system ask an engine what it supports in general,
before any patient data is sent. Keeping them apart stops the forecast response
from becoming overloaded
([WD-6](90-working-decisions.md#wd-6)).

Discovery may describe:

- the engine itself: product, version, and release (see
  [Engine identity](#engine-identity));
- the Knowledge Bases offered, with versions, the Schedule Authorities they
  draw on, effective dates, and documentation;
- the code sets the engine uses, such as vaccine and Contextual Condition code
  systems, with their versions;
- the target diseases each Knowledge Base forecasts, and the vaccines that
  count toward each;
- vaccine codes recognized, with a status for each: recognized but not a valid
  vaccine (such as a historical code), recognized but not evaluated, or
  evaluated and used in recommendations;
- concepts the engine does not handle at all, such as an engine that does not
  forecast rabies vaccine;
- Contextual Conditions recognized, with a status for each: ignored, used only
  to suggest missing context, or affecting results; and
- any `Questionnaire` resources the engine publishes for collecting
  conditions.

<!-- anchor: discovery-options -->

Two delivery patterns have been discussed: a dedicated operation that returns
everything in one bundle, and artifacts published at stable addresses
(`CapabilityStatement`, `ValueSet`, `ConceptMap`, `ObservationDefinition`) with
a light index. The September FHIR draft has only a basic `CapabilityStatement`
and one `ObservationDefinition` example. No design has been chosen
([OQ-8](90-working-decisions.md#oq-8)).
