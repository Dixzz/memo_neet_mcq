import 'package:flutter/material.dart';
import 'package:focus_test/gen/colors.gen.dart';
import 'package:focus_test/helpers/dates.dart';
import 'package:focus_test/helpers/sized_box.dart';
import 'package:focus_test/pages/login/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../helpers/cards.dart';
import '../../helpers/logger.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorName.blue.shade50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Statusbar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer(
                  child: Text(
                    'Profile',
                    style: GoogleFonts.comfortaa(
                        color: ColorName.blue.shade800,
                        fontSize: 22,
                        fontWeight: FontWeight.w900),
                  ),
                  builder: (_, User? w, ch) => w != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ch!,
                            const SpaceVertical(24),
                            RoundedCard(
                                elevation: 1,
                                radius: 28,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'User',
                                      ),
                                      Text(
                                        w.email,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                )),
                            const SpaceVertical(12),
                            const Divider(),
                            const SpaceVertical(8),
                            Wrap(
                              runSpacing: 16,
                              spacing: 12,
                              children: [
                                Builder(builder: (_) {
                                  final ansDate = w.duration;
                                  if (ansDate == null)
                                    return const SizedBox.shrink();
                                  return RoundedCard(
                                      elevation: 1,
                                      radius: 28,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Last Played',
                                            ),
                                            Text(
                                              DatePatterns.eeeddmmmyy
                                                  .format(ansDate),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 28,
                                                  color:
                                                      ColorName.blue.shade700),
                                            )
                                          ],
                                        ),
                                      ));
                                }),
                                RoundedCard(
                                    elevation: 1,
                                    radius: 28,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Longest Streak',
                                          ),
                                          Text(
                                            w.streak.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 28,
                                                color: Colors.blue),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            const SpaceVertical(12),
                            const Divider(),
                            const SpaceVertical(12),
                            Builder(builder: (_) {
                              if (w.totalAns < 1) {
                                return const SizedBox.shrink();
                              }
                              final perc = double.parse((w.correctAns / w.totalAns).toStringAsFixed(2));
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Accuracy',
                                    ),
                                    const SpaceVertical(16),
                                    CircularPercentIndicator(
                                      radius: 50.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent: perc,
                                      center: Text(
                                        "${perc * 100}%",
                                        style: GoogleFonts.comfortaa(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20),
                                      ),
                                      backgroundColor: Colors.grey.shade300,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: ColorName.blue.shade800,
                                    ),
                                  ],
                                ),
                              );
                            })
                          ],
                        )
                      : const Center(child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
    );
  }
}
