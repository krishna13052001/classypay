import 'package:classypay/screens/add_bill_screen.dart';
import 'package:classypay/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/home.dart';
import '../widgets/recent.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = './home';

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PreferredSizeWidget appBar = AppBar(title: Text('Classy Pay'));
  int _index = 0;
  double _height = 0.0;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: _index == 0 ? Home(height: _height) : Recent(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddBillScreen(),
              )),
          label: Text('Add new bill')),
      drawer: Drawer(
          child: ListView(children: [
        Container(
            alignment: Alignment.center,
            child: Text('Welcome to Classy Pay',
                style: TextStyle(color: Colors.white, fontSize: 28)),
            color: Colors.blue,
            height: 200),
        TextButton.icon(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                LogInScreen.routeName, (route) => false),
            icon: Icon(Icons.logout),
            label: Text("Logout"))
      ])),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Recent")
        ],
        currentIndex: _index,
        onTap: (value) {
          if (value != _index) {
            setState(() {
              _index = value;
            });
          }
        },
      ),
    );
  }
}
