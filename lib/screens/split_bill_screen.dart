import 'package:flutter/material.dart';

class SplitBillScreen extends StatelessWidget {
  const SplitBillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Split the bill")),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          SizedBox(height: 10),
          Text("Created by : name 1"),
          SizedBox(height: 10),
          Text("Contributed : \u20b9 399.00"),
          SizedBox(height: 10),
          Text("Amount to be paid : \u20b9 700.00"),
          SizedBox(height: 10),
          Text("Amount gined in return : \u20b9 0.00"),
          SizedBox(height: 10),
          OutlinedButton(onPressed: () {}, child: Text('Pay your part')),
          SizedBox(height: 10),
          Text("Contributer 1 : Contributer name 1"),
          SizedBox(height: 10),
          Text("Contributed : \u20b9 499.00"),
          SizedBox(height: 10),
          Text("Amount to be paid : \u20b9 600.00"),
          SizedBox(height: 10),
          Text("Amount to send : \u20b9 0.00"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(onPressed: () {}, child: Text("Request to pay")),
              OutlinedButton(onPressed: () {}, child: Text("Send amount"))
            ],
          ),
          SizedBox(height: 10),
          Text("Contributer 2 : Contributer name 2"),
          SizedBox(height: 10),
          Text("Contributed : \u20b9 999.00"),
          SizedBox(height: 10),
          Text("Amount to be paid : \u20b9 0.00"),
          SizedBox(height: 10),
          Text("Amount to send : \u20b9 499.00"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(onPressed: () {}, child: Text("Request to pay")),
              OutlinedButton(onPressed: () {}, child: Text("Send amount"))
            ],
          ),
          SizedBox(height: 10),
          Text("Contributer 3 : Contributer name 3"),
          SizedBox(height: 10),
          Text("Contributed : \u20b9 1000.00"),
          SizedBox(height: 10),
          Text("Amount to be paid : \u20b9 0.00"),
          SizedBox(height: 10),
          Text("Amount to send : \u20b9 399.00"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(onPressed: () {}, child: Text("Request to pay")),
              OutlinedButton(onPressed: () {}, child: Text("Send amount"))
            ],
          ),
        ],
      ),
    );
  }
}
