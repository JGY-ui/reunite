import 'package:reunite/data/service/notice/noticeService.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

class FakeNoticeServiceImpl implements NoticeService {
  List<Notice> fakeNotices = [
    Notice(
      id: 1,
      title: "실종자 발견",
      content: "김영희(45세, 여성) 실종자가 부산 해운대구에서 발견되었습니다.",
      date: DateTime(2023, 3, 15).toString(),
    ),
    Notice(
      id: 2,
      title: "실종자 수색 중",
      content: "박지은(10세, 여성) 실종자를 대구 달서구 일대에서 수색 중입니다.",
      date: DateTime(2023, 3, 14).toString(),
    ),
    Notice(
      id: 3,
      title: "실종자 정보 업데이트",
      content: "이철수(71세, 남성) 실종자의 최근 사진과 특징이 업데이트되었습니다.",
      date: DateTime(2023, 3, 13).toString(),
    ),
  ];

  @override
  Future<List<Notice>> loadNotice() async {
    return fakeNotices;
  }
}
