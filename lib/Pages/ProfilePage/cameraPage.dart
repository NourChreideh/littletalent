import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:kidsnursery/Utility/globalColors.dart';
import 'package:kidsnursery/generated/l10n.dart';

class CameraScreen extends StatefulWidget {
  String Url;
  CameraScreen({required this.Url});
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late VlcPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VlcPlayerController.network(
      widget.Url,
      hwAcc: HwAcc.disabled,
      autoInitialize: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
  appBar: AppBar(
backgroundColor: Colors.black,
    title: Text(S.of(context).cameraFeed,style: TextStyle(fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.white),),
            leading:    InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
  ),
      body: Center(
        child: VlcPlayer(
          
          controller: _controller,
          aspectRatio: 16 / 9, 
          placeholder: Center(child: CircularProgressIndicator(color: GlobalColors.mainColor,)),
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:kidsnursery/Utility/globalColors.dart';

// class CameraScreen extends StatefulWidget {
//   final String url;
//   CameraScreen({required this.url});

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late VlcPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VlcPlayerController.network(
//       widget.url,
//       hwAcc: HwAcc.full, // Try enabling hardware acceleration
//       autoInitialize: true,
//       options: VlcPlayerOptions(
//         advanced: VlcAdvancedOptions([
//           '--network-caching=1500',
//           '--rtsp-tcp',
//         ]),
//         rtp: VlcRtpOptions([
//           '--rtsp-frame-buffer-size=100000'
//         ]),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Camera Feed',
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//         ),
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Center(
//         child: VlcPlayer(
//           controller: _controller,
//           aspectRatio: 16 / 9,
//           placeholder: Center(
//             child: CircularProgressIndicator(
//               color: GlobalColors.mainColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
