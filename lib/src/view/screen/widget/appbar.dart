import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;

  final IconData? actionIcon;
  final VoidCallback? onActionPressed;

  final Color backgroundColor;

  CustomAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcon,
    this.onActionPressed,
    this.backgroundColor = Colors.deepPurple,
  });

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: isDark ? AppColors.primary : AppColors.backgroundDark,
      elevation: 4,
      leading: leadingIcon != null
          ? IconButton(
        icon: Icon(leadingIcon, color: Colors.white),
        onPressed: onLeadingPressed ??
                () {
              Navigator.pop(context);
            },
      )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
      ),
      centerTitle: true,
      actions: [
        if (actionIcon != null)
          IconButton(
            icon: Icon(actionIcon, color: Colors.white),
            onPressed: onActionPressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
