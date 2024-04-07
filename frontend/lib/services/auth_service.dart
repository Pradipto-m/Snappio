// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snappio/models/user_model.dart';
import 'package:snappio/providers/user_provider.dart';
import 'package:snappio/screens/auth/verification.dart';
import 'package:snappio/widgets/snackbar.dart';

class AuthServices {

  final FirebaseAuth _phoneAuth = FirebaseAuth.instance;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.0.103:3000/api/v1",
    validateStatus: (status) => status! < 500,
  ));

  Future<bool> onboarded(BuildContext context, {bool onboarding = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("onboard")) {
      return true;
    } else {
      if (onboarding) {
        prefs.setBool("onboard", true);
        Navigator.pushReplacementNamed(context, "/auth");
        return true;
      } else {return false;}
    }
  }
  
  Future<bool> userAuth(BuildContext context, WidgetRef ref) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString("auth");

      if(token != null) {
        Response response = await _dio.get("/user/auth",
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ),
        );

        if(response.statusCode! < 300){
          final UserModel user = UserModel.fromJson(response.data);
          ref.read(userProvider.notifier).setUser(user);
          return true;
        } else {
          showSnackBar(context, "Oops, Please Sign In Again!");
          return false;
        }
      } else { return false; }
    } catch (err) {
      showSnackBar(context, "Server Error");
      return false;
    }
  }

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("phn", phoneNumber);

      await _phoneAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _phoneAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException err) {
          throw Exception(err.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.pushReplacementNamed(context, '/verify',
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

  Future<bool> verifyCredential(BuildContext context, String verificationId, String otpCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      User? user = (await _phoneAuth.signInWithCredential(credential)).user;

      if (user != null) {
        return true;
      } else { return false; }

    } on FirebaseAuthException catch (err) {
      log(err.message.toString());
      return false;
    }
  }

  Future<bool> userExists ({required BuildContext context}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? phone = prefs.getString("phn");
      Response response = await _dio.get(
        "/user/find",
        queryParameters: {"phone": phone},
      );

      if(response.statusCode! < 300){
        return true;
      } else {
        return false;
      }
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  Future<bool> signupUser ({
    required BuildContext context,
    required String username,
    required String name,
    required String email,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? phone = prefs.getString("phn");

      final data = {
        "username": username,
        "name":  name,
        "phone": phone,
        "email": email,
      };

      Response response = await _dio.post("/user/signup",
        data: data,
      );

      if(response.statusCode! < 300){
        return true;
      } else {
        response.statusCode == 400
        ? showSnackBar(context, "Username already exists")
        : showSnackBar(context, "Something went wrong!");
        return false;
      }
    } catch (err) {
      log(err.toString());
      showSnackBar(context, "Server Error");
      return false;
    }
  }

  Future<bool> loginUser ({
    required BuildContext context,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? phone = prefs.getString("phn");
      Response response = await _dio.post("/user/login",
        data: {"phone": phone},
      );

      if(response.statusCode! < 300){
        prefs.setString("auth", response.data["token"]);
        return true;
      }
      else {
        showSnackBar(context, "Something went wrong!");
        return false;
      }
    } catch(err) {
      log(err.toString());
      showSnackBar(context, "Server Error");
      return false;
    }
  }
}
