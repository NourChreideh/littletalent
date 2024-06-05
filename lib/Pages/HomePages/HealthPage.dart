import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kidsnursery/generated/l10n.dart';


class Healthpage extends StatefulWidget {
  final String userID;
  const Healthpage({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<Healthpage> createState() => _HealthpageState();
}

class _HealthpageState extends State<Healthpage> {
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
      body:        Stack(
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
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 20),
                     Text(
                      S.of(context).health,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height:50,),
                    FutureBuilder<List<DocumentSnapshot>>(
                  future: childrenData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No children found');
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
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
                                const SizedBox(height: 5),
                                Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xffE85171)),
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
                                const SizedBox(height: 5)
                              ],
                            ),
                            SizedBox(
                              height: 200,
                              width: 160,
                              child: Image.asset("assets/childhealth.png")),
                        
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                          child: Container(
                            child: Text(
                              selectedChild!['firstName'] != null
                                  ? "${S.of(context).wecompleted} ${selectedChild!['firstName']}, ${S.of(context).andwehave}"
                                  : "No health record",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
  
                             SizedBox(
                              height: 280,
                             
                              child: Image.asset("assets/girlhealth 1.png")),
                         
                       Stack(
                      alignment: Alignment.topCenter,
                         children: [


                           Padding(
                             padding: const EdgeInsets.only(top: 25),
                             child: Container(
                              height: 240,
                              width: 180,
                               decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                 gradient: LinearGradient(
                                   colors: [
                                        const Color(0xffE85171).withOpacity(0.2),
                                        const Color(0xffE85171)
                              
                                 
                                   
                                   ], 
                                   begin: Alignment.topCenter,        
                                   end: Alignment.bottomCenter,       
                                 ),
                               ),
                               child: Padding(
                                 padding: const EdgeInsets.all(15.0),
                                 child: Container(
                                   decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white.withOpacity(0.3)),
                                   child: Column(children: [

                                    const SizedBox(height: 10,),
                                      Text(S.of(context).dailycheck,style: TextStyle(color: Color(0xffE85171),fontSize: 18,fontWeight: FontWeight.w600),),
                                     const SizedBox(height: 10,),
                                     Row(
                                      children: [
                               SizedBox(
                                height: 60 ,
                                width: 30,
                                child: Image.asset("assets/tempmetrer.png",color: Colors.white,)),
                                     selectedChild != null &&
                                      (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('bodytemp')
                                  ?Text(" ${selectedChild!['bodytemp']} C",style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),):
                                   Text(S.of(context).noRecord,style: TextStyle(color: Colors.white),),
                                     ],),
                                             Row(
                                      children: [
                                                   const SizedBox(width: 3,),
                               SizedBox(
                                height: 40 ,
                                width: 30,
                                child: Image.asset("assets/medicine.png",color: Colors.white,)),
                                     selectedChild != null &&
                                      (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('bodytemp')
                                  ?Text(" ${selectedChild!['medicine']} ",style: 
                                   TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),):
                                   Text(S.of(context).noRecord,style: 
                                   TextStyle(color: Colors.white),),
                                     ],),
                                                Row(
                                      children: [
                                        const SizedBox(width: 3,),
                               SizedBox(
                                height: 50 ,
                                width: 30,
                                child: Image.asset("assets/clock.png",color: Colors.white,)),
                                     selectedChild != null &&
                                      (selectedChild!.data() as Map<String, dynamic>)
                                          .containsKey('bodytemp')
                                  ?Flexible(child: Text(" ${time(selectedChild!['healthtime']) } ",style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),)):
                                   Text(S.of(context).noRecord,style: TextStyle(color: Colors.white),),
                                     ],),
                                 
                                   ],),),
                               ),
                             ),
                           ),
                             CircleAvatar(
                              backgroundColor:const Color(0xffAEE4F6).withOpacity(0.3) ,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Center(child: Image.asset("assets/hearthhealtyh.png",color:  const Color(0xffE85171),)),
                              ),),
                         ],
                       ),
 

                        ],)
                     
                    
                      ],
                    );
                  },
                ),
                
                
                ]))
        ],
      ),

          
    );
  }
}
