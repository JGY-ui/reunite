import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
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
            MissingPersonsServiceImpl missingPersonsService =
                MissingPersonsServiceImpl();

            var missingPersonsList =
                await missingPersonsService.loadMissingPersons(
              address: viewModel.myCurrentLocationToString,
            );

            print('missingPersonsList: ${missingPersonsList[0].nm}');

            ////////////////////////////////////////////////////////////////////

            FakeMissingPersonsServiceImpl fakeMissingPersonsService =
                FakeMissingPersonsServiceImpl();

            var fakeMissingPersonsList =
                await fakeMissingPersonsService.loadMissingPersons(
              address: "",
            );

            print('fake missingPersonsList: ${fakeMissingPersonsList[0].nm}');

            ////////////////////////////////////////////////////////////////////

            print(
                'initialCameraPosition 1111 : ${viewModel.initialCameraPosition}');

            await _controller?.moveCamera(
              CameraUpdate.newCameraPosition(viewModel.initialCameraPosition!),
            );
            print(
                'initialCameraPosition 2222 : ${viewModel.initialCameraPosition}');
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
