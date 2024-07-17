import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const ITEM_DATA_STORE_AND_RETRIVAL_KEY = 'itemDetails';

  static List<Map<String, Object>> itemDetails = [
    {'name': 'Name1', 'price': 10.0, 'image': 'tea.png'},
    {'name': '', 'price': '', 'image': ''}
  ];

  @override
  void initState() {
    super.initState();
    _loadItems();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  Future<void> _loadItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(ITEM_DATA_STORE_AND_RETRIVAL_KEY);
    if (jsonString != null) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<Map<String, Object>> loadedItems =
          jsonList.map((item) => item as Map<String, Object>).toList();

      setState(() {
        itemDetails = loadedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.blue,
            child: const Center(
              child: Text("Logo",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            )));
  }
}


// Future<void> _addItem(String newItem) async {
//     setState(() {
//       items.add(newItem);
//     });
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('items', items);
//   }