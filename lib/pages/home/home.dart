import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/logger.dart';

part 'provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Statusbar(),
          Builder(
              builder: (context) =>
                  Text('${context.select((HomeProvider value) => value.c)}')),
          ElevatedButton(
              onPressed: context.read<HomeProvider>().update,
              child: const Text('child')),
          // Expanded(
          //     child: Builder(
          //         builder: (context) => ListView(
          //               children: [
          //                 ...context
          //                     .watch<QuerySnapshot<Map<String, dynamic>>?>()
          //                     !.docs
          //                     .map((e) => Text(e.id))
          //               ],
          //             ))),
          Expanded(
            child: Consumer<QuerySnapshot<Map<String, dynamic>>?>(
                builder: (_, d, __) {
              final docs = d?.docs;
              if (docs == null) return const SizedBox.shrink();
              return Text('data ${docs.length}');
            }),
          ),
        ],
      ),
    );
  }
}
