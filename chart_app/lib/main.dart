import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<num> data = [50, 90, 80, 70, 60, 50, 40, 30, 20, 10];
  StreamController<List<num>> _barsController = StreamController<List<num>>.broadcast();

  @override
  void initState() {
    Timer.run(() {
      _barsController.sink.add(data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: [
        Center(
          child: Container(
              height: 300,
              width: 500,
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: Colors.black), bottom: BorderSide(color: Colors.black)),
                color: Colors.white,
              ),
              child: StreamBuilder<List<num>>(
                  initialData: const [5, 5, 5, 5],
                  stream: _barsController.stream,
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        textOrSperator(istext: false),
                        Row(
                          children: [
                            const SizedBox(
                              width: 80,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: AnimatedBars(
                                color: Colors.amber,
                                value: snapshot.data![0],
                              ),
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: AnimatedBars(
                                color: Colors.blue,
                                value: snapshot.data![1],
                              ),
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: AnimatedBars(
                                color: Colors.green,
                                value: snapshot.data![2],
                              ),
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: AnimatedBars(
                                color: Colors.red,
                                value: snapshot.data![3],
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  })),
        ),
        Center(
          child: SizedBox(height: 300, width: 570, child: textOrSperator(istext: true)),
        ),
      ],
    )));
  }

  Widget textOrSperator({bool istext = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [for (int i = 0; i < data.length; i++) !istext ? const Text("-") : Text(data[i].toString())],
    );
  }
}

class AnimatedBars extends StatefulWidget {
  AnimatedBars({Key? key, this.color = Colors.transparent, this.value = 5}) : super(key: key);
  final Color color;
  final num value;

  @override
  State<AnimatedBars> createState() => _AnimatedBarsState();
}

class _AnimatedBarsState extends State<AnimatedBars> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 599),
        child: Container(
          width: 30,
          height: double.parse(widget.value.toString()) * 2.8,
          color: widget.color,
        ));
  }
}
