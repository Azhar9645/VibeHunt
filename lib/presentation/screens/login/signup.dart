import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/data/models/user_model.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/presentation/screens/login/otp_screen.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fill Your Profile',
          style: j24,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccesState) {
            customSnackbar(context, 'sucess', kGreen, Icons.gpp_good);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => OTPScreen(
                  email: emailController.text,
                  user: UserModel(
                      userName: nameController.text,
                      password: passwordController.text,
                      phoneNumber: phoneController.text,
                      emailId: emailController.text),
                ),
              ),
            );
          } else if (state is SignUpErrorState) {
            customSnackbar(context, state.error, kRed, Icons.error);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'Welcome!',
                      style: j20,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Please create your account here',
                      style: jStyleW,
                    ),
                    const SizedBox(height: 50),
                    MyTextfield(
                      controller: nameController,
                      hintText: 'First Name',
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First name is required';
                        }

                        if (value.length < 5) {
                          return 'First name must be at least 5 characters';
                        }

                        return null;
                      },
                      maxline: 1,
                    ),
                    const SizedBox(height: 20),
                    MyTextfield(
                      controller: emailController,
                      hintText: 'abc@email.com',
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }

                        return null;
                      },
                      maxline: 1,
                    ),
                    const SizedBox(height: 20),
                    MyTextfield(
                      controller:
                          phoneController, // Use a separate controller for phone number
                      hintText: 'Enter your phone number',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      keyboardType:
                          TextInputType.phone, // Set keyboard type to phone
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
                          return 'phone number';
                        }
                        return null;
                      },
                      maxline: 1,
                    ),
                    const SizedBox(height: 20),
                    MyTextfield(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value.contains(RegExp(r'[^\w]'))) {
                          return 'Password must contain at least one non-alphabetic character';
                        }
                        return null;
                      },
                      maxline: 1,
                    ),
                    const SizedBox(height: 20),
                    MyTextfield(
                      controller: confirmpasswordController,
                      hintText: 'Confirm password',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value.contains(RegExp(r'[^\w]'))) {
                          return 'Password must contain at least one non-alphabetic character';
                        }
                        return null;
                      },
                      maxline: 1,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpLoadingSate) {
                              return loadingButton(
                                  media: media,
                                  onPressed: () {},
                                  color: kGreen);
                            }
                        return MyButton(
                          text: 'Confirm',
                          onPressed: () async{
                            print("Email: ${emailController.text}");
                            if (passwordController.text ==
                                      confirmpasswordController.text) {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<SignUpBloc>().add(
                                          SignupButtonClicked(
                                              userName:
                                                  nameController.text,
                                              password:
                                                  passwordController.text,
                                              phoneNumber:
                                                  phoneController.text,
                                              email: emailController.text));
                                    } else {
                                      customSnackbar(
                                          context, 'Fill All Fields', kRed,Icons.error);
                                    }
                                    
                                  } else {
                                    customSnackbar(
                                        context, 'Password miss match', kRed,Icons.done);
                                  }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
