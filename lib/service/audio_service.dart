import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../data/Sound.dart';

class AudioService {
  final _database = FirebaseFirestore.instance;

  List<Sound> sounds = [];

  Future<List<Sound>> read(String path) async {
    await _database.collection(path).get().then((value) {
      sounds = value.docs.map((e) => Sound.fromFirestore(e, null)).toList();
    });

    return sounds;
  }
}
