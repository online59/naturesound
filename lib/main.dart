import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greentie/firebase_options.dart';
import 'package:greentie/service/firebase_service.dart';
import 'package:greentie/ui/home/home_page.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'data/Sound.dart';

Future<void> main() async {
  // Require to init firebase service
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Require to init audio play in background service
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const NatureSoundPlayerApp());
}

class NatureSoundPlayerApp extends StatefulWidget {
  const NatureSoundPlayerApp({super.key});

  @override
  State<NatureSoundPlayerApp> createState() => _NatureSoundPlayerAppState();
}

class _NatureSoundPlayerAppState extends State<NatureSoundPlayerApp> {
  final _audioService = AudioService();
  final List<Sound> _soundList = [];

  void _getData() {
    _audioService.read('audio').then((sounds) {
      setState(() {
        _soundList.addAll(sounds);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _getData();

    return MaterialApp(
      title: "Nature Sounds",
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
      home: HomePage(sounds: _soundList),
    );
  }
}
