import 'package:flutter/material.dart';
import 'package:greentie/ui/home/sound_item.dart';
import 'package:greentie/ui/player/sound_player.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/Sound.dart';


class HomePage extends StatelessWidget {
  const HomePage({required this.sounds, super.key});

  final List<Sound> sounds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nature Sounds'),
      ),
      body: SoundItemDisplay(sounds: sounds),
    );
  }
}

class SoundItemDisplay extends StatelessWidget {
  const SoundItemDisplay({required this.sounds, super.key});

  final List<Sound> sounds;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: sounds.map((sound) {
        return SoundItem(
            sound: sound,
            onSoundSelect: (sound) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SoundPlayerPage(sound: sound)));
            });
      }).toList(),
    );
  }
}
