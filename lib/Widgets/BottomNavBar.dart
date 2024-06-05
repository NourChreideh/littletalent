import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Pages/CenterPage.dart';
import 'package:kidsnursery/Pages/HomePages/HomePage.dart';
import 'package:kidsnursery/Pages/ProfilePage/ProfilePage.dart';
import 'package:kidsnursery/Pages/inbox_page.dart';
import 'package:kidsnursery/main.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar();

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Users user =
      Users(false, false, '', '', false, '', 0, Timestamp.now(), false, '');

  bool isLoading = true;
  int currentTab = 0;
  late Widget currentScreen;

  Future<void> fetchUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    user = await firebaseApi.fetchUser(currentUser!);
    setState(() {
      isLoading = false;
      currentScreen = HomePage(user: user);
    });
  }

  @override
  void initState() {
    super.initState();
    currentScreen = HomePage(user: user);
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: currentScreen,
          bottomNavigationBar: BottomAppBar(
            height: 60,
            color: Color(0xff70CCF3),
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentScreen = HomePage(user: user);
                      currentTab = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: currentTab == 0
                              ? Colors.white
                              : Color(0xff70CCF3),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SvgPicture.asset(
                        "assets/home.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentScreen = InboxScreen(user: user);
                      currentTab = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: currentTab == 1
                              ? Colors.white
                              : Color(0xff70CCF3),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SvgPicture.asset(
                        "assets/msg.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentScreen = CenterPage(user: user);
                      currentTab = 2;
                    });
                  },
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: currentTab == 2
                              ? Colors.white
                              : Color(0xff70CCF3),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SvgPicture.asset(
                        "assets/centericon.svg",
                        color: Colors.white,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentScreen = ProfileScreen(user: user);
                      currentTab = 3;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: currentTab == 3
                              ? Colors.white
                              : Color(0xff70CCF3),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: SvgPicture.asset(
                        "assets/profile.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
