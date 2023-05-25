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
    final theme = Theme.of(context);

    final testStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return GestureDetector(
      onTap: () => onSoundSelect(sound),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/rain_1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(sound.name!),
          ],
        ),
      ),
    );
  }
}
