import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class Mpesa extends StatefulWidget {
  createState() => MpesaState();
}

class MpesaState extends State<Mpesa> {
//create the lipaNaMpesa method here.Please note, the method can have any name, I chose lipaNaMpesa
  Future<void> lipaNaMpesa() async {
    dynamic transactionInitialisation;
    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: 1.0,
              partyA: "254729050401",
              partyB: "174379",
              //Lipa na Mpesa Online ShortCode
              callBackURL: Uri(
                  scheme: "https",
                  host: "mpesa-requestbin.herokuapp.com",
                  path: "/1hhy6391"),
              //This url has been generated from http://mpesa-requestbin.herokuapp.com/?ref=hackernoon.com for test purposes
              accountReference: "Maureen Josephine Clothline",
              phoneNumber: "254729050401",
              baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey:
                  "QjjZAe6BRmaZ2Y7Vl0Ti/9v8MC5wrUjGlfYQvZBO/q1y9/a1u6bHPNUIh5P3+VCfd9xF8hTTz+Ieav06iahU9WSLQE0p+qSqK0XeyMtFtmglw/q+4bx7VoXlm4viawd5qLfYU2pz1cul2aPwBOWzERPyShe6IlBw9KTwO7c67nGbiZ1NHGjVlIQg6Qk2PtSANhz7axuoJNWrGkXFj7iFtChXIzzPAZ6TMZElAsfNOt0jXjB+eUjYFFZMBedMCeGSiL9HvlSYHTW48mWRc8bWRexKgkR6hdileQuFVvFQ3BcxpNnwIhASKL8DDPJoJTbNj3agf9lXk9KOT7n0MFo9CA==");
      //This passkey has been generated from Test Credentials from Safaricom Portal

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());
      //lets print the transaction results to console at this step
      return transactionInitialisation;
    } catch (e) {
      //lets print the error to console for this sample demo
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF481E4D)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mpesa Payment Demo'),
        ),
        body: Center(
            child: MaterialButton(
                color: Color(0xFF481E4D),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                  lipaNaMpesa();
                },
                child: Text(
                  "Lipa na Mpesa",
                  style: TextStyle(color: Colors.white),
                ))),
      ),
    );
  }
}
