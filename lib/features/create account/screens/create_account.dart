import 'package:flock/core/widgets/custom_button.dart';
import 'package:flock/core/widgets/text_fields.dart';
import 'package:flock/features/create%20account/screens/suggested_friends.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName = 'create-accounnt';
  const CreateAccount({super.key, required this.image});
  final String image;
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController bio = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                             _selectedDate != null ?  _selectedDate.toString() : 'Date of Birth',
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
                CustomButton(
                    width: width,
                    height: height,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context)
                            .pushNamed(SuggestedFriends.routeName);
                      }
                    },
                    text: 'Create Account')
              ],
            )),
      ),
    );
  }
}
