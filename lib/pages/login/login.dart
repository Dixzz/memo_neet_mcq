import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:focus_test/gen/assets.gen.dart';
import 'package:focus_test/helpers/const.dart';
import 'package:focus_test/helpers/context_extensions.dart';
import 'package:focus_test/helpers/logger.dart';
import 'package:focus_test/helpers/sized_box.dart';
import 'package:focus_test/pages/home/question.dart';
import 'package:focus_test/pages/login/user.dart';
import 'package:focus_test/pages/pref/shared_pref_impl.dart';
import 'package:focus_test/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:smart_auth/smart_auth.dart';

part 'provider.dart';

class ColorCycler extends StatefulWidget {
  const ColorCycler({
    Key? key,
  }) : super(key: key);

  @override
  _ColorCyclerState createState() => _ColorCyclerState();
}

class _ColorCyclerState extends State<ColorCycler>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  final Rainbow _rb = Rainbow(spectrum: const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.red,
  ], rangeStart: 0.0, rangeEnd: 300.0);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: Text(
        'Focus',
        textAlign: TextAlign.left,
        style: GoogleFonts.comfortaa(
          fontSize: 30,
          fontWeight: FontWeight.w900,
        ),
      ),
      builder: (_, ch) => ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(colors: [
          _rb[animation.value],
          _rb[(50.0 + animation.value) % _rb.rangeEnd]
          // animation.value,
          // Color(0xFF9090FF),
          // const Color(0xFF9DE1AA),
        ]).createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: ch,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 20), vsync: this);

    animation = Tween<double>(
            begin: _rb.rangeStart.toDouble(), end: _rb.rangeEnd.toDouble())
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    logit();
    super.dispose();
  }
}

class Login extends StatelessWidget {
  LoginProvider read(BuildContext context) => context.read();

  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final ctr = read(context);

