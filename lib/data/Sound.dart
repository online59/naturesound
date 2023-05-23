import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sound {

  Sound(
      {this.name, this.author, this.audioUrl, this.imageUrl, this.isFavorite});

  final String? name;
  final String? author;
  final String? audioUrl;
  final String? imageUrl;
  final bool? isFavorite;

  factory Sound.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Sound(
      name: data?['name'],
      author: data?['author'],
      audioUrl: data?['audioUrl'],
      imageUrl: data?['imageUrl'],
      isFavorite: data?['isFavorite'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (author != null) "author": author,
      if (audioUrl != null) "audioUrl": audioUrl,
      if (imageUrl != null) "imageUrl": imageUrl,
      if (isFavorite != null) "isFavorite": isFavorite,
    };
  }
}