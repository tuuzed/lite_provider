import 'package:flutter/material.dart';
import 'package:lite_provider/lite_provider.dart';

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
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return LiteProvider<CounterModel1>(
    //   create: (_) => CounterModel1(),
    //   child: Builder(
    //     builder: (context) => Text("${context.watch<CounterModel1>().count}"),
    //   ),
    // );
    return MutilLiteProvider(
      providers: [
        LiteProvider<CounterModel1>(create: (_) => CounterModel1()),
        LiteProvider<CounterModel2>(create: (_) => CounterModel2()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("LiteProivder"),
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<CounterModel1>(
                  builder: (_, model) => Text(
                    "Counter1: ${model.count}",
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                Consumer<CounterModel2>(
                  builder: (_, model) => Text(
                    "Counter2: ${model.count}",
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Incrence1'),
                      onPressed: () {
                        context.read<CounterModel1>().count++;
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Incrence2'),
                      onPressed: () {
                        context.read<CounterModel2>().count++;
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CounterModel1 with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  set count(value) {
    _count = value;
    notifyListeners();
  }
}

class CounterModel2 with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  set count(value) {
    _count = value;
    notifyListeners();
  }
}
