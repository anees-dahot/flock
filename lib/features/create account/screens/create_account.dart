import 'package:flock/core/widgets/custom_button.dart';
import 'package:flock/core/widgets/text_fields.dart';
import 'package:flock/features/create%20account/blocs/create%20account%20bloc/create_account_bloc.dart';
import 'package:flock/features/create%20account/repository/create_account_repository.dart';
import 'package:flock/features/create%20account/screens/suggested_friends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/flush_message.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName = 'create-accounnt';
  const CreateAccount({
    super.key,
    required this.profileImage,
    required this.profileCover,
  });
  final String profileImage;
  final String profileCover;
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();
  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController bio = TextEditingController();
  late CreateAccountBloc _createAccountBloc;

  @override
  void initState() {
    _createAccountBloc = CreateAccountBloc(CreateAccountRepository());
    print(widget.profileCover);
    print(widget.profileImage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => _createAccountBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Account',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                      controller: fullName,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      hintText: 'Full Name'),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                      controller: userName,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Please enter your user name';
                        }
                        return null;
                      },
                      hintText: 'User Name'),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                      controller: bio,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Please enter your Bio';
                        }
                        return null;
                      },
                      hintText: 'Bio'),
                  SizedBox(height: height * 0.02),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Container(
                        width: width * 0.9,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
                                child: Text(
                                  _selectedDate != null
                                      ? _selectedDate.toString()
                                      : 'Date of Birth',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ))),
                      )),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                      controller: phoneNumber,
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      hintText: 'Phone Number'),
                  SizedBox(height: height * 0.05),
                  BlocConsumer<CreateAccountBloc, CreateAccountState>(
                    listener: (context, state) {
                      if (state is CreateAccountFailureState) {
                        NotificationHelper.showErrorNotification(
                            context, state.error);
                      } else if (state is CreateAccountSuccessState) {
                        NotificationHelper.showSuccessNotification(
                            context, state.message);
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pushNamed(
                              context, SuggestedFriends.routeName);
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateAccountLoadingState) {
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
                              _createAccountBloc.add(
                                CreateAccountFunction(
                                  fullName: fullName.text,
                                  userName: userName.text,
                                  profileImage: widget.profileImage,
                                  bio: bio.text,
                                  dateOfBirth: _selectedDate!,
                                  phoneNumber: int.parse(phoneNumber.text),
                                ),
                              );
                            }
                          },
                          text: 'Create Account');
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
