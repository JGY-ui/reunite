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
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Google Maps Android에서 Hybrid Composition 모드 사용 설정
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // Force Hybrid Composition mode.
    mapsImplementation.useAndroidViewSurface = true;
  }

  // Firebase 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 프로바이더 설정
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
