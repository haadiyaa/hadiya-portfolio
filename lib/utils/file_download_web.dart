import 'package:web/web.dart' as web;

/// Modern Web implementation using package:web.
/// Triggers a direct browser download of [url] with name [filename].
void downloadFileImplementation(String url, String filename) {
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = filename
    ..style.display = 'none';
  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
}
