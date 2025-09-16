import 'package:flutter/material.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

class NoticeDetailedView extends StatelessWidget {
  final Notice noticeData;
  NoticeDetailedView(this.noticeData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice Detailed View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${noticeData.title}',
            ),
            SizedBox(height: 16),
            Text(
              '${noticeData.content}',
            ),
          ],
        ),
      ),
    );
  }
}