    return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                // Color.fromRGBO(238, 215, 255, 1),
                Color.fromRGBO(255, 229, 229, 1.0),
                Color(0xFFEAFFF0),
              ]),
        ),
        child: Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: CustomScrollView(slivers: [
              // Text('data'),
              SliverPadding(
                  padding: EdgeInsets.only(
                      top: context.mediaQueryViewPadding.top + 16)),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SpaceVertical(24),
                    const ColorCycler(),
                    const SpaceVertical(4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Train your Brain',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            height: 1,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),

              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FilledButton.icon(
                              onPressed: ctr.clear,
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 14),
                                minimumSize: const Size(40, 35),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              label: const Text(
                                'Clear',
                                style: TextStyle(fontSize: 12),
                              ),
                              icon: const Icon(
                                Icons.clear_all_outlined,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                            const SpaceHorizontal(8),
                          ],
                        ),
                      ),
                      const SpaceVertical(12),
                      Selector(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SpaceVertical(4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Sign Up',
                                          style: GoogleFonts.comfortaa(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Selector(
                                          builder: (_, w, __) => FlutterSwitch(
                                                width: 30.0,
                                                height: 22.0,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                // valueFontSize: 25.0,
                                                toggleSize: 12.0,
                                                // borderRadius: 30.0,
                                                value: w,
                                                onToggle: ctr.signIn,
                                              ),
                                          selector: (_, LoginProvider v) =>
                                              v.isSignUp)
                                    ],
                                  ),
                                  const SpaceVertical(12),
                                  Builder(
                                      builder: (context) => context.select(
                                          (LoginProvider value) => !value
                                                  .isSignUp
                                              ? Text(
                                                  'Let’s Sign You In',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.comfortaa(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 24,
                                                  ),
                                                )
                                              : Text(
                                                  'Join Us',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.comfortaa(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 24,
                                                  ),
                                                ))),
                                  const SpaceVertical(36),
                                  Selector(
                                      builder: (_, w, __) {
                                        final isNameMode = w == ctr.name;
                                        return Stack(
                                          children: [
                                            Positioned(
                                              top: 16,
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                child: ctr.ctrSelected ==
                                                        ctr.name
                                                    ? const SizedBox.shrink()
                                                    : Wrap(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              ctr.toggle();
                                                              // controller
                                                              //     .selectedUserController
                                                              //     .value =
                                                              //     controller.idCon;
                                                            },
                                                            child:
                                                                SizedBox.square(
                                                                    dimension:
                                                                        24,
                                                                    child:
                                                                        Center(
                                                                      child: Transform
                                                                          .rotate(
                                                                        angle:
                                                                            3.1415,
                                                                        // in radians 1pie
                                                                        child: Assets
                                                                            .images
                                                                            .icArrowRight
                                                                            .svg(
                                                                                width: 16,
                                                                                color: Colors.grey),
                                                                      ),
                                                                    )),
                                                          ),
                                                          const SpaceHorizontal(
                                                              8),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              // width: 200,
                                              // width: isNameMode ? 200 : 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      198, 198, 198, 1),
                                                  width: 1,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 12),
                                              margin: EdgeInsets.only(
                                                  left: !isNameMode ? 40 : 0,
                                                  right: 56,
                                                  bottom: 0,
                                                  top: 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    isNameMode
                                                        ? 'Email'
                                                        : 'Password',
                                                    // textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            146, 146, 146, 1),
                                                        fontSize: 12),
                                                  ),
                                                  Builder(builder: (context) {
                                                    final passShow = context
                                                        .select((LoginProvider
                                                                value) =>
                                                            value
                                                                .passShowValue);
                                                    return Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                            child: TextField(
                                                          autofocus: true,
                                                          controller:
                                                              ctr.ctrSelected,
                                                          obscureText:
                                                              isNameMode
                                                                  ? false
                                                                  : !passShow,
                                                          enableSuggestions:
                                                              false,
                                                          autocorrect: false,
                                                          decoration: InputDecoration.collapsed(
                                                              hintText:
                                                                  'Enter ${isNameMode ? 'email' : 'password'}...',
                                                              hintStyle: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  height: 1)),
                                                        )),
                                                        AnimatedSwitcher(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                            child: !isNameMode
                                                                ? Row(
                                                                    children: [
                                                                      const SpaceHorizontal(
                                                                          8),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          read(context)
                                                                              .togglePassShow();
                                                                        },
                                                                        child: !passShow
                                                                            ? Assets.images.icEye.svg(
                                                                                color: Colors.grey,
                                                                                width: 20)
                                                                            : Assets.images.icEyeOff.svg(color: Colors.grey, width: 20),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : const SizedBox
                                                                    .shrink())
                                                      ],
                                                    );
                                                  })
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 12,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () async {
                                                  if (isNameMode) {
                                                    ctr.toggle();
                                                  } else {
                                                    await ctr.login(context);
                                                  }
                                                },
                                                child: AnimatedContainer(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        boxShadow:
                                                            ctr.ctrSelected ==
                                                                    ctr.pwd
                                                                ? [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(
                                                                                0.4),
                                                                        blurRadius: ctr.ctrSelected == ctr.pwd
                                                                            ? 8
                                                                            : 4,
                                                                        offset: const Offset(
                                                                            2,
                                                                            6))
                                                                  ]
                                                                : null,
                                                        color:
                                                            ctr.ctrSelected ==
                                                                    ctr.pwd
                                                                ? const Color(
                                                                    0xFFEAFFF0)
                                                                : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    child: Center(
                                                      child: Assets
                                                          .images.icArrowRight
                                                          .svg(width: 20),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      selector: (_, LoginProvider selector) =>
                                          selector.ctrSelected),
                                  const SpaceVertical(24),
                                ]),
                          ),
                          builder: (_, w, ch) => AnimatedContainer(
                                duration: const Duration(milliseconds: 600),
                                decoration: BoxDecoration(
                                    color: !w
                                        ? Colors.white
                                        : const Color(0xFFFFF6F0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.25),
                                          blurRadius: 17,
                                          offset: const Offset(0, 0)),
                                    ],
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        topLeft: Radius.circular(16))),
                                child: ch,
                              ),
                          selector: (_, LoginProvider sel) => sel.isSignUp),
                    ],
                  ),
                ),
              ),
            ])));
  }
}
