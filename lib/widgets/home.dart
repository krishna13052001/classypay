import 'package:classypay/screens/split_bill_screen.dart';
import 'package:flutter/material.dart';

import 'contact_list.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
    required double height,
  })  : _height = height,
        super(key: key);

  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(children: [
      Container(
          height: _height * 0.3,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Bill name", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 10),
                  Text("Total number of people shared : 10"),
                  SizedBox(height: 10),
                  Text("Total amount spent : \u20b9 2599.00"),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton.extended(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SplitBillScreen())),
                        label: Text("Split the bill"),
                        heroTag: 1),
                  ),
                ],
              ),
            ),
          )),
      SizedBox(
        height: _height * 0.075,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Contacts', style: TextStyle(fontSize: 24))),
      ),
      SizedBox(height: _height * 0.625, child: ContactList())
    ]));
  }
}
