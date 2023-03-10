import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/providers/ui_provider.dart';
import 'package:provider/provider.dart';


class CustomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    // Get access to the provider via context
    final uiProvider = Provider.of<UiProvider>(context);

    // Get the current index
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(       // Widget coming from material
      onTap: ( int i ) => uiProvider.selectedMenuOpt = i,   // i    Selected index when you click in one. Since 'selectedMenuOpt' is via set --> Via assignment '='
      currentIndex: currentIndex,   // Indicate which item is selected
      elevation: 0,   // Remove the shadow
      items: <BottomNavigationBarItem>[     // Good practise to specify the type. >=2 items
        BottomNavigationBarItem(
          icon: Icon( Icons.map ),
          label: 'Mapa'
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.compass_calibration ),
          label: 'Direcciones'
        ),
      ],
    );
  }
}

