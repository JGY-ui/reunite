import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class NoticeService {
  Future<List<Notice>> loadNotice();
}
