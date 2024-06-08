import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:focus_test/gen/colors.gen.dart';
import 'package:focus_test/pages/pref/shared_pref_impl.dart';
import 'package:focus_test/router.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final res = await Future.wait([
    Firebase.initializeApp(),
    SharedPreferences.getInstance(),
  ]);

  final pref = SharedPreferencesImpl(res[1] as SharedPreferences);
  runApp(Provider(create: (_) => pref, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Focus',
      debugShowCheckedModeBanner: false,
      routerConfig: RouteConfig.router,
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.poppinsTextTheme(
            // openSansTextTheme
            // Theme.of(context).textTheme.apply(
            // bodyColor: AppColors.mainTextColor3,
            // ),
            ),
        primarySwatch: ColorName.blue,
      ),
    );
  }
}
