import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:we_travel/model/WeTravelModel.dart';

import '../ui_tabs/account/AccountTab.dart';
import '../ui_tabs/myVideo/MyVideoTab.dart';
import '../utils.dart';

class HomeScreen extends StatelessWidget {
  final int tabCount = 2;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<WeTravelModel>(
        model: weTravelModel,
        child: ScopedModelDescendant<WeTravelModel>(builder:
            (BuildContext inContext, Widget? child, WeTravelModel accountModel) {
          return DefaultTabController(
              length: tabCount,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: showAppBar(context),
                body: TabBarView(
                  children: [AccountTab(), MyVideoTab()],
                ),
              ));
        }));
  }

  showAppBar(BuildContext context) {
    return AppBar(
      title: Text("We travel"),
      actions: [
        IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(AvailableRoutes().settingsScreen);
            })
      ],
      bottom: TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.account_circle_outlined),
            text: "My account",
          ),
          Tab(
            icon: Icon(Icons.videocam_sharp),
            text: "My videos",
          ),
        ],
      ),
    );
  }
}
