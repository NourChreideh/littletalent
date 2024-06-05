import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class InboxScreen extends StatefulWidget {
  final Users user;
  const InboxScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
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

  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    childrenData = getChildrenData(widget.user.userId).then((data) {
      if (data.isNotEmpty) {
        setState(() {
          selectedChild = data.first;
        });
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
              Row(
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/image 36 (1).png"),
                  ),
                ],
              )
            ],
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    SizedBox(width: 20),
                    Text(
                      S.of(context).inbox,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
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
                            SizedBox(width: 20,),
                            SizedBox(
                              height: 180,
                              child: Image.asset("assets/boyact.png"))
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 40,),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Text(S.of(context).CashReceipt,style: TextStyle(fontSize: 20,),),
                  ],
                ),
                SizedBox(height: 20,),
                selectedChild != null &&
                (selectedChild!.data() as Map<String, dynamic>)
                    .containsKey('Payment')
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    
                        InkWell(
                          onTap: () {
                            String? paymentUrl = selectedChild!['Payment'];
                            if (paymentUrl != null && paymentUrl.isNotEmpty) {
                              _launchURL(paymentUrl);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Payment URL is invalid or empty'),
                              ));
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Color(0xffE85171).withOpacity(0.1)
                                )
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  S.of(context).Clickhere,
                                  style: const TextStyle(
                                    color: Color(0xffE85171),
                                    fontSize: 20, 
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : Text(
                      S.of(context).noRecord,
                      style: TextStyle(color: Colors.red),
                    ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    SizedBox(width: 15,),
                    Text("What's New!", style: TextStyle(fontSize: 20,),),
                  ],
                ),
                SizedBox(height: 20,),
                selectedChild != null &&
                (selectedChild!.data() as Map<String, dynamic>)
                    .containsKey('Message')
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Color(0xffE85171).withOpacity(0.1)
                              )
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                selectedChild!['Message'],
                                style: const TextStyle(
                                  fontSize: 16, 
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : Text(
                      S.of(context).noRecord,
                      style: TextStyle(color: Colors.red),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
