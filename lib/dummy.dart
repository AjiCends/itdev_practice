import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDummyWidget extends StatelessWidget {
  const MyDummyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(),
      child: MyDummyPage(),
    );
  }
}

class MyDummyPage extends StatelessWidget {
  const MyDummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: Center(child: MyCounterWidget())));
  }
}

class MyCounterWidget extends StatefulWidget {
  const MyCounterWidget({super.key});

  @override
  State<MyCounterWidget> createState() => _MyCounterWidgetState();
}

class _MyCounterWidgetState extends State<MyCounterWidget> {
  var fieldTextController = TextEditingController();
  var formTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<MyModel>(
      builder: (context, mymodel, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Counter : ${mymodel.counter}'),
            ElevatedButton(
              onPressed: () {
                mymodel.increment();
              },
              child: Text('Tambah'),
            ),
            ElevatedButton(
              onPressed: () {
                mymodel.reset();
              },
              child: Text('Reset'),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: fieldTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                  ),
                  TextFormField(
                    controller: formTextController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter your username',
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Submitted: ${fieldTextController.text}')));
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class MyModel extends ChangeNotifier {
  int _counter = 1;

  get counter {
    return _counter;
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void reset() {
    _counter = 0;
    notifyListeners();
  }
}
