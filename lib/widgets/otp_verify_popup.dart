import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/app_user.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:viswakarma/services/authentication.dart';

class OtpVerifyPopup extends StatelessWidget {
  final AppUser user;
  final bool isLogin;
  final String phoneNumber;
  OtpVerifyPopup({this.user, this.isLogin = false, this.phoneNumber});
  static String otp;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.7),
        body: Builder(
          builder: (context) => Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.height * 0.03,
                    ),
                    child: Text(
                      'Confirm verification code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: size.width * .8,
                      alignment: Alignment.center,
                      child: PinCodeTextField(
                          length: 6,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          autoDismissKeyboard: true,
                          pinTheme: PinTheme(
                              inactiveColor: Colors.black26,
                              borderWidth: 1.5,
                              shape: PinCodeFieldShape.circle,
                              fieldWidth: size.width * 0.125,
                              fieldHeight: size.width * 0.125),
                          onChanged: (str) => otp = str),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.03,
                      horizontal: size.width * 0.025,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ResendTimerWidget(user: user, isLogin: isLogin),
                        Expanded(
                          child: FlatButton(
                            child: Text('Done'),
                            onPressed: () async =>
                                await Authentication.verifyOTP(context, otp,
                                    user: user, isLogin: isLogin),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResendTimerWidget extends StatefulWidget {
  final AppUser user;
  final bool isLogin;
  final String phoneNumber;
  ResendTimerWidget({this.user, this.isLogin = false, this.phoneNumber});
  @override
  _ResendTimerWidgetState createState() => _ResendTimerWidgetState();
}

class _ResendTimerWidgetState extends State<ResendTimerWidget> {
  String _remainingTime = '00 : 60';
  bool _isRequested = true;
  Timer _timer;
  Timer _countTimer;

  void alterButton() {
    setState(() {
      _isRequested = !_isRequested;
      if (_isRequested) {
        setTimerWidget();
        setBackButton();
      }
    });
  }

  void setTimerWidget() {
    int _time = 59;
    setState(() {
      _remainingTime = '00 : 60';
      _time = 59;
    });
    _countTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_time >= 0)
        setState(() {
          _remainingTime = '00 : $_time';
          _time = _time - 1;
        });
    });
  }

  void setBackButton() {
    _timer = Timer(Duration(seconds: 60), () {
      alterButton();
      _countTimer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    setTimerWidget();
    setBackButton();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _countTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _isRequested
        ? Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                _remainingTime,
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        : Expanded(
            child: FlatButton(
              child: Text(
                'Re-send',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () async {
                await Authentication.signupWithPhoneNumber(context,
                    user: widget.user,
                    isLogin: widget.isLogin,
                    phoneNumber: widget.phoneNumber);
                alterButton();
              },
            ),
          );
  }
}