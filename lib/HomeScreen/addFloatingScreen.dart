import 'package:flutter/material.dart';

class AddFloatingScreen extends StatelessWidget {
  var newItemName = TextEditingController();

  var newItemPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _showBottomSheet(context);
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Add New Item",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30.0),
                _getItemAdditionFormDesign(),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Add'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
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
              width: 20,
            ),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      child: TextField(
                        controller: newItemName,
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
}
