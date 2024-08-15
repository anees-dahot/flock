import 'package:flock/core/widgets/text_fields.dart';
import 'package:flock/features/create%20account/screens/pick_profile_image.dart';
import 'package:flock/features/login/bloc/login_bloc.dart';
import 'package:flock/features/login/repositories/login_repository.dart';
import 'package:flock/features/navigation%20bar/screens/navigation_bar.dart';
import 'package:flock/features/register%20account/screens/register_account_screen.dart';
import 'package:flock/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../utils/flush_message.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late LoginBloc _loginBloc;
  @override
  void initState() {
    _loginBloc = LoginBloc(loginRepository: LoginRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // New welcome text
                Text(
                  'Welcome Back!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height * 0.01), // Spacing
                Text(
                  'Please login to your account',
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
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailureState) {
                      NotificationHelper.showErrorNotification(
                          context, state.error);
                    } else if (state is LoginSuccessState) {
                      NotificationHelper.showSuccessNotification(
                          context, state.message);
                      Future.delayed(const Duration(seconds: 1), () async {
                        await Storage().getUserData().then((value) {
                          if (value == null) {
                            Navigator.pushNamed(
                                context, PickProfileImage.routeName);
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                NavigationBarScreen.routeName,
                                (route) => false);
                          }
                        });
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
                      return Container(
                        width: width * 0.8,
                        height: height * 0.07,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                      );
                    }
                    return CustomButton(
                      width: width,
                      height: height,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _loginBloc.add(LoginFunctionEvent(
                              email: email.text, password: password.text));
                        }
                      },
                      text: 'Login',
                    );
                  },
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RegisterScreen.routeName, (route) => false);
                        },
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
        ),
      ),
    );
  }
}
