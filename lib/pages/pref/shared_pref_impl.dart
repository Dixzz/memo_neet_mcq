import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_test/helpers/const.dart';
import 'package:focus_test/helpers/iterables.dart';
import 'package:focus_test/helpers/logger.dart';
import 'package:focus_test/pages/login/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesImpl {
  final SharedPreferences _pref;

  const SharedPreferencesImpl(this._pref);

  bool get isLoggedIn => (_pref.get(Constants.user) != null);


  String? getLastQuestionRef() => _pref.getString(Constants.lastAnsQuesRef);

  Future<bool> loginUser(String email, String password,
      final CollectionReference<User> userRef) async {
    final res = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => value.user)
        .onError((error, stackTrace) {
      if (error is FirebaseAuthException) {
        final msg = error.message;
        if (error.code == 'email-already-in-use') {
          return FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password)
              .then((value) => value.user)
              .onError((error, stackTrace) {
            logit(error);
            return null;
          });
        }
        if (msg != null) {
          Fluttertoast.showToast(msg: msg);
        }
      }
      return null;
    });
    logit("Signed up $res");
    if (res != null) {
      final u = User();
      try {
        final ref = (await userRef.where('email', isEqualTo: email)
            .limit(1)
            .get())
            .docs
            .firstOrNull()
            ?.reference ??
            await userRef.add(u);
        // await ref.set(u);
        logit('Saved ${u.toJson()}');
        _pref.setString(Constants.user, ref.id);
        return true;
      } catch (e) {
        logit(e);
      }
    }
    return false;
  }
}
