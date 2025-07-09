import 'package:flutter/services.dart';
import 'package:rafek_mumen/main.dart';
import 'package:rafek_mumen/utils/services/alert_service.dart';
import 'package:share_plus/share_plus.dart';

class GeneralService {
  static Future<void> copyText(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      AlertService.showSnackbar(
        navigatorKey.currentContext!,
        'تم نسخ النص',
        duration: const Duration(seconds: 2),
      );
    } catch (e) {}
  }

  /// Shares the provided text using the platform's share dialog.
  static Future<void> shareText(String text, {String? subject}) async {
    try {
      SharePlus.instance.share(ShareParams(text: text, subject: subject));
    } catch (e) {}
  }
}
