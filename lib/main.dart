// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:floater/counter_page.dart';
import 'package:floater/m1.dart';
import 'package:floater/m2.dart';
import 'package:floater/random_words.dart';
import 'package:floater/stateful_home.dart';
import 'package:floater/test_tabs.dart';
import 'package:flutter/material.dart';

const routeHome = '/';
const routeSettings = '/settings';

const routePrefixHomeTabs = '/home/';
const routePrefixM1 = '/module1/';
const routePrefixM2 = '/module2/';
const routeHomeTabsRandomWords = RandomWords.routeName;
const routeHomeTabsCounter = CounterPage.routeName;
const routeHomeTabsModule1 = '/home/module1';
const routeM1 = '/${Module1.routeName}';
const routeM1p1 = '$routeM1/${Module1.p1SubRoute}';
const routeM1p2 = '$routeM1/${Module1.p2SubRoute}';
const routeM2 = '/${Module1.routeName}/${Module2.routeName}';
const routeM2p1 = '$routeM2/${Module2.p1SubRoute}';
const routeM2p2 = '$routeM2/${Module2.p2SubRoute}';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        highlightColor: Colors.pinkAccent,
        disabledColor: Colors.grey,
        focusColor: Colors.pink,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.deepPurpleAccent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
        ),
      ),
      routes: {
        '/': (context) => TabsScreen(),
        // routeHome: (context) => const Module1(routeM2: routeM2),
        // routeM2: (context) => const Module2(),

        // routeM1: (context) => const Module1(),
        // routeM1p1: (context) => const Module1(subRoute: Module1.p1SubRoute),
        // routeM1p2: (context) => const Module1(subRoute: Module1.p2SubRoute),
        // routeHomeTabsCounter: (context) =>
        //     CounterPage(title: 'Counter Title', randomText: WordPair.random()),
      },
      // onGenerateRoute: (settings) {
      //   late Widget page;
      //   if (settings.name == routeHome) {
      //     page = const Module1(
      //       subRoute: Module1.p1SubRoute,
      //     );
      //     // page = HomeFlow();
      //     // page = StatefulHome();
      //   } else if (settings.name == routeSettings) {
      //     page = const SettingsScreen();
      //   } else if (settings.name!.startsWith(routePrefixHomeTabs)) {
      //     final subRoute = settings.name!.substring(routePrefixHomeTabs.length);
      //     page = HomeFlow(
      //       homePageSubRoute: subRoute,
      //     );
      //   } else if (settings.name!.startsWith(routePrefixM1)) {
      //     final subRoute = settings.name!.substring(routePrefixM1.length);
      //     page = Module1(
      //       subRoute: subRoute,
      //     );
      //     // } else if (settings.name!.startsWith(routePrefixM2)) {
      //     //   final subRoute = settings.name!.substring(routePrefixM2.length);
      //     //   page = Module2(
      //     //     subRoute: subRoute,
      //     //   );

      //   } else if (settings.name == CounterPage.routeName) {
      //     page = CounterPage(
      //         title: 'Counter Title', randomText: WordPair.random());
      //   } else {
      //     throw Exception('Unknown route: ${settings.name}');
      //   }

      //   return MaterialPageRoute<dynamic>(
      //     builder: (context) {
      //       return page;
      //     },
      //     settings: settings,
      //   );
      // },
      // debugShowCheckedModeBanner: false,
    ),
  );
}

@immutable
class HomeFlow extends StatefulWidget {
  static HomeFlowState of(BuildContext context) {
    return context.findAncestorStateOfType<HomeFlowState>()!;
  }

  const HomeFlow({
    Key? key,
    required this.homePageSubRoute,
  }) : super(key: key);

  final String homePageSubRoute;

  @override
  HomeFlowState createState() => HomeFlowState();
}

