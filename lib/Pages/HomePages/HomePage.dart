import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kidsnursery/Models/HomeModel.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Pages/HomePages/ActivitiesPage.dart';
import 'package:kidsnursery/Pages/HomePages/AttendancePage.dart';
import 'package:kidsnursery/Pages/HomePages/DiaperPage.dart';
import 'package:kidsnursery/Pages/HomePages/HealthPage.dart';
import 'package:kidsnursery/Pages/HomePages/MealsPage.dart';
import 'package:kidsnursery/Pages/HomePages/Settings.dart';
import 'package:kidsnursery/Pages/HomePages/SleepingPage.dart';
import 'package:kidsnursery/generated/l10n.dart';

class HomePage extends StatefulWidget {
  final Users user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<HomeModel> list = [
      HomeModel(
        Image: "assets/meals.png",
        title: S.of(context).meals,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MealsPage(
                        userID: widget.user.userId,
                      )));
        },
      ),
      HomeModel(
          Image: "assets/health.webp",
          title: S.of(context).health,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Healthpage(
                          userID: widget.user.userId,
                        )));
          }),
      HomeModel(
          Image: "assets/baby-diaper-9988684-8160287.png",
          title: S.of(context).diapers,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DiaperPage(
                          userID: widget.user.userId,
                        )));
          }),
      HomeModel(
        Image: "assets/image 24.png",
        title: S.of(context).sleeping,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SleepingPage(
                        userID: widget.user.userId,
                      )));
        },
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      S.of(context).attendance,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffE85171)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AttendancePage(
                                  userID: widget.user.userId,
                                )));
                  },
                  child: Container(
                    height: 180,
                    width: 360,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffFDDFE1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "assets/attendance.avif",
                          height: 108,
                        ),
                        Container(
                          width: 360,
                          decoration: const BoxDecoration(
                              color: Color(0xff5ED571),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              S.of(context).checkess,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      S.of(context).dailyservices,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffE85171)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 15,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: list[index].onTap,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Container(
                                  height: 190,
                                  width: 160,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: const Color(0xffD7F3FE)),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Color(0xffE8FAFE),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          list[index].title,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff3680CA)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 100,
                                left: 20,
                                child: SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: Image.asset(
                                      list[index].Image,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      S.of(context).activities,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffE85171)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActivitiesPage(
                                  userID: widget.user.userId,
                                )));
                  },
                  child: Container(
                    width: 360,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xffFDDFE1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          child: Image.asset(
                            "assets/activities.jpg",
                            height: 150,
                            width: 360,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          width: 360,
                          decoration: BoxDecoration(
                              color: Color(0xff5ED571),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15))),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              S.of(context).dailyactivities,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
              height: 180,
              child: SvgPicture.asset(
                "assets/bgmain.svg",
                fit: BoxFit.fill,
              )),
          SafeArea(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(widget.user.profileimageUrl.toString())),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${S.of(context).hello} ${widget.user.firstName}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      S.of(context).yoursecondhome,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
