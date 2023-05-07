import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/colorpalletemodel.dart';

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
          Text(pallet.pallete_nme),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: pallet.mycolors.length,
              itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                  height: 50,
                  width: 50,
                  color: Color(pallet.mycolors[index]),
                )],
              );
            },),
          ),
        ],
      )
    );
  }

  Widget _buildList(QuerySnapshot<Object?>? snapshot) {
    if (snapshot!.docs.isEmpty) {
      return const Center(child: Text("No Pallets Yet!"));
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
            stream:
                FirebaseFirestore.instance.collection("Pallets").doc("$userId Pallet").collection("User Pallets").snapshots(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) return const LinearProgressIndicator();
              return Expanded(child: _buildList(snapshot.data));
            }))
      ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pallets")),
      body: _buildBody(context),
    );
  }
}