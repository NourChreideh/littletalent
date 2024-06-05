import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kidsnursery/Pages/language_picker_widget.dart';
import 'package:kidsnursery/generated/l10n.dart';
import 'package:kidsnursery/main.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      S.of(context).allnotifications,
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(
                      width: 15,
                    ),
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
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      S.of(context).settings,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
              

                     Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            S.of(context).notifications,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE85171)),
                          ),
                        ],
                      ),
                     
                 
                          SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: ListTile(
                                 shape: BeveledRectangleBorder(),
                    tileColor: const Color(0xffF5F5F5),
                    trailing: CupertinoTheme(
                      
                      data: CupertinoThemeData(
                        brightness: Brightness.light,
                        primaryColor: Color(0xffE85171), 
                        
                      ),
                      child: CupertinoSwitch(
                        value: switchValue,
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                          });
                        },
                      ),
                    ),
                    title: Text(
                      items.first,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                     Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Divider(color: Colors.grey.withOpacity(0.2),),
                      ),
                       SizedBox(height: 15,),

                     Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            S.of(context).language,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffE85171)),
                          ),
                        ],
                      ),

              
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              SizedBox(width: 16,),
                              Flexible(child: Text(S.of(context).selectthe,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                              SizedBox(width: 20,),
                              LanguagePickerWidget(),
                                 SizedBox(width: 30,),

                           
                            ],
                          ),
                          SizedBox(height: 15,),
                             Row(
                               children: [
                                SizedBox(width: 16,),
                                 Container(
                                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.95,),
                                   child: Text(S.of(context).letUs,
                                   style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xff949494)),),
                                 ),
                               ],
                             ),

                               SizedBox(height: 25,),
                     Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Divider(color: Colors.grey.withOpacity(0.2),),
                      ),
                       SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                                                  onTap: () {
                                                                    firebaseApi.signOut();
                                                                  },
                                                                  child:  Padding(
                                                           padding: const EdgeInsets.only(left: 16,right: 16),
                                                                    child: Container(
                                                                      
                                                                      decoration: BoxDecoration(
                                                                        border: Border.all(color: Color(0xff949494)),
                                                                        borderRadius: BorderRadius.circular(10)),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(10.0),
                                                                        child: Row(
                                                                 
                                                                      mainAxisSize: MainAxisSize.min,
                                                                          children: [
                                                             
                                        Icon(Icons.logout, color:  Color(0xffE85171)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                        S.of(context).signout,
                                          style: TextStyle(
                                             fontSize: 16,
                                        fontWeight: FontWeight.w600, color:  Color(0xffE85171)),
                                        ),
                                                                          
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                      ],
                                    ),
                             SizedBox(height: 40,),
                             Container(
                               child: Row(children: [
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.asset("assets/settingkid.png",fit: BoxFit.fill,)),
                               ],),
                             ),
                             
                              
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
