import 'package:flutter/material.dart';

class MissingpersonsList extends StatelessWidget {
  final ScrollController scrollController;
  final bool show;
  final List<String> items;
  MissingpersonsList(this.scrollController, this.show, this.items, {super.key});

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

    return Stack(children: [
      ListView.builder(
        controller: scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text('아이템 #$index'),
            subtitle: const Text('설명 텍스트'),
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
                  '목록을 표시할 수 없습니다.',
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
