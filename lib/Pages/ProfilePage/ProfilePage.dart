import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kidsnursery/Models/user.dart';
import 'package:kidsnursery/Network/firebase_api.dart';
import 'package:kidsnursery/Pages/ProfilePage/childrens_view.dart';
import 'package:kidsnursery/generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
   final Users user;
  const ProfileScreen({super.key,required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    FirebaseApi firebaseApi = FirebaseApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: Stack(
children: [
   Column(
    mainAxisAlignment: MainAxisAlignment.end,
    
    children: [

Padding(
  padding: const EdgeInsets.only(left: 16,right: 16),
  child: Container(
  height: 520,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(60),
        topLeft: Radius.circular(60)),
      color: Colors.white,
      boxShadow: [BoxShadow(
  color: Colors.grey.withOpacity(0.4),
  offset: const Offset(1, 1),
  blurRadius: 5
  
    )]),
    child: Padding(
      padding: const EdgeInsets.only(left: 20,right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
       Text(S.of(context).stayclose,style: TextStyle(fontSize: 20,
      fontWeight: FontWeight.w600),),
       Text(S.of(context).livefrom,style: TextStyle(fontSize:16,
      fontWeight: FontWeight.w400 ,
      color: Colors.grey),),
   
       const Childrens(),
              SizedBox(height: 5,),
       SizedBox(child: Divider(color: Colors.grey.withOpacity(0.2),)),
              SizedBox(height: 15,),
         Text(
                            S.of(context).Money,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE85171)),
                          ),

                          SizedBox(height: 5,),
                          Row(children: [
 Text(
                               S.of(context).unpaid  ,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff70CCF3)),
                                  ),
SizedBox(width: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffE85171).withOpacity(0.1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "${widget.user.unpaidServices} \$",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                           ),
                                      ),
                                    ),
                                  ),

                          ],),
                                 
                       
      
      ],),
    )),
)

 ],),
 SizedBox(child: SvgPicture.asset("assets/profilebg.svg",fit: BoxFit.fill,),),

  SafeArea(
   child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.end  ,
                        children: [
                       
                        SizedBox(
   height: 210,
     child: Image.asset("assets/profilekids.png",fit: BoxFit.fill),), 
                          Padding(
                            padding: const EdgeInsets.only(right: 10,top: 30),
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "${widget.user.firstName} ${widget.user.lastName}",
                              style:  TextStyle(
                                color: Colors.white,
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
   
   
                        ],
                      ),
 )



]
 
),
    );
  }
}