import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mandeladrawing/view/colorpannel/colorslistpage.dart';

import '../../models/colorpalletemodel.dart';
import '../../utils/mycolors.dart';
import '../../widgets/colorpallete.dart';

class PalletScreen extends StatefulWidget {
  static const routeName = "pallet_screen";
  const PalletScreen({super.key});

  @override
  State<PalletScreen> createState() => _PalletScreenState();
}

class _PalletScreenState extends State<PalletScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Widget _buildListItem(MyColorPallet pallet) {
    return Dismissible(
      key: Key(pallet.pallete_nme),
      background: Container(color: Colors.red),
      child: Column(
        children: [
          Text(
            pallet.pallete_nme,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: pallet.mycolors.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ColorPalette(selectColor: Colors.black,)));
                  },
                  child: Container(
                    height: 30,
                    width: 150,
                    color: Color(pallet.mycolors[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(QuerySnapshot<Object?>? snapshot) {
    if (snapshot!.docs.isEmpty) {
      return const Center(child: Center(child: Text("Create a New Pallet")));
    } else {
      return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          final task = MyColorPallet.fromSnapshot(doc);
          return _buildListItem(task);
        },
      );
    }
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Pallets")
                .doc("$userId Pallet")
                .collection("User Pallets")
                .snapshots(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) return const LinearProgressIndicator();
              return Container(height: 200, child: _buildList(snapshot.data));
            }))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbg,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Select pallet',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: appbg,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.left_chevron,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Get.to(() => const Settings());
              },
              child: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildBody(context),
            FloatingActionButton.extended(
                backgroundColor: button,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ColorsScreen()));
                },
                label: Text("Create a New Pallete"))
          ],
        ),
      ),
    );
  }
}
