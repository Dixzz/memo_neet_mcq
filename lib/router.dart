// GoRouter configuration
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_test/helpers/const.dart';
import 'package:focus_test/pages/home/home.dart';
import 'package:focus_test/pages/login/login.dart';
import 'package:focus_test/pages/login/user.dart';
import 'package:focus_test/pages/pref/shared_pref_impl.dart';
import 'package:focus_test/pages/profile/profile.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/home/question.dart';

enum RouteNames {
  login,
  home,
  profile,
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

class ScaffoldBottomNavigationBar extends StatelessWidget {
  const ScaffoldBottomNavigationBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key);

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: navigationShell.goBranch,
      ),
    );
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
      StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
                  StatefulNavigationShell navigationShell) =>
              ScaffoldBottomNavigationBar(
                navigationShell: navigationShell,
              ),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                name: RouteNames.home.name,
                path: RouteNames.home.routeName,
                builder: (context, state) => MultiProvider(providers: [
                  Provider(
                      create: (_) => FirebaseFirestore.instance
                          .collection(Constants.faQuestionSet)
                          .withConverter(
                            fromFirestore: (snapshot, _) => Question.fromJson(
                                snapshot.data()!..['id'] = snapshot.id),
                            toFirestore: (user, _) => user.toJson(),
                          )),
                  Provider(
                      lazy: true,
                      create: (_) => FirebaseFirestore.instance
                          .collection(Constants.faUsers)
                          .withConverter(
                            fromFirestore: (snapshot, _) =>
                                User.fromJson(snapshot.data()!),
                            toFirestore: (user, _) => user.toJson(),
                          )),
                  ChangeNotifierProvider(
                      create: (context) => HomeProvider(
                          context.read(), context.read(), context.read())),
                ], child: const HomePage()),
              )
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                name: RouteNames.profile.name,
                path: RouteNames.profile.routeName,
                builder: (context, state) => MultiProvider(providers: [
                  StreamProvider(
                      create: (context) => FirebaseFirestore.instance
                          .collection(Constants.faUsers)
                          .withConverter(
                            fromFirestore: (snapshot, _) =>
                                User.fromJson(snapshot.data()!),
                            toFirestore: (user, _) => user.toJson(),
                          )
                          .doc(context.read<SharedPreferencesImpl>().userId!)
                          .snapshots()
                          .map((event) => event.data()),
                      initialData: null)
                ], child: const Profile()),
              ),
            ])
          ]),
      GoRoute(
        name: RouteNames.login.name,
        path: RouteNames.login.routeName,
        builder: (context, state) => MultiProvider(
          providers: [
            Provider(
                create: (_) => FirebaseFirestore.instance
                    .collection(Constants.faQuestionSet)
                    .withConverter(
                      fromFirestore: (snapshot, _) => Question.fromJson(
                          snapshot.data()!..['id'] = snapshot.id),
                      toFirestore: (user, _) => user.toJson(),
                    )),
            Provider(
                create: (_) => FirebaseFirestore.instance
                    .collection(Constants.faUsers)
                    .withConverter(
                      fromFirestore: (snapshot, _) =>
                          User.fromJson(snapshot.data()!),
                      // User.fromJson(snapshot.data()!..['id'] = snapshot.id),
                      toFirestore: (user, _) => user.toJson(),
                    )),

            /// [ChangeNotifierProvider] context, was passed above
            ChangeNotifierProvider(
                create: (context) =>
                    LoginProvider(context.read(), context.read(), context.read()))
          ],
          child: const Login(),
        ),
      ),
    ],
  );
}
