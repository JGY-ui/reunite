import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reunite/data/repository/location/locationRepositoryImpl.dart';
import 'package:reunite/data/service/coding/geocodingServiceImpl.dart';
import 'package:reunite/data/service/locater/locaterServiceimpl.dart';
import 'package:reunite/data/service/missingPersons/fakeMissingPersonListServiceImpl.dart';
import 'package:reunite/data/service/missingPersons/missingPersonListServiceImpl.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

enum MapViewmodelState {
  intial,
  loading,
  loaded,
}

class MapViewModel extends ChangeNotifier {
  // 드래그 가능 여부
  bool isDraggable = false;

  setisDraggable(bool value) {
    isDraggable = value;
    print('# isDraggable : $isDraggable');
    notifyListeners();
  }

  // 레파지토리 설정
  final repository = LocationRepositoryImpl(
    locatorService: LocaterServiceImpl(),
    codingService: GeoCodingServiceImpl(),
  );

  // 상태 변수
  MapViewmodelState state = MapViewmodelState.intial;

  Set<Marker> markers = {};

  // 주소 변수
  String address = "";
  List<MissingPerson> missingPersonsList = [];
  // 현재 위치 변수
  Coordinate? myCurrentLocation;
  // 현재 주소 변수
  String myCurrentLocationToString = "";

  Coordinate? currentCameraCoordinate;

  // List<MissingPerson> missingPersonList;
  late Map<int, Coordinate> missingPersonCoordinates;
  // 초기 카메라 위치 설정
  //37.5665, 126.9780 - 서울
  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.5665, 126.9780),
    zoom: 14.4746,
  );

  // 초기화 작업
  Future<void> lodeIntialLocation() async {
    // 초기 작업인 경우
    if (state == MapViewmodelState.intial) {
      // 상태 갱신
      state = MapViewmodelState.loading;
      notifyListeners();
      // 현재 위치 가져오기
      myCurrentLocation = await repository.getMyCoordinate();
      // 초기 맵 카메라 위치 설정
      initialCameraPosition = CameraPosition(
        target: LatLng(myCurrentLocation?.lat ?? 37.5665,
            myCurrentLocation?.long ?? 126.9780),
        zoom: 14.4746,
      );
      // 페이크 실종자 명단 호출
      FakeMissingPersonsServiceImpl fakeMissingPersonsService =
          FakeMissingPersonsServiceImpl();
      missingPersonsList = await fakeMissingPersonsService.loadMissingPersons(
        address: address,
      );

      // 실제 실종자 명단 호출
      // MissingPersonsServiceImpl missingPersonsService =
      //     MissingPersonsServiceImpl();

      // missingPersonsList = await missingPersonsService.loadMissingPersons(
      //   address: address,
      // );

      print("# missingPersonsList : $missingPersonsList");

      // 상태 갱신
      state = MapViewmodelState.loaded;
      notifyListeners();
    }
  }

  // 주소를 바탕으로 실종자 목록을 불러온다
  _loadMissingPersons(String address) async {
    // 주소로부터 좌표를 가져와서 해당 좌표를 중심으로 실종자 목록을 불러온다
    // 좌표를 중심으로 실종자 목록을 불러온다

    // 실종자 명단 호출
    List<LatLng> missingPersonLatLngList = [];

    for (MissingPerson person in missingPersonsList) {
      if (person.occrAdres != null && person.occrAdres!.isNotEmpty) {
        LatLng? position = await _getCoordinateFromAddress(person.occrAdres!);
        if (position != null) {
          print('# position : $position');

          missingPersonLatLngList.add(position);
        }
      }
    }
  }

  // 현재 위치를 가져온다
  void _getMyCurrentLocation() {
    repository.getMyCoordinate().then((coordinate) {
      print("Current Coordinate: ${coordinate.lat}, ${coordinate.long}");
      myCurrentLocation = coordinate;
    });
  }

  // 현재 위치를 바탕으로 실종자 목록을 업데이트한다
  Future<void> updateMissingPersonCoordinates(Coordinate carmarPosition) async {
    currentCameraCoordinate = carmarPosition;
    print('# updateMissingPersonCoordinates: $currentCameraCoordinate');
  }

  Future<void> updateMissingMarke() async {
    // 현재 위치(위도, 경도)를 바탕으로 주소를 가져온다
    myCurrentLocationToString =
        await repository.getAddressFromCoordinate(currentCameraCoordinate);

    print('# myCurrentLocationToString : ${myCurrentLocationToString}');

    // 현재 주소를 바탕으로 실종자 목록을 불러온다
    _loadMissingPersons(myCurrentLocationToString);

    List<LatLng> missingPersonLatLngList = [];

    markers.clear();

    for (MissingPerson person in missingPersonsList) {
      if (person.occrAdres != null && person.occrAdres!.isNotEmpty) {
        LatLng? position = await _getCoordinateFromAddress(person.occrAdres!);
        if (position != null) {
          print('# position : $position / person.nm : ${person.nm}');

          missingPersonLatLngList.add(position);

          markers.add(
            Marker(
              markerId: MarkerId('${person.nm ?? '실종자'}'),
              position: position,
              infoWindow: InfoWindow(title: '${person.nm ?? '실종자'}'),
            ),
          );
        }
      }
    }

    markers.add(
      Marker(
        markerId: MarkerId('currentCameraCoordinate_location'),
        position:
            LatLng(currentCameraCoordinate!.lat, currentCameraCoordinate!.long),
        infoWindow: InfoWindow(title: 'currentCameraCoordinate Location'),
      ),
    );
    markers.add(
      Marker(
        markerId: MarkerId('myCurrentLocation_location'),
        position: LatLng(myCurrentLocation!.lat, myCurrentLocation!.long),
        infoWindow: InfoWindow(title: 'myCurrentLocation Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ),
    );

// fakeMissingPersonsList

    markers.add(
      Marker(
        markerId: MarkerId('myCurrentLocation_location'),
        position: LatLng(myCurrentLocation!.lat, myCurrentLocation!.long),
        infoWindow: InfoWindow(title: 'myCurrentLocation Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ),
    );

    notifyListeners();
  }

  // 주소를 바탕으로 좌표를 가져온다
  Future<LatLng> _getCoordinateFromAddress(String address) async {
    print('# address : $address');
    Coordinate coordinate = await repository.getCoordinateFromAddress(address);
    print('# address : ${coordinate.lat}, ${coordinate.long}');

    return LatLng(coordinate.lat, coordinate.long);
  }

  // 좌표를 바탕으로 주소를 가져온다
  void _getAddressFromCoordinate(Coordinate coordinate) {
    repository
        .getAddressFromCoordinate(
            Coordinate(lat: coordinate.lat, long: coordinate.long))
        .then((address) {
      print('Address from Coordinate: $address');
      myCurrentLocationToString = address;
    });
  }
}
