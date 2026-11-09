# PRD: <product>

What the product does now. A project is a new update to this file, handed to the development teams. It is made on a `design/<project>` branch and merged through one design PR. Project milestones live in the Linear project and the design PR, not here.

## Problem

<What is wrong today and for whom. Two or three sentences.>

## Users

| User | Need |
|---|---|
| <user> | <need> |

## Goals

- <Measurable outcome.>

## Scope

In scope:
- <item>

Out of scope:
- <item>

## Acceptance criteria

These are the test plan. Every code repo's spec selects the ones for its subsystem: the ACs a project adds or changes must pass in sim and real; the rest are regression, covered by the automated tests. Never reuse or renumber an ID; mark a removed AC `retired` and keep its row.

| ID | Criterion | Verified by | Subsystems |
|---|---|---|---|
| AC-001 | <observable, pass/fail statement> | sim / real / both | <subsystem> |

## Open questions

- <Question, owner.>
