import 'package:flutter/material.dart';
import 'package:sample_provider/state_management/observable.dart';
import 'package:sample_provider/state_management/sample_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Provider Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SampleProvider<int>(
        observable: Observable<int>(0),
        child: const MyHomePage(title: 'Sample Provider'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Counter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final observable = SampleProvider.of<int>(context);
          observable.setValue(observable.value + 1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({
    super.key,
  });

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late final Observable<int> observable;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    observable = SampleProvider.of<int>(context);
    observable.addObserver(rebuild);
  }

  void rebuild(int value) {
    setState(() {});
  }

  @override
  void dispose() {
    observable.removeObserver(rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${observable.value}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
