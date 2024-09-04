// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/labor_screen2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class LaborScreen1 extends StatefulWidget {
//   const LaborScreen1({super.key});
//
//   @override
//   State<LaborScreen1> createState() => _LaborScreen1State();
// }
//
// class _LaborScreen1State extends State<LaborScreen1> {
//   File? _image;
//   final picker = ImagePicker();
//   String? _selectedPriority;
//   String? _selectedComplaint;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(source: ImageSource.camera);
//         setState(() {
//           if (pickedFile != null) {
//             _image = File(pickedFile.path);
//           } else {
//             print('No image selected');
//           }
//         });
//       } catch (e) {
//         print('Error picking image: $e');
//       }
//     } else {
//       print('Camera permission denied');
//     }
//   }
//
//   Future<void> pickImage() async {
//     try {
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() => _image = File(pickedFile.path));
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   Future<DocumentReference ?> uploadImageWithDescription(File image, String description) async {
//     try {
//       // Upload the image to Firebase Storage
//       final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//       await storageRef.putFile(image);
//       final downloadUrl = await storageRef.getDownloadURL();
//
//       // Save the image URL and description to Firestore
//       DocumentReference docref = await FirebaseFirestore.instance.collection('complaints').add({
//         'imageUrl': downloadUrl,
//         'description': description,
//         'complaintCategory': _selectedComplaint,
//         'priority': _selectedPriority,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       print('Upload successful! URL: $downloadUrl');
//       return docref;
//     }
//     catch (e) {
//       print('Error uploading image: $e');
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
//             "[@Username]",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 120),
//               Center(
//                 child: InkWell(
//                   onTap: getImageFromCamera,
//                   borderRadius: BorderRadius.circular(100),
//                   child: Container(
//                     height: 65,
//                     width: 65,
//                     decoration: BoxDecoration(
//                       color: Color(0xffFBFBFB),
//                       borderRadius: BorderRadius.circular(100),
//                       border: Border.all(color: Color(0xffCACACA)),
//                     ),
//                     child: Icon(Icons.camera_alt_sharp),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 14),
//               _image == null
//                   ? Text('No image selected.')
//                   : Image.file(_image!, height: 150),
//               SizedBox(height: 26),
//               InkWell(
//                 onTap: pickImage,
//                 child: Container(
//                   height: 50,
//                   width: 196,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(7),
//                     color: Color(0xBAFBFBFB),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Upload an image',
//                         style: TextStyle(color: Color(0xff9D9C9C), fontSize: 15),
//                       ),
//                       SizedBox(width: 10),
//                       Image.asset('assets/upload_logo.png', height: 41, width: 41),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 29),
//               Container(
//                 height: 247,
//                 width: 309,
//                 child: TextField(
//                   controller: _descriptionController, // Controller to capture description
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
//               SizedBox(height: 20),
//               DropdownButton<String>(
//                 value: _selectedComplaint,
//                 items: [
//                   DropdownMenuItem(
//                     child: Text('Electrical'),
//                     value: 'Electrical',
//                   ),
//                   DropdownMenuItem(
//                     child: Text('Plumbing'),
//                     value: 'Plumbing',
//                   ),
//                   DropdownMenuItem(
//                     child: Text('General'),
//                     value: 'General',
//                   ),
//                 ],
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedComplaint = newValue;
//                   });
//                 },
//                 hint: Text('Complaint Category'),
//               ),
//               DropdownButton<String>(
//                 value: _selectedPriority,
//                 items: [
//                   DropdownMenuItem(
//                     child: Text('Low'),
//                     value: 'Low',
//                   ),
//                   DropdownMenuItem(
//                     child: Text('Medium'),
//                     value: 'Medium',
//                   ),
//                   DropdownMenuItem(
//                     child: Text('High'),
//                     value: 'High',
//                   ),
//                 ],
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedPriority = newValue;
//                   });
//                 },
//                 hint: Text('Define Priority'),
//               ),
//               SizedBox(height: 40),
//               InkWell(
//                 onTap: () async{
//                   if (_image != null) {
//                     // Upload image with description
//                     var docref = await uploadImageWithDescription(_image!, _descriptionController.text);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LaborScreen2(docref: docref!,)),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('no image selected')));
//                   }
//
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 67.5),
//                   child: Container(
//                     width: 200,
//                     decoration: BoxDecoration(
//                       color: Color(0xff0366FF),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Text(
//                               "Submit",
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Image.asset(
//                             "assets/submit.png",
//                             height: 60,
//                             width: 60,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
