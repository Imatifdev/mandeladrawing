// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/colors_screen.dart';
import 'package:mandeladrawing/models/colorpalletemodel.dart';
import 'package:mandeladrawing/pallet_screen.dart';
import 'package:mandeladrawing/view/authview/signup.dart';
import 'package:mandeladrawing/view/colorpannel/colorslistpage.dart';
import 'package:mandeladrawing/view/colorpannel/createpalette.dart';
import 'package:mandeladrawing/view/colorpannel/detailmandela.dart';
import 'package:mandeladrawing/view/colorpannel/imagetexture.dart';
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

import 'controllers/authenticationmodels.dart';
import 'firebase_options.dart';
import 'my.dart';
import 'my2.dart';
import 'package:stripe_android/stripe_android.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Stripe.publishableKey = 'your publish key';

  // await Stripe.instance.applySettings();
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser != null ? Home() : SplashScreen(),
      routes: {PalletScreen.routeName: (ctx) => PalletScreen()},
      // StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.active) {
      //       if (snapshot.hasData) {
      //         return Home();
      //       }
      //     } else if (snapshot.hasError) {
      //       return const Center(
      //         child: Text('\${snapshot.error}'),
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     return Home();
      //   },
      // ),
    );
  }
}
