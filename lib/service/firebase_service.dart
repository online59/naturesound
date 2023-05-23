

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data/Sound.dart';

class AudioService {

  final _database = FirebaseFirestore.instance;
  final List<Sound> soundList = [];

  Future<List<Sound>> read(String path) async {

    // final ref = _database.collection(path).withConverter(
    //   fromFirestore: Sound.fromFirestore,
    //   toFirestore: (Sound sound, _) => sound.toFirestore(),
    // );
    //
    // await ref.get().then((value) => {
    //   for (var sound in value.docs) {
    //     soundList.add(sound.data())
    //   }
    // });

    var data = await _database.collection(path).get();

    return List.from(data.docs.map((doc) => Sound.fromFirestore(doc, null)));
  }
}
