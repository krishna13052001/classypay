import 'package:flutter/material.dart';

import '../widgets/contact_list.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = './home';

  HomeScreen({Key? key}) : super(key: key);

  final PreferredSizeWidget appBar = AppBar(title: Text('Classy Pay'));

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: appBar,
        body: Container(
            child: ListView(children: [
          Container(height: height * 0.3),
          SizedBox(
            height: height * 0.075,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Contacts', style: TextStyle(fontSize: 24))),
          ),
          SizedBox(height: height * 0.625, child: ContactList())
        ])));
  }
}
