import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL( BuildContext context, ScanModel scan  ) async {

  final url = scan.value;

  if ( scan.type == 'http' ) {
    // Abrir el sitio web
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan );
  }

}