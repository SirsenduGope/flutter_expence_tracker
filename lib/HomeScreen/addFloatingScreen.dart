import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:instance_expence_cal/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFloatingScreen extends StatelessWidget {
  var newItemName = TextEditingController();

  var newItemPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return _showBottomSheet(context, true);
    } else {
      return _showBottomSheet(context, false);
    }
  }

  _showBottomSheet(BuildContext context, bool isProtrate) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(16.0),
            child: _getAdditionModel(context, isProtrate),
          ),
        );
      },
    );
  }

  _getAdditionModel(BuildContext context, bool isProtrate) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Add New Item",
          style: isProtrate
              ? const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
              : const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        isProtrate ? const SizedBox(height: 30.0) : const SizedBox(height: 0.0),
        _getItemAdditionFormDesign(),
        isProtrate ? const SizedBox(height: 20.0) : const SizedBox(height: 0.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                saveNewItem(
                    newItemName.text.toString(), newItemPrice.text.toString());
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
            isProtrate
                ? const SizedBox(
                    width: 20,
                  )
                : const SizedBox(
                    width: 40,
                  ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        )
      ],
    );
  }

  _getItemAdditionFormDesign() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  child: Image.asset(
                    "assets/images/tea.png",
                    fit: BoxFit.contain,
                  ),
                )),
            SizedBox(
              width: 40,
            ),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      child: TextField(
                        controller: newItemName,
                        keyboardType: TextInputType.name,
                        maxLength: 10,
                        decoration: const InputDecoration(
                            focusColor: Colors.green,
                            hintText: "Item Name",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextField(
                        controller: newItemPrice,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            focusColor: Colors.green,
                            hintText: "Item Price",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void saveNewItem(String newItemName, String newItemPrice) {
    Map<String, Object> newItem = {
      'name': newItemName,
      'price': newItemPrice,
      'image': ''
    };
    print("New item : $newItem");
    _addItem(newItem);
  }

  Future<void> _addItem(Map<String, Object> newItem) async {
    var itemDetails = SplashScreenState.itemDetails;
    itemDetails.add(newItem);
    String jsonString = jsonEncode(itemDetails);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        SplashScreenState.ITEM_DATA_STORE_AND_RETRIVAL_KEY, jsonString);
  }
}
