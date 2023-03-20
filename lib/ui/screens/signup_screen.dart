// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/notifiers/user_notifier.dart';
import 'package:saheli_app/router/app_router.gr.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneNoController, _firstNameController, _lastNameController, _aadharNoController;

  @override
  void initState() {
    super.initState();
    _phoneNoController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _aadharNoController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNoController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _aadharNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.getSize;
    return Scaffold(
      backgroundColor: const Color(0xFF95adb6),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),
            // logo of our app
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // logo image
                Image.asset(
                  "assets/ic_logo.png",
                  width: size.width * .8,
                ),
                // slogan
                Text(
                  "Together We Journey, Together We Thrive",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              borderOnForeground: true,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // text for login on left side
                      Text(
                        "Sign-Up",
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      // phone number
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "First Name",
                          border: OutlineInputBorder(),
                        ),
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Last Name",
                          border: OutlineInputBorder(),
                        ),
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Aadhar Number",
                          border: OutlineInputBorder(),
                        ),
                        controller: _aadharNoController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(),
                        ),
                        controller: _phoneNoController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.length < 10) {
                            return "Mobile Number must be of 10 digit";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      // Get otp button
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool x = await context.read<UserNotifier>().sendOtp(
                                  _firstNameController.text,
                                  _lastNameController.text,
                                  _aadharNoController.text,
                                  _phoneNoController.text,
                                );
                            if (!x || context.read<UserNotifier>().errorr) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Something Went Wrong"),
                              ));
                            } else if (x) {
                              context.pushRoute(
                                PinCodeVerificationRoute(phoneNumber: _phoneNoController.text),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width * .9, 50), backgroundColor: MyColors.primayColor),
                        child: Consumer<UserNotifier>(builder: (context, notifier, _) {
                          return notifier.sendingOtp
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  "Get OTP",
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                                );
                        }),
                      ),
                      const SizedBox(height: 20),
                      // sign up option
                      GestureDetector(
                        onTap: () => context.router.popAndPush(const LoginRoute()),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Aleardy have an account? ",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              TextSpan(
                                text: "Log In",
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: MyColors.primayColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
