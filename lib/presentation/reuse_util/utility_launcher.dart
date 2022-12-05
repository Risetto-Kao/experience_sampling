import 'package:url_launcher/url_launcher.dart';

class UtilityLauncher {
  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static Future openLink({
    required String url,
  }) {
    return _launchUrl(url);
  }

  static Future openEmail({
    required String toEmail,
    required String subject,
    required String body,
  }) async {
    print("openEmail");
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';

    await _launchUrl(url);
  }
}
