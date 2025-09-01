import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  /// Open any URL
  static Future<void> launchUrlLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  /// WhatsApp (just number, no message)
  static Future<void> openWhatsApp(String phone) async {
    final url = "https://wa.me/$phone";
    await launchUrlLink(url);
  }

  /// Facebook
  static Future<void> openFacebook(String profileUrl) async {
    await launchUrlLink(profileUrl);
  }

  /// Mail
  static Future<void> openMail(String email) async {
    final url = "mailto:$email";
    await launchUrlLink(url);
  }
}
