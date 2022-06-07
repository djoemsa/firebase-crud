import 'dart:io';

import 'package:coders_meme/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final TextEditingController controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Upload')),
      body: Container(
        padding: EdgeInsets.only(
          bottom: 30,
          left: 15,
          right: 15,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (photo != null)
                Expanded(
                    child: Container(
                  color: Colors.blueAccent,
                  child: Image.file(
                    File(photo!.path),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )),
              SizedBox(height: 30),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Meme's Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  imgFromGallery();
                },
                child: Text(
                  'Select a Meme',
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  FireBaseServices().uploadMeme(
                    photo!,
                    controller.text.trim(),
                    user.email!,
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  'Upload the Meme',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
