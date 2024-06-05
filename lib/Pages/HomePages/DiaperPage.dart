import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/Utility/globalColors.dart';
import 'package:kidsnursery/generated/l10n.dart';

class DiaperPage extends StatefulWidget {
  final String userID;
  const DiaperPage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<DiaperPage> createState() => _DiaperPageState();
}

class _DiaperPageState extends State<DiaperPage> {
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
                      S.of(context).diapers,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                                height: 120,
                                width: 170,
                                child: Image.asset(
                                  "assets/diaperbaby.png",
                                  fit: BoxFit.fill,
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 20, right: 16),
                          child: Container(
                            child: Text(
                              selectedChild!['firstName'] != null
                                  ? S.of(context).welcometothe
                                  : S.of(context).noRecord,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 200,
                                width: 350,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 20,
                                          offset: Offset(0, 1),
                                          color: Color(0xffE85171)
                                              .withOpacity(0.1))
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(140),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Color(0xff92CA47).withOpacity(0.9)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white.withOpacity(0.3)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 100,
                                          ),
                                          child: Center(
                                            child: selectedChild != null &&
                                                    (selectedChild!.data()
                                                            as Map<String,
                                                                dynamic>)
                                                        .containsKey(
                                                            'diapers') &&
                                                    (selectedChild!.data()
                                                            as Map<String,
                                                                dynamic>)
                                                        .containsKey(
                                                            'diapertime')
                                                ? RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "${selectedChild!['firstName']} ",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffE85171)),
                                                        ),
                                                        TextSpan(
                                                          text: "make in ",
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${selectedChild!['diapers']} ${selectedChild!['diperContent']} ",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffE85171),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                             S.of(context).todaywetook,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text(
                                                    S.of(context).noRecord,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                   
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                                  selectedChild != null &&
                                                    (selectedChild!.data()
                                                            as Map<String,
                                                                dynamic>)
                                                        .containsKey(
                                                            'diapers') &&
                                                    (selectedChild!.data()
                                                            as Map<String,
                                                                dynamic>)
                                                        .containsKey(
                                                            'diapertime')
                                                ?
                                            Text(
                                              "${S.of(context).At} ${time(selectedChild!['diapertime'])}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white))
                                            :Container(),
                                            SizedBox(
                                              width: 20,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                                  selectedChild != null &&
                                                    (selectedChild!.data()
                                                            as Map<String,
                                                                dynamic>)
                                                        .containsKey(
                                                            'diapers') &&
                                                    (selectedChild!.data()
                                                            as Map<String,
                                                                dynamic>)
                                                        .containsKey(
                                                            'diapertime')
                                                ?
                            selectedChild!['diapers'] == "Couche"
                                ? SizedBox(
                                    height: 255,
                                    width: 150,
                                    child: Image.asset("assets/image 31.png"))
                                : SizedBox(
                                    height: 260,
                                    width: 150,
                                    child: Image.asset("assets/image 32.png")):
                                    SizedBox(
                                    height: 255,
                                    width: 150,
                                    child: Image.asset("assets/image 31.png"))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: 100,
                                child: Image.asset("assets/image 33.png")),
                            SizedBox(
                                height: 180,
                                child: Image.asset("assets/happydiaper.png")),
                          ],
                        )
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
