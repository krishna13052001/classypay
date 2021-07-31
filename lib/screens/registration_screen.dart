import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_screen.dart';
import '../models/app_user.dart';
import '../helpers/snackbar.dart';
import '../widgets/otp_verify_popup.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = './registration';
  @override
  State createState() => new RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  late Size _size;
  final _nameCtrl = TextEditingController();
  final _phNoCtrl = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void onSignupPress() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final _user = AppUser(
        id: DateTime.now().toString(),
        name: _nameCtrl.text,
        phoneNumber: '+91 ' + _phNoCtrl.text,
      );
      showSnackBar(context, message: 'Please wait...');
      try {
        final avl = true;
        if (avl) {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, _, __) => OtpVerifyPopup(
                user: _user, phoneNumber: "+91" + _phNoCtrl.text),
            opaque: false,
          ));
          showSnackBar(context, message: 'Sign-up successful...');
        } else
          showSnackBar(context,
              message: 'User already registered!\nPlease login...');
      } on PlatformException catch (error) {
        showSnackBar(context, message: error.message ?? "");
      } catch (_) {
        showSnackBar(context, message: 'Something went wrong!');
      }
    } else
      showSnackBar(context, message: 'Please fill all the details');
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
                children: <Widget>[
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
                              text: 'Sign up\n\n',
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
                                    text: 'Please signup to continue!',
                                    style: TextStyle(fontSize: 14)),
                              ],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)))),
                  SizedBox(height: _size.height * 0.05),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                      child: Form(
                          key: _formkey,
                          child: Column(children: <Widget>[
                            TextFormField(
                              controller: _nameCtrl,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'This must be filled!';
                                else if (value.length < 5)
                                  return 'Username is too short!';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Username",
                              ),
                              keyboardType: TextInputType.text,
                            ),
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
                            SizedBox(height: _size.height * 0.05),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: MaterialButton(
                                        onPressed: onSignupPress,
                                        color: Theme.of(context).primaryColor,
                                        textColor: Colors.white,
                                        child: FittedBox(
                                            child: Row(children: [
                                          Text("SIGN UP${'\t' * 2}"),
                                          Icon(Icons.arrow_forward)
                                        ]))))),
                          ]))),
                  SizedBox(height: _size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('An exesting member?'),
                      TextButton(
                        child: Text('Login'),
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(LogInScreen.routeName),
                      )
                    ],
                  ),
                ])));
  }
}
