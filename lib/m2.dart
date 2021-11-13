import 'package:floater/counter_page.dart';
import 'package:flutter/material.dart';

// class M1ExternalRoutesConfig {
//   final String counterRoute;
//   M1ExternalRoutesConfig({this.counterRoute = '/counter'});
// }

class Module2 extends StatefulWidget {
  static const routeName = 'm2';
  static const moduleIcon = Icon(Icons.star);

  static const p1SubRoute = 'one';
  static const p2SubRoute = 'two';

  static final elevatedButtonBg =
      ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.pink[800]));

  final String subRoute;
  final GlobalKey<NavigatorState> navigatorKey;
  const Module2(
      {Key? key, this.subRoute = p1SubRoute, required this.navigatorKey})
      : super(key: key);

  @override
  _Module2State createState() => _Module2State();
}

class _Module2State extends State<Module2> {
  // final _navigatorKey = GlobalKey<NavigatorState>();

  void _goToM2p1() {
    widget.navigatorKey.currentState!
        .pushNamed('/${Module2.routeName}/${Module2.p1SubRoute}');
  }

  void _goToM2p2() {
    widget.navigatorKey.currentState!
        .pushNamed('/${Module2.routeName}/${Module2.p2SubRoute}');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.subRoute) {
      case Module2.p2SubRoute:
      case '/${Module2.routeName}/${Module2.p2SubRoute}':
        return Module2p2(goToM1p1: _goToM2p1);
      case Module2.p1SubRoute:
      case '/${Module2.routeName}/${Module2.p1SubRoute}':
      default:
        return Module2p1(goToM2p2: _goToM2p2);
    }
  }
}

AppBar m2AppBar({String subPageName = ''}) {
  return AppBar(
      backgroundColor: Colors.pink[800],
      title: RichText(
          text: TextSpan(children: [
        const WidgetSpan(child: Module2.moduleIcon),
        TextSpan(text: 'M2 ${subPageName.isNotEmpty ? '> $subPageName' : ''}')
      ])));
}

goToCounter(BuildContext context) {
  Navigator.pushNamed(context, CounterPage.routeName);
}

class Module2p1 extends StatelessWidget {
  final Function goToM2p2;
  const Module2p1({Key? key, required this.goToM2p2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m2AppBar(subPageName: '1'),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              // ElevatedButton.icon(
              //     icon: CounterPage.moduleIcon,
              //     label: const Text('go to Counter'),
              //     onPressed: () => ()),
              ElevatedButton.icon(
                  icon: Module2.moduleIcon,
                  label: const Text('< back (M1)'),
                  onPressed: () => Navigator.of(context).pop()),
              ElevatedButton.icon(
                  style: Module2.elevatedButtonBg,
                  icon: Module2.moduleIcon,
                  label: const Text('go to M2.2'),
                  onPressed: () => goToM2p2()),
            ])));
  }
}

class Module2p2 extends StatelessWidget {
  final Function goToM1p1;
  const Module2p2({Key? key, required this.goToM1p1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m2AppBar(subPageName: '2'),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              // ElevatedButton.icon(
              //     icon: CounterPage.moduleIcon,
              //     label: const Text('go to Counter'),
              //     onPressed: () => goToCounter(context)),
              ElevatedButton.icon(
                  style: Module2.elevatedButtonBg,
                  icon: Module2.moduleIcon,
                  label: const Text('< back'),
                  onPressed: () => Navigator.of(context).maybePop()),
              ElevatedButton.icon(
                  icon: Icon(Icons.arrow_forward),
                  label: const Text('Done with M2'),
                  onPressed: () => Navigator.of(context)
                          // .popUntil((route) => !route.toString().contains('m2'))),
                          .popUntil((route) {
                        if (!route.settings.name!.contains('m2')) {
                          (route.settings.arguments as Map)['result'] =
                              'something';
                          return true;
                        } else {
                          return false;
                        }
                      })),
            ])));
  }
}
