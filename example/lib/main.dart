import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:colorify/colorify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Colorify Example',
      debugShowCheckedModeBanner: false,
      home: ColorifyDemo(),
    );
  }
}

class ColorifyDemo extends StatefulWidget {
  const ColorifyDemo({super.key});

  @override
  ColorifyDemoState createState() => ColorifyDemoState();
}

class ColorifyDemoState extends State<ColorifyDemo> {
  final Uuid _uuid = const Uuid();

  /// We'll store a list of randomly generated seeds (UUIDs).
  late List<String> _seeds;

  @override
  void initState() {
    super.initState();
    _generateSeeds();
  }

  /// Generates 7 new UUID strings and updates state.
  void _generateSeeds() {
    setState(() {
      _seeds = List.generate(8, (_) => _uuid.v4());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Random Seed -> Deterministic Color',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )),
      body: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                    child: Text(
                      'All Colors (Full Range, No Restrictions)',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ..._seeds.map(
                    (seed) {
                      return Text(
                        seed,
                        style: TextStyle(
                          fontSize: 18,
                          color: colorify(
                            seed,
                            colorType: ColorType.all,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                    child: Text(
                      'Bright Colors Only (No Greys, Blacks, Whites, etc.)',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ..._seeds.map(
                    (seed) {
                      return Text(
                        seed,
                        style: TextStyle(
                          fontSize: 18,
                          color: colorify(
                            seed,
                            colorType: ColorType.brights,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateSeeds,
        child: const Text(
          'Shuffle',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
