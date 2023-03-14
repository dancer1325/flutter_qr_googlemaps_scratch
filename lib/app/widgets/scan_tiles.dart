import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/providers/scan_list_provider.dart';
import 'package:flutter_qr_googlemaps_scratch/app/utils/utils.dart';
import 'package:provider/provider.dart';

// It's not a Widget with a whole screen with a Scaffold, it's just the body
class ScanTiles extends StatelessWidget {
  
  final String type;

  const ScanTiles({ required this.type });


  @override
  Widget build(BuildContext context) {

    // listen   By default, it's true.  Required for listening changes, once a new scan happens
    // Normally it the provider is into a build --> you will be interested in listening
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    // ListView
    // Allows scrolling
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: ( _, i ) => Dismissible(     // _    BuildContext, which it's not interesting for us
        // Dismissible      If you drag in certain direction ⟶ entry can be dismissed
        key: UniqueKey(),   // Flutter's function to create an unique key
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {   // event about what to make after dragging to dismiss
          // Normally it the provider is into a event listener  --> you will not be interested in listening
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarScanPorId(scans[i].id);
        },
        child: ListTile(        // ListTile         Single fixed-height row
          leading: Icon( 
            this.type == 'http'
              ? Icons.home_outlined
              : Icons.map_outlined, 
            color: Theme.of(context).primaryColor 
          ),
          title: Text( scans[i].value ),
          subtitle: Text( scans[i].id.toString() ),
          trailing: Icon( Icons.keyboard_arrow_right, color: Colors.grey ),
          onTap: () => launchURL(context, scans[i]),
        ),
      )
    );
  }
}