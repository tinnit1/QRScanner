import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: () => scansBloc.deleteAllScans())
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQr,
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Future _scanQr() async {
    // https://stackoverflow.com/questions/46284022/ios-provisioning-profile-expiring-after-6-days
    // geo:5.572536692719274,-73.33600058993228
    String result = 'https://stackoverflow.com/questions/46284022/ios-provisioning-profile-expiring-after-6-days';
    // ScanResult result;
    // try {
    //   result = await BarcodeScanner.scan();

    // } on PlatformException catch (e) {
    //    result = ScanResult(
    //     type: ResultType.Error,
    //     format: BarcodeFormat.unknown,
    //   );

    //   if (e.code == BarcodeScanner.cameraAccessDenied) {
    //     setState(() {
    //       result.rawContent = 'The user did not grant the camera permission!';
    //     });
    //   } else {
    //     result.rawContent = 'Unknown error: $e';
    //   }
    // }
    // print('Future string: ${result.rawContent}');
    if (result != null) {
      final scan = ScanModel(valor: result);
      scansBloc.addScan(scan);

      final scan2 = ScanModel(valor: 'geo:5.572536692719274,-73.33600058993228');
      scansBloc.addScan(scan2);

      await utils.launchInBrowser(scan);
    }
  }

  BottomNavigationBar _crearBottomNav() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Map')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
      ],
    );
  }

  _callPage(int page) {
    switch (page) {
      case 0:
        return MapasPage();
        break;
      case 1:
        return DireccionesPage();
        break;
      default:
        return MapasPage();
        break;
    }
  }
}
