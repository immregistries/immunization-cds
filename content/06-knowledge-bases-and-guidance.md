# Knowledge Bases and Guidance Provenance

The working model distinguishes clinical guidance from its executable
implementation.

## Source of guidance

An organization or expert body publishes immunization recommendations for
clinical or public-health use. Earlier drafts call this body a **Schedule
Authority**. That term is provisional and may be replaced because the role can
publish guidance that is broader, narrower, or less formally versioned than a
single schedule.

## Knowledge Base

A **Knowledge Base** is an identifiable executable operationalization of
guidance from one or more such bodies, possibly including jurisdictional or
local adaptations. It is the coherent rule set a CDS service actually runs.

A client may request one Knowledge Base from those offered by a service. The
service applies one Knowledge Base to a forecast and reports the one actually
used. If combinations of guidance are supported, the service defines them as
coherent Knowledge Bases rather than allowing a requestor to mix individual
guidance sources dynamically.

This distinction answers two different questions:

| Question | Concept |
|---|---|
| Whose clinical guidance or intent is relevant? | Guidance source / provisional “Schedule Authority” role |
| Which executable rules did the service run? | Knowledge Base |

A Knowledge Base may draw on multiple guidance sources, and different
Knowledge Bases may operationalize the same published guidance differently.
Provenance therefore needs to identify the executable artifact without implying
that it is identical to the publisher or the publication.

<!-- CONFIRM: Replace “Schedule Authority” after the community agrees on a term and map it to the earlier four-role governance vocabulary. -->
<!-- CONFIRM: Decide the identifier, version, documentation, and provenance model for Knowledge Bases and guidance sources. -->
