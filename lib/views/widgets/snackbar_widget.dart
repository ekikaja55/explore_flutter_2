import 'package:explore_flutter_2/utils/system_response.dart';
import 'package:flutter/material.dart';

class SnackbarWidget {
  static void show(BuildContext context, SystemResponse res) {
    final Color bgColor;
    final IconData icon;

    switch (res.type) {
      case ResponseType.success:
        bgColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case ResponseType.error:
        bgColor = Colors.red;
        icon = Icons.error;
      case ResponseType.warning:
        bgColor = Colors.orange;
        icon = Icons.warning;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        content: Row(
          spacing: 10.0,
          children: [
            Icon(icon, color: Colors.white),
            Expanded(child: Text(res.msg)),
          ],
        ),
      ),
    );
  }
}
