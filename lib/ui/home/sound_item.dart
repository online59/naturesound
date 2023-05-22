import 'package:flutter/material.dart';

import '../../data/Sound.dart';
import '../../utils/sound_callback.dart';

class SoundItem extends StatelessWidget {
  SoundItem({required this.sound, required this.onSoundSelect})
      : super(key: ObjectKey(sound));

  final Sound sound;
  final SoundSelectCallback onSoundSelect;

  Color _getColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    if (!sound.isFavorite) {
      iconData = Icons.favorite;
    } else {
      iconData = Icons.favorite_border;
    }

    return ListTile(
      onTap: () => onSoundSelect(sound),
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(
          sound.name[0],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      title: Text(sound.name),
    );
  }
}
