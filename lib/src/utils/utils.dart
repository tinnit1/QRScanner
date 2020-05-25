import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(ScanModel scan) async {
  if (scan.tipo == 'http') {
    if (await canLaunch(scan.valor)) {
      await launch(
        scan.valor,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $scan.valor';
    }
  } else {
    print('geo..');
  }
}
