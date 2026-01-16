import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reunite/ui/features/noticeDetailedView/view/noticeDetailedView.dart';

class NoticeView extends StatelessWidget {
  final List noticeData;
  NoticeView(this.noticeData, {super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat inputFormat =
        DateFormat("yyyy-MM-dd HH:mm:ss"); // 문자열 포맷 맞추기
    final DateFormat outputFormat = DateFormat("yyyy-MM-dd HH:mm");
    return Scaffold(
        appBar: AppBar(
          title: Text('Notice'),
        ),
        body: Center(
          child: ListView.builder(
              itemBuilder: (context, index) {
                DateTime parsedDate = inputFormat.parse(noticeData[index].date);
                String formatted = outputFormat.format(parsedDate);

                return ListTile(
                  title: Text('${noticeData[index].title}'),
                  subtitle: Text(formatted),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NoticeDetailedView(noticeData[index])),
                    );
                  },
                );
              },
              itemCount: noticeData.length),
        ));
  }
}
