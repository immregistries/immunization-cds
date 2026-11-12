# Evaluations and Recommendations

This chapter covers what the results say. The terms are defined in
[Terms](01-service-interaction.md#terms); the FHIR elements that carry them
are in [FHIR model](04-fhir-and-testing.md#fhir-model).

## Tiers of standardization {#tiers}

Not every element needs the same level of agreement. Discussion so far
suggests two tiers:

| Tier | Elements | Approach |
|---|---|---|
| Standardized | Target disease, forecast status, dose validity | A shared code set, ideally published at hl7.org, so any requesting system can act on the value without knowing the engine |
| Published by the authority or engine | Forecast reason, series, season, recommendation category, dose number | Codes defined by the Schedule Authority or engine and published so they can be looked up. FHIR allows a standard code and a local code side by side in one element |

<!-- CONFIRM: The tier assignment of each element is a working proposal from the 17 September 2026 meeting. -->

## Organized by target disease {#target-disease}

<!-- anchor: target-disease-not-vaccine-group -->

Recommendations and evaluations are organized by **target disease**.
Discussion on 17 September 2026 concluded:

- Target disease is always given on a recommendation, and there may be more
  than one. A measles, mumps, and rubella recommendation lists three target
  diseases, as three separate repeats, not three codes inside one concept.
- "Vaccine group" is not a defined concept and should not be used. Not
  otherwise specified (NOS) vaccine codes, such as the CVX "unspecified
  formulation" codes, should not stand in for a disease.
- The vaccine code is given only when a specific vaccine is recommended. The
  current FHIR definition of `ImmunizationRecommendation.recommendation.vaccineCode`
  mixes these ideas and needs correcting.
- The evaluation side needs the same structure: an evaluation may count toward
  more than one target disease.

At least one engine is changing its target disease output to a list in its
next release.

## Forecast status and reason {#status-and-reason}

<!-- anchor: status-vs-reason -->

**Forecast status** says where the patient stands. **Forecast reason** says
why. Keeping them apart lets status be standardized while reasons stay open.

Points from discussion so far:

- Today's status values are a temporary code set. A standard set is needed,
  with an example binding in the guide.
- Engines differ. One engine uses **Conditional** to tell the user to consider
  the patient's circumstances; that value is not in the current LOINC list.
  CDSi has no "conditional": it uses *complete* (no dates), *not recommended*
  (for example, between seasons), and *not complete* for everything with a
  date, with a risk-based recommendation category where relevant.
- **Not available** has been used to mean the engine does not forecast this
  target disease at all. That is arguably a capability, not a patient status
  ([OQ-14](90-working-decisions.md#oq-14)).
- A contraindication should be traceable to its reason, for example
  "contraindicated", with the reason "allergy to neomycin".
- Long-standing reason code sets exist. Mapping them is a wider conversation.
  FHIR's ability to send several codes lets an engine send a standard code with
  its legacy one.
- There is concern about mixing the strength of a recommendation with what is
  recommended.

## Recommendation category {#recommendation-category}

Schedule Authorities increasingly classify recommendations: routine,
risk-based, shared clinical decision-making, catch-up, mandatory by law, or
recommended but not mandatory. Without a way to send this classification,
systems may drop or downgrade recommendations that are valid but look
"optional".

- The category is assigned by the Schedule Authority and passed on by the
  engine unchanged. The interface does not interpret it or attach workflow to
  it.
- It is optional. Without it, the timing, validity, and status of a
  recommendation mean the same.
- It is distinct from forecast status (when), forecast reason (why for this
  patient), and the authority (who).
- Each authority defines its own categories. There is no international value
  set, and categories may not map across authorities.

A LOINC observation for *Immunization Recommendation Category* has been
proposed for HL7 v2 messaging. How to represent it in FHIR is open
([OQ-9](90-working-decisions.md#oq-9)).

## More than one recommendation for a target disease {#multiple-recommendations}

The discussion so far assumes one recommendation per target disease. An
engine may return more than one, and each case raises its own design
questions.

**Different dates by vaccine product or series pathway.** The next dose may be
due on different dates depending on the product used or the series pathway
followed. For example, a patient may be recommended for COVID-19 vaccination
with the next dose in 4 weeks if one product is used and in 8 weeks if another
is used. This applies to COVID-19 and meningococcal B (MenB) vaccines, and
possibly others. The requesting system needs to know which dates go with which
product or pathway. These could be separate recommendations, each with a
vaccine code or series, or one recommendation with several date sets
([OQ-20](90-working-decisions.md#oq-20)).

**Different recommendation categories.** An engine may return several
recommendations for one target disease, each with a different recommendation
category and possibly different dates. For a 6-month-old, an engine such as
ICE could return two MMR recommendations: a risk-based one that applies now if
certain risk factors are present, and a routine one due at 12 months. Both can
be useful together. Here the recommendation category is what tells the two
apart, which strains the point above that category is optional
([OQ-21](90-working-decisions.md#oq-21)).

In both cases, a requesting system that expects one recommendation per target
disease may show only one, or treat them as conflicting. The response needs to
make clear how the recommendations relate to each other.

<!-- CONFIRM: Raised in community comments, November 2026; not yet discussed by the group. Confirm that MenB and COVID-19 are the right examples to name. -->

## Series, season, and doses remaining {#series-and-season}

<!-- anchor: series -->

**Series.** Knowing which series an engine selected helps trace both
evaluations and recommendations. FHIR carries series as a string; change
requests propose a coded concept.

<!-- anchor: season -->

**Season.** For seasonal vaccines, a requesting system may want to know which
season a dose was evaluated in and which season a recommendation is for. This
is supporting context that helps clinicians and patients understand a
recommendation, not something a decision depends on. At
least one engine sends this in extensions today. Change requests propose adding
season to both resources. How seasons are named is open
([OQ-15](90-working-decisions.md#oq-15)).

<!-- anchor: doses-remaining -->

**Doses remaining.** Users asked for the number of doses left in the series. A
new element has been proposed.

## Support report and messages {#support-report}

Each response says what the engine did and did not consider:

- Contextual Conditions used, ignored, unsupported, or invalid (see
  [Contextual Conditions in the request](01-service-interaction.md#contextual-conditions));
- vaccine codes not recognized, or recognized but not evaluated;
- additional context suggested;
- the Knowledge Base used; and
- informational notes, warnings, partial results, or errors that blocked the
  forecast.

The September FHIR draft returns these as separate output parameters and uses
`OperationOutcome` for messages. A draft list of message types includes:

- unknown condition code;
- unsupported condition code;
- unknown or incompatible Knowledge Base;
- unsupported version;
- conflicting conditions; and
- insufficient information.

How a requesting system can reliably tell a complete result from a partial or
blocked one is open ([OQ-7](90-working-decisions.md#oq-7)). So is
the expected format of the support report
([OQ-25](90-working-decisions.md#oq-25)). When a submitted condition
is used or influences a forecast, it might also be returned with the
recommendation for that target disease, not only in the support report
([OQ-24](90-working-decisions.md#oq-24)).
