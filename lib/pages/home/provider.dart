import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  // late final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  // late final StreamController _streamCtr;

  HomeProvider() {
    // final path = FirebaseFirestore.instance.collection('events');
    // stream = path.snapshots();
    // _streamCtr = StreamController()..addStream(stream);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _streamCtr.close();
  }

  int c = -1;

  void update() {
    c += 1;
    notifyListeners();
  }
}
