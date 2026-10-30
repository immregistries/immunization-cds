# Architecture

ImmDS + HALO is a machine-to-machine forecast interface. It can support an IIS,
clinical application, workflow system, testing tool, or CDS Hooks integration,
but it does not define the user experience of those systems.

The conceptual flow is:

```text
Requesting system
  assessment date + patient + immunization history + optional context
                              |
                              v
CDS service applies one executable Knowledge Base
                              |
                              v
evaluations + recommendations + transparency + provenance
```

## Responsibilities

The requesting system assembles the patient facts, immunization history, and
asserted Contextual Conditions needed for the call.

The CDS service validates the request, applies one coherent Knowledge Base, and
produces the requested evaluations and recommendations. The interaction does
not require the service to inspect other patient records, maintain a session,
or dynamically combine individual sources of guidance at runtime.

The response identifies material limitations: for example, data that was not
recognized or supported, context that was ignored, incomplete results, or an
issue that prevented a reliable forecast.

## Guidance and executable logic

Organizations or expert bodies publish clinical guidance. Software implements
guidance as executable rules. These are related but not identical artifacts.
Section 6 distinguishes the publisher or source of guidance from the Knowledge
Base actually executed by a CDS service.
