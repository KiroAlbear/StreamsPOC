import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final StreamController<int> _streamController = StreamController<int>();

  void _incrementCounter() {
    _streamController.add(_counter++);
  }

  Stream<int> _periodecStream() {
    Duration interval = Duration(seconds: 1);
    Stream<int> stream = Stream<int>.periodic(interval, transform);

    stream = stream.take(59);
    return stream;
  }

  int transform(int value) {
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is infinite counter that increments every second and show loading at first:',
            ),
            StreamBuilder(
              stream: _periodecStream(),
              builder: (context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const Text(
              'This is a counter that increments When you press the button',
              textAlign: TextAlign.center,
            ),
            StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return Text(
                    '0',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                  ;
                }
              },
            )
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
