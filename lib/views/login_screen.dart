import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weigth_tracker/helping_material/helping_material.dart';
import 'package:weigth_tracker/helping_material/scalling.dart';
import 'package:weigth_tracker/network/firebase.dart';
import 'package:weigth_tracker/widgets/button.dart';
import 'package:weigth_tracker/widgets/textfield_class.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showpassword = false;
  bool obscureText = true;
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? password = '';
  bool _validate = false;
  bool loading = false;
  bool screenDisable = false;

  @override
  Widget build(BuildContext context) {
    init(context);
    return AbsorbPointer(
      absorbing: screenDisable,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          height: screenHeight,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(10)),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height(50),bottom: height(20)),
                      child: SimpleText('Sign In',
                          color: Colors.black,
                          roboto: true,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                    TextFieldClass(
                      'Email',
                      'Enter your email',
                      image: 'assets/mail.svg',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailCtr,
                      isEmail: true,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height(10)),
                      child: TextFormField(
                        controller: passwordCtr,
                        cursorColor: Colors.black,
                        obscureText: obscureText,
                        obscuringCharacter: '*',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          contentPadding: EdgeInsets.only(top: 5),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                if (showpassword) {
                                  obscureText = true;
                                  showpassword = false;
                                } else {
                                  obscureText = false;
                                  showpassword = true;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(showpassword
                                  ? 'assets/hide_password.svg'
                                  : 'assets/show_password.svg'),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password';
                          } else if (value.length < 6) {
                            return 'Length of password should be greater than 6';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          password = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height(30)),
                      child: loading
                          ? CircularIndicatorBar()
                          : Button(
                          'Login',
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (_formkey.currentState!.validate() ){
                              var res=await signInWithEmailAndPassword(
                                  email: emailCtr.text.trim(),
                                  password: passwordCtr.text.trim());
                            }

                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
