part of 'home.dart';

class HomeProvider extends ChangeNotifier {
  // late final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  // late final StreamController _streamCtr;

  final CollectionReference<Question> _quesRef;
  final CollectionReference<User> _userRef;
  final SharedPreferencesImpl _pref;

  Question? currentQuestion;
  bool finishedSet = false;
  bool? isCorrect;

  String? currentChoice;

  CountdownTimerController? ct;

  void updateChoice(String ch) {
    if (ch == currentChoice) return;
    currentChoice = ch;
    notifyListeners();
  }

  Future<void> scheduleTimer(DateTime? lastDate) => Future.microtask(() {
        logit("Called to schedule ");
        if (lastDate != null) {
          ct?.disposeTimer();
          ct = CountdownTimerController(
              onEnd: () {
                Future.microtask(() {
                  ct = null;
                  notifyListeners();
                });
              },
              endTime:
                  lastDate.add(const Duration(days: 1)).millisecondsSinceEpoch);
          notifyListeners();
          ct?.start();
        }
      });

  Future fetchQuestion() => Future.microtask(() async {
        final ansDate = _pref.getLastQuestionDateTime();
        if (ansDate != null &&
            DateTime.now().difference(ansDate).inDays < 1 &&
            _pref.getColLastQuestionRef() != currentQuestion?.id) {
          logit("time pending rescheduled");
          scheduleTimer(ansDate);
          return;
        }

        final path = _pref.getLastQuestionRef();
        var q = _quesRef.orderBy('date').limit(1);
        if (path != null) {
          final res = await _quesRef.doc(path).get();
          q = q.startAfterDocument(res);
          logit("fetching after ${res.data()?.id}");
        }
        q.get().then((value) {
          final nextQuest = value.docs.firstOrNull()?.data();
          if (nextQuest == null) {
            ct?.disposeTimer();
            currentQuestion = null;
            finishedSet = true;
            currentChoice = null;
            ct = null;
            notifyListeners();
            return;
          }

          currentQuestion = nextQuest;
          notifyListeners();
        }).onError((error, stackTrace) {
          logit(error);
        });
      });

  HomeProvider(this._quesRef, this._pref, this._userRef) {
    fetchQuestion();
  }

  Future<void> submitAnswer() async {
    final ch = currentChoice;
    final question = currentQuestion;
    if (ch == null) {
      Fluttertoast.showToast(msg: 'Please select a choice');
      return;
    }
    if (question == null) {
      Fluttertoast.showToast(
          msg: 'Please restart app unable to fetch question');
      return;
    }
    final res = _userRef.doc(_pref.userId!);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final user = (await res.get()).data();
      if (user != null) {
        if (user.lastAnsQuesRef == question.id) {
          logit("Same ques answered");
        }
        user
          ..totalAns += 1
          ..lastAnsQuesRef = question.id;

        final now = DateTime.now();

        if (question.choic[ch] == true) {
          user.correctAns += 1;
          final ansDate = user.duration;
          if (ansDate == null) {
            user.streak += 1;
          } else {
            if (now.difference(ansDate).inDays == 1) {
              user.streak += 1;
            } else {
              user.streak = 0;
            }
          }
          isCorrect = true;
        } else if (question.choic[ch] == false) {
          isCorrect = false;
        }

        _pref.saveLastQuestionDateTime(now);
        _pref.saveLastQuestionRef(question.id);
        user.duration = now;
        transaction.update(res, user.toJson());
        Future.microtask(() async {
          notifyListeners();
          await Future.delayed(const Duration(milliseconds: 1500));
          currentChoice = null;
          currentQuestion = null;
          isCorrect = null;
          notifyListeners();
          fetchQuestion();
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    logit();
    ct?.dispose();
    super.dispose();
    // _streamCtr.close();
  }
}
