import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reunite/data/service/missingPersons/fakeMissingPersonListServiceImpl.dart';
import 'package:reunite/data/service/missingPersons/missingPersonListServiceImpl.dart';
import 'package:reunite/ui/features/missingList/view/listView.dart';
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
        body: Stack(
          children: [
            GoogleMap(
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
            DraggableScrollableSheet(
              initialChildSize: 0.1, // 처음 보이는 높이 (20%)
              minChildSize: 0.1, // 최소 높이
              maxChildSize: 0.8, // 최대 높이 (화면의 절반)
              snap: true, // 스냅 활성화
              snapSizes: const [0.1, 0.8], // 20% 또는 50%에서만 멈춤
              builder: (context, scrollController) {
                if (scrollController.hasClients) {
                  scrollController.position.isScrollingNotifier.addListener(() {
                    final isMax = scrollController.position.viewportDimension >=
                        scrollController.position.maxScrollExtent;

                    if (isMax) {
                      viewModel.setisDraggable(true);
                    } else {
                      viewModel.setisDraggable(false);
                    }

                    print(
                        '## scrollController.position.viewportDimension : ${scrollController.position.viewportDimension}');
                    print(
                        '## scrollController.position.maxScrollExtent : ${scrollController.position.maxScrollExtent}');
                    print(
                        '## scrollController.position : ${scrollController.position.viewportDimension >= scrollController.position.maxScrollExtent}');
                  });
                }

                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: MissingpersonsList(
                      scrollController, viewModel.isDraggable, [
                    'test',
                    'test2',
                    'test3',
                    'test4',
                    'test5',
                    'test6',
                    'test7',
                    'test8',
                    'test9',
                    'test10'
                  ]),
                );
              },
            ),
          ],
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
