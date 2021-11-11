import 'package:english_words/english_words.dart';
import 'package:floater/counter_page.dart';
import 'package:floater/m1.dart';
import 'package:floater/main.dart';
import 'package:floater/random_words.dart';
import 'package:flutter/material.dart';

class StatefulHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatefulHomeState();
  }
}

class _StatefulHomeState extends State<StatefulHome> {
  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children = [
      const RandomWords(),
      CounterPage(title: 'Counter+', randomText: WordPair.random()),
      Module1(
        goToM2Callback: () => setState(() {
          _currentIndex = 1;
        }),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("New Patient Record"),
      // ),
      body: IndexedStack(index: _currentIndex, children: _children),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              label: RandomWords.routeName, icon: RandomWords.moduleIcon),
          BottomNavigationBarItem(
              label: CounterPage.routeName, icon: CounterPage.moduleIcon),
          BottomNavigationBarItem(
              label: Module1.routeName, icon: Icon(Icons.location_pin)),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
