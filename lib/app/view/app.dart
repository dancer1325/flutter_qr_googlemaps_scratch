import 'package:flutter/material.dart';
import 'package:flutter_qr_googlemaps_scratch/app/pages/home_page.dart';
import 'package:flutter_qr_googlemaps_scratch/app/pages/mapa_page.dart';
import 'package:flutter_qr_googlemaps_scratch/app/providers/scan_list_provider.dart';
import 'package:flutter_qr_googlemaps_scratch/app/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  // Dummy counter
  /*@override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }*/

  @override
  Widget build(BuildContext context) {

    return MultiProvider(     // Required in case you need several providers, which are state managers
      // Providers available in the Context --> to use in any Widget
      providers: [
        // ChangeNotifierProvider(create: (_) => new UiProvider() ),    Unnecessary new
        ChangeNotifierProvider(create: (_) => UiProvider() ),
        ChangeNotifierProvider(create: (_) => ScanListProvider() ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,      // Mode banner displayed in top right
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          'home': ( _ ) => HomePage(),
          'mapa': ( _ ) => MapaPage(),
        },
        // theme: ThemeData.dark()                        // Preø configure theme
        //     theme: ThemeData.light().copyWith()        // Make a copy of light theme
        theme: ThemeData(                             // Create the theme by constructor
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: FloatingActionButtonThemeData(     // Some elements have got an attribute to specify the theme, such as the FloatingActionButton
                backgroundColor: Colors.deepPurple
            )
        ),
      ),
    );

  }
}
