import 'package:flock/core/widgets/custom_button.dart';
import 'package:flock/core/widgets/text_fields.dart';
import 'package:flutter/material.dart';

import '../../login/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register-screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // New welcome text
            Text(
              'Welcome Buddy!',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height * 0.01), // Spacing
            Text(
              'Please register your new account',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: height * 0.04), // Spacing before the form
            CustomTextField(
              controller: email,
              hintText: 'Enter Your Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              inputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CustomTextField(
              controller: password,
              hintText: 'Enter Your Password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password is too weak';
                }
                return null;
              },
              isPassword: true,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            CustomButton(
              width: width,
              height: height,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  print('logged in');
                }
              },
              text: 'Register',
            ),

            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.routeName, (route) => false);
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      " Login here!",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
