import 'package:flutter/material.dart';

class AddBillScreen extends StatelessWidget {
  const AddBillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add a new bill")),
        body: ListView(
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.center,
                child: Text('Fill details',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(45)))),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                    hintText: "Enter your bill name")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Your contribution",
                    hintText: "Enter amount you contributed")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contributer 1",
                    hintText: "Enter your contributer 1 name")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Amount 1",
                    hintText: "Enter your contributer 1 amount")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone number 1",
                    hintText: "Enter your contributer 1 phone number")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contributer 2",
                    hintText: "Enter your Contributer 2 name")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Amount 2",
                    hintText: "Enter your contributer 2 amount")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone number 2",
                    hintText: "Enter your contributer 2 phone number")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contributer 3",
                    hintText: "Enter your Contributer 3 name")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Amount 3",
                    hintText: "Enter your contributer 3 amount")),
            SizedBox(height: 20),
            TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone number 3",
                    hintText: "Enter your contributer 3 phone number")),
            SizedBox(height: 20),
            FloatingActionButton.extended(
                onPressed: () {}, label: Text("Submit"))
          ],
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        ));
  }
}
