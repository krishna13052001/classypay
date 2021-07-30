import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'global/variables.dart';
import 'models/app_user.dart';
AuthCredential _phoneCredential;
UserCredential _authResult;
String _phoneVerificationId;

class Authentication {
  static Future<void> signupWithPhoneNumber(BuildContext context,
      {AppUser user, bool isLogin = false, String phoneNumber}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          codeAutoRetrievalTimeout: (verificationId) {},
          codeSent: (verificationId, forceResendingToken) {
            _phoneVerificationId = verificationId;
          },
          phoneNumber: isLogin ? phoneNumber : user.phoneNumber,
          verificationCompleted: (phoneAuthCredential) async {
            LoadingDialog.loader(context);
            try {
              _authResult = await FirebaseAuth.instance
                  .signInWithCredential(phoneAuthCredential);
              firebaseUser = _authResult.user;
              isLogin
                  ? await Database.getUserData(firebaseUser.uid)
                  : await Database.uploadUserData(user);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName, (route) => false);
            } on FirebaseException catch (error) {
              try {
                firebaseUser.delete();
              } catch (_) {}
              Navigator.pop(context);
              Fluttertoast.showToast(msg: error.message);
            } on PlatformException catch (error) {
              try {
                firebaseUser.delete();
              } catch (_) {}
              Navigator.pop(context);
              Fluttertoast.showToast(msg: error.message);
            } catch (_) {
              try {
                firebaseUser.delete();
              } catch (_) {}
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: 'Something went wrong!\nPlease try again.');
            }
          },
          verificationFailed: (error) {
            Fluttertoast.showToast(msg: error.message);
          },
          timeout: Duration(seconds: 60));
    } on FirebaseException catch (error) {
      Fluttertoast.showToast(msg: error.message);
    } on PlatformException catch (error) {
      Fluttertoast.showToast(msg: error.message);
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong!\nPlease try again.');
    }
  }

  static Future<void> verifyOTP(BuildContext context, String otp,
      {AppUser user, bool isLogin}) async {
    LoadingDialog.loader(context);
    try {
      _phoneCredential = PhoneAuthProvider.credential(
          verificationId: _phoneVerificationId, smsCode: otp);
      _authResult =
          await FirebaseAuth.instance.signInWithCredential(_phoneCredential);
      firebaseUser = _authResult.user;
      isLogin
          ? await Database.getUserData(firebaseUser.uid)
          : await Database.uploadUserData(user);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseException catch (error) {
      print(error);
      try {
        firebaseUser.delete();
      } catch (_) {}
      Navigator.pop(context);
      Fluttertoast.showToast(msg: error.message);
    } on PlatformException catch (error) {
      try {
        firebaseUser.delete();
      } catch (_) {}
      Navigator.pop(context);
      Fluttertoast.showToast(msg: error.message);
    } catch (_) {
      try {
        firebaseUser.delete();
      } catch (_) {}
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Something went wrong!\nPlease try again.');
    }
  }

  static Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      firebaseUser = null;
      currentUser = null;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LandingPage.routeName, (route) => false);
    } on FirebaseException catch (error) {
      Fluttertoast.showToast(msg: error.message);
    } on PlatformException catch (error) {
      Fluttertoast.showToast(msg: error.message);
    } catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong!\nPlease try again.');
    }
  }
}