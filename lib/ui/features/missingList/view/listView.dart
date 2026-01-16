import 'package:flutter/material.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

class MissingpersonsList extends StatelessWidget {
  final ScrollController scrollController;
  final bool show;
  final List<MissingPerson> items;
  MissingpersonsList(this.scrollController, this.show, this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    print(
        '# MissingpersonsList build with ${items.length} / items.isEmpty : ${items.isEmpty} / show : $show');

    if (items.isEmpty) {
      return Center(
        child: Text(
          '표시할 항목이 없습니다.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return Stack(children: [
      ListView.builder(
        controller: scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('${items[index].nm}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('발생지역: ${items[index].occrAdres ?? '정보 없음'}'),
                Text('발생일자: ${items[index].occrde ?? '정보 없음'}'),
              ],
            ),
          );
        },
      ),
      if (!show)
        Positioned.fill(
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  '위로 올려주세요.',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
    ]);
  }
}
