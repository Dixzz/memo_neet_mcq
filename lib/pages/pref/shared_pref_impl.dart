
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:focus_test/helpers/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesImpl {
  final SharedPreferences _pref;


  const SharedPreferencesImpl(this._pref);

  bool get isLoggedIn  => (_pref.get('id') != null);

  Future<bool> loginUser(String email, String password) async {
    final res = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)).user;
    logit("Signed in $res");
    if (res != null) {
      await _pref.setString('id', res.uid);
    }
    return res != null;
  }
}