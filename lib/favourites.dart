

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<String> myList= [];

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.favorite_outline_rounded),
        title: Text("Shared Pref Demo"),
      ),
      body: Container(
        color: Colors.orange[50],
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Card(
                child: CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    "${index + 1}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              title: Text(
                myList[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2,
              color: Colors.deepOrange,
            );
          },
          itemCount: myList.length,
        ),
      ),
    );
  }

  Future<void> getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('favourites');
    if (jsonString != null) {
      setState(() {
        myList = List<String>.from(json.decode(jsonString));
      });
    }
  }
}
