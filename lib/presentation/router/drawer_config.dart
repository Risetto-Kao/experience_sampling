import 'package:experience_sampling/presentation/constants/default_constants.dart';
import 'package:experience_sampling/presentation/router/route_config.dart';

final List<DrawerInfo> drawerInfos = <DrawerInfo>[
  // ? homepage
  DrawerInfo('首頁', ImagePath.HOME, RouteConfig.homepage), // *

  // todo: Icon need to change
  DrawerInfo('作答原則與報償', ImagePath.BOOK_OPEN, RouteConfig.rightIntro), // *
  DrawerInfo('名詞定義與範例', ImagePath.BOOK_OPEN, RouteConfig.answerIntro), // *
  DrawerInfo('基本設定', ImagePath.SETTINGS, RouteConfig.setting),
  DrawerInfo('填寫問卷', ImagePath.EDIT, RouteConfig.questionnaire), // *
  DrawerInfo('問卷紀錄', ImagePath.CALENDAR, RouteConfig.history), // *
  DrawerInfo('數位足跡', ImagePath.MAP_PIN, RouteConfig.dp),
  DrawerInfo('聯絡我們', ImagePath.MAIL, RouteConfig.connect),
  DrawerInfo('退出研究', ImagePath.MAIL, RouteConfig.quit),
  // DrawerInfo('初次試填', ImagePath.EDIT, RouteConfig.testQ),
];
