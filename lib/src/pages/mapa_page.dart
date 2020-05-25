import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map = new MapController();

  String idStyle = 'ckamrxgg41aec1kqc0y90pyun';

  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                map.move(scan.getLatLng(), 15.0);
              })
        ],
      ),
      body: _createFlutterMap(scan, context),
      floatingActionButton: _createBottomFloat(context),
    );
  }

  _createFlutterMap(ScanModel scan, BuildContext context) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15,
      ),
      layers: [_createMap(), _createMarker(scan)],
    );
  }

  _createMap() {
    return TileLayerOptions(
        urlTemplate:
            'https://api.mapbox.com/styles/v1/{user}/{id}/tiles/256/{z}/{x}/{y}?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoidGlubml0IiwiYSI6ImNrYW1zYWt4bDA4dm4ycHJ4ZWM5Z3kzOTAifQ.2lNh8RJuF9ylekGttVDGEw',
          'id': idStyle,
          'user': 'tinnit'
        });
  }

  _createMarker(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 120,
          height: 120,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 70.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }

  _createBottomFloat(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (idStyle == 'ckamrxgg41aec1kqc0y90pyun') {
          idStyle = 'ckamuzc8h0qv61io6mc04ugux';
        } else {
          idStyle = 'ckamrxgg41aec1kqc0y90pyun';
        }
        setState(() {});
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.repeat,
      ),
    );
  }
}
