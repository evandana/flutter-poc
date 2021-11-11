import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './random_words.dart';
import './counter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // const randomWords = RandomWords();
    final randomText = WordPair.random();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            brightness: Brightness.dark,
            primaryColor: Colors.deepPurple,
            highlightColor: Colors.pinkAccent,
            focusColor: Colors.pink,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.deepPurpleAccent,
            )),
        // home: CounterPage(title: 'Flutter Demo Home Page', randomText: randomText),
        // home: const RandomWords(),
        routes: <String, WidgetBuilder>{
          HomePage.routeName: (BuildContext context) =>
              HomePage(randomText: randomText),
          // HomePage(randomText: randomText, randomWords: randomWords),
          // CounterPage.routeName: (BuildContext context) =>
          //     CounterPage(title: 'Counter Page', randomText: randomText),
          // RandomWords.routeName: (BuildContext context) => const RandomWords(),
        });
  }
}

class HomePage extends StatelessWidget {
  static const routeName = '/';

  final WordPair randomText;
  // final RandomWords randomWords;

  const HomePage({Key? key, required this.randomText})
      // {Key? key, required this.randomText, required this.randomWords})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        // The number of tabs / content sections to display.
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Title'),
              bottom: const TabBar(
                // indicator: BoxDecoration(
                //   color: Theme.of(context).backgroundColor,
                // ),
                tabs: [
                  Tab(icon: Icon(Icons.ac_unit)),
                  Tab(icon: Icon(Icons.accessible)),
                  Tab(icon: Icon(Icons.account_balance)),
                ],
              ),
            ),
            // bottomNavigationBar: SafeArea(
            //   child: TabBar(
            //     indicator: BoxDecoration(
            //       color: Theme.of(context).backgroundColor,
            //     ),
            //     tabs: const [
            //       Tab(icon: Icon(Icons.ac_unit)),
            //       Tab(icon: Icon(Icons.accessible)),
            //       Tab(icon: Icon(Icons.account_balance)),
            //     ],
            //   ),
            // ),
            body: Center(
                child: TabBarView(
              children: [
                const RandomWords(),
                CounterPage(title: 'Counter Page', randomText: randomText),
                const Tab(icon: Icon(Icons.account_balance)),
              ],
            ))));
  }
}
