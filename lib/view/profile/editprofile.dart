import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/mycolors.dart';
import '../../widgets/mybutton.dart';
import '../../widgets/textformfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appbar,
        leading: const Icon(
          CupertinoIcons.left_chevron,
          color: Colors.black,
          size: 30,
        ),
        title: const Text(
          "Hi, Abc",
          style: TextStyle(fontSize: 26, color: appbartitle),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(
              CupertinoIcons.settings,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/dp.jpg'),
                  ),
                  Positioned(
                      bottom: -5,
                      left: 110,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.photo_camera,
                            size: 30,
                          )))
                ]),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFieldInput(
                validator: (value) {
                  if (value.length < 2) {
                    return 'Enter a valid name';
                  }
                  return null;
                },
                textEditingController: _lastnameController,
                hintText: "Abc",
                textInputType: TextInputType.emailAddress,
                action: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                validator: (value) {
                  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                textEditingController: _emailController,
                hintText: "abc@gmail.com",
                textInputType: TextInputType.emailAddress,
                action: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                validator: (value) {
                  if (value.length < 11) {
                    return 'Enter a valid phone num';
                  }
                  return null;
                },
                textEditingController: _mobilecontroller,
                hintText: "2567388929",
                textInputType: TextInputType.emailAddress,
                action: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              TextFieldInput(
                validator: (value) {
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                isPass: true,
                textEditingController: _passController,
                hintText: "*********",
                textInputType: TextInputType.emailAddress,
                action: TextInputAction.next,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyCustomButton(
                        title: "Cancel",
                        borderrad: 25,
                        onaction: () {
                          Navigator.pop(context);
                        },
                        color1: red,
                        color2: red,
                        width: MediaQuery.of(context).size.width),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: MyCustomButton(
                        title: "Save",
                        borderrad: 25,
                        onaction: () {},
                        color1: green,
                        color2: green,
                        width: MediaQuery.of(context).size.width),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
