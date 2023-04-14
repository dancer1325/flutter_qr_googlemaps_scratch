import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Required to extend from StatefulWidget for using google_maps_flutter
// https://pub.dev/packages/google_maps_flutter#both
class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  // Control the map view
  // https://pub.dev/documentation/google_maps_flutter/latest/google_maps_flutter/GoogleMapController-class.html
  Completer<GoogleMapController> _controller = Completer();

  // https://pub.dev/documentation/google_maps_flutter_platform_interface/latest/google_maps_flutter_platform_interface/MapType.html
  // Property whose changes can be tracked
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    // Read the arguments passed
    final scan = ModalRoute.of(context)?.settings.arguments as ScanModel;

    final initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
      tilt: 50
    );

    // Markers
    // https://pub.dev/documentation/google_maps_flutter_platform_interface/latest/google_maps_flutter_platform_interface/Marker-class.html
    var markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('geo-location'),
      position: scan.getLatLng()
    ));


    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon( Icons.location_disabled), 
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),   // Get easier come back to the previous position
                    zoom: 17.5,
                    tilt: 50
                  )
                )
              );
            }
          )
        ],
      ),
      body: GoogleMap(
        // https://pub.dev/documentation/google_maps_flutter/latest/google_maps_flutter/GoogleMap-class.html
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.layers ),
        onPressed: () {
          // Be able to switch mapType

          if ( mapType == MapType.normal ) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }

          // Function to redraw the StatefulWidget with state mapType
          setState(() {});
        }
      ),
   );
  }
}