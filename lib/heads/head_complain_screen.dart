// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//

//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HeadComplainScreen(),
//     );
//   }
// }
//
// class HeadComplainScreen extends StatefulWidget {
//   const HeadComplainScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HeadComplainScreen> createState() => _HeadComplainScreenState();
// }
//
// class _HeadComplainScreenState extends State<HeadComplainScreen> {
//   String? imageUrl;
//   final picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadImage();
//   }
//
//   Future<void> _loadImage() async {
//     try {
//       final ref = FirebaseStorage.instance.ref().child('images/cat.png');
//       final url = await ref.getDownloadURL();
//       setState(() {
//         imageUrl = url;
//       });
//     } catch (e) {
//       print('Error loading image: $e');
//       setState(() {
//         imageUrl = null; // Handle error state gracefully
//       });
//     }
//   }
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffB8D0F8),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Color(0xcc0061FF),
//         title: Center(
//           child: Text(
//             "[@Head scr test]",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Center(
//                 child: imageUrl != null
//                     ? Image.network(
//                   imageUrl!,
//                   height: 200,
//                   width: 200,
//                   fit: BoxFit.cover,
//                 )
//                     : Icon(
//                   Icons.image,
//                   size: 150,
//                   color: Color(0xff666666),
//                 ),
//               ),
//               SizedBox(height: 29),
//               SizedBox(
//                 height: 247,
//                 width: 309,
//                 child: TextField(
//                   maxLines: null,
//                   expands: true,
//                   decoration: InputDecoration(
//                     hintText: 'Type your description here...',
//                     hintStyle: TextStyle(color: Color(0xffCACACA)),
//                     fillColor: Colors.grey[50],
//                     filled: true,
//                     prefixIcon: Icon(
//                       Icons.lock_outline,
//                       color: Color(0xffCACACA),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Color(0xff0061FF)),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Color(0xffCACACA)),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => rejectionScreen(),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(25, 0, 32, 0),
//                       child: Container(
//                         width: 108,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: Color(0xff0366FF),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(
//                               "Reject",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => acceptanceScreen(),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(25, 0, 32, 0),
//                       child: Container(
//                         width: 108,
//                         height: 45,
//                         decoration: BoxDecoration(
//                           color: Color(0xff0366FF),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(
//                               "Accept",
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
