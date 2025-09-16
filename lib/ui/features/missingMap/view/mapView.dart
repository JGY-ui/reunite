import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reunite/data/repository/missingPersons/fakeMissingPersonRepositoryImpl.dart';
import 'package:reunite/data/repository/missingPersons/missingPersonRepositoryImpl.dart';
import 'package:reunite/data/repository/notice/fakeNoticeRepositoryImpl.dart';
import 'package:reunite/data/repository/notice/noticeRepositoryImpl.dart';
import 'package:reunite/data/service/missingPersons/fakeMissingPersonListServiceImpl.dart';
import 'package:reunite/data/service/missingPersons/missingPersonListServiceImpl.dart';
import 'package:reunite/data/service/notice/fakeNoticeServiceImpl.dart';
import 'package:reunite/data/service/notice/noticeServiceImpl.dart';
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
                final sheetMaxHeight = MediaQuery.of(context).size.height * 0.5;
                if (scrollController.hasClients) {
                  scrollController.position.isScrollingNotifier.addListener(() {
                    final isMax = scrollController.position.viewportDimension >=
                        sheetMaxHeight;

                    if (isMax) {
                      viewModel.setisDraggable(true);
                    } else {
                      viewModel.setisDraggable(false);
                    }
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
                  child: MissingpersonsList(scrollController,
                      viewModel.isDraggable, viewModel.missingPersonsList),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            /// test code for fake notice repository
            var noticeRepositoryImpl =
                NoticeRepositoryImpl(service: NoticeServiceImpl());
            var noticData = await noticeRepositoryImpl.loadNotice();
            print('## notice data: ${noticData[0].content}');

            var fakeNoticeRepositoryImpl = FakeNoticeRepositoryImpl();
            var fakeNoticData = await fakeNoticeRepositoryImpl.loadNotice();
            print('## fake notice data: ${fakeNoticData[0].content}');

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
