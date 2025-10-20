import 'package:flutter/material.dart';

import '../../widgets/custom_alert.dart';

class CustomAlertProvider with ChangeNotifier {
  Future<void> showCustomAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onYes, required Null Function() onCancel,
  }) async {
    await showDialog(
      context: context,
      builder: (_) => CustomAlertDialog(
        title: title,
        content: content,
        onYes: onYes,
        onCancel: () => Navigator.pop(context),
      ),
    );
  }
}
