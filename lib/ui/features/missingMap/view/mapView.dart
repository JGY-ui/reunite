import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reunite/data/repository/missingPersons/fakeMissingPersonRepositoryImpl.dart';
import 'package:reunite/data/repository/missingPersons/missingPersonRepositoryImpl.dart';
import 'package:reunite/data/service/missingPersons/fakeMissingPersonListServiceImpl.dart';
import 'package:reunite/data/service/missingPersons/missingPersonListServiceImpl.dart';
import 'package:reunite/ui/features/missingMap/models/coordinate.dart';
import 'package:reunite/ui/features/missingMap/viewModel/mapViewModel.dart';

class Mapview extends StatelessWidget {
  Mapview({super.key});
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MapViewModel>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.state == MapViewmodelState.intial) {
        viewModel.lodeIntialLocation();
      }
    });

    if (viewModel.state == MapViewmodelState.intial) {
      print('intial');
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (viewModel.state == MapViewmodelState.loaded) {
      // return Text('Loaded');
      print('Loaded');
      return Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: viewModel.initialCameraPosition!,
          onMapCreated: (controller) {
            _controller = controller;
            print(
                '# Map created with initial position: ${viewModel.initialCameraPosition}');
          },
          markers: viewModel.markers,
          onCameraMove: (position) {
            print('# Camera moved to: ${position.target}');
            viewModel.updateMissingPersonCoordinates(Coordinate(
                lat: position.target.latitude,
                long: position.target.longitude));
          },
          onCameraIdle: () async {
            viewModel.updateMissingMarke();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            ////////////////////////////////////////////////////////////////////
            MissingPersonRepositoryImpl missingPersonRepositoryImpl =
                MissingPersonRepositoryImpl(
              service: MissingPersonsServiceImpl(), // 실제 서비스 구현체
            );

            var missingPersonsList =
                await missingPersonRepositoryImpl.loadMissingPersons(
              address: viewModel.myCurrentLocationToString,
            );

            print('missingPersonsList: ${missingPersonsList[0].nm}');

            ////////////////////////////////////////////////////////////////////

            FakeMissingPersonRepositorylmpl fakeMissingPersonsServiceImpl =
                FakeMissingPersonRepositorylmpl();

            var fakeMissingPersonsList =
                await fakeMissingPersonsServiceImpl.loadMissingPersons(
              address: "",
            );

            print('fake missingPersonsList: ${fakeMissingPersonsList[0].nm}');

            ////////////////////////////////////////////////////////////////////

            await _controller?.moveCamera(
              CameraUpdate.newCameraPosition(viewModel.initialCameraPosition!),
            );
          },
          child: Icon(Icons.my_location),
        ),
      );
    } else {
      print('invalid state');
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
