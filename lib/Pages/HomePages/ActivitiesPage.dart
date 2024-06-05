import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/generated/l10n.dart';

class ActivitiesPage extends StatefulWidget {
  final String userID;

  const ActivitiesPage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  late Future<List<DocumentSnapshot>> childrenData;
  DocumentSnapshot? selectedChild;

  Future<List<DocumentSnapshot>> getChildrenData(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Children')
        .get();
    return querySnapshot.docs;
  }

  @override
  void initState() {
    super.initState();
    childrenData = getChildrenData(widget.userID).then((data) {
      if (data.isNotEmpty) {
        setState(() {
          selectedChild = data.first;
        });
      }
      return data;
    });
  }

  final List<Color> staticColors = [
    Color(0xff92C947),
    Color(0xffFFB822),
    Color(0xffA771BC),
    Color(0xffFD51B5),
    Color(0xff92C947),
    Color(0xffFFB822),
    Color(0xffA771BC),
    Color(0xffFD51B5),
    Color(0xff92C947),
    Color(0xffFFB822),
    Color(0xffA771BC),
    Color(0xffFD51B5),
    Color(0xff92C947),
    Color(0xffFFB822),
    Color(0xffA771BC),
    Color(0xffFD51B5),
    Color(0xff92C947),
    Color(0xffFFB822),
    Color(0xffA771BC),
    Color(0xffFD51B5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 330,
                ),
                selectedChild != null &&
                        (selectedChild!.data() as Map<String, dynamic>)
                            .containsKey('activities')
                    ? ActivitiesList(selectedChild: selectedChild!)
                    : Center(
                        child: Text(
                          S.of(context).noactivities,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 160,
                child: SvgPicture.asset(
                  "assets/bgmain.svg",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                child: SvgPicture.asset(
                  "assets/settingbg.svg",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      S.of(context).activities,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                FutureBuilder<List<DocumentSnapshot>>(
                  future: childrenData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No children found');
                    }

                    List<DropdownMenuItem<DocumentSnapshot>> dropdownItems =
                        snapshot.data!.map((childDoc) {
                      return DropdownMenuItem<DocumentSnapshot>(
                        value: childDoc,
                        child: Text(
                            childDoc['firstName'] + ' ' + childDoc['lastName']),
                      );
                    }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).MyChildren,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffE85171)),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                        Border.all(color: Color(0xffE85171)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: DropdownButton<DocumentSnapshot>(
                                      isExpanded: true,
                                      value: selectedChild,
                                      underline: Container(),
                                      items: dropdownItems,
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedChild = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5)
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.asset("assets/paintactivities.png"),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 20, right: 16),
                          child: Container(
                            child: Text(
                              selectedChild != null &&
                                      selectedChild!['firstName'] != null
                                  ? "${S.of(context).Hereis} ${selectedChild!['firstName']} ${S.of(context).Participated}"
                                  : S.of(context).noRecord,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActivitiesList extends StatelessWidget {
  final DocumentSnapshot selectedChild;

  const ActivitiesList({Key? key, required this.selectedChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activities = selectedChild['activities'] as List;
    final List<Color> staticColors = [
      Color(0xff92C947),
      Color(0xffFFB822),
      Color(0xffA771BC),
      Color(0xffFD51B5),
      Color(0xff92C947),
      Color(0xffFFB822),
      Color(0xffA771BC),
      Color(0xffFD51B5),
      Color(0xff92C947),
      Color(0xffFFB822),
      Color(0xffA771BC),
      Color(0xffFD51B5),
      Color(0xff92C947),
      Color(0xffFFB822),
      Color(0xffA771BC),
      Color(0xffFD51B5),
      Color(0xff92C947),
      Color(0xffFFB822),
      Color(0xffA771BC),
      Color(0xffFD51B5),
    ];

    return SizedBox(
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: activities.length,
        itemBuilder: (context, index) {
          bool isEvenIndex = index.isEven;

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: isEvenIndex
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: isEvenIndex
                              ? Radius.circular(120)
                              : Radius.circular(12),
                          bottomRight: isEvenIndex
                              ? Radius.circular(12)
                              : Radius.circular(50),
                          topRight: isEvenIndex
                              ? Radius.circular(12)
                              : Radius.circular(12),
                          topLeft: isEvenIndex
                              ? Radius.circular(100)
                              : Radius.circular(12),
                        ),
                        color: staticColors[index],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${activities[index]}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              isEvenIndex
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: SizedBox(
                              height: 130,
                              child: Image.asset("assets/girlactivity.png")),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 80),
                          child: SizedBox(
                              height: 130,
                              child: Image.asset("assets/boyactivity.png")),
                        ),
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
