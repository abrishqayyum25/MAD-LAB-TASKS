Name: Abrish Qayyum
Roll No: 04072313043

A1: 22
A2: 7
A3: 12
A4: 21

B1: The Stateless classes are LabApp, HomePage, StudentCard,and GoalBanner because their data never 
changes after they are created.The Stateful classes are Tally, Countdown, and BuggyCounter because 
their data (count, time, clicks) changes over time and needs to update the screen.

B2: The Timer must be cancelled in dispose() to avoid memory leaks and the "setState() called after 
dispose()" error.If the widget is removed from the screen while the timer is still running,it will
 try to update a state that no longer exists.

B3: Widgets like const SizedBox, const Text, const Tally, and const Countdown can be const. Using 
const allows Flutter to reuse the same widget instance, which makes the app faster and saves memory
because it skips rebuilding them.