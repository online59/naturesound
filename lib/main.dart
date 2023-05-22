import 'package:flutter/material.dart';
import 'package:greentie/ui/home/home_page.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'data/Sound.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const NatureSoundPlayerApp());
}

class NatureSoundPlayerApp extends StatelessWidget {
  const NatureSoundPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nature Sounds",
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
      home: const HomePage(sounds: [
        Sound(
            "Numb",
            "Likin Park",
            "https://cdn.pixabay.com/audio/2022/05/13/audio_257112ce99.mp3",
            false),
        Sound(
            "War of Change",
            "War of Change",
            "https://cdn.pixabay.com/audio/2022/06/19/audio_04c9de5c9f.mp3",
            false),
        Sound(
            "OMG",
            "NewJeans ",
            "https://cdn.pixabay.com/audio/2021/12/10/audio_369fce8def.mp3",
            false),
      ]),
    );
  }
}
