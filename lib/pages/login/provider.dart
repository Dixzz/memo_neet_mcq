part of 'login.dart';

class LoginProvider extends ChangeNotifier {

  final _smartAuth = SmartAuth();
  final SharedPreferencesImpl _preferencesImpl;
  final CollectionReference<User> _userRef;
  final CollectionReference<Question> _quesRef;

  /// input fields
  late final name = TextEditingController();
  late final pwd = TextEditingController();
  late TextEditingController ctrSelected = name;
  late bool passShowValue = false;
  late bool isSignUp = false;

  LoginProvider(this._preferencesImpl, this._quesRef, this._userRef) {
    logit("Created");
    _smartAuth
        .getCredential(
      showResolveDialog: true,
      accountType: Constants.accType,
      isPasswordLoginSupported: true,
    )
        .then((value) {
      final id = value?.name;
      final pass = value?.password;
      if (id == null || pass == null) return;
      Future.microtask(() {
        name.text = id;
        pwd.text = pass;
        if (isSignUp) {
          isSignUp = false;
          notifyListeners();
        }
        if (ctrSelected != pwd) {
          ctrSelected = pwd;
          notifyListeners();
        }
      });
    });
  }

  void clear() {
    name.clear();
    pwd.clear();
    passShowValue = false;
    ctrSelected = name;
    notifyListeners();
  }

  void signIn(bool v) {
    isSignUp = v;
    notifyListeners();
  }

  void toggle() {
    if (ctrSelected == name) {
      ctrSelected = pwd;
    } else {
      ctrSelected = name;
    }
    notifyListeners();
  }

  Future<void> login(final BuildContext context) async {
    final email = name.text;
    final pass = pwd.text;

    if (email.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter email');
      return;
    }
    if (pass.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter password');
      return;
    }
    if (await _preferencesImpl.loginUser(email, pass, _userRef, _quesRef)) {
      _smartAuth.saveCredential(
          id: Constants.accType, name: email, password: pass);
      if (context.mounted) {
        RouteNames.home.replaceRoute(context);
      }
    }
  }

  @override
  void dispose() {
    name.dispose();
    pwd.dispose();
    logit();
    super.dispose();
  }

  void togglePassShow() {
    passShowValue = !passShowValue;
    notifyListeners();
  }
}
