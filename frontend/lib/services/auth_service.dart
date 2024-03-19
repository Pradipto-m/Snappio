// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snappio/screens/verification.dart';

final FirebaseAuth _phoneAuth = FirebaseAuth.instance;

Future signInWithPhone(BuildContext context, String phoneNumber) async {
  try {
    _phoneAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _phoneAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException err) {
        throw Exception(err.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        Navigator.pushNamed(context, '/verify',
          arguments: VerificationArgs(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Auto retrieval time out');
      },
    );
  } on FirebaseAuthException catch (err) {
    log(err.message.toString());
  }
}

Future verifyOTP(BuildContext context, String verificationId, String otpCode) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );
    User? user = (await _phoneAuth.signInWithCredential(credential)).user;
    if (user != null) {
      Navigator.pushNamed(context, '/signup');
    }
  } on FirebaseAuthException catch (err) {
    log(err.message.toString());
  }
}
