import 'package:flutter/material.dart';
import 'package:greentie/service/audio_manager.dart';
import 'package:image_network/image_network.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import '../../data/Sound.dart';

class SoundPlayerPage extends StatefulWidget {
  const SoundPlayerPage({required this.sound, super.key});

  final Sound sound;

  @override
  State<SoundPlayerPage> createState() => _SoundPlayerPageState();
}

class _SoundPlayerPageState extends State<SoundPlayerPage> {
  late final AudioPlayerManager _audioManager;

  bool isLoopPlay = false;

  AudioRepeatModeState _handlingLoopPlayButton() {
    if (!isLoopPlay) {
      isLoopPlay = true;
      return AudioRepeatModeState.all;
    } else {
      isLoopPlay = false;
      return AudioRepeatModeState.none;
    }
  }

  @override
  void initState() {
    super.initState();
    _audioManager = AudioPlayerManager(AudioPlayer());
  }

  @override
  Widget build(BuildContext context) {
    _audioManager.setAudioSource(widget.sound);

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.sound.name!),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ImageNetwork(
                  image: widget.sound.imageUrl!,
                  height: double.infinity,
                  width: double.infinity),
              const Spacer(),
              ValueListenableBuilder<ProgressBarState>(
                  valueListenable: _audioManager.progressNotifier,
                  builder: (_, value, __) {
                    return ProgressBar(
                      progress: value.current,
                      buffered: value.buffered,
                      total: value.total,
                      onSeek: _audioManager.seek,
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder<MediaButtonState>(
                      valueListenable: _audioManager.mediaButtonNotifier,
                      builder: (_, value, __) {
                        switch (value) {
                          case MediaButtonState.loading:
                            return Container(
                              margin: const EdgeInsets.all(8),
                              width: 32,
                              height: 32,
                              child: const CircularProgressIndicator(),
                            );
                          case MediaButtonState.paused:
                            return IconButton(
                              icon: const Icon(Icons.play_arrow),
                              iconSize: 32,
                              onPressed: () => _audioManager.play(),
                            );
                          case MediaButtonState.playing:
                            return IconButton(
                              icon: const Icon(Icons.pause),
                              iconSize: 32,
                              onPressed: () => _audioManager.pause(),
                            );
                        }
                      }),
                  const SizedBox(
                    width: 8.0,
                  ),
                  ValueListenableBuilder<AudioRepeatModeState>(
                      valueListenable: _audioManager.loopButtonNotifier,
                      builder: (_, value, __) {
                        return IconButton(
                          icon: const Icon(Icons.loop),
                          isSelected: isLoopPlay,
                          iconSize: 24,
                          onPressed: () =>
                              _audioManager.loop(_handlingLoopPlayButton()),
                        );
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioManager.dispose();
    super.dispose();
  }
}
