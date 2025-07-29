import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:reunite/data/repository/location/fakeLocationRepositoryImpl.dart';
import 'package:reunite/data/service/coding/fakeGeoCodingServiceImpl.dart';
import 'package:reunite/data/service/coding/geocodingServiceImpl.dart';
import 'package:reunite/data/service/locater/fakeLocaterServiceImpl.dart';
import 'package:reunite/data/service/locater/locaterServiceimpl.dart';
import 'package:reunite/permission/permission.dart';

void main() {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // Force Hybrid Composition mode.
    mapsImplementation.useAndroidViewSurface = true;
  }
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    /*위치 값 서비스 테스트 코드*/
    // var geoCodingService = FakeGeoGeoCodingServiceImpl();
    // var coordinateFromAddress =
    //     await geoCodingService.getCoordinateFromAddress('');

    // var geoCodingService_real_data = GeoCodingServiceImpl();
    // var coordinateFromAddress_real_data =
    //     await geoCodingService.getCoordinateFromAddress('서울특별시 중구 세종대로 110');

    // // 주소 변환 테스트 코드
    // print(
    //     'coordinateFromAddress : ${coordinateFromAddress.lat} / coordinateFromAddress_real_data : ${coordinateFromAddress_real_data.lat}');

    /*위치 값 서비스 테스트 코드*/
    var locaterService = FakeLocaterServiceImpl();
    var getCurrentLocation = await locaterService.getCurrentLocation();

    var locaterService_real_data = LocaterServiceImpl();
    var getCurrentLocation_real_data =
        await locaterService_real_data.getCurrentLocation();

    print(
        'fake coordinateFromAddress : ${getCurrentLocation.lat} / coordinateFromAddress : ${getCurrentLocation.long}');
    print(
        'fake coordinateFromAddress : ${getCurrentLocation_real_data.lat} / coordinateFromAddress : ${getCurrentLocation_real_data.long}');

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
