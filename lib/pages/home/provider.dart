part of 'home.dart';

class HomeProvider extends ChangeNotifier {
  // late final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  // late final StreamController _streamCtr;

  HomeProvider() {
    logit("Created");
    logit("Current ${FirebaseAuth.instance.currentUser?.toString()}");
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
