import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instance_expence_cal/splashScreen.dart';
import 'addFloatingScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _totalExpence = 0.0;
  bool isProtrate = true;

  @override
  Widget build(BuildContext context) {
    var itemDetails = SplashScreenState.itemDetails;
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      isProtrate = true;
    } else {
      isProtrate = false;
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text(
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
                    padding: isProtrate
                        ? const EdgeInsets.all(12)
                        : const EdgeInsets.only(left: 10, top: 2, bottom: 2),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Total Expence :",
                        style: getHeaderTextStyle(),
                      ),
                    ),
                  ),
                  Padding(
                      padding:
                          isProtrate ? EdgeInsets.all(10) : EdgeInsets.all(3),
                      child: ElevatedButton(
                        onPressed: () {
                          print("button pressed");
                        },
                        style: getExpenceBtnStyle(context),
                        child: Padding(
                          padding: isProtrate
                              ? const EdgeInsets.all(8.0)
                              : const EdgeInsets.all(2),
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
                      flex: isProtrate ? 1 : 3,
                      child: getResetButton(context, isProtrate),
                    )
                  ],
                )),
          ),
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

  getGridItemButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      elevation: 10,
      // textStyle: const TextStyle(fontSize: 10, color: Colors.black),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      padding: const EdgeInsets.all(10),
    );
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

  getResetButton(BuildContext context, bool isProtrate) {
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
              style: isProtrate
                  ? const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                  : const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  getGridViewItems(List<Map<String, Object>> itemDetails, int index) {
    return ElevatedButton(
      onPressed: () {
        addTotalExpence(itemDetails, index);
      },
      style: getGridItemButtonStyle(),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/images/${itemDetails[index]['image']}",
              fit: BoxFit.contain,
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
    );
  }

  addTotalExpence(List<Map<String, Object>> itemDetails, int index) {
    setState(() {
      var price = itemDetails[index]['price'];
      _totalExpence = _totalExpence + double.parse(price.toString());
    });
  }

  getGridViewAddIconBox() {
    return ElevatedButton(
      onPressed: () {
        // _toggleAddFloatingScreen();
        getAddFloatingScreen();
      },
      style: getGridItemButtonStyle(),
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
    );
  }

  getItemBoxDecoration(BuildContext context) {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(3, 3),
          ),
        ]);
  }

  getAddFloatingScreen() {
    return AddFloatingScreen().build(context);
  }
}
