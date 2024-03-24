import 'package:flutter/material.dart';
import 'package:snappio/services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  static String _phone = '';
  static bool _load = false;

  void onSubmit(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {_load = true;});
      final phoneNumber = "+91${_phoneController.text.trim()}";
      await AuthServices().signInWithPhone(context, phoneNumber);
    }
    setState(() {_load = false;});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/images/signup.png"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 42),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 45),
                    Text("Welcome to Snappio",
                      style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 80),
                    Form(
                      key: _formkey,
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Enter mobile number",
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 17),
                          prefix: Text("+91  ",
                              style: Theme.of(context).textTheme.displaySmall),
                          suffixIcon: _phone.length == 10 ? const Icon(Icons.check_circle_outline_rounded) : null,
                          suffixIconColor: Colors.green),
                        keyboardType: TextInputType.phone,
                        style: Theme.of(context).textTheme.displaySmall,
                        onChanged: (value) => {
                          setState(() {
                            _phone = value;
                          })
                        },
                        validator: (value) {
                          if (value!.length != 10) {
                            return "Please enter a valid phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 80),
                    InkWell(
                      onTap: () => onSubmit(context),
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
                        child: _load ? const CircularProgressIndicator()
                          : Text("Send OTP", style: Theme.of(context).textTheme.labelLarge))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
