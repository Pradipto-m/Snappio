import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:snappio/services/auth_service.dart';
import 'package:snappio/widgets/snackbar.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = "/signup";
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  static bool _load = false;

  bool validEmail() {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
      .hasMatch(_emailController.text);
  }
  bool validUsername() {
    return RegExp(r"^([a-z0-9]{4,10}$)").hasMatch(_usernameController.text);
  }

  void onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {_load = true;});
      try {
        AuthServices().signupUser(
          context: context,
          username: _usernameController.text,
          name: _nameController.text,
          email: _emailController.text
        ).then((value) {
          AuthServices().loginUser(context: context).then((value) {
            if(value) {Navigator.pushReplacementNamed(context, "/splash");}
            else {showSnackBar(context, "Failed to signup user");}
          });
        });
      } catch (err) {
        log(err.toString());
        showSnackBar(context, "Server Error");
        setState(() {_load = false;});
      }
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
            SizedBox(height: 275, child: Image.asset("assets/images/auth.png")),
            const SizedBox(height: 42),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 42),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Join Snappio", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_box_outlined),
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                          contentPadding: EdgeInsets.all(17)),
                        style: Theme.of(context).textTheme.bodySmall,
                        validator: (value) {
                          if (value!.isEmpty) return "Please provide your name";
                          return null;
                        },
                      ),
                      const SizedBox(height: 21),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_rounded),
                          labelText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                          contentPadding: EdgeInsets.all(17)),
                        style: Theme.of(context).textTheme.bodySmall,
                        validator: (value) {
                          if (value!.length < 4 || value.length > 10) {
                            return "Username should be 4-10 characters long";
                          } else if(!validUsername()) {
                            return "Only lowercase alphabets and numericals";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 21),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          labelText: "Email",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          contentPadding: EdgeInsets.all(17)),
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context).textTheme.bodySmall,
                        validator: (value) {
                          return validEmail() ? null : "Invalid email";
                        },
                      ),
                    ]),
                  ),
                  const SizedBox(height: 55),
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
                      child: _load
                          ? const CircularProgressIndicator()
                          : Text("Signup", style: Theme.of(context).textTheme.labelLarge))
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
          ),
        ),
      ),
    );
  }
}
