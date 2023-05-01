import 'dart:math';

import 'package:get/get.dart';
import 'package:mandeladrawing/controllers/authenticationmodels.dart';
import 'package:mandeladrawing/controllers/usercontroller.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final authRepo = Get.put(AuthRepo());
  final userrepo = Get.put(UserRepo());
  //fetch records query
  getUserData() {
    final email = authRepo.firebaseUser.value?.email;
    if (email != null) {
      return userrepo.getUserDetails(email);
    } else {
      //Get.snackbar("Error", "Login to Continue");
    }
  }
}
