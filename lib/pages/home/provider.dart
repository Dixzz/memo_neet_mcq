part of 'home.dart';

class HomeProvider extends ChangeNotifier {
  // late final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  // late final StreamController _streamCtr;

  final CollectionReference<Question> _quesRef;
  final SharedPreferencesImpl _pref;

  HomeProvider(this._quesRef, this._pref) {
    Future(() async {
      final path = _pref.getLastQuestionRef();
      var q = _quesRef.limit(1);
      if (path != null) {
        var res = await _quesRef.doc(path).get();
        q = q.startAfterDocument(res);
        logit("fetching after ${res.data()}");
      }
      q.get().then((value) => logit(value.docs.length));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    logit();
    super.dispose();
    // _streamCtr.close();
  }

  int c = -1;

  void update() {
    c += 1;
    notifyListeners();
  }
}
