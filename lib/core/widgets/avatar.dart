import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class Avatar extends StatelessWidget {
  final String name;
  final double size;

  const Avatar({super.key, required this.name, this.size = 48});

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  Color avatarColor(String name) {
    const ru = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ';
    const en = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    final upper = name.trim().toUpperCase();
    if (upper.isEmpty) return Colors.grey;

    final first = upper[0];

    int index;

    if (ru.contains(first)) {
      index = ru.indexOf(first);
    } else if (en.contains(first)) {
      index = en.indexOf(first);
    } else {
      index = first.codeUnitAt(0);
    }

    return AppColors.avatarColors[index % AppColors.avatarColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: avatarColor(name),
      ),
      alignment: Alignment.center,
      child: Text(initials, style: AppTextStyles.avatar),
    );
  }
}
