import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:techblog/Auth/auth.dart';
import 'package:techblog/Enum/index.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:techblog/Mixins/index.dart';

class PhoneAuthController extends GetxController with PrintLogMixin {
  VoidCallback? onStarted,
      onCodeSent,
      onCodeResent,
      onVerified,
      onFailed,
      onError,
      onAutoRetrievalTimeout;

  final Rx<bool> _loading = Rx(false);
  bool get loading => _loading.value;

  final Rx<TextEditingController> _phoneNumberController =
      Rx(TextEditingController());

  TextEditingController get phoneNumberController =>
      _phoneNumberController.value;

  final Rxn _status = Rxn();
  PhoneAuthState get status => _status.value;

  dynamic _authCredential;
  get authCredential => _authCredential.value;

  final Rxn _actualCode = Rxn();
  String get actualCode => _actualCode.value;

  final Rxn _phone = Rxn();
  String get phone => _phone.value;

  final Rxn _message = Rxn();
  String get message => _message.value;

  setMethods(
      {VoidCallback? onStarted,
      VoidCallback? onCodeSent,
      VoidCallback? onCodeResent,
      VoidCallback? onVerified,
      VoidCallback? onFailed,
      VoidCallback? onError,
      VoidCallback? onAutoRetrievalTimeout}) {
    this.onStarted = onStarted;
    this.onCodeSent = onCodeSent;
    this.onCodeResent = onCodeResent;
    this.onVerified = onVerified;
    this.onFailed = onFailed;
    this.onError = onError;
    this.onAutoRetrievalTimeout = onAutoRetrievalTimeout;
  }

  Future<bool> instantiate(
      {String? dialCode,
      VoidCallback? onStarted,
      VoidCallback? onCodeSent,
      VoidCallback? onCodeResent,
      VoidCallback? onVerified,
      VoidCallback? onFailed,
      VoidCallback? onError,
      VoidCallback? onAutoRetrievalTimeout}) async {
    this.onStarted = onStarted;
    this.onCodeSent = onCodeSent;
    this.onCodeResent = onCodeResent;
    this.onVerified = onVerified;
    this.onFailed = onFailed;
    this.onError = onError;
    this.onAutoRetrievalTimeout = onAutoRetrievalTimeout;

    if (phoneNumberController.text.length < 10) {
      return false;
    }
    phone = dialCode.toString() + phoneNumberController.text;
    if (kDebugMode) {
      print(phone);
    }
    _startAuth();
    return true;
  }

  set phone(String value) {
    _phone.value = value;
    update();
  }

  set message(String value) {
    _message.value = value;
    update();
  }

  set status(PhoneAuthState value) {
    _status.value = value;
    update();
  }

  set loading(bool value) {
    _loading.value = value;
    update();
  }

  set actualCode(String value) {
    _actualCode.value = value;
    update();
  }

  set authCredential(value) {
    _authCredential.value = value;
    update();
  }

  _addStatus(PhoneAuthState state) {
    status = state;
  }

  void _addStatusMessage(String s) {
    message = s;
  }

  void verifyOTPAndLogin({String? smsCode}) async {
    _authCredential = PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode.toString());

    FireBase.auth.signInWithCredential(_authCredential).then((result) async {
      printLog('Authentication successful', LogState.info);
      _addStatusMessage('Authentication successful');
      _addStatus(PhoneAuthState.verified);
      onVerified!();
    }).catchError((error) {
      onError!();
      printLog(error.toString(), LogState.error);
      _addStatus(PhoneAuthState.error);
      _addStatusMessage(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
  }

  _startAuth() {
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent codeSent =
        (String? verificationId, [int? forceResendingToken]) async {
      actualCode = verificationId!;
      printLog('Start Authentication', LogState.info);
      _addStatusMessage("\nEnter the code sent to " + phone);
      _addStatus(PhoneAuthState.codeSent);
      onCodeSent!();
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      actualCode = verificationId;
      _addStatusMessage("\nAuto retrieval time out");
      _addStatus(PhoneAuthState.autoRetrievalTimeOut);
      printLog('Auto retrieval time out', LogState.info);
      onAutoRetrievalTimeout!();
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed = (authException) {
      printLog(authException.message, LogState.error);
      _addStatusMessage('${authException.message}');
      _addStatus(PhoneAuthState.failed);
      onFailed!();
      if (authException.message!.contains('not authorized')) {
        _addStatusMessage('App not authroized');
      } else if (authException.message.toString().contains('Network')) {
        _addStatusMessage(
            'Please check your internet connection and try again');
      } else {
        _addStatusMessage('Something has gone wrong, please try later ' +
            authException.message.toString());
      }
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      _addStatusMessage('Auto retrieving verification code');
      printLog("Auto retrieving verification code", LogState.info);

      FireBase.auth.signInWithCredential(auth).then((value) {
        if (value.user != null) {
          printLog("Authentication successful", LogState.info);

          _addStatusMessage('Authentication successful');
          _addStatus(PhoneAuthState.verified);
          onVerified!();
        } else {
          onFailed!();

          _addStatus(PhoneAuthState.failed);
          _addStatusMessage('Invalid code/invalid authentication');
        }
      }).catchError((error) {
        onError!();
        printLog(error.toString(), LogState.error);
        _addStatus(PhoneAuthState.error);
        _addStatusMessage('Something has gone wrong, please try later $error');
      });
    };

    _addStatusMessage('Phone auth started');

    printLog("Phone auth started", LogState.info);

    FireBase.auth
        .verifyPhoneNumber(
            phoneNumber: phone.toString(),
            timeout: const Duration(seconds: 60),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      onCodeSent!();
      _addStatus(PhoneAuthState.codeSent);
      _addStatusMessage('Code sent');
      printLog('Code sent', LogState.info);
    }).catchError((error) {
      printLog(error.message, LogState.error);
      onError!();
      _addStatus(PhoneAuthState.error);
      _addStatusMessage(error.toString());
    });
  }
}
