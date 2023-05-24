
import 'package:flutter/material.dart';

import '../data/Sound.dart';
import '../service/audio_service.dart';

class FirebaseServiceState extends ChangeNotifier {

  final List<Sound> sounds = [];
}