## What this project does

Computes the Greatest Common Divisor of two 8-bit numbers using the iterative subtraction algorithm (Euclidean algorithm without division). The design is split into two independent modules — a controller FSM and a datapath — which is the fundamental architecture used in all real digital hardware.

The algorithm

while A ≠ B:

if A > B: A = A - B

else:     B = B - A

result = A  (when A == B)

Architecture: why datapath + controller?

The datapath does arithmetic. The controller decides what the datapath should do next. They communicate through a clean interface:

Controller → Datapath (control signals): a_ld, b_ld, a_sel, b_sel, output_en Datapath → Controller (status signals): a_gt_b, a_eq_b, a_lt_b

This separation is the same pattern used in ALUs, multipliers, and processor pipelines.

Controller FSM — 8 states

| State | Action | Next |
| --- | --- | --- |
| S0 | Wait for go | S1 if go=1 |
| S1 | Load A and B from inputs (a_sel=1, b_sel=1, a_ld=1, b_ld=1) | S2 |
| S2 | Wait one cycle for registers to settle | S3 |
| S3 | Compare A vs B | S4 if A>B, S5 if A<B, S7 if A==B |
| S4 | A = A - B (a_ld=1) | S6 |
| S5 | B = B - A (b_ld=1) | S6 |
| S6 | Wait one cycle | S3 (loop back) |
| S7 | Assert done, enable output | S0 |

Datapath internals

in1 ──→ [mux m1] ──→ [register r1 (A)] ──→ [subtractor s1: A-B] ──┐

in2 ──→ [mux m2] ──→ [register r2 (B)] ──→ [subtractor s2: B-A] ──┘

↓

[comparator c1]

(a_gt_b, a_eq_b, a_lt_b)

↓

[register rout] → out (when output_en=1)

Two subtractors run in parallel every cycle (A−B and B−A). The controller chooses which result to load back using a_sel/b_sel mux selects.

Testbench cases

| in1 | in2 | Expected GCD |
| --- | --- | --- |
| 10 | 5 | 5 |
| 243 | 144 | 9 |
| 112 | 46 | 2 |

## File structure

controller.v   — 8-state FSM, generates all control signals

datapath.v     — Instantiates subtractors, muxes, registers, comparator

comparator.v   — Combinational: sets a_gt_b, a_eq_b, a_lt_b

subtractor.v   — 8-bit subtraction (assign out = in1 - in2)

register.v     — Load-enable register (loads when lden=1)

mux.v          — 2:1 mux selecting between feedback and fresh input

top.v          — Connects controller and datapath

top_tb.v       — Tests GCD(10,5), GCD(243,144), GCD(112,46)
