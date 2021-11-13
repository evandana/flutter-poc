import 'package:english_words/english_words.dart';
import 'package:floater/m1.dart';
import 'package:floater/m2.dart';
import 'package:flutter/material.dart';

import './counter_page.dart';
// import './random_words.dart';

/**
 * This would need to be extracted to a common package 
 * so it could be accessed by both the main orchestrator 
 * and the Modules (1/2)
 */
class DepModule {
  final ButtonStyle elevatedButtonBg;
  DepModule(this.elevatedButtonBg);
}

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;

  final _randomWords = GlobalKey<NavigatorState>();
  final _counterPage = GlobalKey<NavigatorState>();
  final _m1Screen = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Navigator(
            key: _m1Screen,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: RouteSettings(arguments: Map()),
              builder: (BuildContext context) => Module1(
                  depModConstructor: ({navigatorKey, subRoute}) =>
                      Module2(navigatorKey: navigatorKey, subRoute: subRoute),
                  depModProps: DepModule(Module2.elevatedButtonBg)),
            ),
          ),
          Navigator(
            key: _counterPage,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => CounterPage(
                title: 'test counter',
                randomText: WordPair.random(),
              ),
            ),
          ),
          // Navigator(
          //   key: _randomWords,
          //   onGenerateRoute: (route) => MaterialPageRoute(
          //     settings: route,
          //     builder: (context) => const RandomWords(),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (val) => _onTap(val, context),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Module1.moduleIcon,
            label: 'M1',
          ),
          BottomNavigationBarItem(
            icon: CounterPage.moduleIcon,
            label: 'Counter',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.library_books),
          //   label: 'random words',
          // ),
        ],
      ),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_currentIndex == val) {
      switch (val) {
        case 0:
          _randomWords.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          _counterPage.currentState!.popUntil((route) => route.isFirst);
          break;
        case 2:
          _m1Screen.currentState!.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = val;
        });
      }
    }
  }
}
