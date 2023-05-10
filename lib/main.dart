// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/models/colorpalletemodel.dart';
import 'package:mandeladrawing/view/authview/signup.dart';
import 'package:mandeladrawing/view/colorpannel/colorslistpage.dart';
import 'package:mandeladrawing/view/colorpannel/createpalette.dart';
import 'package:mandeladrawing/view/colorpannel/detailmandela.dart';
import 'package:mandeladrawing/view/colorpannel/imagetexture.dart';
import 'package:mandeladrawing/view/colorpannel/selectmandelas.dart';
import 'package:mandeladrawing/view/createpannel/drawpage.dart';
import 'package:mandeladrawing/view/plans/showmainpage.dart';
import 'package:mandeladrawing/view/plans/showplans.dart';
import 'package:mandeladrawing/view/plans/stripepayment.dart';
import 'package:mandeladrawing/view/splash.dart';
import 'package:mandeladrawing/widgets/create.dart';
import 'package:mandeladrawing/view/profile/profileview.dart';
import 'package:mandeladrawing/view/settings/settingsscreen.dart';
import 'package:mandeladrawing/view/authview/login.dart';
import 'package:mandeladrawing/view/colorpannel/animal.dart';
import 'package:mandeladrawing/view/colorpannel/viewmandelas.dart';
import 'package:mandeladrawing/view/dashboard.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'checkscreen.dart';
import 'controllers/authenticationmodels.dart';
import 'firebase_options.dart';
import 'my.dart';
import 'my2.dart';
import 'package:stripe_android/stripe_android.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51N3ozXKuYtdF845ofkT3mnJPklviwqoYWXmh4rBRta7f4ULTStn7H5FPUizInnktKg2yDp2YdeiU9liipwYjv8hj00OyAY8oAp';

//  await Stripe.instance.applySettings();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(() => AuthRepo()));
  // .then((value) => print("connected " + value.options.asMap.toString()))
  // .catchError((e) => print(e.toString()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(
          color: Colors.blue,
          size: 24.0,
        ),
      ),
      home:
          FirebaseAuth.instance.currentUser != null ? Plans() : SplashScreen(),
      routes: {PalletScreen.routeName: (ctx) => PalletScreen()},
    );
  }
}
