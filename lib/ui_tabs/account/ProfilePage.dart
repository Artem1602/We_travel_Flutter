import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:we_travel/model/AccountModel.dart';

class ProfilePage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_scrollListener);

    return ScopedModel<AccountModel>(
        model: accountModel,
        child: ScopedModelDescendant<AccountModel>(
          builder: (BuildContext inContext, Widget? child,
              AccountModel accountModel) {
            return Scaffold(
                floatingActionButton: AnimatedOpacity(
                  child: FloatingActionButton(
                    child: Icon(Icons.edit),
                    onPressed: onEditFabPressed,
                  ),
                  duration: Duration(milliseconds: 350),
                  opacity: accountModel.fabOpacity,
                ),
                body: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/user_backGround.png"),
                                    fit: BoxFit.cover)),
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              child: Container(
                                  alignment: Alignment(0.0, 2.5),
                                  child: SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: accountModel.userImg)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        accountModel.userName!,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 10),
                      Text(accountModel.userStatus,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black45,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              children: [
                                Text("About me",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blueGrey,
                                    )),
                                SizedBox(height: 10),
                                Text(
                                  accountModel.userInfo,
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ));
          },
        ));
  }

  void _scrollListener() {
    if (_scrollController.offset > 15 &&
        !_scrollController.position.outOfRange) {
      accountModel.setHideFab(0);
    } else if (_scrollController.offset <= 15 &&
        !_scrollController.position.outOfRange) {
      accountModel.setHideFab(1);
    }
  }

  void onEditFabPressed() {
    accountModel.setStackIndex(1);
  }
}
