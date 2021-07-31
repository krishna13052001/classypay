import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Classy Pay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: LogInScreen(),
        home: HomeScreen(),
        routes: {
          LogInScreen.routeName: (ctx) => LogInScreen(),
          RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen()
        });
  }
}
