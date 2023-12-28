import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/database.dart';
import 'package:flutter_chat/pages/home.dart';
import 'package:flutter_chat/shared.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter_chat/pages/signin.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String email = "", password = "", confirmPassword = "", name = "";
  TextEditingController mailcontronller = new TextEditingController();
  TextEditingController passwordcontronller = new TextEditingController();
  TextEditingController confirmPasswordcontronller =
      new TextEditingController();
  TextEditingController namecontronller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String Id = randomAlphaNumeric(10);
        String user = mailcontronller.text.replaceAll("@gmail.com", "");
        String updateusername =
            user.replaceFirst(user[0], user[0].toUpperCase());
        String firstletter = user.substring(0, 1).toUpperCase();
        Map<String, dynamic> userInforMap = {
          "Name": namecontronller.text,
          "E-mail": mailcontronller.text,
          "username": updateusername.toUpperCase(),
          "SearchKey": firstletter,
          "Photo":
              "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75b34a",
          "Id": Id,
        };
        await DatabaseMethods().addUserDetails(userInforMap, Id);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper()
            .saveUserDisplayName(namecontronller.text);
        await SharedPreferenceHelper().saveUserEmail(mailcontronller.text);
        await SharedPreferenceHelper().saveUserPic(
            "https://firebasestorage.googleapis.com/v0/b/barberapp-ebcc1.appspot.com/o/icon1.png?alt=media&token=0fad24a5-a01b-4d67-b4a0-676fbc75b34a");
        await SharedPreferenceHelper().saveUserName(
            mailcontronller.text.replaceAll("@gmail.com", "").toUpperCase());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Registered Succesfully",
          style: TextStyle(fontSize: 20),
        )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => signinView()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weed-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Password Provider is too Weak",
            style: TextStyle(fontSize: 18),
          )));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account already exist",
                style: TextStyle(fontSize: 18),
              )));
        }
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
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => signinView()));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 60, left: 20),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                ),
              ),
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
                          "SIGN UP",
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
                                padding:
                                    const EdgeInsets.only(top: 5.0, left: 20.0),
                                child: const Text(
                                  "Name",
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
                                  controller: namecontronller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: Color.fromARGB(255, 219, 110, 9),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 6.5)),
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
                                  controller: mailcontronller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter E-mail';
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
                                  controller: passwordcontronller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: Color.fromARGB(255, 219, 110, 9),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 6.5)),
                                  obscureText: true,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 20.0),
                                child: const Text(
                                  "Confirm Password",
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
                                  controller: confirmPasswordcontronller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Confirm Password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.password,
                                        color: Color.fromARGB(255, 219, 110, 9),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 6.5)),
                                  obscureText: true,
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     if (_formkey.currentState!.validate()) {
                              //       setState(() {
                              //         email = mailcontronller.text;
                              //         name = namecontronller.text;
                              //         password = passwordcontronller.text;
                              //         confirmPassword =
                              //             confirmPasswordcontronller.text;
                              //       });
                              //     }
                              //     registration();
                              //   },

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
                                          email = mailcontronller.text;
                                          name = namecontronller.text;
                                          password = passwordcontronller.text;
                                          confirmPassword =
                                              confirmPasswordcontronller.text;
                                        });
                                      }
                                      registration();
                                    },
                                    child: const Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    )),
                              ),

                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ), //form login
          ],
        ),
      ),
    );
  }
}
