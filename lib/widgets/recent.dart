import 'package:classypay/screens/split_bill_screen.dart';
import 'package:classypay/screens/view_bill_screen.dart';
import "package:flutter/material.dart";

class Recent extends StatelessWidget {
  const Recent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      bool _isTrue = index % 2 == 0;
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          isThreeLine: true,
          title: Text("Bill name"),
          subtitle: Text("Total amount: \u20b9 3999.00"),
          trailing: _isTrue
              ? OutlinedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewBillScreen())),
                  child: Text("View", style: TextStyle(color: Colors.green)))
              : OutlinedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SplitBillScreen())),
                  child: Text("Split", style: TextStyle(color: Colors.red))),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
    });
  }
}
