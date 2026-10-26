import 'package:url_launcher/url_launcher.dart';

/// Fallback implementation for non-web platforms.
void downloadFileImplementation(String url, String filename) {
  launchUrl(Uri.parse(url));
}
