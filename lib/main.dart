import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'SplashPage.dart';

// @dart=2.9
void main() {
  // initial mobileAds
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  get hymns => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllLanguageBible',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // #FF8800
        //  #dadada
        //  #ff003366
      ),
      routes: {
        '/SplashPage': (context) => const SplashPage(),
      },
      // home: new HymnalListPage(),
      home: const SplashPage(),
    );
  }
}

