import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jobless/model/user_model.dart';
import 'package:jobless/providers/auth/auth_provider.dart';
import 'package:jobless/providers/user/user_provider.dart';
import 'package:jobless/theme.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController goalController = TextEditingController(text: '');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    void showError(String message){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(message)));
    }

    var authProvider = Provider.of<AuthProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign Up', style: greyTextStyle.copyWith(fontSize: 16.0)),
                SizedBox(height: 4.0),
                Text(
                  'Begin New Journey',
                  style: blackTextStyle.copyWith(
                      fontSize: 24.0, fontWeight: FontWeight.w600),
                ),
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/image_profile.png'),
                      )),
                ),
                Text(
                  'Full Name',
                  style: greyTextStyle.copyWith(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: nameController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 26.0, vertical: 20.0),
                      fillColor: formColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: primaryColor)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: ''),
                  style: greenTextStyle,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Email',
                  style: greyTextStyle.copyWith(fontSize: 16.0),
                ),
                TextFormField(

                    controller: emailController,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 26.0, vertical: 20.0),
                        fillColor: formColor,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                              color: EmailValidator.validate(emailController.text)
                                  ? primaryColor
                                  : Colors.red),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                              color: EmailValidator.validate(emailController.text)
                                  ? primaryColor
                                  : Colors.red),
                        ),
                        hintText: ''),
                    style: EmailValidator.validate(emailController.text)
                        ? greenTextStyle
                        : redTextStyle),
                SizedBox(height: 20.0),
                Text('Password', style: greyTextStyle.copyWith(fontSize: 16.0)),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 26.0, vertical: 20.0),
                      fillColor: formColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: primaryColor)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: ''),
                  style: greenTextStyle,
                ),
                Text('Your Goal', style: greyTextStyle.copyWith(fontSize: 16.0)),
                TextFormField(
                  controller: goalController,
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 26.0, vertical: 20.0),
                      fillColor: formColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: primaryColor)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: ''),
                  style: greenTextStyle,
                ),
                SizedBox(height: 40.0),
                Container(
                  width: double.infinity,
                  height: 45.0,

                  child: isLoading ? Center(child: CircularProgressIndicator())
                    : TextButton(
                      onPressed: () async {
                        if(nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            goalController.text.isEmpty){
                          showError('Data cannot be empty');
                        }else{
                          setState(() {
                            isLoading = true;
                          });
                        UserModel user = await authProvider.register(
                            emailController.text, passwordController.text, nameController.text, goalController.text);
                        setState(() {
                          isLoading = false;
                        });
                        if(user == null){
                            showError('Wrong Data');
                        }else{
                            userProvider.user = user;
                            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);}
                        }
                        },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(65.0),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: whiteTextStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                SizedBox(height: 20.0),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);},
                      child: Text('Back To Sign In',
                          style:
                              greyTextStyle.copyWith(fontWeight: FontWeight.w300))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
