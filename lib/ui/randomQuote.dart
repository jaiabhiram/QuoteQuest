import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert' as convert;

import 'package:quotes/model/quote.dart';
import 'package:sqflite/sqflite.dart';

class RandomQuote extends StatefulWidget {
  @override
  State<RandomQuote> createState() => _RandomState();
}

class _RandomState extends State<RandomQuote> {
  var _quote = '';
  var _author = '';
  var _id = '';
  //var isFavourite = false;

  void getRandomQuote() async {
    var url = 'https://api.quotable.io/random';
    var response = await http.get(Uri.parse(url));
    var jsonReponse = convert.jsonDecode(response.body);
    var quote = jsonReponse['content'];
    var author = jsonReponse['author'];
    var id = jsonReponse['_id'];

    bool isFavourite = false;
    setState(() {
      _id = id.toString();
      _quote = quote.toString();
      _author = author.toString();
    });
  }

  @override
  void initState() {
    super.initState();

    getRandomQuote();
  }

  Future<void> _addFavourite(Quote quoteAndName) async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'favouriteQuotes'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE favouriteQuotes(id TEXT,authorName TEXT, quote TEXT,isFavourite INTEGER )');
    }, version: 1);
    final db = await database;
    await db.insert('favouriteQuotes', quoteAndName.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 100, bottom: 20),
          child: Text(
            'Quality Quotes',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Expanded(
            child: Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 125, top: 75),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black)),
                    child: Column(children: [
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () async {
                            var quoteAndName = Quote(
                                id: _id,
                                authorName: _author,
                                quote: _quote,
                                isFavourite: 0);
                            await _addFavourite(quoteAndName);
                          },
                        ),
                        alignment: Alignment.topRight,
                      ),
                      Expanded(
                        child: Center(
                            child: Text(
                          _quote,
                          style: TextStyle(fontSize: 17),
                        )),
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            ' - ' + _author,
                            style: TextStyle(fontSize: 17),
                          ))
                    ]),
                  ),
                ))),
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: TextButton(
              onPressed: getRandomQuote,
              child: Text(
                'New Quote',
                style: TextStyle(fontSize: 17),
              )),
        )
      ],
    );
  }
}
