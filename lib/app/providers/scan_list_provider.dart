import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/models/scan_model.dart';
import 'package:flutter_qr_googlemaps_scratch/app/providers/db_provider.dart';

// Interaction between DDBB and UI
class ScanListProvider extends ChangeNotifier {

  List<ScanModel> scans = [];
  String typeSeleccionado = 'http';

  Future<ScanModel> nuevoScan( String value ) async {

    final nuevoScan = new ScanModel(value: value);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // Asignar el ID de la base de datos al modelo
    nuevoScan.id = id;

    if ( this.typeSeleccionado == nuevoScan.type ) {
      this.scans.add(nuevoScan);
      notifyListeners();    // Once it changes --> Notify it, being listened by the proper Widget
    }

    return nuevoScan;
  }

  Future<void> cargarScans() async {
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...scans];      // Destructuring
    notifyListeners();
  }

  Future<void> cargarScanPortype( String type ) async {
    final scans = await DBProvider.db.getScansPortype(type);
    this.scans = [...scans];      // Replace all
    this.typeSeleccionado = type;
    notifyListeners();
  }

  Future<void> borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  Future<void> borrarScanPorId( int id ) async {
    await DBProvider.db.deleteScan(id);
  }



}

