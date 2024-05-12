import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class UserStorageRepository {
  Future<bool> storeUserToDb(User user) async {
    // try {
    //   final a = await db
    //       .collection('users')
    //       .where(UserFieldNames.phoneNumber, isEqualTo: user.phoneNumber)
    //       .get();
    //   if (a.docs.isNotEmpty) {
    //     return false;
    //   }

    //   final payload = UserPayload(
    //     displayName: user.displayName,
    //     uid: user.uid,
    //     photoUrl: user.photoURL,
    //     phoneNumber: user.phoneNumber,
    //   );

    //   await db.collection('users').add(payload);
    //   return true;
    // } catch (e) {
    //   developer.log("User storage to firestore error", error: e);
    // }
    return false;
  }
}
