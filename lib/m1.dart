import 'package:floater/counter_page.dart';
import 'package:flutter/material.dart';

class Module1 extends StatefulWidget {
  static const routeName = 'm1';
  static const moduleIcon = Icon(Icons.location_pin);
  static const p1SubRoute = 'one';
  static const p2SubRoute = 'two';
  static const String m2ValDefault = '?';

  final String subRoute;
  final String routeM2;
  final depModProps; // How do I add typing for this?
  final depModConstructor; // How do I add typing for this?
  const Module1(
      {Key? key,
      required this.depModProps,
      required this.depModConstructor,
      this.subRoute = p1SubRoute,
      this.routeM2 = '/m1/m2'})
      : super(key: key);

  @override
  _Module1State createState() => _Module1State();
}

class _Module1State extends State<Module1> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var _m2Val = Module1.m2ValDefault;

  void _goToM1p1() {
    _navigatorKey.currentState!
        .pushNamed('/${Module1.routeName}/${Module1.p1SubRoute}');
  }

  void _goToM1p2() {
    _navigatorKey.currentState!
        .pushNamed('/${Module1.routeName}/${Module1.p2SubRoute}');
  }

  _goToM2() {
    return _navigatorKey.currentState!.pushNamed(widget.routeM2);
  }

  void _setM2Val(m2Val) {
    setState(() {
      _m2Val = m2Val;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget.subRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    print(settings.name);
    if (settings.name!.contains('m2')) {
      page = widget.depModConstructor(
        navigatorKey: _navigatorKey,
        subRoute: settings.name!,
      );
    } else {
      switch (settings.name) {
        // m1
        case '/${Module1.routeName}/${Module1.p2SubRoute}':
          page = Module1p2(
              m2Val: _m2Val,
              setM2Val: _setM2Val,
              depMod: widget.depModProps,
              goToM1p1: _goToM1p1,
              goToM2: _goToM2);
          break;
        case '/${Module1.routeName}/${Module1.p1SubRoute}':
        case Module1.p1SubRoute:
        default:
          page = Module1p1(m2Val: _m2Val, goToM1p2: _goToM1p2);
          break;
      }
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: RouteSettings(name: settings.name, arguments: Map()),
    );
  }
}

AppBar m1AppBar({String subPageName = ''}) {
  return AppBar(
      title: RichText(
          text: TextSpan(children: [
    const WidgetSpan(child: Module1.moduleIcon),
    TextSpan(text: 'M1 ${subPageName.isNotEmpty ? '> $subPageName' : ''}')
  ])));
}

goToCounter(BuildContext context) {
  Navigator.pushNamed(context, CounterPage.routeName);
}

class Module1p1 extends StatelessWidget {
  final Function goToM1p2;
  final String m2Val;
  const Module1p1(
      {Key? key, this.m2Val = Module1.m2ValDefault, required this.goToM1p2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m1AppBar(subPageName: '1'),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Text(
          //   'M2 val: $m2Val', // <-- not sure why this gets reset on going back from M1p2
          //   style: const TextStyle(fontSize: 50),
          // ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(''),
            ElevatedButton.icon(
                icon: Module1.moduleIcon,
                label: const Text('go to M1.2'),
                onPressed: () => goToM1p2()),
          ])
        ])));
  }
}

class Module1p2 extends StatefulWidget {
  final Function goToM1p1;
  final Function goToM2;
  final Function setM2Val;
  final String m2Val;
  final depMod; // How do I add typing for this?
  const Module1p2(
      {Key? key,
      required this.setM2Val,
      required this.m2Val,
      required this.depMod,
      required this.goToM1p1,
      required this.goToM2})
      : super(key: key);

  @override
  _Module1p2State createState() => _Module1p2State();
}

class _Module1p2State extends State<Module1p2> {
  var _m2Val = Module1.m2ValDefault;

  void _setM2Val(m2Val) {
    setState(() {
      _m2Val = m2Val;
    });
    widget.setM2Val(m2Val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m1AppBar(subPageName: '2'),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'M2 val: $_m2Val',
              style: const TextStyle(fontSize: 50),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton.icon(
                  icon: Module1.moduleIcon,
                  label: const Text('< back'),
                  onPressed: () => Navigator.of(context).maybePop()),
              _m2Val == Module1.m2ValDefault
                  ? ElevatedButton.icon(
                      style: widget.depMod.elevatedButtonBg,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('go to M2'),
                      onPressed: () async {
                        await widget.goToM2();
                        var args =
                            ModalRoute.of(context)!.settings.arguments as Map;
                        _setM2Val(args['result']);
                        print('args: ${args['result']}');
                      })
                  : const Text("You're done!"),
            ]),
          ],
        )));
  }
}
