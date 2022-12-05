import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/presentation/pages/answer_intro/answer_intro_page.dart';
import 'package:experience_sampling/presentation/pages/connect/connect_page.dart';
import 'package:experience_sampling/presentation/pages/dp/dp_page.dart';
import 'package:experience_sampling/presentation/pages/history/history_page.dart';
import 'package:experience_sampling/presentation/pages/homepage/home_page.dart';
import 'package:experience_sampling/presentation/pages/questionnaire/questionnaire_page.dart';
import 'package:experience_sampling/presentation/pages/quit/quit_page.dart';
import 'package:experience_sampling/presentation/pages/right_intro/right_intro_page.dart';
import 'package:experience_sampling/presentation/pages/setting/setting_page.dart';
import 'package:experience_sampling/presentation/pages/test_q/test_q_page.dart';
import 'package:experience_sampling/presentation/reuse_util/app_scaffold.dart';

class RouteConfig {
  static const String homepage = "/";
  static const String history = "/history";
  static const String setting = "/setting";
  static const String dp = "/dp";
  static const String connect = "/connect";
  static const String questionnaire = "/questionnaire";
  static const String quit = "/quit";
  static const String answerIntro = "/answer_intro";
  static const String rightIntro = "/right_intro";
  static const String testQ = "/test_q";
  static const String testing = "/testing";

  static final List<GetPage> getPages = [
    GetPage(
        name: homepage,
        page: () => AppScaffold(child: HomeSection(), key: Key('home'))),
    GetPage(
        name: answerIntro,
        page: () => AppScaffold(
              child: AnswerIntroPage(),
              key: Key('answer_intro'),
            )),
    GetPage(
        name: rightIntro,
        page: () => AppScaffold(
              child: RightIntroPage(),
              key: Key('right_intro'),
            )),
    GetPage(
        name: connect,
        page: () => AppScaffold(
              child: ConnectPage(),
              key: Key('connect'),
            )),
    GetPage(
        name: history,
        page: () => AppScaffold(
              child: HistorySection(),
              key: Key('history'),
            )),
    GetPage(
        name: dp,
        page: () => AppScaffold(
              child: DPSection(),
              key: Key('dp'),
            )),
    GetPage(
        name: setting,
        page: () => AppScaffold(child: SettingSection(), key: Key('setting'))),
    GetPage(
        name: questionnaire,
        page: () => AppScaffold(
              child: QuestionnaireSection(),
              key: Key('questionnaire'),
            )),
    GetPage(name: quit, page: () => AppScaffold(child: QuitPage())),
    GetPage(name: testQ, page: () => AppScaffold(child: TestQPage())),
  ];
}
