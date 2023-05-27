// ignore_for_file: prefer_const_literals_to_create_immutables, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mandeladrawing/utils/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:mandeladrawing/view/authview/forgotpassword.dart';
import 'package:mandeladrawing/view/authview/signup.dart';
import 'package:mandeladrawing/view/dashboard.dart';
import 'package:mandeladrawing/widgets/mybutton.dart';
import 'package:mandeladrawing/widgets/textformfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../controllers/authenticationmodels.dart';
import '../../controllers/logincontroller.dart';
import '../../controllers/signupcontroller.dart';
import '../../methods/authmodels.dart';
import '../../models/loginviewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginViewModel loginVM = LoginViewModel();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isChecked = false;
  String _textFieldValue = '';
  //google signin
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      print('Signed in with Google: ${user!.displayName}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
      showToast('Signing Successful', Colors.green);
    } catch (e) {
      showToast('Failed to sign in with Google: $e', Colors.red);
    }
  }

  void showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
    );
  }

//function to handle checkbox
  void _handleCheckboxChanged(bool? checkboxState) {
    setState(() {
      _isChecked = checkboxState ?? true;
    });
  }

//function to store value in database
  void _handleTextFieldChanged(String value) {
    setState(() {
      _textFieldValue = value;
    });
  }

  void _showetoast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    double fontSize;

    // Adjust the font size based on the screen width
    if (screenWidth < 320) {
      fontSize = 10.0; // Small screen (e.g., iPhone 4S)
    } else if (screenWidth < 375) {
      fontSize = 13.0; // Medium screen (e.g., iPhone 6, 7, 8)
    } else if (screenWidth < 414) {
      fontSize = 14.0; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else if (screenWidth < 600) {
      fontSize = 15.0; // Large screen (e.g., iPhone 6 Plus, 7 Plus, 8 Plus)
    } else {
      fontSize = 20.0; // Extra large screen or unknown device
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appbar,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: Text(
            "Sign In ",
            style: TextStyle(fontSize: 26, color: appbartitle),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: Form(
              key: formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenheight / 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldInput(
                        validator: (value) {
                          if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onChanged: _handleTextFieldChanged,
                        action: TextInputAction.next,
                        textEditingController: _emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress),
                  ),
                  SizedBox(
                    height: screenheight / 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldInput(
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onChanged: _handleTextFieldChanged,
                        action: TextInputAction.next,
                        textEditingController: _passController,
                        hintText: "Password",
                        textInputType: TextInputType.emailAddress),
                  ),

                  SizedBox(
                    height: screenheight / 30,
                  ),
                  //remember me sec
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: _handleCheckboxChanged,
                            ),
                            Text(
                              "Remember Me ",
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ForgitPassword());
                          },
                          child: Text(
                            "FORGOT PASSWORD?",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: fontSize,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenheight / 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: MyCustomButton(
                        title: "Sign In ",
                        borderrad: 50,
                        onaction: () async {
                          if (formGlobalKey.currentState!.validate()) {
                            bool loggedIn = false;
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passController.text.trim(),
                              );
                              // User is signed in
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }

                            // loggedIn =
                            // await loginVM.login(
                            //     controller.email.text.trim(),
                            //     controller.pass.text.trim());
                            // if (loggedIn) {
                            print("ok");
                            Get.to(() => Home());
                            //   _showetoast("Sigin Successfully");
                            // } else {
                            //   _showetoast(loginVM.message);
                            // }
                          } else
                            _showetoast("Please enter valid pass or email");
                        },
                        color1: gd2,
                        color2: gd1,
                        width: MediaQuery.of(context).size.width - 40),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("or"),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          void _showetoast(String message) {
                            Fluttertoast.showToast(
                              msg: "FaceBook is not allowing to authenticate",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }

                          ;
                        },
                        child: Image(
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                            image: AssetImage('assets/facebook.png')),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: signInWithGoogle,
                        child: Image(
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                            image: AssetImage('assets/google.png')),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Accound?",
                          style: TextStyle(
                            fontSize: fontSize,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignupPage());
                          },
                          child: Text(
                            "Create new one",
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
