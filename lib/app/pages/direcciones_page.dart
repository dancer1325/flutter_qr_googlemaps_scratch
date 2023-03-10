import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/widgets/scan_tiles.dart';

// Show the history of scanned directions. It's not a whole page, just the body
class DireccionesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Preferred const for constructors https://dart-lang.github.io/linter/lints/prefer_const_constructors.html
    return const ScanTiles(type: 'http');
  }
}