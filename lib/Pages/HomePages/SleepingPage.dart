import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/generated/l10n.dart';

class SleepingPage extends StatefulWidget {
  final String userID;

  const SleepingPage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<SleepingPage> createState() => _SleepingPageState();
}

class _SleepingPageState extends State<SleepingPage> {
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
                     S.of(context).sleeping,
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
                              child: Image.asset("assets/image 35.png"),
                            )
                        
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
                          child: Container(
                            child: Text(
                            S.of(context).shhhh,
                                 
                              style: TextStyle(
                             fontStyle: FontStyle.italic,
                                fontSize: 20,),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 300  ,
                          width: 400,
                          child: Image.asset("assets/image 34.png")),
                           selectedChild != null &&
                                                    (selectedChild!.data()
                                                            as Map<String,
                                                                dynamic>)
                                                        .containsKey(
                                                            'sleepingFrom') &&
                                                    (selectedChild!.data()
                                                            as Map<String,
                                                                dynamic>)
                                                        .containsKey(
                                                            'diapertime')
                                                ? 

    Padding(
                          padding: const EdgeInsets.only(left: 16, top: 40, right: 16),
                          child: Container(
                            child: 
                            RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                      fontSize: 24, color: Colors.black),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${selectedChild!['firstName']} ",
                                                      style: TextStyle(
                                                          color: Color(0xffE85171)),
                                                    ),
                                                    TextSpan(
                                                      text: S.of(context).isSleeping,
                                                    ),
                                                       TextSpan(
                                                      text:
                                                          "${selectedChild!['sleepingFrom']} ",
                                                      style:
                                                          TextStyle(color: Colors.green),
                                                    ),
                                                   
                                                     TextSpan(
                                                      text: S.of(context).to,
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${selectedChild!['sleepingTo']} ",
                                                      style:
                                                          TextStyle(color: Colors.green),
                                                    ),
                                                   
                                                  ],
                                                ),
                                              ),
                            
                            
                          
                          ),
                        ): Padding(
                          padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
                          child: Container(
                            child: Text(
                           S.of(context).noRecord,
                                 
                              style: TextStyle(

                             fontStyle: FontStyle.italic,
                                fontSize: 20,),
                            ),
                          ),
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
