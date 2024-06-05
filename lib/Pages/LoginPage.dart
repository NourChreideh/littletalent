import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kidsnursery/Network/Response/ApiResponse.dart';
import 'package:kidsnursery/Network/firebase_api.dart';
import 'package:kidsnursery/generated/l10n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final FirebaseApi firebaseApi = FirebaseApi();
TextEditingController _username = TextEditingController();
TextEditingController _password = TextEditingController();
bool isloading = true;

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    _password.clear();
    _username.clear();
    super.dispose();
  }

  void loadingDialog() {
    showDialog(
        context: context,
        builder: (context) => const SizedBox(
              height: 10,
              width: 50,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
            ));
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  void loggin(BuildContext context) async {
    loadingDialog();
    ApiResponse apiResponse = await firebaseApi.signInWithPhoneNumber(
        _username.text.trim(), _password.text.trim());

    displayMessage(apiResponse.message.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
        children: [
       Container(child: SvgPicture.asset("assets/Group 1171275131.svg",fit: BoxFit.fill,)),
       SizedBox(child: SvgPicture.asset("assets/Group 1171275132.svg",fit: BoxFit.fill,)),
      
        ],
      ),
      Column(children: [
        SizedBox(height: 220,),
Row(children: [

Image.asset("assets/Vector.png")

],),
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [

Image.asset("assets/cartoy1.png")

],),
SizedBox(height: 150,),

Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [

Image.asset("assets/school bag blue 1.png")

],),


SizedBox(height: 70,),
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [

Padding(
  padding: const EdgeInsets.only(left: 30),
  child: Image.asset("assets/Palette 1.png"),
)

],),
      ],),
         SingleChildScrollView(
           child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/logo.png",
                            fit: BoxFit.fill,
                          ))),
                ),
           
                Text(
                  S.of(context).welcome,
                  style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10,),
                Text(
                  S.of(context).loginsentence,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).username,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                    SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Color(0xff6DCEEF)),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _username,
                          decoration: InputDecoration(
                            hintText: S.of(context).username,
                            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 15),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).password,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                       SizedBox(height: 5,),
                                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: Color(0xff6DCEEF)),
                      ),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText:  "password",
                                                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8),fontSize: 15),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10.0),
                        ),
                      ),
                                    ),
                    ],
                  ),

                const SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () {
                    loggin(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                  color: Color(0xff92CA47),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).singin,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
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
