import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/router/route_config.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getMediaQueryHeight(context) * 0.08,
      width: getMediaQueryWidth(context),
      color: secondaryColor,
      child: Center(
        child: IconButton(
          iconSize: 35,
          icon: Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Get.toNamed(RouteConfig.homepage);
          },
        ),
      ),
    );
  }
}
