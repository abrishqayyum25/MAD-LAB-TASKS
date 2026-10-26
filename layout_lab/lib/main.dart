// main.dart - Team Board lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Abrish Qayyum';
const String rollNo = '04072313043'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev', 'Data Structures', 'Operating Systems', 'Databases',
  'Networks', 'Software Eng', 'AI', 'Web Engineering', 'Graphics', 'Security',
];
const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];
const List<String> mains = [
  'start', 'center', 'end', 'spaceBetween', 'spaceAround', 'spaceEvenly',
];
const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];
const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5); // where the clock starts
final int tick = 1 + u % 3; // how much it adds every second
final int ticks = 4 + u % 4; // how many ticks until it stops
final int stopAt = startSec + ticks * tick; // the clock stops here

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3; // used by the experiment in Step 5

// Step 6: axes (the NAMES are printed on the settings card; you type the enum)
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5]; // use swatches[hue]!.shade100

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);
// ===========================================================================

// Step 2 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Team Board', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsCard(),
            const SizedBox(height: 12),
            
            const Welcome(), // Step 4
            const SizedBox(height: 12),
            
            const Clock(), // Step 1, 2, 3
            const SizedBox(height: 12),
            
            const SwapBoard(), // Step 5
            const SizedBox(height: 12),
            
            const InfoPanel(), // Step 6
            const SizedBox(height: 12),
            
            const SummaryRow(), // Step 7
            const SizedBox(height: 12),
            
            const ShareRow(), // Step 8
            const SizedBox(height: 12),
            
            const InfoBox(), // Step 9
            const SizedBox(height: 12),
            
            const StampStack(), // Step 10
            const SizedBox(height: 12),

            // Add each new widget BELOW the previous one, in the order the
            // steps tell you, with a SizedBox(height: 12) between widgets.
          ],
        ),
      ),
    );
  }
}

// ---- Provided: shows YOUR numbers. Keep it on the page. Do not rename.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC (taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}

// ---- Provided for Step 7. It overflows on purpose. Do not rename anything.
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  // Think (Step 7): Why does wrapping a Text in Expanded make it wrap its words? 
  // Use the idea "constraints go down, sizes go up" from slide 13.
  // Answer: Expanded tells the Text to take a specific width (constraints go down). 
  // The Text then wraps its words to fit inside that width (sizes go up). 
  // Without Expanded, the Text would try to be as wide as it wants and overflow.

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// STEP 1 & 2: THE CLOCK
// ==========================================
class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;
  int _builds = 0; // Step 2

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState'); // Step 2
    
    // Think (Step 1): Why do we start the Timer in initState and not inside build? 
    // What would happen to the speed of the clock if we started it in build?
    // Answer: initState runs once. build() runs many times. If we start the timer 
    // in build, multiple timers will run at the same time, making the clock speed up.

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);
      if (_seconds >= stopAt) timer.cancel(); // stop at your limit
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Step 2
    lifecycleLog.add('dispose'); // Step 2
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++; // Step 2

    // Think (Step 2): Why does Builds go up by one per second and not by two? 
    // What error would you see in the console if the widget left the screen 
    // and _timer.cancel() was missing from dispose?
    // Answer: setState runs once per second, so build runs once per second. 
    // Without _timer.cancel(), the timer keeps running after the widget is gone. 
    // This causes a "setState() called after dispose()" error.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session: $_seconds s', key: const Key('clock')),
        Text('Builds: $_builds', key: const Key('builds')),
        Probe(seconds: _seconds), // Step 3
      ],
    );
  }
}

// ==========================================
// STEP 3: THE PROBE (BuildContext)
// ==========================================
class Probe extends StatelessWidget {
  final int seconds;
  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final above = context.findAncestorWidgetOfExactType<Scaffold>() != null;

    // Think (Step 3): Which of the two, Widget or Element, is "cheap and thrown away" 
    // and which one keeps the State? Where is the third one, the RenderObject, 
    // and what is its job?
    // Answer: Widget is cheap and thrown away (rebuilt every time). Element keeps the State. 
    // RenderObject is the third one; its job is to draw (paint) and layout the screen.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seen at: $seconds s', key: const Key('probe-seen')),
        Text('Widget #${identityHashCode(this)}', key: const Key('probe-widget')),
        Text('Element #${identityHashCode(context)}', key: const Key('probe-element')),
        Text('Context belongs to: ${context.widget.runtimeType}', key: const Key('probe-context')),
        Text('Scaffold above me: $above', key: const Key('probe-above')),
      ],
    );
  }
}

// ==========================================
// STEP 4: WELCOME AND TILE
// ==========================================
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome, $studentName', key: const Key('welcome')),
    );
  }
}

class Tile extends StatefulWidget {
  final String label;
  const Tile(this.label, {super.key});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;

