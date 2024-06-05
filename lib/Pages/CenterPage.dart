// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Widgets/BottomNavBar.dart';
import 'package:kidsnursery/generated/l10n.dart';

class CenterPage extends StatefulWidget {
  final Users user;
  const CenterPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<CenterPage> createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8faf9),
      body: Stack(
        children: [
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 700,),
            ],
          ),
                     Row(children: [
SizedBox(
  height: 350,
  width: 200,
  child: Image.asset("assets/rope.png",fit: BoxFit.fill,)),

  SizedBox(
  height: 350,
  width: 200,
  child: Image.asset("assets/rope.png",fit: BoxFit.fill,)),

              ],),
          SizedBox(
            height: 180,
            child: SvgPicture.asset("assets/profilebg.svg",fit: BoxFit.fill,)),

          SafeArea(
            child: Column(
              children: [
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Little Talent Childcare",
                          style: TextStyle(
                            color: Colors.white,
                              fontSize: 30 , fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          S.of(context).ChildCareService,
                          style: const TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
   const SizedBox(height: 80,),
              
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.3), 
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              S.of(context).adress,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                         Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              "assets/home-address.png",
                              height: 20,
                              width: 20,
                            ),
                         
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "Facing Saydet Zgharta Universal Hospital",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              S.of(context).contactinfo,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              "assets/telephone.png",
                              height: 20,
                              width: 20,
                            ),
                                 const SizedBox(
                              width: 15,
                            ),
                             const Text(
                              "71 876 183",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              "assets/insta.png",
                              height: 20,
                              width: 20,
                            ),
                                 const SizedBox(
                              width: 15,
                            ),
                             const Text(
                              "little_talent_childcare",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              "assets/facebook.png",
                              height: 20,
                              width: 20,
                            ),
                                 const SizedBox(
                              width: 15,
                            ),
                             const Text(
                              "little talent childcare",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 5,
                        ),
                         Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                             S.of(context).Operatinghours,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                     
                        DayOpen(S.of(context).Mondays),
                        const SizedBox(
                          height: 3,
                        ),
                        DayOpen(S.of(context).Tuesdays),
                        const SizedBox(
                          height: 3,
                        ),
                        DayOpen(S.of(context).Wednesdays),
                        const SizedBox(
                          height: 3,
                        ),
                        DayOpen(S.of(context).Thursdays),
                        const SizedBox(
                          height: 3,
                        ),
                        DayOpen(S.of(context).Fridays),
                        const SizedBox(
                          height: 3,
                        ),
                       
                        const Divider(),
                        const SizedBox(
                          height: 5,
                        ),
                         Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              S.of(context).CenterClosing,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                    
                     
                         Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              S.of(context).SaturdayandSunday,
                              style:
                                  const TextStyle(fontSize: 15, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),

    );
  }
}

Widget DayOpen(String day) {
  return Row(
    children: [
      const SizedBox(
        width: 15,
      ),
      Text(
        day,
        style: const TextStyle(fontSize: 15, color: Colors.black54),
      ),
      const Spacer(),
      const Text(
        "7:00 AM - 02:20 PM",
        style: TextStyle(fontSize: 15, color: Colors.black54),
      ),
      const SizedBox(
        width: 5,
      ),
    ],
  );
}
