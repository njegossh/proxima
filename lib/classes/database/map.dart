
import 'database.dart';

extension MapDatabase on Database {


  Future getInstructorsWithinRadius(
    double userLocationX,
    double userLocationY,
    double radius,
  ) async {
    final query = firestore.collection('users').where(
      'locationX', 
      isLessThan: userLocationX + radius,
      isGreaterThan: userLocationX - radius,
    );
    return await query.get();
  }
}
