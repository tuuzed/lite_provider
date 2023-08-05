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
      home: const HomePage(),
    );
  }
}

class CounterModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  set count(value) {
    _count = value;
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LiteProvider(
      create: (context) => CounterModel(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("LiteProivder"),
          ),
          body: Center(
            child: Consumer<CounterModel>(
              builder: (_, model) => Text(
                "${model.count}",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<CounterModel>().count++;
            },
          ),
        );
      }),
    );
  }
}
