// GoRouter configuration
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:focus_test/pages/home/home.dart';
import 'package:focus_test/pages/login/login.dart';
import 'package:focus_test/pages/login/user.dart';
import 'package:focus_test/pages/pref/shared_pref_impl.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/home/question.dart';

enum RouteNames {
  login,
  home,
  ;

  String get routeName {
    return "/$name";
  }

  Future navigate(BuildContext context, [dynamic arguments]) async {
    GoRouter.of(context).pushNamed(name, extra: arguments);
  }
  Future replaceRoute(BuildContext context) async {
    GoRouter.of(context).pushReplacementNamed(name);
  }
}

class RouteConfig {
  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: RouteNames.home.routeName,
    // observers: [_GoRouterObserver()],
    redirect: (BuildContext context, GoRouterState state) {
      if (!context.read<SharedPreferencesImpl>().isLoggedIn) {
        return RouteNames.login.routeName;
      } else {
        return null;
      }
    },
    routes: [
      GoRoute(
        name: RouteNames.home.name,
        path: RouteNames.home.routeName,
        builder: (context, state) => MultiProvider(providers: [
          Provider(
              create: (_) => FirebaseFirestore.instance
                  .collection('questionSet')
                  .withConverter(
                    fromFirestore: (snapshot, _) =>
                        Question.fromJson(snapshot.data()!),
                    toFirestore: (user, _) => user.toJson(),
                  )),
          StreamProvider(
              create: (_) => FirebaseFirestore.instance
                  .collection('questionSet')
                  .snapshots(),
              initialData: null),
          ChangeNotifierProvider(create: (_) => HomeProvider()),
        ], child: const HomePage()),
      ),
      GoRoute(
        name: RouteNames.login.name,
        path: RouteNames.login.routeName,
        builder: (context, state) => MultiProvider(
          providers: [
            Provider(
                create: (_) => FirebaseFirestore.instance
                    .collection('users')
                    .withConverter(
                      fromFirestore: (snapshot, _) =>
                          User.fromJson(snapshot.data()!..['id'] = snapshot.id),
                      toFirestore: (user, _) => user.toJson(),
                    )),
            /// [ChangeNotifierProvider] context, was passed above
            ChangeNotifierProvider(
                create: (context) => LoginProvider(
                    context.read<SharedPreferencesImpl>(),
                    context.read<CollectionReference<User>>()))
          ],
          child: const Login(),
        ),
      ),
    ],
  );
}
