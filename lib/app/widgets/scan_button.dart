import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_qr_googlemaps_scratch/app/providers/scan_list_provider.dart';
import 'package:flutter_qr_googlemaps_scratch/app/utils/utils.dart';
import 'package:provider/provider.dart';


class ScanButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,   // Remove the shadow
      child: Icon( Icons.filter_center_focus ),
      onPressed: () async {

        // Testing the Widget
        // 1) Hardcoding 'scanBarcode' functionality
        // final barcodeScanRes = 'geo:45.287135,-75.920226';   // Geo coordinates copied from any place from Google Maps
        // print(barcodeScanRes);

        // 2) 'scanBarcode' functionality
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR );


        // Nothing is found
        if ( barcodeScanRes == '-1' ) {
          return;
        }

        // Get access to the ScanListProvider via context, casting to ScanListProvider
        // listen   false - Since it won't be redrawn in case that there are value changes, my code is in charge of relaunching the request
        // Normally it the provider is into a event listener  --> you will not be interested in listening
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);
      }
    );
  }
}