import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/widgets/scan_tiles.dart';

// Show the history of scanned maps. It's not a whole page, just the body
class MapasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return const ScanTiles(type: 'geo');
  
  }
}