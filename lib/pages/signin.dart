// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/database.dart';
import 'package:flutter_chat/pages/signup.dart';
import 'package:flutter_chat/shared.dart';
import 'package:flutter_chat/pages/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_chat/database.dart';

class signinView extends StatefulWidget {
  const signinView({super.key});

  @override
  State<signinView> createState() => _signinViewState();
}

class _signinViewState extends State<signinView> {
  String email = "", password = "", name = "", pic = "", username = "", id = "";
  TextEditingController userEmailController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  UserLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      QuerySnapshot querySnapshot =
          await DatabaseMethods().getUserbyemail(email);
      name = "${querySnapshot.docs[0]["Name"]}";
      username = "${querySnapshot.docs[0]["username"]}";
      pic = "${querySnapshot.docs[0]["Photo"]}";
      id = querySnapshot.docs[0].id;

      await SharedPreferenceHelper().saveUserDisplayName(name);
      await SharedPreferenceHelper().saveUserName(username);
      await SharedPreferenceHelper().saveUserId(id);
      await SharedPreferenceHelper().saveUserPic(pic);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0x00f28750),
                    Color.fromARGB(255, 219, 110, 9),
                    Color.fromARGB(255, 248, 115, 6)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 105.0))),
            ),

            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 100.0),
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black, width: 0.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(3, 3),
                              )
                            ]),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20.0),
                                child: const Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                height: MediaQuery.of(context).size.height / 13,
                                width: MediaQuery.of(context).size.width / 1.4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1.0),
                                    borderRadius: BorderRadius.circular(10)),

                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.mail_outline,
                                        color: Color.fromARGB(255, 219, 110, 9),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 6.5)),
                                  controller: userEmailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Email!';
                                    }
                                    return null;
                                  },
                                ),

                                // decoration: BoxDecoration(
                                //   border: Border.all(width: 0.5),
                                //   color: Colors.black38,
                                // ),
                                // child: const TextField(
                                //   decoration: InputDecoration(border: InputBorder.none),
                                // ),
                                // decoration: BoxDecoration(
                                //   border: Border.all(width: 1.0, color: Colors.black),
                                //   borderRadius: BorderRadius.circular(8),
                                // ),
                                // height: 50.0,
                                // width: 250.0,
                                // // child: const TextField(
                                // //   decoration: InputDecoration(),
                                // // ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 20.0),
                                child: const Text(
                                  "Password",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                height: MediaQuery.of(context).size.height / 13,
                                width: MediaQuery.of(context).size.width / 1.4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1.0),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: Color.fromARGB(255, 219, 110, 9),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 6.5)),
                                  obscureText: true,
                                  controller: userPasswordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 130, top: 20),
                                child: showAlertDialog(),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 105.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 219, 110, 9),
                                        onPrimary:
                                            Color.fromARGB(255, 228, 216, 48)),
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        setState(() {
                                          email = userEmailController.text;
                                          password =
                                              userPasswordController.text;
                                        });
                                      }
                                      UserLogin();
                                    },
                                    child: const Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 50, right: 50),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: const Color.fromARGB(
                                              255, 158, 158, 158),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          'or',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 158, 158, 158),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Color.fromARGB(
                                              255, 158, 158, 158),
                                        ),
                                      ),
                                    ]),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.1),
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      child: SvgPicture.asset(
                                        'assets/images/facebook.svg',
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 55,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.1),
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      child: SvgPicture.asset(
                                        'assets/images/google.svg',
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.1),
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      child: SvgPicture.asset(
                                        'assets/images/apple.svg',
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ), //form login
            Container(
              padding: EdgeInsets.only(left: 60, top: 510),
              child: Center(
                child: Row(children: [
                  Expanded(
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => signup()));
                      },
                      child: Text(
                        "Sign Up Now",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.normal,
                            fontSize: 10.0),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class showAlertDialog extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  String email = "";
  final _formkey = GlobalKey<FormState>();
  TextEditingController userEmailController = new TextEditingController();

  showAlertDialog({super.key});

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
          content: Text(
        "Password Reset Email has been sent",
        style: TextStyle(fontSize: 18),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
            content: Text(
          "No User found for that email.",
          style: TextStyle(fontSize: 18.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(children: [
                    Center(
                      // padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                    Form(
                      key: _formkey,
                      child: Center(
                        child: Container(
                          // margin: EdgeInsets.only(left: 20.0),
                          height: MediaQuery.of(context).size.height / 13,
                          width: MediaQuery.of(context).size.width / 1.4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1.0),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: userEmailController,
                            validator: (ValueKey) {
                              if (ValueKey == null || ValueKey.isEmpty) {
                                return 'Please Enter your E-mail';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                  color: Color.fromARGB(255, 219, 110, 9),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 6.5)),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        // padding: const EdgeInsets.only(top: 10.0, left: 105.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 219, 110, 9),
                                onPrimary: Color.fromARGB(255, 228, 216, 48)),
                            onPressed: () {
                              if(_formkey.currentState!.validate()){
                                    setState(() {
                                     
                                    });
                                    resetPassword();
                                  }
                            },
                            child: const Text(
                              "Send Email",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            )),
                      ),
                    ),
                  ]),
                ),
              )),
      child: const Text(
        "Forgot Password?",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
    );
  }
  
  void setState(Null Function() param0) {
     email= userEmailController.text;
  }
}
