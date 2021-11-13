import 'package:floater/counter_page.dart';
import 'package:floater/m2.dart';
import 'package:flutter/material.dart';

// class M1ExternalRoutesConfig {
//   final String counterRoute;
//   M1ExternalRoutesConfig({this.counterRoute = '/counter'});
// }

class Module1 extends StatefulWidget {
  static const routeName = 'm1';
  static const moduleIcon = Icon(Icons.location_pin);

  static const p1SubRoute = 'one';
  static const p2SubRoute = 'two';

  final String subRoute;
  final String routeM2;
  const Module1({Key? key, this.subRoute = p1SubRoute, this.routeM2 = '/m1/m2'})
      : super(key: key);

  @override
  _Module1State createState() => _Module1State();
}

class _Module1State extends State<Module1> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _goToM1p1() {
    _navigatorKey.currentState!
        .pushNamed('/${Module1.routeName}/${Module1.p1SubRoute}');
  }

  void _goToM1p2() {
    _navigatorKey.currentState!
        .pushNamed('/${Module1.routeName}/${Module1.p2SubRoute}');
  }

  _goToM2() {
    print('m2 route: ${widget.routeM2}');
    return _navigatorKey.currentState!.pushNamed(widget.routeM2);
    // return _navigatorKey.currentState!.pushNamed(widget.routeM2).then((_) {
    //   final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    //   final result = arguments['result'];
    // });
    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => Module2())
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
      page = Module2(
        navigatorKey: _navigatorKey,
        subRoute: settings.name!,
      );
      // return MaterialPageRoute(
      //     settings: RouteSettings(arguments: Map(), name: '/m2'), // (1)
      //     builder: (_) => Module2(
      //           navigatorKey: _navigatorKey,
      //           subRoute: settings.name!,
      //         ));
    } else {
      switch (settings.name) {
        // m2
        // case '/m1/m2':
        //   page = Module2(navigatorKey: _navigatorKey);
        //   break;

        // m1
        case '/${Module1.routeName}/${Module1.p2SubRoute}':
          page = Module1p2(goToM1p1: _goToM1p1, goToM2: _goToM2);
          break;
        case '/${Module1.routeName}/${Module1.p1SubRoute}':
        case Module1.p1SubRoute:
        default:
          page = Module1p1(goToM1p2: _goToM1p2);
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
  // @override
  // Widget build(BuildContext context) {
  //   switch (widget.subRoute) {
  //     case Module1.p2SubRoute:
  //       return Module1p2(goToM1p1: _goToM1p1);
  //     case Module1.p1SubRoute:
  //     default:
  //       return Module1p1(goToM1p2: _goToM1p2);
  //   }
  // }
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
  const Module1p1({Key? key, required this.goToM1p2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m1AppBar(subPageName: '1'),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              // ElevatedButton.icon(
              //     icon: CounterPage.moduleIcon,
              //     label: const Text('go to Counter'),
              //     onPressed: () => ()),
              ElevatedButton.icon(
                  icon: Module1.moduleIcon,
                  label: const Text('< disabled'),
                  onPressed: () => {}),
              ElevatedButton.icon(
                  icon: Module1.moduleIcon,
                  label: const Text('go to M1.2'),
                  onPressed: () => goToM1p2()),
            ])));
  }
}

class Module1p2 extends StatelessWidget {
  final Function goToM1p1;
  final Function goToM2;
  const Module1p2({Key? key, required this.goToM1p1, required this.goToM2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: m1AppBar(subPageName: '2'),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              ElevatedButton.icon(
                  icon: Module1.moduleIcon,
                  label: const Text('< back'),
                  onPressed: () => Navigator.of(context).maybePop()),
              ElevatedButton.icon(
                  style: Module2.elevatedButtonBg,
                  icon: Icon(Icons.arrow_forward),
                  label: const Text('go to M2'),
                  onPressed: () async {
                    await goToM2();
                    var args =
                        ModalRoute.of(context)!.settings.arguments as Map;
                    print('args: ${args['result']}');
                  }),
            ])));
  }
}
