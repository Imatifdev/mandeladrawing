import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/controllers/usercontroller.dart';
import 'package:mandeladrawing/models/usermodel.dart';

import 'authenticationmodels.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final email = TextEditingController();

  final pass = TextEditingController();
  final userrepo = Get.put(UserRepo());
  void LoginUser(String email, String pass) {
    //String? error =
    AuthRepo.instance.loginWithEmailAndPassword(email, pass);
    //as String?;
    // if (error != null) {
    //   Get.showSnackbar(GetSnackBar(message: error.toString()));
    // }
  }

  Future<void> createUser(UserModel user) async {
    await userrepo.createUser(user);
  }
}
