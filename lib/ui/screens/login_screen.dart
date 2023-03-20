// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saheli_app/app.dart';
import 'package:saheli_app/notifiers/user_notifier.dart';
import 'package:saheli_app/router/app_router.gr.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _textEditingController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.getSize;
    return Scaffold(
      backgroundColor: const Color(0xFF95adb6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 40),
          // logo of our app
          Column(
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
          Expanded(
            child: Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
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
                        "Log-In",
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.black),
                      ),
                      // phone number
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(),
                        ),
                        controller: _textEditingController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.length < 10) {
                            return "Mobile Number must be of 10 digit";
                          } else {
                            return null;
                          }
                        },
                      ),
                      // Get otp button
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final x = await context.read<UserNotifier>().sendLoginOtp(_textEditingController.text);
                            if (x) {
                              context.pushRoute(PinCodeVerificationRoute(phoneNumber: _textEditingController.text));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(content: Text("something went wrong")));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width * .9, 50), backgroundColor: MyColors.primayColor),
                        child: Consumer<UserNotifier>(builder: (context, notfier, _) {
                          return notfier.sendingOtp
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  "Get OTP",
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                                );
                        }),
                      ),

                      // sign up option
                      GestureDetector(
                        onTap: () => context.router.popAndPush(const SignupRoute()),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don't have an account? ",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              TextSpan(
                                text: "Sign Up",
                                onEnter: (event) {
                                  if (event.down) {
                                    context.router.popAndPush(const SignupRoute());
                                  }
                                },
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
          ),
        ],
      ),
    );
  }
}
