import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:greentie/firebase_options.dart';
import 'package:greentie/service/audio_service.dart';
import 'package:greentie/ui/home/home_page.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'data/Sound.dart';
import 'in_nature_app.dart';

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

  // Run app
  runApp(const InNatureApp());
}
