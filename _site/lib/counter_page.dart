// The bulk of this content comes directly from Flutter docs

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class CounterPage extends StatefulWidget {
  static const routeName = '/counter-page';
  static const moduleIcon = Icon(Icons.add);
  const CounterPage({Key? key, required this.title, required this.randomText})
      : super(key: key);

  final String title;

  final WordPair randomText;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage>
    with AutomaticKeepAliveClientMixin<CounterPage> {
  int _counter = 0;

  @override
  bool get wantKeepAlive => true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This page illustrates how state is preserved across tabs',
              style: TextStyle(fontSize: 30),
            ),
            const Divider(),
            Text(
              'You have tapped the ${widget.randomText.asPascalCase} button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
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
