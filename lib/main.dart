import 'package:floater/counter_page.dart';
import 'package:floater/m1.dart';
import 'package:floater/m2.dart';
import 'package:floater/random_words.dart';
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
      },
    ),
  );
}
