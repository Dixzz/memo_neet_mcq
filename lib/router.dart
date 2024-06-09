// GoRouter configuration
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focus_test/gen/colors.gen.dart';
import 'package:focus_test/helpers/const.dart';
import 'package:focus_test/helpers/logger.dart';
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
  root,
  profile,
  ;

  String get routeName {
    return "/$name";
  }

  Future navigate(BuildContext context, [dynamic arguments]) async {
    return GoRouter.of(context).pushNamed(name, extra: arguments);
  }

  Future replaceRoute(BuildContext context) async {
    return GoRouter.of(context).replaceNamed(name);
  }
}

class RouteConfig {
  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: RouteNames.login.routeName,
    // observers: [_GoRouterObserver()],

    /// redirect lagging for first build Scaffold unable to generate
    redirect: (BuildContext context, GoRouterState state) {
      if (context.read<SharedPreferencesImpl>().isLoggedIn &&
          state.matchedLocation == RouteNames.login.routeName) {
        return RouteNames.root.routeName;
      } else {
        return null;
      }
    },
    routes: [
      // GoRoute(
      //     path: RouteNames.root.routeName,
      //     name: RouteNames.root.name,
      //     builder: (_, __) =>
      //         Scaffold(
      //           body: Text('child 1'),
      //           bottomNavigationBar: BottomNavigationBar(
      //             backgroundColor: ColorName.blue.shade50,
      //             type: BottomNavigationBarType.fixed,
      //             items: const [
      //               BottomNavigationBarItem(
      //                   icon: Icon(Icons.home), label: 'Home'),
      //               BottomNavigationBarItem(
      //                   icon: Icon(Icons.person_rounded), label: 'Profile'),
      //             ],
      //             currentIndex: 0,
      //           ),
      //         )),

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
                create: (context) => LoginProvider(
                    context.read(), context.read(), context.read()))
          ],
          child: const Login(),
        ),
      ),
      GoRoute(
        name: RouteNames.root.name,
        path: RouteNames.root.routeName,
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
              create: (context) =>
                  HomeProvider(context.read(), context.read(), context.read())),
        ], child: const HomePage()),
      ),
      GoRoute(
        name: RouteNames.profile.name,
        path: RouteNames.profile.routeName,
        builder: (context, state) => MultiProvider(providers: [
          FutureProvider(
              create: (context) => FirebaseFirestore.instance
                  .collection(Constants.faUsers)
                  .withConverter(
                    fromFirestore: (snapshot, _) =>
                        User.fromJson(snapshot.data()!),
                    toFirestore: (user, _) => user.toJson(),
                  )
                  .doc(context.read<SharedPreferencesImpl>().userId!)
                  .get().then((value) => value.data()),
              initialData: null)
        ], child: const Profile()),
      ),
    ],
  );
}
