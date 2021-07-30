import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = './registration';
  @override
  State createState() => new RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  Size _size;
  String _radioVal = '';
  final _nameCtrl = TextEditingController();
  final _optnCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _addCtrl = TextEditingController();
  final _phNoCtrl = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void _onRadioPress(String val) {
    setState(() {
      _radioVal = val;
    });
  }

  void onSignupPress() async {
    if (_formkey != null &&
        _formkey.currentState.validate() &&
        _radioVal != '') {
      _formkey.currentState.save();
      final _user = AppUser(
        id: DateTime.now().toString(),
        name: _nameCtrl.text,
        occupation: _optnCtrl.text,
        age: _ageCtrl.text,
        address: _addCtrl.text,
        phoneNumber: '+91 ' + _phNoCtrl.text,
        timeCreated: DateTime.now(),
        isServiceProvider: _radioVal == 'Service provider' ? true : false,
      );
      Fluttertoast.showToast(msg: 'Please wait...');
      LoadingDialog.loader(context);
      try {
        final avl = (await FirebaseFirestore.instance
                .collection('users')
                .where('phNo', isEqualTo: '+91 ' + _phNoCtrl.text)
                .get())
            .docs
            ?.isEmpty;
        Navigator.pop(context);
        if (avl) {
          Authentication.signupWithPhoneNumber(context, user: _user);
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, _, __) => OtpVerifyPopup(user: _user),
            opaque: false,
          ));
        } else
          Fluttertoast.showToast(
              msg: 'User already registered!\nPlease login...');
      } on FirebaseException catch (error) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: error.message);
      } on PlatformException catch (error) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: error.message);
      } catch (_) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: 'Something went wrong!');
      }
    }
    else
      Fluttertoast.showToast(msg: 'Please fill all the details');
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.yellow, Colors.amber, Colors.orange])),
            child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: _size.height * 0.05),
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context))),
                  SizedBox(height: _size.height * 0.05),
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
                                if (value.isEmpty)
                                  return 'This must be filled!';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Username",
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            Row(children: [
                              SizedBox(
                                  width: _size.width * 0.6,
                                  child: TextFormField(
                                    controller: _optnCtrl,
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'This must be filled!';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Occupation",
                                    ),
                                    keyboardType: TextInputType.text,
                                  )),
                              SizedBox(width: _size.width * 0.1),
                              SizedBox(
                                  width: _size.width * 0.2,
                                  child: TextFormField(
                                    controller: _ageCtrl,
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'This must be filled!';
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Age",
                                    ),
                                    keyboardType: TextInputType.number,
                                  ))
                            ]),
                            TextFormField(
                              controller: _addCtrl,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'This must be filled!';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Address",
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              controller: _phNoCtrl,
                              validator: (value) {
                                if (value.isEmpty)
                                  return 'This must be filled!';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: _size.height * 0.05),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Are you?',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueGrey))),
                            Column(children: [
                              RadioListTile(
                                dense: true,
                                title: Text('Service provider',
                                    style: TextStyle(fontSize: 14)),
                                groupValue: _radioVal,
                                onChanged: _onRadioPress,
                                value: 'Service provider',
                              ),
                              RadioListTile(
                                dense: true,
                                title: Text('User',
                                    style: TextStyle(fontSize: 14)),
                                groupValue: _radioVal,
                                onChanged: _onRadioPress,
                                value: 'User',
                              )
                            ]),
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
                      FlatButton(
                        textColor: Theme.of(context).accentColor,
                        child: Text('Login'),
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(LogInScreen.routeName),
                      )
                    ],
                  ),
                ])));
  }
}