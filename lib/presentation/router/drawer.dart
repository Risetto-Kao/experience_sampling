import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:experience_sampling/presentation/reuse_util/rwd.dart';
import 'package:experience_sampling/presentation/router/drawer_config.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryColor,
      child: ListView(padding: EdgeInsets.zero, children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))),
          height: getMediaQueryHeight(context) * 0.1,
        ),
        ...drawerInfos
            .map((info) => DrawerListTile(
                title: info.title,
                imagePath: info.imagePath,
                routeName: info.routeName))
            .toList()
      ]),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final String routeName;

  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))),
          child: ListTile(
            leading: Image.asset(imagePath),
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Get.toNamed(routeName),
          ),
        ),
      ],
    );
  }
}
