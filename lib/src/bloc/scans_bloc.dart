import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    // Obtener Scans de la base de datos
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose() { 
    _scansController?.close();
  }

  addScan(ScanModel scanModel) async {
    await DBProvider.db.nuevoScan(scanModel);
    getScans();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getAllScans());
  }

  deletScan(int id) async{
    await DBProvider.db.deleteScanById(id);
    getScans();
  }

  deleteAllScans() async{
    await DBProvider.db.deleteAll();
    getScans();
  }
}