import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coders_meme/model/meme_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';

class FireBaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _database =
      FirebaseFirestore.instance.collection('memes');

  Future<void> guestSignIn() async {
    await _auth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> uploadMeme(
    File imageFile,
    String name,
    String author,
  ) async {
    final fileName = basename(imageFile.path);

    final ref = FirebaseStorage.instance.ref().child('memes/$fileName');
    final task = await ref.putFile(imageFile);
    String result = await ref.getDownloadURL();

    String id = await _database.doc().id;

    _database.doc(id).set({
      'name': name,
      'author': author,
      'imgUrl': result,
      'id': id,
    });
  }

  Future<void> EditMeme(
    String newName,
    MemeModel memeModel,
  ) async {
    _database.doc(memeModel.id).update({
      'name': newName,
    });
  }

  Future<void> DeleteMeme(
    MemeModel memeModel,
  ) async {
    _database.doc(memeModel.id).delete();
  }

  Stream<List<MemeModel>> fetchMemes() =>
      FirebaseFirestore.instance.collection('memes').snapshots().map((event) =>
          event.docs.map((e) => MemeModel.fromJson(e.data())).toList());
}
