import 'package:proxima/classes/models/user.dart';
import 'database.dart';

extension MapDatabase on Database {

  Future<List<User>> getInstructorsWithinRadius(
    double userLocationX,
    double userLocationY,
    double radius,
  ) async {
    final query = firestore.collection('users').where(
      'locationX', 
      isLessThan: userLocationX + radius,
      isGreaterThan: userLocationX - radius,
    ).where(
      'locationY',
      isLessThan: userLocationY + radius,
      isGreaterThan: userLocationX - radius,
    );
    final result = await query.get();
    return result.docs.map((doc){
      return User.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }
}
