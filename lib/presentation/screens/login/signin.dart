import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibehunt/presentation/screens/home/home_screen.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:vibehunt/presentation/widgets/custom_buttons.dart';
import 'package:vibehunt/presentation/widgets/custom_snackbar.dart';
import 'package:vibehunt/utils/constants.dart';
import 'package:vibehunt/presentation/screens/login/signup.dart';
import 'package:vibehunt/presentation/widgets/main_button.dart';
import 'package:vibehunt/presentation/widgets/textfield.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccesState) {
            customSnackbar(context, 'welcome back', kGreen, Icons.done);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }),
              (Route<dynamic> route) => false,
            );
          } else if (state is SignInErrorState) {
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
                    const SizedBox(height: 70),
                    Image.asset(
                      'assets/logo/vibehunt logo.png',
                      width: 500,
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Getting Started.!',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
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
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ).hasMatch(value)) {
                          return 'Enter a valid Gmail address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MyTextfield(
                      controller: passwordController,
                      hintText: 'Your password',
                      obscureText: true,
                      maxline: 1,
                      prefixIcon: const Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!value.contains(RegExp(r'[^\w]'))) {
                          return 'Password must contain at least one non-alphabetic character';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        if (state is SignInLoadingState) {
                          return loadingButton(
                            media: media,
                            onPressed: () {},
                            color: kGreen,
                          );
                        }
                        return MyButton(
                          text: 'Sign In',
                          onPressed: () async{
                            if (_formKey.currentState!.validate()) {
                                  context.read<SignInBloc>().add(
                                      SignInButtonClickEvent(
                                          email: emailController.text,
                                          password: passwordController.text));
                                } else {
                                  customSnackbar(
                                      context, 'Fill All Fields', kRed,Icons.fast_forward);
                                }

                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Or Continue with',
                      style: jStyleW,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Define your onTap action here
                        },
                        child: Container(
                          width: 55, // Width of the round button
                          height: 55, // Height of the round button
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle, // Make it circular
                            color:
                                Colors.white, // Background color of the button
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/google.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dont have any account?',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
