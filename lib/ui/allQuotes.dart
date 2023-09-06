import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/quote.dart';

class allQuotes extends StatefulWidget {
  @override
  State<allQuotes> createState() => _allQuotesState();
}

class _allQuotesState extends State<allQuotes> {
  var results = [];
  var isLoading = true;
  @override
  void initState() {
    getAuthors();
  }

  Future<void> getAuthors() async {
    const url = 'https://api.quotable.io/quotes';
    var response = await http.get(Uri.parse(url));
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse['results']);
    setState(() {
      results = jsonResponse['results'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Text('Loading...')
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(results[index]['content'])),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(' - ' + results[index]['author']))
                    ],
                  ),
                ),
              );
            });
  }
}
