import 'dart:io';

import 'package:coders_meme/model/meme_model.dart';
import 'package:coders_meme/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditPage extends StatelessWidget {
  final MemeModel _memeModel;
  EditPage(this._memeModel, {Key? key}) : super(key: key);

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
              Expanded(
                  child: Container(
                      color: Colors.blueAccent,
                      child: Image.network(
                        _memeModel.url,
                        fit: BoxFit.cover,
                      ))),
              SizedBox(height: 30),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Meme's New Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  FireBaseServices().EditMeme(controller.text, _memeModel);
                  Navigator.pop(context);
                },
                child: Text(
                  'Update name',
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  FireBaseServices().DeleteMeme(_memeModel);
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete meme post',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
