import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../bloc/background_audio_task.dart';
import '../data/Sound.dart';

class AudioPlayerManager extends BackgroundAudioTask {
  AudioPlayerManager(this.audioPlayer);

  final AudioPlayer audioPlayer;

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  final mediaButtonNotifier = ValueNotifier<MediaButtonState>(MediaButtonState.paused);

  final loopButtonNotifier = ValueNotifier<AudioRepeatModeState>(AudioRepeatModeState.none);

  Future<void> setAudioSource(Sound sound) async {

    await audioPlayer.setAudioSource(AudioSource.uri(
      Uri.parse(sound.audioUrl!),
      tag: MediaItem(
          id: '${ObjectKey(sound)}',
          title: sound.name!,
      ),
    ));
    _init();
  }

  void _init() {
    audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        mediaButtonNotifier.value = MediaButtonState.loading;
      } else if (!isPlaying) {
        mediaButtonNotifier.value = MediaButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        mediaButtonNotifier.value = MediaButtonState.playing;
      } else {
        audioPlayer.seek(Duration.zero);
        audioPlayer.pause();
      }
    });

    audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
          current: position,
          buffered: oldState.buffered,
          total: oldState.total);
    });

    audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: bufferedPosition,
          total: oldState.total);
    });

    audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: oldState.buffered,
          total: totalDuration ?? Duration.zero);
    });
  }

  void play() {
    audioPlayer.play();
  }

  Future<void> loop(AudioRepeatModeState repeatMode) async {
    switch (repeatMode) {
      case AudioRepeatModeState.none:
        await audioPlayer.setLoopMode(LoopMode.off);
        loopButtonNotifier.value = AudioRepeatModeState.none;
        break;
      case AudioRepeatModeState.all:
        await audioPlayer.setLoopMode(LoopMode.all);
        loopButtonNotifier.value = AudioRepeatModeState.all;
        break;
    }
  }

  void pause() {
    audioPlayer.pause();
  }

  void dispose() {
    audioPlayer.dispose();
  }

  void seek(Duration position) {
    audioPlayer.seek(position);
  }
}

class ProgressBarState {
  ProgressBarState(
      {required this.current, required this.buffered, required this.total});

  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum MediaButtonState { paused, playing, loading }

enum AudioRepeatModeState { none, all }
