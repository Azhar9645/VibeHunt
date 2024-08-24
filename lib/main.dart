import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibehunt/firebase_options.dart';
import 'package:vibehunt/presentation/screens/login/signin.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/otp_verification/otp_verification_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:vibehunt/presentation/viewmodel/bloc/sign_up_bloc/sign_up_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.setLanguageCode('en');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => OtpVerificationBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VibeHunt',
        theme: ThemeData(
          scaffoldBackgroundColor:
              Colors.black, // Set the background color to black
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark, // Use dark mode for the entire app
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor:
                Colors.black, // Set AppBar background color to black
            iconTheme: IconThemeData(
              color: Colors.white, // Set AppBar icon color to white
            ),
          ),
          textTheme: TextTheme(
            displayLarge: GoogleFonts.jost(fontSize: 24, color: Colors.white),
            titleMedium: GoogleFonts.jost(fontSize: 18, color: Colors.white),
            bodyLarge: GoogleFonts.mulish(fontSize: 16, color: Colors.white),
            bodyMedium: GoogleFonts.mulish(fontSize: 14, color: Colors.white),
            // Define more styles as needed
          ),
          useMaterial3: true,
        ),
        home: SignInScreen(),
      ),
    );
  }
}
