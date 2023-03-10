import 'package:flutter/material.dart';

// ChangeNotifier      To declare as part of Material App's widgets, to share the information
// Required to make all about this class, to be accessible from the context in any part of the Flutter application
class UiProvider extends ChangeNotifier {

  // Property to share between all my application, to know which one is the current index
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt( int i ) {
    this._selectedMenuOpt = i;
    notifyListeners();    // Notify to all widget that it has been changed --> Force to redraw all the widgets
  }


}