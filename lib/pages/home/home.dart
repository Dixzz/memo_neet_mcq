import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_test/gen/colors.gen.dart';
import 'package:focus_test/helpers/iterables.dart';
import 'package:focus_test/helpers/sized_box.dart';
import 'package:focus_test/pages/home/question.dart';
import 'package:focus_test/pages/login/user.dart';
import 'package:focus_test/pages/pref/shared_pref_impl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';
import '../../helpers/logger.dart';

part 'provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider read = context.read();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Assets.images.bg.image(
              fit: BoxFit.fitHeight, opacity: const AlwaysStoppedAnimation(.2)),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: read.fetchQuestion,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.refresh_outlined,
                          ),
                        ),
                      ),
                    ),
                    const SpaceVertical(8),
                    Selector(
                        child: const Text('No Questions left'),
                        builder: (_, w, ch) =>
                            w ? ch! : const SizedBox.shrink(),
                        selector: (_, HomeProvider selector) =>
                            selector.finishedSet),
                    Selector(
                        child: const Text('Next Question in'),
                        builder: (_, w, ch) => w != null
                            ? Column(
                                children: [
                                  ch!,
                                  CountdownTimer(
                                    controller: w
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        selector: (_, HomeProvider selector) => selector.ct),
                    Stack(
                      alignment: Alignment.topCenter,
                      // fit: StackFit.expand,
                      children: [
                        Selector(
                            child: Column(
                              children: [
                                const SpaceVertical(24),
                                FilledButton(
                                    onPressed: read.submitAnswer,
                                    child: const Text('Submit')),
                              ],
                            ),
                            builder: (_, w, ch) {
                              var asciiStart = 65;
                              return w != null
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.white.withAlpha(100),
                                                border: Border.all(width: .2),
                                                borderRadius:
                                                    BorderRadius.circular(32)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    w.text,
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.comfortaa(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                  const SpaceVertical(24),
                                                  Wrap(
                                                    direction: Axis.vertical,
                                                    spacing: 12,
                                                    runAlignment:
                                                        WrapAlignment.center,
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: w.choic.keys
                                                        .map((e) => Selector(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 8),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  read.updateChoice(
                                                                      e);
                                                                },
                                                                child: Text(
                                                                    '${String.fromCharCode(asciiStart++)}. $e'),
                                                              ),
                                                            ),
                                                            builder: (_, w,
                                                                    ch) =>
                                                                DecoratedBox(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: w ==
                                                                            e
                                                                        ? Border.all(
                                                                            width:
                                                                                1.5,
                                                                            color:
                                                                                ColorName.blue)
                                                                        : null,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    color: ColorName
                                                                        .blue
                                                                        .shade100,
                                                                  ),
                                                                  child: ch,
                                                                ),
                                                            selector: (_,
                                                                    HomeProvider
                                                                        selector) =>
                                                                selector
                                                                    .currentChoice))
                                                        .toImmutableList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        ch!,
                                      ],
                                    )
                                  : const SizedBox.shrink();
                            },
                            selector: (_, HomeProvider selector) =>
                                selector.currentQuestion),
                        Positioned(
                          // left: 0,
                          // right: 0,
                          top: 0,
                          bottom: 0,
                          child: IgnorePointer(
                            child: Selector(
                                builder: (_, w, __) => w == null
                                    ? const SizedBox.shrink()
                                    : w
                                        ? Lottie.asset(Assets.images.confetti,
                                            animate: true, fit: BoxFit.contain)
                                        : Lottie.asset(Assets.images.wrong,
                                            animate: true, fit: BoxFit.contain),
                                selector: (_, HomeProvider sel) =>
                                    sel.isCorrect),
                          ),
                        )
                      ],
                    ),
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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
