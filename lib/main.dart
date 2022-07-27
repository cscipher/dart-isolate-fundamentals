import 'package:flutter/material.dart';
import 'package:isolate_fundamentals/isolate_code.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int a1 = 0, a2 = 0, a3 = 0, a4 = 0;
  final IsolateFundamental _isolate = IsolateFundamental();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: () async {
                  a1 = await _isolate.initFib(10);
                  setState(() {});
                },
                child: const Text('run fib(10)')),
            Visibility(visible: a1 != 0, child: Text('result -> $a1')),
            ElevatedButton(
                onPressed: () async {
                  a2 = await _isolate.initFib(20);
                  setState(() {});
                },
                child: const Text('run fib(20)')),
            Visibility(visible: a2 != 0, child: Text('result -> $a2')),
            ElevatedButton(
                onPressed: () async {
                  a3 = await _isolate.initFib(30);
                  setState(() {});
                },
                child: const Text('run fib(30)')),
            Visibility(visible: a3 != 0, child: Text('result -> $a3')),
            ElevatedButton(
                onPressed: () async {
                  a4 = await _isolate.initFib(40);
                  setState(() {});
                },
                child: const Text('run fib(40)')),
            Visibility(visible: a4 != 0, child: Text('result -> $a4')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
