import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snappio/services/auth_service.dart';

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
  static String _otp = "";

  void onSubmit(BuildContext context, String verificationId) {
    setState(() {_load = !_load;});
    verifyOTP(context, verificationId, _otp).then((value) {
      log("OTP verification successful");
      setState(() {_load = !_load;});
    }).catchError((err) {
      log(err.toString());
      setState(() {_load = !_load;});
    });
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
                              style: Theme.of(context).textTheme.displaySmall,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  _otp += value,
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
                              style: Theme.of(context).textTheme.displaySmall,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  _otp += value,
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
                              style: Theme.of(context).textTheme.displaySmall,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  _otp += value,
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
                              style: Theme.of(context).textTheme.displaySmall,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  _otp += value,
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
                              style: Theme.of(context).textTheme.displaySmall,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  _otp += value,
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
                              style: Theme.of(context).textTheme.displaySmall,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) => {
                                if (value.length == 1) {
                                  _otp += value,
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
                          child: _load
                              ? const CircularProgressIndicator()
                              : Text("Verify", style: Theme.of(context).textTheme.labelLarge))
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
