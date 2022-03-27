import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VapeAssistant',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Vape Assistant'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double baseVolume = 250;
  double desiredNicotine = 6;
  double desiredAromaPercent = 10;
  int nboosters = 0;
  int naroma = 0;
  double totalVolume = 0;

  void calculate({bool redraw = false}) {
    double desiredAroma = desiredAromaPercent / 100;
    totalVolume =
        20 * baseVolume / (20 - desiredNicotine - (20 * desiredAroma));
    nboosters = (desiredNicotine * totalVolume / 200).floor();
    naroma = (desiredAroma * totalVolume / 10).floor();
    if (redraw) {
      setState(() => {});
    }
  }

  void changeBaseVolume(double value) {
    baseVolume = value;
    calculate(redraw: true);
  }

  void changeDesiredAromaPercent(double value) {
    desiredAromaPercent = value;
    calculate(redraw: true);
  }

  void changeDesiredNicotine(double value) {
    desiredNicotine = value;
    calculate(redraw: true);
  }

  @override
  Widget build(BuildContext context) {
    calculate();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            Padding(
              child: SpinBox(
                min: 0,
                max: 1000,
                acceleration: 10,
                value: 250,
                step: 50,
                onChanged: changeBaseVolume,
                decoration:
                    const InputDecoration(labelText: 'Base Volume (mL)'),
              ),
              padding: const EdgeInsets.all(16),
            ),
            Padding(
              child: SpinBox(
                min: 0.0,
                max: 18.0,
                acceleration: 0.1,
                decimals: 1,
                value: desiredNicotine,
                step: 0.1,
                onChanged: changeDesiredNicotine,
                decoration:
                    const InputDecoration(labelText: 'Nicotine (mg/mL)'),
              ),
              padding: const EdgeInsets.all(16),
            ),
            Padding(
              child: SpinBox(
                min: 5,
                max: 15,
                value: desiredAromaPercent,
                step: 1,
                onChanged: changeDesiredAromaPercent,
                decoration: const InputDecoration(labelText: 'Aroma (%)'),
              ),
              padding: const EdgeInsets.all(16),
            ),
            Padding(
              child: Text('Number of boosters: $nboosters'),
              padding: const EdgeInsets.all(16),
            ),
            Padding(
              child: Text('Number of aroma vials: $naroma'),
              padding: const EdgeInsets.all(16),
            ),
            Padding(
              child: Text('Total volume: ${totalVolume.toStringAsFixed(2)}'),
              padding: const EdgeInsets.all(16),
            ),
          ],
        ),
      ),
    );
  }
}
