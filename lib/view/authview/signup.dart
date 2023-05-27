// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mandeladrawing/view/plans/showmainpage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandeladrawing/models/usermodel.dart';
import 'package:mandeladrawing/view/dashboard.dart';
import 'package:mandeladrawing/view/profile/profileview.dart';
import 'package:mandeladrawing/widgets/pickimages.dart';
import 'package:mandeladrawing/widgets/textformfield.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/signupcontroller.dart';
import '../../methods/authmodels.dart';
import '../../models/registeruserviewmodel.dart';
import '../../utils/mycolors.dart';
import '../../widgets/mybutton.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  File? _selectedImage;
  String? _imageUrl;
  RegisterViewModel registerVM = RegisterViewModel();
  //controllers for managing data
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  Uint8List? _image;

//key for handling auth
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  bool _isSigningUp = false;
  final RegisterViewModel _registerVM = RegisterViewModel();

  bool _isChecked = false;
  String? _errorMessage;

  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
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
    _mobilecontroller.dispose();
    _lastnameController.dispose();
    _fnameController.dispose();
    super.dispose();
  }

  String ErrorMessage = "";

//function to select image of user
  void selectimage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.width;
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
    final controller = Get.put(SignupController());
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: appbar,

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
            "Sign Up ",
            style: TextStyle(fontSize: 26, color: appbartitle),
          ),
        ),
        // resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Form(
            key: formGlobalKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenheight / 8,
                  ),
                  Center(
                    child: Stack(children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  AssetImage('assets/blankimage.jpg'),
                            ),
                      Positioned(
                          bottom: -10,
                          left: 75,
                          child: IconButton(
                              onPressed: () {
                                selectimage();
                              },
                              icon: Icon(
                                CupertinoIcons.add_circled,
                                size: 30,
                                color: Colors.black,
                              )))
                    ]),
                  ),
                  SizedBox(
                    height: screenheight / 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldInput(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter your name";
                        }
                        return null;
                      },
                      //textEditingController: controller.fname,

                      textEditingController: controller.fname,
                      hintText: "First Name*",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: screenheight / 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your name";
                        }
                        return null;
                      },
                      textEditingController: controller.lname,
                      hintText: "Last Name*",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: screenheight / 25,
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
                      textEditingController: controller.email,
                      hintText: "Email Address*",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    height: screenheight / 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      inputBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),

                        borderRadius:
                            BorderRadius.circular(50), // Set border radius here
                      ),
                      inputDecoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),

                          borderRadius: BorderRadius.circular(
                              50), // Set border radius here
                        ),
                        hintText: "Number",
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(
                              50), // Set border radius here
                        ),
                        filled: true,
                        fillColor: const Color(0xffeceff6),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: _mobilecontroller,
                      formatInput: true,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),

                  SizedBox(
                    height: screenheight / 25,
                  ),
                  // TextFieldInput(
                  //   validator: (value) {
                  //     if (value.length < 11) {
                  //       return "Enter a valid number";
                  //     }
                  //     return null;
                  //   },
                  //   textEditingController: controller.phone,
                  //   hintText: "Mobile Number*",
                  //   textInputType: TextInputType.number,
                  //   action: TextInputAction.next,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldInput(
                      validator: (value) {
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      textEditingController: controller.pass,
                      hintText: "Password",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: _onCheckboxChanged,
                        ),
                        Text(
                          "I accept all terms and conditions ",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  // InkWell(
                  //   onTap: _isSigningUp
                  //       ? null
                  //       : () async {
                  //           if (formGlobalKey.currentState!.validate()) {
                  //             setState(() {
                  //               _isSigningUp = true;
                  //             });
                  //             // call Firebase function to sign up user
                  //             bool isRegistered = false;
                  //             isRegistered = await _registerVM.register(
                  //                 _emailController.text.trim(),
                  //                 _passController.text.trim(),
                  //                 _fnameController.text.trim(),
                  //                 _lastnameController.text.trim(),
                  //                 _mobilecontroller.text.trim());
                  //             if (isRegistered) {
                  //               var userId =
                  //                   FirebaseAuth.instance.currentUser!.uid;
                  //               await FirebaseFirestore.instance
                  //                   .collection("UsersData")
                  //                   .doc(userId)
                  //                   .set({
                  //                 "First Name": _fnameController.text.trim(),
                  //                 "Last Name": _lastnameController.text.trim(),
                  //                 "Email": _emailController.text.trim(),
                  //                 "Mobile": _mobilecontroller.text.trim()
                  //               });
                  //               Navigator.pushAndRemoveUntil(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (ctx) => const Home()),
                  //                   (Route<dynamic> route) => false);
                  //             }
                  //           }
                  //         },
                  //   child: Container(
                  //     height: 60,
                  //     width: 300,
                  //     decoration: BoxDecoration(
                  //         gradient: LinearGradient(
                  //           colors: [gd2, gd1],
                  //         ),
                  //         borderRadius: BorderRadius.circular(20)),
                  //     child: Center(
                  //       child: _isSigningUp
                  //           ? const CircularProgressIndicator()
                  //           : const Text(
                  //               'Sign Up',
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //     ),
                  //   ),
                  // ),
                  // ElevatedButton(
                  //   onPressed: _isSigningUp
                  //       ? null
                  //       : () async {
                  //           if (formGlobalKey.currentState!.validate()) {
                  //             setState(() {
                  //               _isSigningUp = true;
                  //             });
                  //             // call Firebase function to sign up user
                  //             bool isRegistered = false;
                  //             isRegistered = await _registerVM.register(
                  //                 _emailController.text.trim(),
                  //                 _passController.text.trim(),
                  //                 _fnameController.text.trim(),
                  //                 _lastnameController.text.trim(),
                  //                 _mobilecontroller.text.trim());
                  //             if (isRegistered) {
                  //               print("register");
                  //               var userId =
                  //                   FirebaseAuth.instance.currentUser!.uid;
                  //               await FirebaseFirestore.instance
                  //                   .collection("UsersData")
                  //                   .doc(userId)
                  //                   .set({
                  //                 "First Name": _fnameController.text.trim(),
                  //                 "Last Name": _lastnameController.text.trim(),
                  //                 "Email": _emailController.text.trim()
                  //               });

                  //               print("user is stored");
                  //               Navigator.pushAndRemoveUntil(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (ctx) => const Home()),
                  //                   (Route<dynamic> route) => false);
                  //             } else {
                  //               print(_registerVM.message);
                  //             }
                  //           }
                  //         },
                  //   child: _isSigningUp
                  //       ? const CircularProgressIndicator()
                  //       : const Text('Sign Up'),
                  // ),

                  SizedBox(
                    height: screenheight / 10,
                  ),
                  MyCustomButton(
                      title: "Sign Up ",
                      borderrad: 50,
                      onaction: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          if (_isChecked == true) {
                            final user = UserModel(
                                email: controller.email.text.trim(),
                                fname: controller.fname.text.toString(),
                                lname: controller.lname.text.trim(),
                                pass: controller.pass.text.trim(),
                                phone: controller.phone.text.trim());
                            bool isRegistered = false;
                            isRegistered = await registerVM.register(
                                controller.phone.text.trim(),
                                controller.email.text.trim(),
                                controller.pass.text.trim(),
                                controller.fname.text.toString(),
                                controller.lname.text.trim());
                            if (isRegistered) {
                              final userId =
                                  FirebaseAuth.instance.currentUser!.uid;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userId)
                                  .set(user.toJson())
                                  .whenComplete(() => Get.snackbar("Success",
                                      "Your Account has been successfuly created",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:
                                          Colors.green.withOpacity(0.6),
                                      colorText: Colors.white))
                                  .catchError((error, stackTrace) {
                                Get.snackbar("Error",
                                    "Something went wrong. Please try again",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        Colors.red.withOpacity(0.1),
                                    colorText: Colors.white);
                              });
                            }

                            Get.to(() => ShowingMainPage());
                          }
                          print(controller.email);
                        }
                      },
                      color1: gd2,
                      color2: gd1,
                      width: MediaQuery.of(context).size.width - 40),
                  SizedBox(
                    height: screenheight / 20,
                  ),
                  SizedBox(
                    height: screenheight / 18,
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Image(
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                            image: AssetImage('assets/facebook.png')),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            final googleSignIn = GoogleSignIn();
                            final googleUser = await googleSignIn.signIn();
                            final googleAuth = await googleUser!.authentication;

                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth.accessToken,
                              idToken: googleAuth.idToken,
                            );

                            final userCredential = await FirebaseAuth.instance
                                .signInWithCredential(credential);

                            final user = userCredential.user;
                            final displayName = user!.displayName;
                            final email = user.email;
                            final phone = user.phoneNumber;
                            //ssave data in firestore
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .set({
                              'First Name': displayName,
                              'Email': email,
                              'Phone': phone
                              // Add more fields as needed
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => ShowingMainPage()));
                            Get.to(() => ShowingMainPage());
                          } catch (e) {
                            if (e is FirebaseAuthException) {
                              if (e.code ==
                                  'account-exists-with-different-credential') {
                                _showetoast(
                                    'An account with the same email already exists');
                              } else {
                                _showetoast(
                                    'Failed to sign up with Google: ${e.message}');
                              }
                            } else {
                              _showetoast('Failed to sign up with Google: $e');
                            }
                          }
                        },
                        child: Image(
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                            image: AssetImage('assets/google.png')),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
