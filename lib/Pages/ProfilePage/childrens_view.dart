import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidsnursery/Models/children.dart';
import 'package:kidsnursery/Pages/ProfilePage/cameraPage.dart';
import 'package:kidsnursery/Utility/globalColors.dart';



class Childrens extends StatefulWidget {
  const Childrens({Key? key}) : super(key: key);

  @override
  State<Childrens> createState() => _ChildrensState();
}

class _ChildrensState extends State<Childrens> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Users')
          .doc(currentUser!.uid)
          .collection('Children')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching Children.'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final childrens = snapshot.data?.docs;

        if (childrens == null || childrens.isEmpty) {
          return const Center(child: Text('No childrens found.'));
        }
        return SizedBox(
         height: 200,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: childrens.length,
            itemBuilder: (context, index) {
              final childrenData =
                  childrens[index].data() as Map<String, dynamic>;
              Children child = Children(
                  childrenData['age'],
                  childrenData['firstName'],
                  childrenData['lastName'],
                  childrenData['profileImageUrl'],
                  childrenData['Class'],
                  childrenData['ageType']
                  );

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
               
                  SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                          borderRadius: BorderRadiusDirectional.circular(12),
                          child: child.profileimageUrl.isNotEmpty
                              ? Image.network(
                                  child.profileimageUrl,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                )
                              : Image.asset(
                                  "assets/kid.webp",
                                  fit: BoxFit.fill,
                                ))),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${child.firstName} ${child.lastName}",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87,fontWeight: FontWeight.w500),
                      ),SizedBox(height: 5,),
                      Text(
                        "${child.age} ${child.ageType}",
                        style: const TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const Spacer(),
                InkWell(
                  onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraScreen(Url: child.ClassUrl,)),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: GlobalColors.mainColor.withOpacity(0.2),
                    child: Icon(Icons.video_camera_back,color: GlobalColors.mainColor,),),
                ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
