import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class MessageDivider extends StatelessWidget {
  const MessageDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.divider,
      height: 1,
      thickness: 0.5,
    );
  }
}