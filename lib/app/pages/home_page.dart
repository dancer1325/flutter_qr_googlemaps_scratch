import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/pages/direcciones_page.dart';
import 'package:flutter_qr_googlemaps_scratch/app/pages/mapas_page.dart';
import 'package:flutter_qr_googlemaps_scratch/app/providers/scan_list_provider.dart';
import 'package:flutter_qr_googlemaps_scratch/app/providers/ui_provider.dart';
import 'package:flutter_qr_googlemaps_scratch/app/widgets/custom_navigatorbar.dart';
import 'package:flutter_qr_googlemaps_scratch/app/widgets/scan_button.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,         // Remove the appBar's shadow
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon( Icons.delete_forever ), 
            onPressed: (){

              Provider.of<ScanListProvider>(context, listen: false)
                .borrarTodos();

            }
          )
        ],
      ),
      body: _HomePageBody(),
     bottomNavigationBar: CustomNavigationBar(),
     floatingActionButton: ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,     // Float the action button over the bottomNavigationBar.
   );
  }
}

// Widget which returns a Widget based on currentIndex
class _HomePageBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    // Get access to the UiProvider via context, casting to UiProvider
    final uiProvider = Provider.of<UiProvider>(context);

    // Get the current index
    final currentIndex = uiProvider.selectedMenuOpt;

    // Get access to the ScanListProvider via context, casting to ScanListProvider
    // listen   false - Since it won't be redrawn in case that there are value changes, my code is in charge of relaunching the request
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch( currentIndex ) {
      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return MapasPage();

      case 1: 
        scanListProvider.cargarScanPorTipo('http');
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}