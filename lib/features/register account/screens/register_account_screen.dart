import 'package:flock/core/widgets/custom_button.dart';
import 'package:flock/core/widgets/text_fields.dart';
import 'package:flock/features/register%20account/bloc/register_account_bloc.dart';
import 'package:flock/features/register%20account/repository/register_account_repository.dart';
import 'package:flock/utils/flush_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register-screen';
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late RegisterAccountBloc _registerAccountBloc;

  @override
  void initState() {
    _registerAccountBloc = RegisterAccountBloc(RegisterAccountRepository());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => _registerAccountBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
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
              BlocConsumer<RegisterAccountBloc, RegisterAccountState>(
                listenWhen: (previous, current) => current != previous,
                listener: (context, state) {
                  if (state is RegisterAccountFailureState) {
                    NotificationHelper.showErrorNotification(
                        context, state.error);
                  } else if (state is RegisterAccountSuccessState) {
                    NotificationHelper.showSuccessNotification(
                        context, state.message);
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is RegisterAccountLoadingState) {
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
                        _registerAccountBloc.add(RegisterAccountFunction(
                            email: email.text, password: password.text));
                      }
                    },
                    text: 'Register',
                  );
                },
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
      ),
    );
  }
}
