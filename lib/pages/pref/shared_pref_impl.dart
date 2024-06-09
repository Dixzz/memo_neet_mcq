import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_test/helpers/const.dart';
import 'package:focus_test/helpers/iterables.dart';
import 'package:focus_test/helpers/logger.dart';
import 'package:focus_test/pages/home/question.dart';
import 'package:focus_test/pages/login/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesImpl {
  final SharedPreferences _pref;

  const SharedPreferencesImpl(this._pref);

  bool get isLoggedIn => (userId != null);

  String? get userId => _pref.getString(Constants.user);

  String? getLastQuestionRef() => _pref.getString(Constants.lastAnsQuesRef);

  String? getColLastQuestionRef() => _pref.getString(Constants.lastQuesRef);

  DateTime? getLastQuestionDateTime() {
    final d = _pref.getInt(Constants.lastAnsQuesDateTime);
    if (d == null) return null;
    final date = DateTime.fromMillisecondsSinceEpoch(d);
    return date;
  }

  Future<void> saveLastQuestionRef(String value) =>
      _pref.setString(Constants.lastAnsQuesRef, value);

  Future<void> saveColLastQuestionRef(String value) =>
      _pref.setString(Constants.lastQuesRef, value);

  Future<void> saveLastQuestionDateTime(DateTime value) =>
      _pref.setInt(Constants.lastAnsQuesDateTime, value.millisecondsSinceEpoch);

  Future<void> saveUserRef(String value) =>
      _pref.setString(Constants.user, value);

  Future<bool> loginUser(
      String email,
      String password,
      final CollectionReference<User> userRef,
      CollectionReference<Question> quesColRef) async {
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
      final u = User(email);
      try {
        final lastQuesRef =
            (await quesColRef.orderBy('date').limitToLast(1).get())
                .docs
                .firstOrNull()
                ?.id;

        if (lastQuesRef != null) {
          await saveColLastQuestionRef(lastQuesRef);
        }

        final ref =
            (await userRef.where('email', isEqualTo: email).limit(1).get())
                    .docs
                    .firstOrNull()
                    ?.reference ??
                await userRef.add(u);
        // await ref.set(u);
        final lastQues = (await ref.get()).data();
        final time = lastQues?.duration;
        final quesRef = lastQues?.lastAnsQuesRef;

        if (time != null) {
          saveLastQuestionDateTime(time);
        }
        if (quesRef != null) {
          saveLastQuestionRef(quesRef);
        }
        saveUserRef(ref.id);
        return true;
      } catch (e) {
        logit(e);
      }
    }
    return false;
  }

  clear() => _pref.clear();
}
