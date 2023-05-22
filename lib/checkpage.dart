import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _selectedImage;
  String? _imageUrl;

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      String imageId = DateTime.now().millisecondsSinceEpoch.toString();
      await uploadImageToFirebase(_selectedImage!, imageId);
      String imageUrl = await getImageUrlFromFirebase(imageId);
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  Future<void> uploadImageToFirebase(File imageFile, String imageId) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageId);
    await firebaseStorageRef.putFile(imageFile);
  }

  Future<String> getImageUrlFromFirebase(String imageId) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageId);
    String downloadURL = await firebaseStorageRef.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 200,
              ),
            if (_imageUrl != null)
              Image.network(
                _imageUrl!,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Pick and Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
