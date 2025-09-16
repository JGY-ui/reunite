import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reunite/data/service/notice/NoticeService.dart';
import 'package:reunite/ui/features/missingMap/models/model.dart';

class NoticeServiceImpl implements NoticeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Notice>> loadNotice() async {
    final snapshot = await _firestore.collection('notices').get();
    return snapshot.docs.map((doc) => Notice.fromJson(doc.data())).toList();
  }
}
