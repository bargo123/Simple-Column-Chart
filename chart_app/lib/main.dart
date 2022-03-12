import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SimpleColumnChart(),
    );
  }
}

class SimpleColumnChart extends StatefulWidget {
  const SimpleColumnChart();

  @override
  State<SimpleColumnChart> createState() => SimpleColumnChartState();
}

class SimpleColumnChartState extends State<SimpleColumnChart> {
  List<num> data = [50, 90, 80, 70, 60, 50, 40, 30, 20, 10];
  final StreamController<List<num>> _barsController = StreamController<List<num>>.broadcast();

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

class AnimatedBars extends StatelessWidget {
  AnimatedBars({Key? key, this.color = Colors.transparent, this.value = 5});
  final Color color;
  final num value;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 599),
        child: Container(
          width: 30,
          height: double.parse(value.toString()) * 2.8,
          color: color,
        ));
  }
}
