import 'package:flutter/material.dart';

class MissingpersonsList extends StatelessWidget {
  final ScrollController scrollController;
  MissingpersonsList(this.scrollController, {super.key});

  final List<String> items = [
    'test',
    'test2',
    'test3',
    'test4',
    'test5',
  ];

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          '표시할 항목이 없습니다.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(child: Text('${index + 1}')),
          title: Text('아이템 #$index'),
          subtitle: const Text('설명 텍스트'),
        );
      },
    );
  }
}
