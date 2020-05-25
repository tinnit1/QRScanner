import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {
  MapasPage({Key key}) : super(key: key);
  final scanBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scanBloc.getScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scanBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text('No hay información'),
          );
        }

        return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) => Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) =>
                      scanBloc.deletScan(scans[index].id),
                  child: ListTile(
                    leading: Icon(
                      Icons.map,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(scans[index].valor),
                    subtitle: Text('ID: ${scans[index].id.toString()}'),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                    ),
                    onTap: () => utils.launchInBrowser(context, scans[index]),
                  ),
                ));
      },
    );
  }
}
