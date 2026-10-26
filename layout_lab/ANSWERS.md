# Layout Lab - ANSWERS

Name: Abrish Qayyum
Roll No: 04072313043

A1: 32
A2: 8
A3: 0
A4: 50

B1:
Stateless: LabApp, HomePage, SettingsCard, Welcome, Probe, InfoPanel, SummaryRow, ShareRow, InfoBox, StampStack. (They don't change data).
Stateful: Clock, Tile, SwapBoard. (They change data and use setState).

B2:
Widget is rebuilt on every setState.
Element and RenderObject are kept. Element holds the State.
Probe showed: Widget number changes every second, but Element number stays the same.

B3:
Row gives width limit to Expanded (constraints go down). Text takes that width and wraps words (sizes go up). Without Expanded, text overflows.