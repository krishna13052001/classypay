import 'package:flutter/material.dart';

class ViewBillScreen extends StatelessWidget {
  const ViewBillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Bill name")),
        body: ListView(padding: const EdgeInsets.all(8.0), children: [
          SizedBox(height: 10),
          Text("Created by : name 1"),
          SizedBox(height: 10),
          Text("Contributed : \u20b9 399.00"),
          SizedBox(height: 10),
          Text("Amount paid in return : \u20b9 700.00"),
          SizedBox(height: 10),
          Text("Amount gined in return : \u20b9 0.00"),
          SizedBox(height: 10),
          Text("Contributer 1 : Contributer name 1"),
          SizedBox(height: 10),
          Text("Contributed : \u20b9 499.00"),
          SizedBox(height: 10),
          Text("Amount pain in return : \u20b9 600.00"),
          SizedBox(height: 10),
          Text("Amount gined in retur : \u20b9 0.00"),
          SizedBox(height: 10),
          Text("Contributer 2 : Contributer name 2"),
          SizedBox(height: 10),
          Text("Contributed : \u20b9 999.00"),
          SizedBox(height: 10),
          Text("Amount pain in return : \u20b9 0.00"),
          SizedBox(height: 10),
          Text("Amount gined in return : \u20b9 499.00"),
          SizedBox(height: 10),
          Text("Contributer 3 : Contributer name 3"),
          SizedBox(height: 10),
          Text("Contributed : \u20b9 1000.00"),
          SizedBox(height: 10),
          Text("Amount pain in return : \u20b9 0.00"),
          SizedBox(height: 10),
          Text("Amount gined in return : \u20b9 399.00"),
        ]));
  }
}
