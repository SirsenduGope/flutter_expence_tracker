import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _totalExpence = 0.0;
  var itemDetails = [
    {'name': 'Name1', 'price': 10.0, 'image': 'tea.png'},
    {'name': 'Name2', 'price': 5.0, 'image': 'tea.png'},
    {'name': 'Name3', 'price': 7.0, 'image': 'tea.png'},
    {'name': 'Name4', 'price': 15.5, 'image': 'tea.png'},
    {'name': 'Name5', 'price': 17.0, 'image': 'tea.png'},
    {'name': 'Name6', 'price': 4.0, 'image': 'tea.png'},
    {'name': '', 'price': '', 'image': ''}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          backgroundColor: Theme.of(context).primaryColor),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Total Expence :",
                        style: getHeaderTextStyle(),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          print("button pressed");
                        },
                        style: getExpenceBtnStyle(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text('$_totalExpence')),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
                width: double.infinity,
                // color: Colors.white60,
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: getGridViewForBody(itemDetails),
                    ),
                    Expanded(
                      flex: 1,
                      child: getResetButton(context),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  getExpenceBtnStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColorLight,
        elevation: 10,
        textStyle: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))));
  }

  getHeaderTextStyle() {
    return const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  }

  getGridViewForBody(List<Map<String, Object>> itemDetails) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120),
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.all(5),
            decoration: getItemBoxDecoration(context),
            child: (index < itemDetails.length - 1)
                ? getGridViewItems(itemDetails, index)
                : getGridViewAddIconBox());
      },
      itemCount: itemDetails.length,
    );
  }

  getResetButton(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                _totalExpence = 0.0;
              });
            },
            style: getExpenceBtnStyle(context),
            child: Text(
              "Reset Expence",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  getGridViewItems(List<Map<String, Object>> itemDetails, int index) {
    return Material(
      child: InkWell(
        splashColor: Colors.redAccent.withOpacity(0.5),
        highlightColor: Colors.yellow.withOpacity(0.3),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/images/${itemDetails[index]['image']}",
                fit: BoxFit.cover,
              ),
            ),
            Text(
              itemDetails[index]['name'].toString(),
            ),
            Text(
              'Rs. ${itemDetails[index]['price']}',
            ),
          ],
        ),
        onTap: () {
          print("Index : ${itemDetails[index]['price']}");
          addTotalExpence(itemDetails, index);
        },
      ),
    );
  }

  addTotalExpence(List<Map<String, Object>> itemDetails, int index) {
    setState(() {
      var price = itemDetails[index]['price'];
      _totalExpence = _totalExpence + double.parse(price.toString());
    });
  }

  getGridViewAddIconBox() {
    return Material(
      child: InkWell(
        splashColor: Colors.redAccent.withOpacity(0.5),
        highlightColor: Colors.yellow.withOpacity(0.3),
        child: const Icon(
          Icons.add,
          size: 60,
          shadows: [
            Shadow(
                color: Color.fromARGB(255, 139, 135, 135),
                blurRadius: 3,
                offset: Offset(3, 3))
          ],
        ),
        onTap: () {
          print("Add");
        },
      ),
    );
  }

  getItemBoxDecoration(BuildContext context) {
    return BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 1),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(3, 3),
          ),
        ]);
  }
}
