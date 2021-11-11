import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);
  static const routeName = '/random-words';
  static const moduleIcon = Icon(Icons.sort_by_alpha);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords>
    with AutomaticKeepAliveClientMixin<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
            // backgroundColor: Theme.of(context).canvasColor,
            title: const Text('Name Generator'),
            actions: [
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: _pushSaved,
                tooltip: 'Saved Suggestions',
              )
            ]),
        body: _buildSuggestions());
  }

  @override
  bool get wantKeepAlive => true;

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map((pair) {
            return ListTile(
              title: Text(pair.asPascalCase, style: _biggerFont),
            );
          });
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return Divider(
            color: Theme.of(context).highlightColor,
            thickness: 0.25,
          );
        }

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: _biggerFont),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Theme.of(context).highlightColor : null,
          semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }
}
