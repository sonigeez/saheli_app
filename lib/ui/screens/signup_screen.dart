import 'package:flutter/material.dart';
import 'package:saheli_app/app.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.getSize;
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
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
          const Spacer(flex: 3),
          // signup
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width * .8, 50),
            ),
            child: const Text("Sign Up"),
          ),
          const SizedBox(height: 20),
          // login button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width * .8, 50),
            ),
            child: const Text("Login"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
