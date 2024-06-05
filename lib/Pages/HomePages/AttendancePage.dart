import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/generated/l10n.dart'; // Import the intl package

class AttendancePage extends StatefulWidget {
  final String userID;

  const AttendancePage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
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
        selectedChild = data.first;
      }
      return data;
    });
  }

  String formatDateTime(Timestamp timestamp) {
    var dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String time(Timestamp timestamp) {
    var dateTime = timestamp.toDate();
    return DateFormat('hh:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Column(
            children: [
              SizedBox(height: 250),
              SizedBox(
                height: 500,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/containercustimizespng.png",
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
                     S.of(context).attendance,
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
                      return CircularProgressIndicator();
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
                              width: 20,
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
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Color(0xffE85171))),
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
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.asset(
                                  "assets/happykid.png",
                                  fit: BoxFit.fill,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: 100,
                                height: 30,
                                child: Image.asset(
                                  "assets/attendanceicon.png",
                                  fit: BoxFit.fill,
                                )),
                            Container(
                              height: 100,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 12,
                                        offset: Offset(0, 1),
                                        color:
                                            Color(0xffE85171).withOpacity(0.2))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xffBB9777)
                                              .withOpacity(0.5),
                                        ),
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xffBB9777)
                                              .withOpacity(0.5),
                                        ),
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xffBB9777)
                                              .withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                 selectedChild != null &&
                                      (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('checkedInTimestamp')&&  (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('checkedOutTimestamp')
                                  ?
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 210),
                                            child: Text(
                                              '${selectedChild!['firstName']} ${(selectedChild!['attendance'] == "checked in" ? "checked out" : "checked in")} ${S.of(context).bysystem}  _${time((selectedChild!["attendance"] != "checked in" ? selectedChild!['checkedInTimestamp'] : selectedChild!['checkedOutTimestamp']) as Timestamp)} _',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 18,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${formatDateTime((selectedChild!["attendance"] != "checked in" ? selectedChild!['checkedInTimestamp'] : selectedChild!['checkedOutTimestamp']) as Timestamp)}",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          )
                                        ],
                                      ):Text(S.of(context).noRecord),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 100,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 12,
                                        offset: Offset(0, 1),
                                        color:
                                            Color(0xffE85171).withOpacity(0.2))
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                      selectedChild != null &&
                                      (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('checkedInTimestamp')&&  (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('checkedOutTimestamp')
                                  ?
                                Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                          
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 200),
                                            child: Text(
                                              ' ${selectedChild!['firstName']} ${selectedChild!['attendance']}  ${S.of(context).bysystem}  _ ${time((selectedChild!["attendance"] == "checked in" ? selectedChild!['checkedInTimestamp'] : selectedChild!['checkedOutTimestamp']) as Timestamp)} _',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${formatDateTime((selectedChild!["attendance"] == "checked in" ? selectedChild!['checkedInTimestamp'] : selectedChild!['checkedOutTimestamp']) as Timestamp)} ",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ):Container(),
                                    Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xffBB9777)
                                              .withOpacity(0.5),
                                        ),
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xffBB9777)
                                              .withOpacity(0.5),
                                        ),
                                        CircleAvatar(
                                          radius: 6,
                                          backgroundColor: Color(0xffBB9777)
                                              .withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 100,
                                height: 30,
                                child: Image.asset(
                                  "assets/attendanceicon.png",
                                  fit: BoxFit.fill,
                                )),
                          ],
                        ),
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
