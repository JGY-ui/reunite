import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reunite/data/repository/location/locationRepositoryImpl.dart';
import 'package:reunite/data/service/coding/geocodingServiceImpl.dart';
import 'package:reunite/data/service/locater/locaterServiceimpl.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

class MapViewModel {
  late Coordinate coordinate;
  String address = "";
  late Coordinate myCurrentLocation;
  late String myCurrentLocationToString;
  // List<MissingPerson> missingPersonList;
  late List<Coordinate> missingPersonCoordinates;

  final repository = LocationRepositoryImpl(
    locatorService: LocaterServiceImpl(),
    codingService: GeoCodingServiceImpl(),
  );

  loadMissingPersons(String address) {
    // 주소로부터 좌표를 가져와서 해당 좌표를 중심으로 실종자 목록을 불러온다
    // 좌표를 중심으로 실종자 목록을 불러온다
    // 주소로부터 좌표를 가져오는 로직이 필요하다
  }

  void getMyCurrentLocation() {
    repository.getMyCoordinate().then((coordinate) {
      print("Current Coordinate: ${coordinate.lat}, ${coordinate.long}");
      myCurrentLocation = coordinate;
    });
  }

  changeCamera(_controller) async {
    // 카메라 위치를 변경하는 로직이 필요하다
    final controller = await _controller.future;
    getMyCurrentLocation();
    // 지도 이동
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(myCurrentLocation.lat, myCurrentLocation.long), 16));
  }

  void getCoordinateFromAddress(String address) {
    repository.getCoordinateFromAddress(address).then((coordinate) {
      print('Coordinate from Address: ${coordinate.lat}, ${coordinate.long}');
    });
  }

  void getAddressFromCoordinate(Coordinate coordinate) {
    repository
        .getAddressFromCoordinate(
            Coordinate(lat: coordinate.lat, long: coordinate.long))
        .then((address) {
      print('Address from Coordinate: $address');
      myCurrentLocationToString = address;
    });
  }
}
