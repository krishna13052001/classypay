import 'package:flutter/material.dart';
import 'package:classypay/widgets/contact_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(title: Text('Classy Pay')),
        body: Container(child: ContactList()));
  }
}
