import 'package:reunite/data/repository/notice/NoticeRepository.dart';
import 'package:reunite/data/service/notice/NoticeService.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeService _service;

  NoticeRepositoryImpl({required NoticeService service}) : _service = service;

  @override
  Future<List<Notice>> loadNotice() async {
    var noticData = await _service.loadNotice();
    print('## notice data: ${noticData[0].content}');
    return noticData;
  }
}
