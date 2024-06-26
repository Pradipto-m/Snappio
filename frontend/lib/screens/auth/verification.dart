import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:snappio/services/auth_service.dart';
import 'package:snappio/widgets/snackbar.dart';

class VerificationArgs {
  final String verificationId;
  const VerificationArgs({required this.verificationId});
}

class OtpScreen extends StatefulWidget {
  static const String routeName = "/verify";
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  static bool _load = false;
  static bool? _error;
  static String code1 = "";
  static String code2 = "";
  static String code3 = "";
  static String code4 = "";
  static String code5 = "";
  static String code6 = "";

  void onSubmit(BuildContext context, String verificationId) {
    final String otp = code1 + code2 + code3 + code4 + code5 + code6;
    if (otp.length != 6) {
      showSnackBar(context, "Incorrect OTP");
      return;
    }
    try {
      setState(() { _error = null; _load = true; });
      AuthServices().verifyCredential(context, verificationId, otp)
      .then((value) {
        if (!value) {
          setState(() { _error = true; _load = true; });
          showSnackBar(context, "Incorrect OTP");
          Future.delayed(const Duration(milliseconds: 1500), () {
            setState(() { _error = null; _load = false; });
          });
          return;
        }
        AuthServices().userExists(context: context).then((value) {
          if (!value) {
            setState(() { _error = false; _load = true; });
            Future.delayed(const Duration(milliseconds: 1500), () =>
              Navigator.pushReplacementNamed(context, "/signup"));
          } else {
            AuthServices().loginUser(context: context).then((value) {
              if (value) {
                setState(() { _error = false; _load = true; });
                Future.delayed(const Duration(milliseconds: 1500), () =>
                  Navigator.pushReplacementNamed(context, "/splash"));
              }
              else {
                showSnackBar(context, "Oops, something went wrong!");
                setState(() { _error = null; _load = false; });
              }
            });
          }
        });
      });
    } catch (err) { log(err.toString()); }
  }

  @override
  Widget build(BuildContext context) {

    final argument = ModalRoute.of(context)!.settings.arguments as VerificationArgs;
    final verificationId = argument.verificationId;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/images/login.png"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 45),
                    Text("Chat Share Privately", style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 80),
                    Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 54,
                            height: 60,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(19))),
                                filled: true,
                                fillColor: Colors.white10
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  code1 = value,
                                  FocusScope.of(context).nextFocus(),
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 54,
                            height: 60,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(19))),
                                filled: true,
                                fillColor: Colors.white10
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  code2 = value,
                                  FocusScope.of(context).nextFocus(),
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 54,
                            height: 60,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(19))),
                                filled: true,
                                fillColor: Colors.white10
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  code3 = value,
                                  FocusScope.of(context).nextFocus(),
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 54,
                            height: 60,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(19))),
                                filled: true,
                                fillColor: Colors.white10
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  code4 = value,
                                  FocusScope.of(context).nextFocus(),
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 54,
                            height: 60,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(19))),
                                filled: true,
                                fillColor: Colors.white10
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  code5 = value,
                                  FocusScope.of(context).nextFocus(),
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 54,
                            height: 60,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(19))),
                                filled: true,
                                fillColor: Colors.white10
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  code6 = value,
                                  FocusScope.of(context).nextFocus(),
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    InkWell(
                      onTap: () => onSubmit(context, verificationId),
                      splashColor: Colors.transparent,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 330),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        width: _load ? 60.0 : 340.0,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                          color: Theme.of(context).cardColor),
                        child: _error == null ? _load
                          ? CircularProgressIndicator(color: Theme.of(context).highlightColor)
                          : Text("Verify", style: Theme.of(context).textTheme.labelLarge)
                          : _error! ?
                          Icon(Ionicons.close_circle_outline, size: 40,
                            color: Theme.of(context).iconTheme.color) :
                          Icon(Ionicons.checkmark_circle_outline, size: 40,
                            color: Theme.of(context).iconTheme.color)
                      ),
                    ),
                  ],
                )),
            ],
            ),
          ),
        )
      );
  }
}
