import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/generated/l10n.dart';

class MealsPage extends StatefulWidget {
  final String userID;

  const MealsPage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
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

  String formatDateTime(Timestamp timestamp) {
    var dateTime = timestamp.toDate();
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String time(Timestamp timestamp) {
    var dateTime = timestamp.toDate();
    return DateFormat('hh:mm').format(dateTime);
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
                      S.of(context).meals,
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
                                    border: Border.all(color: Color(0xffE85171)),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, right: 10),
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
                              child: Image.asset("assets/foodmeal.png"),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
                          child: Container(
                            child: Text(
                              selectedChild!['firstName'] != null
                                  ? "${S.of(context).iwant} ${selectedChild!['firstName']} ${S.of(context).mealstoday}"
                                  : S.of(context).nomealtaken,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    topRight: Radius.circular(150)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12,
                                      offset: Offset(0, 1),
                                      color: Color(0xffE85171).withOpacity(0.2))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: selectedChild != null &&
                                      (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('mealtype') &&
                                      (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('mealtime')
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(maxWidth: 280),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 20, color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${selectedChild!['firstName']} ",
                                                      style: TextStyle(
                                                          color: Color(0xffE85171)),
                                                    ),
                                                    TextSpan(
                                                      text: S.of(context).reallyEnjoyed,
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${selectedChild!['mealtype']} ",
                                                      style:
                                                          TextStyle(color: Colors.green),
                                                    ),
                                                    TextSpan(
                                                      text: S.of(context).todays,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                color: Color(0xffD7F3FE)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                "${S.of(context).At} ${time((selectedChild!['mealtime']) as Timestamp)}",
                                                style: TextStyle(
                                                    fontSize: 20, color: Colors.black),
                                              ),
                                            )),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${formatDateTime((selectedChild!['mealtime']) as Timestamp)}",
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(width: 10)
                                          ],
                                        )
                                      ],
                                    )
                                  : Center(
                                      child: Text(
                                        S.of(context).nomealtaken,
                                        style: TextStyle(fontSize: 20, color: Colors.red),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: SizedBox(
                            height: 150,
                            width: 50,
                            child: Image.asset(
                              "assets/rope 1.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 115,
                  width: 150,
                  child: Image.asset(
                    "assets/babyeat.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }
}
