import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:quotes/model/quote.dart';
import 'package:sqflite/sqflite.dart';

class Favourite extends StatefulWidget {
  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  List<Quote> favouritesList = [];

  Future<void> _quotes() async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'favouriteQuotes'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE favouriteQuotes(id TEXT,authorName TEXT, quote TEXT,isFavourite INTEGER )');
    }, version: 1);
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favouriteQuotes');
    maps.forEach((element) {
      setState(() {
        var q = Quote(
            id: element['id'],
            authorName: element['authorName'],
            quote: element['quote'],
            isFavourite: element['isFavourite']);
        favouritesList.add(q);
      });
    });

    // return List.generate(maps.length, (i) {
    //   return Quote(authorName: maps[i]['authorName'], quote: maps[i]['quote']);
    // });
  }

  Future<void> _removeFavourites(String _id) async {
    final database =
        openDatabase(join(await getDatabasesPath(), 'favouriteQuotes'),
            onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE favouriteQuotes(id TEXT,authorName TEXT, quote TEXT,isFavourite INTEGER )');
    }, version: 1);
    final db = await database;

    await db.delete('favouriteQuotes', where: 'id = ?', whereArgs: [_id]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _quotes();
  }

  @override
  Widget build(BuildContext context) {
    return favouritesList.length == 0
        ? Text('No Quotes added to favourites')
        : ListView.builder(
            itemCount: favouritesList.length,
            itemBuilder: (context, index) {
              int isFavourite = favouritesList[index].isFavourite.toInt();
              print(isFavourite);
              return ListTile(
                title: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            var _id = favouritesList[index].id;
                            _removeFavourites(_id);
                          },
                          icon: Icon(Icons.favorite),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(favouritesList[index].quote)),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(' - ' + favouritesList[index].authorName))
                    ],
                  ),
                ),
              );
            });
  }
}
