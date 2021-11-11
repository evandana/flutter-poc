import 'package:floater/counter_page.dart';
import 'package:flutter/material.dart';

class Module1 extends StatefulWidget {
  static const routeName = '/m1';
  static const moduleIcon = Icon(Icons.location_pin);
  final Function goToM2Callback;
  const Module1({Key? key, required this.goToM2Callback}) : super(key: key);

  @override
  _Module1State createState() => _Module1State();
}

AppBar m1AppBar({String subPageName = ''}) {
  return AppBar(
      title: RichText(
          text: TextSpan(children: [
    const WidgetSpan(child: Module1.moduleIcon),
    TextSpan(text: 'M1 ${subPageName.isNotEmpty ? '> $subPageName' : ''}')
  ])));
}

class _Module1State extends State<Module1> {
  @override
  Widget build(BuildContext context) {
    return Module1p1(goToM2Callback: widget.goToM2Callback);
  }
}

goToM1p2(BuildContext context) {
  Navigator.push(context, MaterialPageRoute<void>(
    builder: (BuildContext context) {
      return const Module1p2();
    },
  ));
}

goToCounter(BuildContext context) {
  Navigator.pushNamed(context, CounterPage.routeName);
}

class Module1p1 extends StatelessWidget {
  final Function goToM2Callback;
  const Module1p1({Key? key, required this.goToM2Callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m1AppBar(subPageName: '1'),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton.icon(
              icon: CounterPage.moduleIcon,
              label: const Text('go to Counter'),
              onPressed: () => goToM2Callback()),
          ElevatedButton.icon(
              icon: Module1.moduleIcon,
              label: const Text('go to M1.2'),
              onPressed: () => goToM1p2(context)),
        ])));
  }
}

class Module1p2 extends StatelessWidget {
  final Function goToM2Callback;
  const Module1p2({Key? key, required this.goToM2Callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m1AppBar(subPageName: '2'),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton.icon(
              icon: CounterPage.moduleIcon,
              label: const Text('go to Counter'),
              onPressed: () => goToM2Callback()),
          ElevatedButton.icon(
              icon: Module1.moduleIcon,
              label: const Text('go to M1.2'),
              onPressed: () => goToM1p2(context)),
        ])));
  }
}
