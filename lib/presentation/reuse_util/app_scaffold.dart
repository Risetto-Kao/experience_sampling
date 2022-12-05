import 'package:flutter/material.dart';
import 'package:experience_sampling/presentation/reuse_util/header_section.dart';
import 'package:experience_sampling/presentation/router/drawer.dart';
import 'package:experience_sampling/presentation/styles/colors.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      key: _scaffoldKey,
      body: Column(
        children: [
          HeaderSection(),
          Stack(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  'Experience Sampling',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                height: 50,
                alignment: Alignment.center,
                color: secondaryColor,
              ),
              IconButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Expanded(child: widget.child)
        ],
      ),
    );
  }
}
