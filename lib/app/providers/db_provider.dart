import 'dart:io';

import 'package:flutter_qr_googlemaps_scratch/app/models/scan_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Singleton class    === 1! instance of the class
class DBProvider {

  static late Database _database;
  static final DBProvider db = DBProvider._();      // '_'    Private constructor
  DBProvider._();

  // Private --> Get access via 'get'
  // Since it's async --> returns Future <>
  // Singleton class, returning the existing one, in case it exists
  Future<Database> get database async {
    if ( _database != null ) return _database;

    _database = await initDB();

    return _database;

  }

  // All interactions with the DB must be async
  Future<Database> initDB() async{

    // https://api.flutter.dev/flutter/dart-io/Directory-class.html
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'ScansDB.db' );   //  ScansDB.db    Database name
    print( path );

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,     // Each time some change is done about the database --> Increase the version
      onOpen: (db) { },
      onCreate: ( Database db, int version ) async {

        // '''    Because the sql command is coded in several lines
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            type TEXT,
            value TEXT
          )
        ''');
      }
    );

  }

  Future<int> nuevoScanRaw( ScanModel nuevoScan ) async {
    final id    = nuevoScan.id;
    final type  = nuevoScan.type;
    final value = nuevoScan.value;

    // Verificar la base de datos
    // await    Because the database could be yet being created
    final db = await database;

    // '$type'  and   '$value'    because it's a string
    final res = await db.rawInsert('''
      INSERT INTO Scans( id, type, value )
        VALUES( $id, '$type', '$value' )
    ''');

    return res;
  }

  // Same as 'nuevoScanRaw', but with 'insert' --> You don't type the sql sentence
  Future<int> nuevoScan( ScanModel nuevoScan ) async {

    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson() );

    // Es el ID del último registro insertado;
    return res;
  }

  Future<ScanModel?> getScanById( int id ) async {

    final db  = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);      // ?   It's related to whereArgs

    return res.isNotEmpty
          ? ScanModel.fromJson( res.first )     // first    Because res returns a List
          : null;
  }

  // Similar to previous, but without filtering / where statement
  Future<List<ScanModel>> getTodosLosScans() async {

    final db  = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList()
          : [];
  }

  // rawQuery --> we type the sql statement
  Future<List<ScanModel>> getScansPortype( String type ) async {

    final db  = await database;
    // '''    Because several lines are added
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE type = '$type'    
    ''');

    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList()
          : [];
  }

  Future<int> updateScan( ScanModel nuevoScan ) async {
    final db  = await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [ nuevoScan.id ] );
    return res;
  }

  Future<int> deleteScan( int id ) async {
    final db  = await database;
    final res = await db.delete( 'Scans', where: 'id = ?', whereArgs: [id] );
    return res;
  }

  Future<int> deleteAllScans() async {
    final db  = await database;
    // '''    Because several lines are added
    final res = await db.rawDelete('''
      DELETE FROM Scans    
    ''');
    return res;
  }

}

