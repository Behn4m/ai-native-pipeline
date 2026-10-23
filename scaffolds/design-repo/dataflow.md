# Dataflow

What moves between components. This is the only place interfaces are defined. Specs and plans cite `DF-` IDs and never redefine them.

## Overview

<One paragraph or a table of the main flows, citing DF IDs.>

## DF-001: <producer CMP-xxx> → <consumer CMP-xxx>

- **Version:** 1
- **Transport:** <BLE / HTTP / MQTT / function call / ...>
- **Trigger:** <what causes it to be sent>
- **Direction and timing:** <one-way / request-response, rate, latency budget (CON ID)>

Payload:

| Field | Type | Unit | Required | Notes |
|---|---|---|---|---|
| <field> | <type> | <unit> | yes / no | <range, encoding, byte order> |

Errors and edge cases:

| Case | Behaviour |
|---|---|
| <timeout / missing field / retry> | <what each side does> |

Schema file: <path to OpenAPI / protobuf / JSON Schema, if any>
