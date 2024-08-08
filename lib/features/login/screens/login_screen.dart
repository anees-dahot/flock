import 'package:flock/core/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            CustomTextField(
              controller: email,
              hintText: 'Enter Your Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
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
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  print('logged in');
                }
              },
              child: Container(
                width: width * 0.8,
                height: height * 0.07,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      " Register here!",
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
