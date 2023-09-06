import 'package:flutter/material.dart';
import 'package:quotes/ui/accounts.dart';
import 'package:quotes/ui/allQuotes.dart';
import 'package:quotes/ui/favourites.dart';
import 'package:quotes/ui/randomQuote.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedItemIndex = 0;
  List<Widget> _pages = [
    RandomQuote(),
    Favourite(),
    allQuotes(),
    Accounts(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages.elementAt(_selectedItemIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_quote), label: 'Quotes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'Account'),
        ],
        currentIndex: _selectedItemIndex,
        onTap: navbarItemClicked,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
      ),
    );
  }

  void navbarItemClicked(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }
}
