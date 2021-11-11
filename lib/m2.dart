import 'package:flutter/material.dart';

class Module2 extends StatefulWidget {
  const Module2({Key? key}) : super(key: key);

  @override
  _Module2State createState() => _Module2State();
}

final m2AppBar = AppBar(
  title: const Text('M2.1'),
);

class _Module2State extends State<Module2> {
  @override
  Widget build(BuildContext context) {
    return const Module2p1();
  }
}

goToM2p2(BuildContext context) {
  Navigator.push(context, MaterialPageRoute<void>(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Page')),
        body: Center(
          child: TextButton(
            child: const Text('POP'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    },
  ));
}

class Module2p1 extends StatelessWidget {
  const Module2p1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m2AppBar,
        body: Center(
          child: ElevatedButton(
              child: const Text('go to M2.2'),
              onPressed: () => goToM2p2(context)),
        ));
  }
}

class Module2p2 extends StatelessWidget {
  const Module2p2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m2AppBar,
        body: Center(
            child: Column(children: [
          ElevatedButton(
              child: const Text('go to M.2'),
              onPressed: () => goToM2p2(context)),
        ])));
  }
}