class HomeFlowState extends State<HomeFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  // void _onDiscoveryComplete() {
  //   _navigatorKey.currentState!.pushNamed(routeDeviceSetupSelectDevicePage);
  // }

  // void _onDeviceSelected(String deviceId) {
  //   _navigatorKey.currentState!.pushNamed(routeDeviceSetupConnectingPage);
  // }

  // void _onConnectionEstablished() {
  //   _navigatorKey.currentState!.pushNamed(routeDeviceSetupFinishedPage);
  // }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                    'If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: Scaffold(
        appBar: _buildFlowAppBar(),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.homePageSubRoute,
          // onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page = const RandomWords();
    // switch (settings.name) {
    //   case routeDeviceSetupStartPage:
    //     page = WaitingPage(
    //       message: 'Searching for nearby bulb...',
    //       onWaitComplete: _onDiscoveryComplete,
    //     );
    //     break;
    //   case routeDeviceSetupSelectDevicePage:
    //     page = SelectDevicePage(
    //       onDeviceSelected: _onDeviceSelected,
    //     );
    //     break;
    //   case routeDeviceSetupConnectingPage:
    //     page = WaitingPage(
    //       message: 'Connecting...',
    //       onWaitComplete: _onConnectionEstablished,
    //     );
    //     break;
    //   case routeDeviceSetupFinishedPage:
    //     page = FinishedPage(
    //       onFinishPressed: _exitSetup,
    //     );
    //     break;
    // }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _onExitPressed,
        icon: const Icon(Icons.chevron_left),
      ),
      title: const Text('Bulb Setup'),
    );
  }
}

@immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF222222),
                ),
                child: Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'home',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(routeM1p1);
                },
                child: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(routeDeviceSetupStart);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Welcome'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, routeSettings);
          },
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(8, (index) {
            return Container(
              width: double.infinity,
              height: 54,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF222222),
              ),
            );
          }),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Settings'),
    );
  }
}



// class SelectDevicePage extends StatelessWidget {
//   const SelectDevicePage({
//     Key? key,
//     required this.onDeviceSelected,
//   }) : super(key: key);

//   final void Function(String deviceId) onDeviceSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Select a nearby device:',
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 54,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateColor.resolveWith((states) {
//                       return const Color(0xFF222222);
//                     }),
//                   ),
//                   onPressed: () {
//                     onDeviceSelected('22n483nk5834');
//                   },
//                   child: const Text(
//                     'Bulb 22n483nk5834',
//                     style: TextStyle(
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class WaitingPage extends StatefulWidget {
//   const WaitingPage({
//     Key? key,
//     required this.message,
//     required this.onWaitComplete,
//   }) : super(key: key);

//   final String message;
//   final VoidCallback onWaitComplete;

//   @override
//   _WaitingPageState createState() => _WaitingPageState();
// }

// class _WaitingPageState extends State<WaitingPage> {
//   @override
//   void initState() {
//     super.initState();
//     _startWaiting();
//   }

//   Future<void> _startWaiting() async {
//     await Future<dynamic>.delayed(const Duration(seconds: 3));

//     if (mounted) {
//       widget.onWaitComplete();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const CircularProgressIndicator(),
//               const SizedBox(height: 32),
//               Text(widget.message),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FinishedPage extends StatelessWidget {
//   const FinishedPage({
//     Key? key,
//     required this.onFinishPressed,
//   }) : super(key: key);

//   final VoidCallback onFinishPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 250,
//                 height: 250,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Color(0xFF222222),
//                 ),
//                 child: const Center(
//                   child: Icon(
//                     Icons.lightbulb,
//                     size: 175,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               const Text(
//                 'Bulb added!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.resolveWith((states) {
//                     return const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 12);
//                   }),
//                   backgroundColor: MaterialStateColor.resolveWith((states) {
//                     return const Color(0xFF222222);
//                   }),
//                   shape: MaterialStateProperty.resolveWith((states) {
//                     return const StadiumBorder();
//                   }),
//                 ),
//                 onPressed: onFinishPressed,
//                 child: const Text(
//                   'Finish',
//                   style: TextStyle(
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }