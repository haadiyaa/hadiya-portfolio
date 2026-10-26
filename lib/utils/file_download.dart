import 'file_download_stub.dart'
    if (dart.library.js_interop) 'file_download_web.dart';

/// Triggers a direct browser download of [url] saved as [filename].
void downloadResumePdf({
  String url = 'resume.pdf',
  String filename = 'Haadiya_CT_Resume.pdf',
}) {
  downloadFileImplementation(url, filename);
}
