import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:focus_test/helpers/colors.dart' show generateMaterialColor;
import 'package:focus_test/helpers/logger.dart';
import 'package:focus_test/pages/home/home.dart';
import 'package:focus_test/pages/home/provider.dart';
import 'package:focus_test/pages/pref/shared_pref_impl.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final res = await Future.wait([
    Firebase.initializeApp(),
    SharedPreferences.getInstance(),
  ]);

  runApp(Provider(
      create: (_) => SharedPreferencesImpl(res[1] as SharedPreferences),
      child: const MyApp()));
  // faEventColRef = collectionRef.withConverter<Event>(
  //   fromFirestore: (snapshot, _) =>
  //       Event.fromJson(snapshot.data()!..['id'] = snapshot.id),
  //   toFirestore: (user, _) => user.toJson(),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    logit('${context.read<SharedPreferencesImpl>()}');
    return MaterialApp(
      title: 'Focus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        textTheme: GoogleFonts.comboTextTheme(
            // openSansTextTheme
            // Theme.of(context).textTheme.apply(
            // bodyColor: AppColors.mainTextColor3,
            // ),
            ),
        primarySwatch: generateMaterialColor(const Color(0xFF9DE1AA)),
      ),
      home: MultiProvider(providers: [
        StreamProvider(
            create: (_) =>
                FirebaseFirestore.instance.collection('events').snapshots(),
            initialData: null),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ], child: const HomePage()),
    );
  }
}
