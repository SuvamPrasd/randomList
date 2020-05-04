import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random words generator',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 16);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random words'),
      ),
      body: _buildSuggestions(_suggestions, _biggerFont, _saved),
    );
  }
}

Widget _buildSuggestions(List _suggestions, TextStyle _biggerFont, Set _saved) {
  return ListView.builder(itemBuilder: (ctx, i) {
    if (i.isOdd) {
      Divider();
    }

    final int index = i ~/ 2;
    if (index >= _suggestions[i]) {
      _suggestions.addAll(generateWordPairs().take(10));
    }
    return _buildRow(_suggestions[index], _biggerFont, _saved);
  });
}

Widget _buildRow(WordPair pair, TextStyle _biggerFont, Set _saved) {
  final bool alreadySaved = _saved.contains(pair);
  return ListTile(
    title: Text(
      pair.asPascalCase,
      style: _biggerFont,
    ),
    trailing: Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ),
    onTap: (){
      setState(){
        if(alreadySaved){
          _saved.remove(pair);
        }else{
          _saved.add(pair);
        }
      }
    },
  );
}
