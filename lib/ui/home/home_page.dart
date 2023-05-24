import 'package:flutter/material.dart';

import 'sound_item_display.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nature Sounds'),
      ),
      body: const SoundItemDisplay(),
    );
  }
}
