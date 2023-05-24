import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greentie/data/Sound.dart';
import 'package:greentie/service/audio_service.dart';

import '../player/sound_player_page.dart';
import 'sound_item.dart';

class SoundItemDisplay extends StatefulWidget {
  const SoundItemDisplay({super.key});

  @override
  State<SoundItemDisplay> createState() => _SoundItemDisplayState();
}

class _SoundItemDisplayState extends State<SoundItemDisplay> {
  final List<Sound> _sounds = [];
  final _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    _audioService.read('audio').then((values) {
      setState(() {
        _sounds.addAll(values);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sounds.isNotEmpty) {
      return ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _sounds.map((sound) {
          return SoundItem(
              sound: sound,
              onSoundSelect: (sound) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SoundPlayerPage(sound: sound);
                }));
              });
        }).toList(),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }
}
