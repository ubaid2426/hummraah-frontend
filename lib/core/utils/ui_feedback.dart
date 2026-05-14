import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UIFeedback {
  /// 🔵 LOADING
  static void loading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          Center(child: Lottie.asset('assets/animation/loading.json', width: 120)),
    );
  }

  /// 🟢 SUCCESS
  static void success(BuildContext context, String msg) {
    _show(context, msg, 'assets/animation/success.json');
  }

  /// 🔴 ERROR
  static void error(BuildContext context, String msg) {
    _show(context, msg, 'assets/animation/error.json');
  }

  /// ❌ CLOSE LOADER / DIALOG
  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// 🔁 INTERNAL DIALOG
  static void _show(BuildContext context, String msg, String lottie) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(lottie, width: 100),
            const SizedBox(height: 10),
            Text(msg, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
