import 'package:flutter/material.dart';
import 'package:jobless/providers/auth/auth_provider.dart';
import 'package:jobless/providers/user/user_provider.dart';
import 'package:jobless/view/home_screen.dart';
import 'package:jobless/view/onboarding_screen.dart';
import 'package:jobless/view/signin_screen.dart';
import 'package:jobless/view/signup_screen.dart';
import 'package:jobless/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(JoblessApp());

class JoblessApp extends StatelessWidget {
  const JoblessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
    ],

    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' :(context) => SplashScreen(),
        '/onBoarding' :(context) => OnBoardingScreen(),
        '/signup' :(context) => SignUpScreen(),
        '/signin' :(context) => SigninScreen(),
        '/home' : (context) => HomeScreen()
      },
    ),
    );

  }
}