  // Think (Step 4): You built Tile out of an ElevatedButton without writing 
  // extends ElevatedButton. What is this style called, and why does Flutter prefer it?
  // Answer: This style is called "Composition". Flutter prefers it because it is 
  // more flexible and easier to reuse than inheritance.

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => taps++),
      child: Text('${widget.label}: $taps'),
    );
  }
}

// ==========================================
// STEP 5: SWAPBOARD (Keys)
// ==========================================
class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  var tiles = [
    Tile(tileA, key: ValueKey(tileA)),
    Tile(tileB, key: ValueKey(tileB)),
    Tile(tileC, key: ValueKey(tileC)),
  ];

  void swap() => setState(() => tiles = tiles.reversed.toList());

  // Think (Step 5): Without keys, why did the number stay at the left even though the 
  // label moved? Use the words widget, Element and State in your answer.
  // Answer: Without keys, Flutter matches the new Widget to the old Element by its position. 
  // So the Element and State (the number) stay on the left, even though the label in the 
  // Widget changed.

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: tiles),
        const SizedBox(height: 8),
        ElevatedButton(
          key: const Key('swap'),
          onPressed: swap,
          child: const Text('Swap'),
        ),
      ],
    );
  }
}

// ==========================================
// STEP 6: INFO PANEL (Row and Column Axes)
// ==========================================
class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  // Think (Step 6): In a Column, which axis is the main axis? Why does 
  // crossAxisAlignment: CrossAxisAlignment.center in a Column move the children 
  // left or right and not up or down?
  // Answer: In a Column, the main axis is vertical (up/down) and the cross axis is 
  // horizontal (left/right). crossAxisAlignment works on the cross axis, so it moves 
  // the children left or right.

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row (Main axis is horizontal)
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aapki setting
          children: [
            Text('Start: $startSec s', key: const Key('row-a')),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
        ),
        const SizedBox(height: 12),
        
        // Inner Column (Main axis is vertical)
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: CrossAxisAlignment.center, // Aapki setting
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// STEP 8: SHARE ROW (Expanded vs Flexible)
// ==========================================
class ShareRow extends StatelessWidget {
  const ShareRow({super.key});

  // Think (Step 8): What would change on the screen if you swapped Expanded and 
  // Flexible between the two buttons? Which one is "Flexible with fit: tight"?
  // Answer: If we swap them, the "Exp" button (now Flexible) would shrink to fit 
  // its text, and the "Flex" button (now Expanded) would stretch to fill the space. 
  // "Expanded" is just a Flexible with fit: tight, meaning it is forced to fill 
  // its allocated space.

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('share-row'),
      children: [
        SizedBox(
          key: const Key('fixed'),
          width: fixedW,
          child: ElevatedButton(onPressed: () {}, child: const Text('F')),
        ),
        Expanded(
          flex: flexA,
          child: ElevatedButton(
            key: const Key('exp'),
            onPressed: () {},
            child: const Text('Exp'),
          ),
        ),
        Flexible(
          flex: flexB,
          child: ElevatedButton(
            key: const Key('flex'),
            onPressed: () {},
            child: const Text('Flex'),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// STEP 9: INFO BOX (Container)
// ==========================================
class InfoBox extends StatelessWidget {
  const InfoBox({super.key});

  // Think (Step 9): Which one is inside the border, margin or padding? When would 
  // you use a plain Padding or SizedBox instead of a Container?
  // Answer: Padding is inside the border. Margin is outside. We use a plain Padding 
  // when we only need space inside, and SizedBox when we only need a fixed space 
  // (gap) between widgets. Container is used when we need decoration (color, border, shape).

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('info-box'),
      margin: EdgeInsets.all(boxMargin),
      padding: EdgeInsets.all(boxPad),
      decoration: BoxDecoration(
        color: swatches[hue]!.shade100,
        borderRadius: BorderRadius.circular(boxRadius),
        border: Border.all(width: boxBorder),
      ),
      child: Text('Course: $course', key: const Key('box-text')),
    );
  }
}

// ==========================================
// STEP 10: STAMP STACK (Stack & Positioned)
// ==========================================
class StampStack extends StatelessWidget {
  const StampStack({super.key});

  // Think (Step 10): What decides the size of the Stack? What happens to the layout 
  // if the Icons come first and the grey Container last?
  // Answer: The size of the Stack is decided by its largest non-positioned child. 
  // If the Icons come first, they are small, so the Stack would be very small. 
  // The grey Container (which is 300x120) would then be drawn on top but the Stack 
  // itself would not take up the full space, so the layout would look broken.

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('stack'),
      children: [
        Container(
          key: const Key('layer-base'),
          width: 300,
          height: 120,
          color: Colors.grey.shade300,
        ),
        Positioned(
          top: dotTop,
          right: dotRight,
          child: const Icon(Icons.star, key: Key('dot-top')),
        ),
        Positioned(
          bottom: dotBottom,
          left: dotLeft,
          child: const Icon(Icons.circle, key: Key('dot-bottom')),
        ),
      ],
    );
  }
}