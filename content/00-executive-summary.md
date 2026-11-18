# Executive Summary

::: {.status-notice}
**Version 0.3.0: working preview for community reaction.**

This is a working draft, not a standard, approved specification, ballot
artifact, or clinical guidance. It gathers in one place what the Immunization
CDS (ImmDS + HALO) work has proposed and discussed so far, so the community can
correct it. It is unfinished. Disagreements and open questions are left visible
on purpose, in [Working Decisions](90-working-decisions.md#working-decisions).

Corrections are welcome as comments on the published page, as GitHub issues,
or in the
[topic 1 meetings](https://informatics.immregistries.org/hub/es/topic/1).
:::

<!-- changed v0.4.0: The guide now opens with this summary and a separate Scope. Use cases, basis and history, and related work moved to the Background chapter. -->

Immunization clinical decision support (CDS) engines evaluate a patient's
immunization history and recommend the vaccinations due now or later. Many
engines run as independent services that receive patient information and
return evaluations and recommendations. They perform similar functions but use
different proprietary interfaces. That raises integration costs, makes it hard
to switch engines, and makes testing and validation harder.

Immunization CDS (ImmDS + HALO) defines **one common service interface for
immunization CDS engines**. It standardizes the exchange between a system that
requests immunization decision support and the engine that provides it. It does
**not** standardize clinical decision logic, vaccination schedules, or
forecasting methods.

The name joins the original Immunization Decision Support Forecast (ImmDS)
interface with HALO, short for **H**ealth, **A**ge, **L**ifestyle,
**O**ccupation, and other factors. HALO is implemented as
[Contextual Conditions](https://immregistries.github.io/contextual-conditions/latest/),
the subject of [topic 7](https://informatics.immregistries.org/hub/es/topic/7):
neutral, coded facts about a patient's circumstances that the requesting system
supplies and the engine may use.
