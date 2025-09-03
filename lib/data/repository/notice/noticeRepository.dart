import 'package:reunite/ui/features/missingMap/models/model.dart';

abstract class NoticeRepository {
  Future<List<Notice>> loadNotice();
}
