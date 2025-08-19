import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:reunite/data/repository/location/fakeLocationRepositoryImpl.dart';
import 'package:reunite/data/repository/location/locationRepositoryImpl.dart';
import 'package:reunite/data/service/coding/fakeGeoCodingServiceImpl.dart';
import 'package:reunite/data/service/coding/geocodingServiceImpl.dart';
import 'package:reunite/data/service/locater/fakeLocaterServiceImpl.dart';
import 'package:reunite/data/service/locater/locaterServiceimpl.dart';
import 'package:reunite/permission/permission.dart';
import 'package:reunite/ui/features/missingMap/view/mapView.dart';

import 'ui/features/missingMap/models/model.dart';
import 'ui/features/missingMap/viewModel/mapViewModel.dart';

void main() {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // Force Hybrid Composition mode.
    mapsImplementation.useAndroidViewSurface = true;
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MapViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocationPermissionChecker().check();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Mapview(),
    );
  }
}
