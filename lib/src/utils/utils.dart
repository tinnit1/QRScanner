import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Future<void> launchInBrowser(BuildContext context ,ScanModel scan) async {
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
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
