// import 'package:flutter/widgets.dart';
// import 'package:flutter/foundation.dart';
// import 'package:mandeladrawing/models/usermodel.dart';

// import '../models/authmodels.dart';

// class UserProvider with ChangeNotifier {
//   UserModel? _user;

//   final FirebaseAuthMethod _authMethods = FirebaseAuthMethod();

//   get getUser {
//     return _user;
//   }

//   Future<void> refreshUser() async {
//     UserModel user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }
// }
