import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:kidsnursery/Models/user.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
final cron = Cron();
void scheduleTask(Users user) async {
  cron.schedule(Schedule.parse("0 0 */2 * *"), () async {
    final attendanceCollection = _firestore.collection('Attendance');
    final attendancenapshot = attendanceCollection.doc(user.userId);
    await attendancenapshot.set({
      'attendance': FieldValue.arrayUnion([
        {'childName': '', 'type': ''}
      ])
    });
    final healthcollection = _firestore.collection('health');
    final healthsnapshot = healthcollection.doc(user.userId);
    await healthsnapshot.set({
      'health': FieldValue.arrayUnion([
        {'Message': ''}
      ])
    });
    final diapersCollection = _firestore.collection('diapers');
    final diapersSnapshot = diapersCollection.doc(user.userId);
    await diapersSnapshot.set({
      'diapers': FieldValue.arrayUnion([
        {'childName': '', 'type': ''}
      ])
    });
    final messagesCollection = _firestore.collection('message');
    final messageSnapshot = messagesCollection.doc(user.userId);
    await messageSnapshot.set({
      'message': FieldValue.arrayUnion([
        {'childName': '', 'type': ''}
      ])
    });
    final mealsCollection = _firestore.collection('meals');
    final mealsnapshot = mealsCollection.doc(user.userId);
    await mealsnapshot.set({
      'meals': FieldValue.arrayUnion([
        {
          'meals': '',
        }
      ])
    });
    final activityCollection = _firestore.collection('activity');
    final activitynapshot = activityCollection.doc(user.userId);
    await activitynapshot.set({
      'activity': FieldValue.arrayUnion([
        {
          'childName': '',
        }
      ])
    });
    print('@@@@@@@@@@@@@@@@@@Alooooooooooooooo');
  });
}
