import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import '../screens/registration_screen.dart';
import '../widgets/otp_verify_popup.dart';
import '../helpers/snackbar.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = './login';

  @override
  State createState() => new LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phNoCtrl = TextEditingController();
  late Size _size;

  void onSigninPress() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showSnackBar(context, message: 'Please wait...');
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, _, __) =>
            OtpVerifyPopup(isLogin: true, phoneNumber: "+91" + _phNoCtrl.text),
        opaque: false,
      ));
      showSnackBar(context, message: "Login successful...");
    }
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[Color(0xffee0000), Color(0xffeeee00)],
            )),
            child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: _size.height * 0.05),
                children: [
                  Navigator.canPop(context)
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context)))
                      : SizedBox(height: 30),
                  Padding(
                      padding: EdgeInsets.only(left: _size.width * 0.05),
                      child: RichText(
                          text: TextSpan(
                              text: 'Log in\n\n',
                              children: [
                                TextSpan(
                                    text: 'Hi, ',
                                    children: [
                                      TextSpan(
                                          text: 'Welcome!\n',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor))
                                    ],
                                    style: TextStyle(fontSize: 24)),
                                TextSpan(
                                    text: 'Please login to continue!',
                                    style: TextStyle(fontSize: 14)),
                              ],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)))),
                  SizedBox(height: _size.height * 0.1),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                      child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  controller: _phNoCtrl,
                                  validator: (value) {
                                    if (value!.isEmpty)
                                      return 'This must be filled!';
                                    else if (value.length != 10)
                                      return 'Phone number must contain 10 digits!';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Phone Number",
                                      prefixText: "+91 "),
                                  keyboardType: TextInputType.phone,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: MaterialButton(
                                            onPressed: onSigninPress,
                                            color:
                                                Theme.of(context).primaryColor,
                                            textColor: Colors.white,
                                            child: FittedBox(
                                                child: Row(children: [
                                              Text("LOGIN${'\t' * 2}"),
                                              Icon(Icons.arrow_forward)
                                            ])))))
                              ]))),
                  SizedBox(height: _size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('New Candidate?'),
                      TextButton(
                        child: Text('Register'),
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(RegistrationScreen.routeName),
                      )
                    ],
                  ),
                ])));
  }
}
