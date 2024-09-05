// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/labor_screen2.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
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
//   Future<File?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     print(file.lengthSync());
//     print(result?.lengthSync());
//
//     return result;
//   }
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(source: ImageSource.camera);
//         if (pickedFile != null) {
//           File? compressedFile = await compressImage(File(pickedFile.path));
//           setState(() {
//             _image = compressedFile;
//           });
//         } else {
//           print('No image selected');
//         }
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
//         File? compressedFile = await compressImage(File(pickedFile.path));
//         setState(() {
//           _image = compressedFile;
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   Future<DocumentReference?> uploadImageWithDescription(File image, String description) async {
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
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
//
//   void _showLoaderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
//
//   void _hideLoaderDialog(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffB8D0F8),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: Color(0xcc0061FF),
//        foregroundColor: Colors.white,
//         title: Center(
//           child: Text(
//             "[@Username]",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       drawer: Drawer(
//
//         child: ListView(
//           children: [
//             UserAccountsDrawerHeader(decoration: BoxDecoration(
//               image: DecorationImage(image: NetworkImage('https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),fit: BoxFit.cover),
//
//             ),
//                 currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),), accountName: Text('Hamza'), accountEmail: Text('hamza@cat.com'))
//             ,ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Profile'),
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
//               },
//             )
//
//           ],
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
//                   controller: _descriptionController,
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
//                 onTap: () async {
//                   if (_image != null) {
//                     _showLoaderDialog(context);
//                     // Upload image with description
//                     var docref = await uploadImageWithDescription(_image!, _descriptionController.text);
//                     _hideLoaderDialog(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LaborScreen2(docref: docref!)),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No image selected')));
//                   }
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


// first code ^

// //this code is w/out list
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/labor_screen2.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:firebase_auth/firebase_auth.dart';
// import '../login_v2.dart';
// import 'uesr_list.dart'; // Ensure this import is correct
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
//   List<String> _selectedComplaints = [];
//   String? _selectedPriority;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   Future<File?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(
//         dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     print(file.lengthSync());
//     print(result?.lengthSync());
//
//     return result;
//   }
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(source: ImageSource.camera);
//         if (pickedFile != null) {
//           File? compressedFile = await compressImage(File(pickedFile.path));
//           setState(() {
//             _image = compressedFile;
//           });
//         } else {
//           print('No image selected');
//         }
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
//         File? compressedFile = await compressImage(File(pickedFile.path));
//         setState(() {
//           _image = compressedFile;
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   Future<DocumentReference?> uploadImageWithDescription(
//       File image, String description) async {
//     try {
//       // Get the current user ID
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Upload the image to Firebase Storage
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//       await storageRef.putFile(image);
//       final downloadUrl = await storageRef.getDownloadURL();
//
//       // Determine the head based on selected complaints
//       final complaintCategory = _selectedComplaints.isNotEmpty
//           ? _selectedComplaints.first
//           : 'General';
//
//       // Save the image URL, description, and user ID to Firestore
//       DocumentReference docref =
//           await FirebaseFirestore.instance.collection('complaints').add({
//         'imageUrl': downloadUrl,
//         'description': description,
//         'complaintCategory': complaintCategory,
//         'priority': _selectedPriority,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': userId, // Include the user ID here
//       });
//
//       print('Upload successful! URL: $downloadUrl');
//       return docref;
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
//
//   void _showLoaderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
//
//   void _hideLoaderDialog(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   void _showMultiSelectDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         List<String> tempSelectedComplaints = List.from(_selectedComplaints);
//         return AlertDialog(
//           title: Text('Select Complaint Categories'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CheckboxListTile(
//                     title: Text('Electrical'),
//                     value: tempSelectedComplaints.contains('Electrical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Electrical');
//                         } else {
//                           tempSelectedComplaints.remove('Electrical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Mechanical'),
//                     value: tempSelectedComplaints.contains('Mechanical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Mechanical');
//                         } else {
//                           tempSelectedComplaints.remove('Mechanical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('HVAC'),
//                     value: tempSelectedComplaints.contains('HVAC'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('HVAC');
//                         } else {
//                           tempSelectedComplaints.remove('HVAC');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Utility'),
//                     value: tempSelectedComplaints.contains('Utility'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Utility');
//                         } else {
//                           tempSelectedComplaints.remove('Utility');
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   _selectedComplaints = tempSelectedComplaints;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//             builder: (context) =>
//                 LoginScreen()), // Navigate to your login screen
//         (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffB8D0F8),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: Color(0xcc0061FF),
//         foregroundColor: Colors.white,
//         title: Center(
//           child: Text(
//             "[@Username]",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       'https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: NetworkImage(
//                     'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
//               ),
//               accountName: Text('Hamza'),
//               accountEmail: Text('hamza@cat.com'),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Profile()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.list_alt),
//               title: Text('Complain List'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => MyGeneratedComplaintsScreen()),
//                 );
//               },
//             ),
//           ],
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
//                         style:
//                             TextStyle(color: Color(0xff9D9C9C), fontSize: 15),
//                       ),
//                       SizedBox(width: 10),
//                       Image.asset('assets/upload_logo.png',
//                           height: 41, width: 41),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 29),
//               Container(
//                 height: 247,
//                 width: 309,
//                 child: TextField(
//                   controller: _descriptionController,
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
//               ElevatedButton(
//                 onPressed: _showMultiSelectDialog,
//                 child: Text('Select Complaint Categories'),
//               ),
//               Wrap(
//                 children: _selectedComplaints
//                     .map((complaint) => Chip(
//                           label: Text(complaint),
//                           onDeleted: () {
//                             setState(() {
//                               _selectedComplaints.remove(complaint);
//                             });
//                           },
//                         ))
//                     .toList(),
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
//                 onTap: () async {
//                   if (_image != null) {
//                     _showLoaderDialog(context);
//                     // Upload image with description
//                     var docref = await uploadImageWithDescription(
//                         _image!, _descriptionController.text);
//                     _hideLoaderDialog(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => LaborScreen2(docref: docref!)),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('No image selected')));
//                   }
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
//
// multiple complain categiries
//

  //
  // import 'dart:io';
  // import 'package:cloud_firestore/cloud_firestore.dart';
  // import 'package:complaint_management_sys/labor_screen2.dart';
  // import 'package:complaint_management_sys/profile.dart';
  // import 'package:flutter/material.dart';
  // import 'package:flutter/services.dart';
  // import 'package:image_picker/image_picker.dart';
  // import 'package:permission_handler/permission_handler.dart';
  // import 'package:firebase_storage/firebase_storage.dart';
  // import 'package:flutter_image_compress/flutter_image_compress.dart';
  // import 'package:path_provider/path_provider.dart';
  // import 'package:path/path.dart' as path;
  // import 'package:firebase_auth/firebase_auth.dart';
  // import '../login_v2.dart';
  // import 'uesr_list.dart';
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
  //   List<String> _selectedComplaints = [];
  //   String? _selectedPriority;
  //   final TextEditingController _descriptionController = TextEditingController();
  //
  //   Future<void> requestPermission(Permission permission) async {
  //     var status = await permission.status;
  //     if (!status.isGranted) {
  //       status = await permission.request();
  //     }
  //   }
  //
  //   Future<File?> compressImage(File file) async {
  //     final dir = await getTemporaryDirectory();
  //     final targetPath = path.join(
  //         dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
  //
  //     var result = await FlutterImageCompress.compressAndGetFile(
  //       file.absolute.path,
  //       targetPath,
  //       quality: 50,
  //     );
  //
  //     print(file.lengthSync());
  //     print(result?.lengthSync());
  //
  //     return result;
  //   }
  //
  //   Future<void> getImageFromCamera() async {
  //     await requestPermission(Permission.camera);
  //     if (await Permission.camera.isGranted) {
  //       try {
  //         final pickedFile = await picker.pickImage(source: ImageSource.camera);
  //         if (pickedFile != null) {
  //           File? compressedFile = await compressImage(File(pickedFile.path));
  //           setState(() {
  //             _image = compressedFile;
  //           });
  //         } else {
  //           print('No image selected');
  //         }
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
  //         File? compressedFile = await compressImage(File(pickedFile.path));
  //         setState(() {
  //           _image = compressedFile;
  //         });
  //       }
  //     } on PlatformException catch (e) {
  //       print('Failed to pick image: $e');
  //     }
  //   }
  //
  //   Future<DocumentReference?> uploadImageWithDescription(
  //       File image, String description) async {
  //     try {
  //       // Get the current user ID
  //       String userId = FirebaseAuth.instance.currentUser!.uid;
  //
  //       // Upload the image to Firebase Storage
  //       final storageRef = FirebaseStorage.instance
  //           .ref()
  //           .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
  //       await storageRef.putFile(image);
  //       final downloadUrl = await storageRef.getDownloadURL();
  //
  //       // Concatenate the selected complaints into a single string
  //       String complaintCategories = _selectedComplaints.join(', ');
  //
  //       // Save the image URL, description, and user ID to Firestore
  //       DocumentReference docref =
  //       await FirebaseFirestore.instance.collection('complaints').add({
  //         'imageUrl': downloadUrl,
  //         'description': description,
  //         'complaintCategories': complaintCategories,
  //         'priority': _selectedPriority,
  //         'timestamp': FieldValue.serverTimestamp(),
  //         'userId': userId,
  //       });
  //
  //       print('Upload successful! URL: $downloadUrl');
  //       return docref;
  //     } catch (e) {
  //       print('Error uploading image: $e');
  //     }
  //   }
  //
  //   void _showLoaderDialog(BuildContext context) {
  //     showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return Dialog(
  //           backgroundColor: Colors.transparent,
  //           child: Container(
  //             alignment: Alignment.center,
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       },
  //     );
  //   }
  //
  //   void _hideLoaderDialog(BuildContext context) {
  //     Navigator.pop(context);
  //   }
  //
  //   void _showMultiSelectDialog() {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         List<String> tempSelectedComplaints = List.from(_selectedComplaints);
  //         return AlertDialog(
  //           title: Text('Select Complaint Categories'),
  //           content: StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState) {
  //               return Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   CheckboxListTile(
  //                     title: Text('Electrical'),
  //                     value: tempSelectedComplaints.contains('Electrical'),
  //                     onChanged: (bool? value) {
  //                       setState(() {
  //                         if (value == true) {
  //                           tempSelectedComplaints.add('Electrical');
  //                         } else {
  //                           tempSelectedComplaints.remove('Electrical');
  //                         }
  //                       });
  //                     },
  //                   ),
  //                   CheckboxListTile(
  //                     title: Text('Mechanical'),
  //                     value: tempSelectedComplaints.contains('Mechanical'),
  //                     onChanged: (bool? value) {
  //                       setState(() {
  //                         if (value == true) {
  //                           tempSelectedComplaints.add('Mechanical');
  //                         } else {
  //                           tempSelectedComplaints.remove('Mechanical');
  //                         }
  //                       });
  //                     },
  //                   ),
  //                   CheckboxListTile(
  //                     title: Text('HVAC'),
  //                     value: tempSelectedComplaints.contains('HVAC'),
  //                     onChanged: (bool? value) {
  //                       setState(() {
  //                         if (value == true) {
  //                           tempSelectedComplaints.add('HVAC');
  //                         } else {
  //                           tempSelectedComplaints.remove('HVAC');
  //                         }
  //                       });
  //                     },
  //                   ),
  //                   CheckboxListTile(
  //                     title: Text('Utility'),
  //                     value: tempSelectedComplaints.contains('Utility'),
  //                     onChanged: (bool? value) {
  //                       setState(() {
  //                         if (value == true) {
  //                           tempSelectedComplaints.add('Utility');
  //                         } else {
  //                           tempSelectedComplaints.remove('Utility');
  //                         }
  //                       });
  //                     },
  //                   ),
  //                 ],
  //               );
  //             },
  //           ),
  //           actions: [
  //             TextButton(
  //               child: Text('Cancel'),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 setState(() {
  //                   _selectedComplaints = tempSelectedComplaints;
  //                 });
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  //
  //   Future<void> _logout() async {
  //     try {
  //       await FirebaseAuth.instance.signOut();
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => LoginScreen()),
  //             (Route<dynamic> route) => false,
  //       );
  //     } catch (e) {
  //       print('Error signing out: $e');
  //     }
  //   }
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       backgroundColor: Color(0xffB8D0F8),
  //       appBar: AppBar(
  //         automaticallyImplyLeading: true,
  //         backgroundColor: Color(0xcc0061FF),
  //         foregroundColor: Colors.white,
  //         title: Center(
  //           child: Text(
  //             "[@Username]",
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ),
  //         actions: [
  //           IconButton(
  //             icon: Icon(Icons.logout),
  //             onPressed: _logout,
  //           ),
  //         ],
  //       ),
  //       drawer: Drawer(
  //         child: ListView(
  //           children: [
  //             UserAccountsDrawerHeader(
  //               decoration: BoxDecoration(
  //                 image: DecorationImage(
  //                   image: NetworkImage(
  //                       'https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //               currentAccountPicture: CircleAvatar(
  //                 backgroundImage: NetworkImage(
  //                     'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  //               ),
  //               accountName: Text('Hamza'),
  //               accountEmail: Text('hamza@cat.com'),
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.person),
  //               title: Text('Profile'),
  //               onTap: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => Profile()));
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.list_alt),
  //               title: Text('Complain List'),
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => MyGeneratedComplaintsScreen()),
  //                 );
  //               },
  //             ),
  //           ],
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
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: Color(0xff707070).withOpacity(0.4),
  //                           offset: Offset(0, 4),
  //                           blurRadius: 5,
  //                         ),
  //                       ],
  //                     ),
  //                     child: Icon(Icons.camera_alt),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 30),
  //               TextButton(
  //                 onPressed: pickImage,
  //                 child: Text(
  //                   "Upload from Gallery",
  //                   style: TextStyle(
  //                     decoration: TextDecoration.underline,
  //                     color: Color(0xff0061FF),
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //               if (_image != null)
  //                 Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Image.file(
  //                     _image!,
  //                     height: 250,
  //                   ),
  //                 ),
  //               SizedBox(height: 10),
  //               ElevatedButton(
  //                 onPressed: _showMultiSelectDialog,
  //                 child: Text("Select Complaint Category"),
  //               ),
  //               SizedBox(height: 20),
  //               DropdownButtonFormField<String>(
  //                 value: _selectedPriority,
  //                 items: [
  //                   DropdownMenuItem(value: "High", child: Text("High")),
  //                   DropdownMenuItem(value: "Medium", child: Text("Medium")),
  //                   DropdownMenuItem(value: "Low", child: Text("Low")),
  //                 ],
  //                 onChanged: (value) {
  //                   setState(() {
  //                     _selectedPriority = value!;
  //                   });
  //                 },
  //                 decoration: InputDecoration(
  //                   labelText: 'Select Priority',
  //                   border: OutlineInputBorder(),
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 15),
  //                 child: TextField(
  //                   controller: _descriptionController,
  //                   maxLines: 5,
  //                   decoration: InputDecoration(
  //                     hintText: 'Enter your description here',
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //               ElevatedButton(
  //                 onPressed: () async {
  //                   if (_image != null &&
  //                       _descriptionController.text.isNotEmpty) {
  //                     _showLoaderDialog(context);
  //                     await uploadImageWithDescription(
  //                       _image!,
  //                       _descriptionController.text,
  //                     );
  //                     _hideLoaderDialog(context);
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(content: Text('Complaint submitted successfully!')),
  //                     );
  //                   } else {
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(content: Text('Please complete all fields!')),
  //                     );
  //                   }
  //                 },
  //                 child: Text("Submit"),
  //               ),
  //               SizedBox(height: 20),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }



//complain in list


//video button
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/labor_screen2.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:firebase_auth/firebase_auth.dart';
// import '../login_v2.dart';
// import 'uesr_list.dart';
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
//   File? _video;
//   final picker = ImagePicker();
//   List<String> _selectedComplaints = [];
//   String? _selectedPriority;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   Future<File?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(
//         dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     print(file.lengthSync());
//     print(result?.lengthSync());
//
//     return result;
//   }
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(source: ImageSource.camera);
//         if (pickedFile != null) {
//           File? compressedFile = await compressImage(File(pickedFile.path));
//           setState(() {
//             _image = compressedFile;
//           });
//         } else {
//           print('No image selected');
//         }
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
//         File? compressedFile = await compressImage(File(pickedFile.path));
//         setState(() {
//           _image = compressedFile;
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   Future<void> getVideoFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickVideo(source: ImageSource.camera);
//         if (pickedFile != null) {
//           setState(() {
//             _video = File(pickedFile.path);
//           });
//         } else {
//           print('No video selected');
//         }
//       } catch (e) {
//         print('Error picking video: $e');
//       }
//     } else {
//       print('Camera permission denied');
//     }
//   }
//
//   Future<void> pickVideo() async {
//     try {
//       final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           _video = File(pickedFile.path);
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick video: $e');
//     }
//   }
//
//   Future<DocumentReference?> uploadImageWithDescription(
//       File image, String description) async {
//     try {
//       // Get the current user ID
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Upload the image to Firebase Storage
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//       await storageRef.putFile(image);
//       final downloadUrl = await storageRef.getDownloadURL();
//
//       // Save the image URL, description, and user ID to Firestore
//       DocumentReference docref =
//       await FirebaseFirestore.instance.collection('complaints').add({
//         'imageUrl': downloadUrl,
//         'description': description,
//         'complaintCategories': _selectedComplaints, // Save as a list
//         'priority': _selectedPriority,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': userId,
//       });
//
//       print('Upload successful! URL: $downloadUrl');
//       return docref;
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
//
//   Future<void> uploadVideoWithDescription(
//       File video, String description) async {
//     try {
//       // Get the current user ID
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Upload the video to Firebase Storage
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('videos/${DateTime.now().millisecondsSinceEpoch}.mp4');
//       await storageRef.putFile(video);
//       final downloadUrl = await storageRef.getDownloadURL();
//
//       // Save the video URL, description, and user ID to Firestore
//       await FirebaseFirestore.instance.collection('complaints').add({
//         'videoUrl': downloadUrl,
//         'description': description,
//         'complaintCategories': _selectedComplaints, // Save as a list
//         'priority': _selectedPriority,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': userId,
//       });
//
//       print('Video upload successful! URL: $downloadUrl');
//     } catch (e) {
//       print('Error uploading video: $e');
//     }
//   }
//
//   void _showLoaderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
//
//   void _hideLoaderDialog(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   void _showMultiSelectDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         List<String> tempSelectedComplaints = List.from(_selectedComplaints);
//         return AlertDialog(
//           title: Text('Select Complaint Categories'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CheckboxListTile(
//                     title: Text('Electrical'),
//                     value: tempSelectedComplaints.contains('Electrical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Electrical');
//                         } else {
//                           tempSelectedComplaints.remove('Electrical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Mechanical'),
//                     value: tempSelectedComplaints.contains('Mechanical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Mechanical');
//                         } else {
//                           tempSelectedComplaints.remove('Mechanical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('HVAC'),
//                     value: tempSelectedComplaints.contains('HVAC'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('HVAC');
//                         } else {
//                           tempSelectedComplaints.remove('HVAC');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Utility'),
//                     value: tempSelectedComplaints.contains('Utility'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Utility');
//                         } else {
//                           tempSelectedComplaints.remove('Utility');
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   _selectedComplaints = tempSelectedComplaints;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//             (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffB8D0F8),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: Color(0xcc0061FF),
//         foregroundColor: Colors.white,
//         title: Center(
//           child: Text('Labor Screen 1', style: TextStyle(fontSize: 20)),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xcc0061FF),
//               ),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//             ListTile(
//               title: Text('My Profile'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Profile()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text('Generate Complaint'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LaborScreen2(docref: null,)),
//                 );
//               },
//             ),
//             // Add more menu items here if needed
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               if (_image != null)
//                 Image.file(
//                   _image!,
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               if (_video != null)
//                 Container(
//                   child: Text("Video selected: ${_video!.path}"),
//                 ),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(
//                   labelText: 'Description',
//                 ),
//                 maxLines: 5,
//               ),
//               SizedBox(height: 10),
//               DropdownButton<String>(
//                 hint: Text('Select Priority'),
//                 value: _selectedPriority,
//                 items: ['High', 'Medium', 'Low'].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedPriority = newValue;
//                   });
//                 },
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _showMultiSelectDialog,
//                 child: Text('Select Complaint Categories'),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: getImageFromCamera,
//                 child: Text('Capture Image from Camera'),
//               ),
//               ElevatedButton(
//                 onPressed: pickImage,
//                 child: Text('Select Image from Gallery'),
//               ),
//               ElevatedButton(
//                 onPressed: getVideoFromCamera,
//                 child: Text('Capture Video from Camera'),
//               ),
//               ElevatedButton(
//                 onPressed: pickVideo,
//                 child: Text('Select Video from Gallery'),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_image != null || _video != null) {
//                     if (_descriptionController.text.isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Description cannot be empty!'),
//                         ),
//                       );
//                       return;
//                     }
//                     _showLoaderDialog(context);
//                     if (_image != null) {
//                       await uploadImageWithDescription(
//                         _image!,
//                         _descriptionController.text,
//                       );
//                     }
//                     if (_video != null) {
//                       await uploadVideoWithDescription(
//                         _video!,
//                         _descriptionController.text,
//                       );
//                     }
//                     _hideLoaderDialog(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LaborScreen2(docref: null,)),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Please select an image or video first!'),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// good code



// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/labor_screen2.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:firebase_auth/firebase_auth.dart';
// import '../login_v2.dart';
// import 'uesr_list.dart';
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
//   List<String> _selectedComplaints = [];
//   String? _selectedPriority;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   Future<File?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(
//         dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     print(file.lengthSync());
//     print(result?.lengthSync());
//
//     return result;
//   }
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(source: ImageSource.camera);
//         if (pickedFile != null) {
//           File? compressedFile = await compressImage(File(pickedFile.path));
//           setState(() {
//             _image = compressedFile;
//           });
//         } else {
//           print('No image selected');
//         }
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
//         File? compressedFile = await compressImage(File(pickedFile.path));
//         setState(() {
//           _image = compressedFile;
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   Future<DocumentReference?> uploadImageWithDescription(
//       File image, String description) async {
//     try {
//       // Get the current user ID
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Upload the image to Firebase Storage
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//       await storageRef.putFile(image);
//       final downloadUrl = await storageRef.getDownloadURL();
//
//       // Save the image URL, description, complaint categories, priority, and status to Firestore
//       DocumentReference docref = await FirebaseFirestore.instance
//           .collection('complaints')
//           .add({
//         'imageUrl': downloadUrl,
//         'description': description,
//         'complaintCategories': _selectedComplaints, // Save as a list
//         'priority': _selectedPriority,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': userId,
//         'status': 'acceptance pending', // Add the status field
//       });
//
//       print('Upload successful! URL: $downloadUrl');
//       return docref;
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//     return null;
//   }
//
//
//   void _showLoaderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
//
//   void _hideLoaderDialog(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   void _showMultiSelectDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         List<String> tempSelectedComplaints = List.from(_selectedComplaints);
//         return AlertDialog(
//           title: Text('Select Complaint Categories'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CheckboxListTile(
//                     title: Text('Electrical'),
//                     value: tempSelectedComplaints.contains('Electrical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Electrical');
//                         } else {
//                           tempSelectedComplaints.remove('Electrical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Mechanical'),
//                     value: tempSelectedComplaints.contains('Mechanical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Mechanical');
//                         } else {
//                           tempSelectedComplaints.remove('Mechanical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('HVAC'),
//                     value: tempSelectedComplaints.contains('HVAC'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('HVAC');
//                         } else {
//                           tempSelectedComplaints.remove('HVAC');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Utility'),
//                     value: tempSelectedComplaints.contains('Utility'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Utility');
//                         } else {
//                           tempSelectedComplaints.remove('Utility');
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   _selectedComplaints = tempSelectedComplaints;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//             (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: Color(0xffB8D0F8),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: Color(0xcc0061FF),
//         foregroundColor: Colors.white,
//         title: Center(
//           child: Text(
//             "[@Username]",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       'https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: NetworkImage(
//                     'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
//               ),
//               accountName: Text('Hamza'),
//               accountEmail: Text('hamza@cat.com'),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Profile()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.list_alt),
//               title: Text('Complain List'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => MyGeneratedComplaintsScreen()),
//                 );
//               },
//             ),
//           ],
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
//                         style:
//                         TextStyle(color: Color(0xff9D9C9C), fontSize: 15),
//                       ),
//                       SizedBox(width: 10),
//                       Image.asset('assets/upload_logo.png',
//                           height: 41, width: 41),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 29),
//               Container(
//                 height: 247,
//                 width: 309,
//                 child: TextField(
//                   controller: _descriptionController,
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
//               ElevatedButton(
//                 onPressed: _showMultiSelectDialog,
//                 child: Text('Select Complaint Categories'),
//               ),
//               Wrap(
//                 children: _selectedComplaints
//                     .map((complaint) => Chip(
//                   label: Text(complaint),
//                   onDeleted: () {
//                     setState(() {
//                       _selectedComplaints.remove(complaint);
//                     });
//                   },
//                 ))
//                     .toList(),
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
//                 onTap: () async {
//                   if (_image != null) {
//                     _showLoaderDialog(context);
//                     // Upload image with description
//                     var docref = await uploadImageWithDescription(
//                         _image!, _descriptionController.text);
//                     _hideLoaderDialog(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => LaborScreen2(docref: docref!)),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('No image selected')));
//                   }
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


//multiple images
//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import '../login_v2.dart';
//
// class LaborScreen1 extends StatefulWidget {
//   const LaborScreen1({super.key});
//
//   @override
//   State<LaborScreen1> createState() => _LaborScreen1State();
// }
//
// class _LaborScreen1State extends State<LaborScreen1> {
//   List<File> _images = [];
//   final picker = ImagePicker();
//   List<String> _selectedComplaints = [];
//   String? _selectedPriority;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   Future<File?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(
//         dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     print(file.lengthSync());
//     print(result?.lengthSync());
//
//     return result;
//   }
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(
//             source: ImageSource.camera, imageQuality: 50);
//         if (pickedFile != null) {
//           File? compressedFile = await compressImage(File(pickedFile.path));
//           if (compressedFile != null) {
//             setState(() {
//               _images.add(compressedFile);
//             });
//           }
//         } else {
//           print('No image captured');
//         }
//       } catch (e) {
//         print('Error capturing image: $e');
//       }
//     } else {
//       print('Camera permission denied');
//     }
//   }
//
//   Future<void> pickImage() async {
//     try {
//       final pickedFiles = await picker.pickMultiImage(imageQuality: 50);
//       if (pickedFiles != null && pickedFiles.isNotEmpty) {
//         List<File> compressedFiles = [];
//         for (var file in pickedFiles) {
//           File? compressedFile = await compressImage(File(file.path));
//           if (compressedFile != null) {
//             compressedFiles.add(compressedFile);
//           }
//         }
//         setState(() {
//           _images.addAll(compressedFiles);
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick images: $e');
//     }
//   }
//
//   Future<DocumentReference> uploadImagesWithDescription(List<File> images,
//       String description) async {
//     try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       List<String> imageUrls = [];
//
//       for (File image in images) {
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//         await storageRef.putFile(image);
//         final downloadUrl = await storageRef.getDownloadURL();
//         imageUrls.add(downloadUrl);
//       }
//
//       DocumentReference docref = await FirebaseFirestore.instance
//           .collection('complaints')
//           .add({
//         'imageUrls': imageUrls,
//         'description': description,
//         'complaintCategories': _selectedComplaints,
//         'priority': _selectedPriority,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': userId,
//         'status': 'acceptance pending',
//       });
//
//       print('Upload successful! URLs: $imageUrls');
//       return docref;
//     } catch (e) {
//       print('Error uploading images: $e');
//       rethrow;
//     }
//   }
//
//   void _showLoaderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
//
//   void _hideLoaderDialog(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   void _showMultiSelectDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         List<String> tempSelectedComplaints = List.from(_selectedComplaints);
//         return AlertDialog(
//           title: Text('Select Complaint Categories'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CheckboxListTile(
//                     title: Text('Electrical'),
//                     value: tempSelectedComplaints.contains('Electrical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Electrical');
//                         } else {
//                           tempSelectedComplaints.remove('Electrical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Mechanical'),
//                     value: tempSelectedComplaints.contains('Mechanical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Mechanical');
//                         } else {
//                           tempSelectedComplaints.remove('Mechanical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('HVAC'),
//                     value: tempSelectedComplaints.contains('HVAC'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('HVAC');
//                         } else {
//                           tempSelectedComplaints.remove('HVAC');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Utility'),
//                     value: tempSelectedComplaints.contains('Utility'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Utility');
//                         } else {
//                           tempSelectedComplaints.remove('Utility');
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   _selectedComplaints = tempSelectedComplaints;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//             (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   void _showImagePreview(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: PhotoViewGallery.builder(
//             itemCount: _images.length,
//             builder: (context, index) {
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: FileImage(_images[index]),
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.covered * 2,
//               );
//             },
//             scrollPhysics: BouncingScrollPhysics(),
//             backgroundDecoration: BoxDecoration(
//               color: Colors.black,
//             ),
//             pageController: PageController(initialPage: index),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffE9F1FF),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: Color(0xff0056D2),
//         title: Center(
//           child: Text(
//             "Labor Screen",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xff0056D2),
//               ),
//               accountName: Text(
//                   FirebaseAuth.instance.currentUser?.displayName ?? '',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               accountEmail: Text(FirebaseAuth.instance.currentUser?.email ?? ''),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: NetworkImage(
//                     'https://i.pinimg.com/564x/ea/35/3a/ea353a1b36bbd1cfa593c4d4e4ed5930.jpg'),
//               ),
//             ),
//             ListTile(
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => Profile()),
//                 );
//               },
//             ),
//             // Add other drawer items here if needed
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter Description',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 DropdownButton<String>(
//                   value: _selectedPriority,
//                   hint: Text('Select Priority'),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedPriority = newValue;
//                     });
//                   },
//                   items: <String>['High', 'Medium', 'Low']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_descriptionController.text.isEmpty ||
//                     _selectedPriority == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Please fill all fields'),
//                     ),
//                   );
//                   return;
//                 }
//                 if (_images.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Please select at least one image'),
//                     ),
//                   );
//                   return;
//                 }
//                 _showLoaderDialog(context);
//                 try {
//                   await uploadImagesWithDescription(
//                     _images,
//                     _descriptionController.text,
//                   );
//                   setState(() {
//                     _images.clear();
//                     _descriptionController.clear();
//                     _selectedPriority = null;
//                   });
//                 } catch (e) {
//                   print('Error uploading images: $e');
//                 }
//                 _hideLoaderDialog(context);
//               },
//               child: Text('Upload Complaint'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 getImageFromCamera();
//               },
//               child: Text('Take Photo'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 pickImage();
//               },
//               child: Text('Pick Photos'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _showMultiSelectDialog();
//               },
//               child: Text('Select Categories'),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: _images.isEmpty
//                   ? Center(child: Text('No images selected'))
//                   : GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                 ),
//                 itemCount: _images.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _showImagePreview(index),
//                     child: Image.file(
//                       _images[index],
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import '../login_v2.dart';
//
// class LaborScreen1 extends StatefulWidget {
//   const LaborScreen1({super.key});
//
//   @override
//   State<LaborScreen1> createState() => _LaborScreen1State();
// }
//
// class _LaborScreen1State extends State<LaborScreen1> {
//   List<File> _images = [];
//   final picker = ImagePicker();
//   List<String> _selectedComplaints = [];
//   String? _selectedPriority;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   Future<File?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(
//         dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     print(file.lengthSync());
//     print(result?.lengthSync());
//
//     return result;
//   }
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(
//             source: ImageSource.camera, imageQuality: 50);
//         if (pickedFile != null) {
//           File? compressedFile = await compressImage(File(pickedFile.path));
//           if (compressedFile != null) {
//             setState(() {
//               _images.add(compressedFile);
//             });
//           }
//         } else {
//           print('No image captured');
//         }
//       } catch (e) {
//         print('Error capturing image: $e');
//       }
//     } else {
//       print('Camera permission denied');
//     }
//   }
//
//   Future<void> pickImage() async {
//     try {
//       final pickedFiles = await picker.pickMultiImage(imageQuality: 50);
//       if (pickedFiles != null && pickedFiles.isNotEmpty) {
//         List<File> compressedFiles = [];
//         for (var file in pickedFiles) {
//           File? compressedFile = await compressImage(File(file.path));
//           if (compressedFile != null) {
//             compressedFiles.add(compressedFile);
//           }
//         }
//         setState(() {
//           _images.addAll(compressedFiles);
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick images: $e');
//     }
//   }
//
//   Future<DocumentReference> uploadImagesWithDescription(List<File> images,
//       String description) async {
//     try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       List<String> imageUrls = [];
//
//       for (File image in images) {
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//         await storageRef.putFile(image);
//         final downloadUrl = await storageRef.getDownloadURL();
//         imageUrls.add(downloadUrl);
//       }
//
//       DocumentReference docref = await FirebaseFirestore.instance
//           .collection('complaints')
//           .add({
//         'imageUrls': imageUrls,
//         'description': description,
//         'complaintCategories': _selectedComplaints,
//         'priority': _selectedPriority,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': userId,
//         'status': 'acceptance pending',
//       });
//
//       print('Upload successful! URLs: $imageUrls');
//       return docref;
//     } catch (e) {
//       print('Error uploading images: $e');
//       rethrow;
//     }
//   }
//
//   void _showLoaderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
//
//   void _hideLoaderDialog(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   void _showMultiSelectDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         List<String> tempSelectedComplaints = List.from(_selectedComplaints);
//         return AlertDialog(
//           title: Text('Select Complaint Categories'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CheckboxListTile(
//                     title: Text('Electrical'),
//                     value: tempSelectedComplaints.contains('Electrical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Electrical');
//                         } else {
//                           tempSelectedComplaints.remove('Electrical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Mechanical'),
//                     value: tempSelectedComplaints.contains('Mechanical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Mechanical');
//                         } else {
//                           tempSelectedComplaints.remove('Mechanical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('HVAC'),
//                     value: tempSelectedComplaints.contains('HVAC'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('HVAC');
//                         } else {
//                           tempSelectedComplaints.remove('HVAC');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Utility'),
//                     value: tempSelectedComplaints.contains('Utility'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Utility');
//                         } else {
//                           tempSelectedComplaints.remove('Utility');
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   _selectedComplaints = tempSelectedComplaints;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//             (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   void _showImagePreview(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: PhotoViewGallery.builder(
//             itemCount: _images.length,
//             builder: (context, index) {
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: FileImage(_images[index]),
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.covered * 2,
//               );
//             },
//             scrollPhysics: BouncingScrollPhysics(),
//             backgroundDecoration: BoxDecoration(
//               color: Colors.black,
//             ),
//             pageController: PageController(initialPage: index),
//           ),
//         );
//       },
//     );
//   }
//
//   void _removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffE9F1FF),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: Color(0xff0056D2),
//         title: Center(
//           child: Text(
//             "Labor Screen",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 color: Color(0xff0056D2),
//               ),
//               accountName: Text(
//                   FirebaseAuth.instance.currentUser?.displayName ?? '',
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               accountEmail: Text(FirebaseAuth.instance.currentUser?.email ?? ''),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: AssetImage('assets/highqlogo.png'),
//               ),
//             ),
//             ListTile(
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => Profile()),
//                 );
//               },
//             ),
//             // Add other drawer items here if needed
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _descriptionController,
//                     decoration: InputDecoration(
//                       labelText: 'Enter Description',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 DropdownButton<String>(
//                   value: _selectedPriority,
//                   hint: Text('Select Priority'),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedPriority = newValue;
//                     });
//                   },
//                   items: <String>['High', 'Medium', 'Low']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_descriptionController.text.isEmpty ||
//                     _selectedPriority == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Please fill all fields'),
//                     ),
//                   );
//                   return;
//                 }
//                 if (_images.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Please select at least one image'),
//                     ),
//                   );
//                   return;
//                 }
//                 _showLoaderDialog(context);
//                 try {
//                   await uploadImagesWithDescription(
//                     _images,
//                     _descriptionController.text,
//                   );
//                   setState(() {
//                     _images.clear();
//                     _descriptionController.clear();
//                     _selectedPriority = null;
//                   });
//                 } catch (e) {
//                   print('Error uploading images: $e');
//                 }
//                 _hideLoaderDialog(context);
//               },
//               child: Text('Upload Complaint'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 getImageFromCamera();
//               },
//               child: Text('Take Photo'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 pickImage();
//               },
//               child: Text('Pick Photos'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 _showMultiSelectDialog();
//               },
//               child: Text('Select Categories'),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: _images.isEmpty
//                   ? Center(child: Text('No images selected'))
//                   : GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                 ),
//                 itemCount: _images.length,
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     children: [
//                       GestureDetector(
//                         onTap: () => _showImagePreview(index),
//                         child: Image.file(
//                           _images[index],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: IconButton(
//                           icon: Icon(Icons.remove_circle, color: Colors.red),
//                           onPressed: () => _removeImage(index),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// UI good
// but send only general category
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import '../about.dart';
// import '../login_v2.dart';
// import 'uesr_list.dart';
//
// class LaborScreen1 extends StatefulWidget {
//   const LaborScreen1({super.key});
//
//   @override
//   State<LaborScreen1> createState() => _LaborScreen1State();
// }
//
// class _LaborScreen1State extends State<LaborScreen1> {
//   List<File> _images = [];
//   final picker = ImagePicker();
//   List<String> _selectedComplaints = [];
//   User? user;
//   String userName = "";
//   String userEmail = "";
//   String? profileImageUrl;
//   String? _selectedPriority;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   Future<File?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(
//         dir.absolute.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     return result;
//   }
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(
//             source: ImageSource.camera, imageQuality: 50);
//         if (pickedFile != null) {
//           File? compressedFile = await compressImage(File(pickedFile.path));
//           if (compressedFile != null) {
//             setState(() {
//               _images.add(compressedFile);
//             });
//           }
//         } else {
//           print('No image captured');
//         }
//       } catch (e) {
//         print('Error capturing image: $e');
//       }
//     } else {
//       print('Camera permission denied');
//     }
//   }
//
//   Future<void> pickImage() async {
//     try {
//       final pickedFiles = await picker.pickMultiImage(imageQuality: 50);
//       if (pickedFiles != null && pickedFiles.isNotEmpty) {
//         List<File> compressedFiles = [];
//         for (var file in pickedFiles) {
//           File? compressedFile = await compressImage(File(file.path));
//           if (compressedFile != null) {
//             compressedFiles.add(compressedFile);
//           }
//         }
//         setState(() {
//           _images.addAll(compressedFiles);
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick images: $e');
//     }
//   }
//
//   Future<DocumentReference> uploadImagesWithDescription(List<File> images,
//       String description) async {
//     try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//
//       List<String> imageUrls = [];
//
//       for (File image in images) {
//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
//         await storageRef.putFile(image);
//         final downloadUrl = await storageRef.getDownloadURL();
//         imageUrls.add(downloadUrl);
//       }
//
//       DocumentReference docref = await FirebaseFirestore.instance
//           .collection('complaints')
//           .add({
//         'imageUrls': imageUrls,
//         'description': description,
//         'complaintCategories': _selectedComplaints, // Ensure this is correctly added
//         'priority': _selectedPriority,
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': userId,
//         // 'status': 'acceptance pending',
//       });
//
//       print('Upload successful! URLs: $imageUrls');
//       return docref;
//     } catch (e) {
//       print('Error uploading images: $e');
//       rethrow;
//     }
//   }
//
//
//   void _showLoaderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _hideLoaderDialog(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   void _showMultiSelectDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         List<String> tempSelectedComplaints = List.from(_selectedComplaints);
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           title: Text('Select Complaint Categories'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CheckboxListTile(
//                     title: Text('Electrical'),
//                     value: tempSelectedComplaints.contains('Electrical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Electrical');
//                         } else {
//                           tempSelectedComplaints.remove('Electrical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Mechanical'),
//                     value: tempSelectedComplaints.contains('Mechanical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Mechanical');
//                         } else {
//                           tempSelectedComplaints.remove('Mechanical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('HVAC'),
//                     value: tempSelectedComplaints.contains('HVAC'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('HVAC');
//                         } else {
//                           tempSelectedComplaints.remove('HVAC');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Utility'),
//                     value: tempSelectedComplaints.contains('Utility'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Utility');
//                         } else {
//                           tempSelectedComplaints.remove('Utility');
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   _selectedComplaints = tempSelectedComplaints;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//   Future<void> fetchUserData() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUser.uid)
//           .get();
//
//       setState(() {
//         user = currentUser;
//         userName = userDoc['name'] ?? 'No Name';
//         userEmail = currentUser.email ?? 'No Email';
//         profileImageUrl = userDoc['profileImageUrl'];
//       });
//     }
//   }
//
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//             (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   void _showImagePreview(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: PhotoViewGallery.builder(
//             itemCount: _images.length,
//             builder: (context, index) {
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: FileImage(_images[index]),
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.covered * 2,
//               );
//             },
//             scrollPhysics: BouncingScrollPhysics(),
//             backgroundDecoration: BoxDecoration(
//               color: Colors.black,
//             ),
//             pageController: PageController(initialPage: index),
//           ),
//         );
//       },
//     );
//   }
//
//   void _removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xffE9F1FF),
//     appBar: AppBar(
//     automaticallyImplyLeading: true,
//     backgroundColor:
//     Colors.blueAccent,
//       title: Text('Labor Screen'),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.logout),
//           onPressed: _logout,
//         ),
//       ],
//     ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       'https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: profileImageUrl != null
//                     ? NetworkImage(profileImageUrl!)
//                     : NetworkImage(
//                     'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
//               ),
//               accountName: Text(userName),
//               accountEmail: Text(userEmail),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text("Profile"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Profile()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text(" Complaints"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyGeneratedComplaintsScreen()),
//                 );
//               },
//             ),
//     ListTile(
//               leading: Icon(Icons.info_outline),
//               title: Text("About"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AboutScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Image Grid
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: _images.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _showImagePreview(index),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           elevation: 4,
//                           child: Image.file(
//                             _images[index],
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.remove_circle,
//                               color: Colors.red,
//                             ),
//                             onPressed: () => _removeImage(index),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             // Add Image Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.camera_alt),
//                   label: Text('Capture Image'),
//                   onPressed: getImageFromCamera,
//                 ),
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.photo_library),
//                   label: Text('Select Images'),
//                   onPressed: pickImage,
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             // Description Input
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Description',
//                 hintText: 'Enter description here',
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 20),
//             // Priority Dropdown
//             DropdownButtonFormField<String>(
//               value: _selectedPriority,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Priority',
//               ),
//               items: ['High', 'Medium', 'Low'].map((priority) {
//                 return DropdownMenuItem<String>(
//                   value: priority,
//                   child: Text(priority),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedPriority = newValue;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             // Category Selection Button
//             ElevatedButton(
//               onPressed: _showMultiSelectDialog,
//               child: Text('Select Categories'),
//             ),
//             SizedBox(height: 20),
//             // Submit Button
//             ElevatedButton(
//               onPressed: () async {
//                 if (_descriptionController.text.isEmpty ||
//                     _images.isEmpty ||
//                     _selectedPriority == null ||
//                     _selectedComplaints.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Please fill all fields and select images.'),
//                     ),
//                   );
//                   return;
//                 }
//
//                 // Debugging prints
//                 print('Description: ${_descriptionController.text}');
//                 print('Priority: $_selectedPriority');
//                 print('Categories: $_selectedComplaints');
//
//                 _showLoaderDialog(context);
//                 try {
//                   await uploadImagesWithDescription(
//                     _images,
//                     _descriptionController.text,
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Complaint successfully submitted.'),
//                     ),
//                   );
//                   setState(() {
//                     _images.clear();
//                     _descriptionController.clear();
//                     _selectedPriority = null;
//                     _selectedComplaints.clear();
//                   });
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Error submitting complaint.'),
//                     ),
//                   );
//                 } finally {
//                   _hideLoaderDialog(context);
//                 }
//               },
//               child: Text('Submit'),
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
// }



//notification code and video code incomplete but good UI
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_management_sys/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';
import '../about.dart';
import '../login_v2.dart';
import 'uesr_list.dart';

class LaborScreen1 extends StatefulWidget {
  const LaborScreen1({super.key});

  @override
  State<LaborScreen1> createState() => _LaborScreen1State();
}

class _LaborScreen1State extends State<LaborScreen1> {
  List<File> _images = [];
  final picker = ImagePicker();
  List<String> _selectedComplaints = [];
  User? user;
  String userName = "";
  String userEmail = "";
  String? profileImageUrl;
  String? _selectedPriority;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> requestPermission(Permission permission) async {
    var status = await permission.status;
    if (!status.isGranted) {
      status = await permission.request();
    }
  }

  Future<File?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = path.join(
        dir.absolute.path, "${DateTime
        .now()
        .millisecondsSinceEpoch}.jpg");

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
    );

    return result;
  }
  void _removeVideo(int index) {
    setState(() {
      _videos.removeAt(index);
    });
  }


  Future<void> getImageFromCamera() async {
    await requestPermission(Permission.camera);
    if (await Permission.camera.isGranted) {
      try {
        final pickedFile = await picker.pickImage(
            source: ImageSource.camera, imageQuality: 50);
        if (pickedFile != null) {
          File? compressedFile = await compressImage(File(pickedFile.path));
          if (compressedFile != null) {
            setState(() {
              _images.add(compressedFile);
            });
          }
        } else {
          print('No image captured');
        }
      } catch (e) {
        print('Error capturing image: $e');
      }
    } else {
      print('Camera permission denied');
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFiles = await picker.pickMultiImage(imageQuality: 50);
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        List<File> compressedFiles = [];
        for (var file in pickedFiles) {
          File? compressedFile = await compressImage(File(file.path));
          if (compressedFile != null) {
            compressedFiles.add(compressedFile);
          }
        }
        setState(() {
          _images.addAll(compressedFiles);
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick images: $e');
    }
  }

  Future<DocumentReference> uploadImagesWithDescription(
      List<File> images, String description) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      List<String> imageUrls = [];
      List<String> videoUrls = [];

      // Upload images
      for (File image in images) {
        String imageUrl = await uploadFile(image, 'images/');
        imageUrls.add(imageUrl);
      }

      // Upload videos
      for (File video in _videos) {
        String videoUrl = await uploadFile(video, 'videos/');
        videoUrls.add(videoUrl);
      }

      // Add the complaint document
      return FirebaseFirestore.instance.collection('complaints').add({
        'description': description,
        'imageUrls': imageUrls,
        'videoUrls': videoUrls,
        'priority': _selectedPriority,
        'timestamp': Timestamp.now(),
        'userId': userId,
        'categories': _selectedComplaints,
      });
    } catch (e) {
      print('Error uploading complaint: $e');
      rethrow;
    }
  }

  Future<String> uploadFile(File file, String path) async {
    try {
      String fileName = file.uri.pathSegments.last;
      Reference reference = FirebaseStorage.instance.ref().child('$path$fileName');
      UploadTask uploadTask = reference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      rethrow;
    }
  }



  void _showLoaderDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        );
      },
    );
  }

  void _hideLoaderDialog(BuildContext context) {
    Navigator.pop(context);
  }

  void _showMultiSelectDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> tempSelectedComplaints = List.from(_selectedComplaints);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text('Select Complaint Categories'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: Text('Electrical'),
                    value: tempSelectedComplaints.contains('Electrical'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedComplaints.add('Electrical');
                        } else {
                          tempSelectedComplaints.remove('Electrical');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Mechanical'),
                    value: tempSelectedComplaints.contains('Mechanical'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedComplaints.add('Mechanical');
                        } else {
                          tempSelectedComplaints.remove('Mechanical');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('HVAC'),
                    value: tempSelectedComplaints.contains('HVAC'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedComplaints.add('HVAC');
                        } else {
                          tempSelectedComplaints.remove('HVAC');
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Utility'),
                    value: tempSelectedComplaints.contains('Utility'),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedComplaints.add('Utility');
                        } else {
                          tempSelectedComplaints.remove('Utility');
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  _selectedComplaints = tempSelectedComplaints;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      setState(() {
        user = currentUser;
        userName = userDoc['name'] ?? 'No Name';
        userEmail = currentUser.email ?? 'No Email';
        profileImageUrl = userDoc['profileImageUrl'];
      });
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void _showImagePreview(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: PhotoViewGallery.builder(
            itemCount: _images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(_images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(
              color: Colors.black,
            ),
            pageController: PageController(initialPage: index),
          ),
        );
      },
    );
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }


  List<File> _videos = []; // Add this to manage video files

  Future<void> pickVideo() async {
    try {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _videos.add(File(pickedFile.path));
        });
      } else {
        print('No video selected');
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

  Future<void> recordVideo() async {
    try {
      final pickedFile = await picker.pickVideo(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _videos.add(File(pickedFile.path));
        });
      } else {
        print('No video recorded');
      }
    } catch (e) {
      print('Error recording video: $e');
    }
  }

  void _showVideoPreview(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: VideoPlayerWidget(videoFile: _videos[index], videoUrl: '', file: null,),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9F1FF),
    appBar: AppBar(
    automaticallyImplyLeading: true,
    backgroundColor:
    Colors.blueAccent,
      title: Text('Generate New Complain '),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: _logout,
        ),
      ],
    ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: profileImageUrl != null
                    ? NetworkImage(profileImageUrl!)
                    : NetworkImage(
                    'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
              ),
              accountName: Text(userName),
              accountEmail: Text(userEmail),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(" Complaints"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyGeneratedComplaintsScreen()),
                );
              },
            ),
    ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("About"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Grid
            Container(
              height: 200, // Adjust the height according to your needs
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showImagePreview(index),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 4,
                          child: Image.file(
                            _images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () => _removeImage(index),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Video Grid
            Container(
              height: 200, // Adjust the height according to your needs
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _videos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showVideoPreview(index),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 4,
                          child: VideoPlayerWidget(
                            videoFile: _videos[index], videoUrl: '', file: null,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                            onPressed: () => _removeVideo(index),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Add Image Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Capture Image'),
                  onPressed: getImageFromCamera,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.photo_library),
                  label: Text('Select Images'),
                  onPressed: pickImage,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.videocam),
                  label: Text('Record Video'),
                  onPressed: recordVideo,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.video_library),
                  label: Text('Select Video'),
                  onPressed: pickVideo,
                ),
              ],
            ),
            SizedBox(height: 20),
            // Description Input
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Enter description here',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            // Priority Dropdown
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Priority',
              ),
              items: ['High', 'Medium', 'Low'].map((priority) {
                return DropdownMenuItem<String>(
                  value: priority,
                  child: Text(priority),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedPriority = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            // Category Selection Button
            ElevatedButton(
              onPressed: _showMultiSelectDialog,
              child: Text('Select Categories'),
            ),
            SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              onPressed: () async {
                if (_descriptionController.text.isEmpty ||
                    _images.isEmpty ||
                    _videos.isEmpty ||
                    _selectedPriority == null ||
                    _selectedComplaints.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Please fill all fields and select images/videos.'),
                    ),
                  );
                  return;
                }

                _showLoaderDialog(context);
                try {
                  await uploadImagesWithDescription(
                    _images,
                    _descriptionController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Complaint successfully submitted.'),
                    ),
                  );
                  setState(() {
                    _images.clear();
                    _videos.clear();
                    _descriptionController.clear();
                    _selectedPriority = null;
                    _selectedComplaints.clear();
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error submitting complaint.'),
                    ),
                  );
                } finally {
                  _hideLoaderDialog(context);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );

  }
}
//
// //
class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  const VideoPlayerWidget({super.key, required this.videoFile, required String videoUrl, required file});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return _initialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}






//compress
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:video_compress/video_compress.dart';
// import 'package:video_player/video_player.dart';
// import '../about.dart';
// import '../login_v2.dart';
// import 'uesr_list.dart';
//
// class LaborScreen1 extends StatefulWidget {
//   const LaborScreen1({super.key});
//
//   @override
//   State<LaborScreen1> createState() => _LaborScreen1State();
// }
//
// class _LaborScreen1State extends State<LaborScreen1> {
//   List<File> _images = [];
//   final picker = ImagePicker();
//   List<String> _selectedComplaints = [];
//   User? user;
//   String userName = "";
//   String userEmail = "";
//   String? profileImageUrl;
//   String? _selectedPriority;
//   final TextEditingController _descriptionController = TextEditingController();
//
//   Future<void> requestPermission(Permission permission) async {
//     var status = await permission.status;
//     if (!status.isGranted) {
//       status = await permission.request();
//     }
//   }
//
//   Future<File?> compressImage(File file) async {
//     final dir = await getTemporaryDirectory();
//     final targetPath = path.join(
//         dir.absolute.path, "${DateTime
//         .now()
//         .millisecondsSinceEpoch}.jpg");
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//     );
//
//     return result;
//   }
//   void _removeVideo(int index) {
//     setState(() {
//       _videos.removeAt(index);
//     });
//   }
//
//
//   Future<void> getImageFromCamera() async {
//     await requestPermission(Permission.camera);
//     if (await Permission.camera.isGranted) {
//       try {
//         final pickedFile = await picker.pickImage(
//             source: ImageSource.camera, imageQuality: 50);
//         if (pickedFile != null) {
//           File? compressedFile = await compressImage(File(pickedFile.path));
//           if (compressedFile != null) {
//             setState(() {
//               _images.add(compressedFile);
//             });
//           }
//         } else {
//           print('No image captured');
//         }
//       } catch (e) {
//         print('Error capturing image: $e');
//       }
//     } else {
//       print('Camera permission denied');
//     }
//   }
//
//   Future<void> pickImage() async {
//     try {
//       final pickedFiles = await picker.pickMultiImage(imageQuality: 50);
//       if (pickedFiles != null && pickedFiles.isNotEmpty) {
//         List<File> compressedFiles = [];
//         for (var file in pickedFiles) {
//           File? compressedFile = await compressImage(File(file.path));
//           if (compressedFile != null) {
//             compressedFiles.add(compressedFile);
//           }
//         }
//         setState(() {
//           _images.addAll(compressedFiles);
//         });
//       }
//     } on PlatformException catch (e) {
//       print('Failed to pick images: $e');
//     }
//   }
//
//   Future<DocumentReference> uploadImagesWithDescription(
//       List<File> images, String description) async {
//     try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//       List<String> imageUrls = [];
//       List<String> videoUrls = [];
//
//       // Upload images
//       for (File image in images) {
//         String imageUrl = await uploadFile(image, 'images/');
//         imageUrls.add(imageUrl);
//       }
//
//       // Upload videos
//       for (File video in _videos) {
//         String videoUrl = await uploadFile(video, 'videos/');
//         videoUrls.add(videoUrl);
//       }
//
//       // Add the complaint document
//       return FirebaseFirestore.instance.collection('complaints').add({
//         'description': description,
//         'imageUrls': imageUrls,
//         'videoUrls': videoUrls,
//         'priority': _selectedPriority,
//         'timestamp': Timestamp.now(),
//         'userId': userId,
//         'categories': _selectedComplaints,
//       });
//     } catch (e) {
//       print('Error uploading complaint: $e');
//       rethrow;
//     }
//   }
//
//
//   Future<String> uploadFile(File file, String path) async {
//     try {
//       String fileName = file.uri.pathSegments.last;
//       Reference reference = FirebaseStorage.instance.ref().child('$path$fileName');
//       UploadTask uploadTask = reference.putFile(file);
//       TaskSnapshot taskSnapshot = await uploadTask;
//       return await taskSnapshot.ref.getDownloadURL();
//     } catch (e) {
//       print('Error uploading file: $e');
//       rethrow;
//     }
//   }
//
//
//
//   void _showLoaderDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Container(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _hideLoaderDialog(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   void _showMultiSelectDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         List<String> tempSelectedComplaints = List.from(_selectedComplaints);
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           title: Text('Select Complaint Categories'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CheckboxListTile(
//                     title: Text('Electrical'),
//                     value: tempSelectedComplaints.contains('Electrical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Electrical');
//                         } else {
//                           tempSelectedComplaints.remove('Electrical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Mechanical'),
//                     value: tempSelectedComplaints.contains('Mechanical'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Mechanical');
//                         } else {
//                           tempSelectedComplaints.remove('Mechanical');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('HVAC'),
//                     value: tempSelectedComplaints.contains('HVAC'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('HVAC');
//                         } else {
//                           tempSelectedComplaints.remove('HVAC');
//                         }
//                       });
//                     },
//                   ),
//                   CheckboxListTile(
//                     title: Text('Utility'),
//                     value: tempSelectedComplaints.contains('Utility'),
//                     onChanged: (bool? value) {
//                       setState(() {
//                         if (value == true) {
//                           tempSelectedComplaints.add('Utility');
//                         } else {
//                           tempSelectedComplaints.remove('Utility');
//                         }
//                       });
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 setState(() {
//                   _selectedComplaints = tempSelectedComplaints;
//                 });
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> fetchUserData() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUser.uid)
//           .get();
//
//       setState(() {
//         user = currentUser;
//         userName = userDoc['name'] ?? 'No Name';
//         userEmail = currentUser.email ?? 'No Email';
//         profileImageUrl = userDoc['profileImageUrl'];
//       });
//     }
//   }
//
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//             (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }
//
//   void _showImagePreview(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: PhotoViewGallery.builder(
//             itemCount: _images.length,
//             builder: (context, index) {
//               return PhotoViewGalleryPageOptions(
//                 imageProvider: FileImage(_images[index]),
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.covered * 2,
//               );
//             },
//             scrollPhysics: BouncingScrollPhysics(),
//             backgroundDecoration: BoxDecoration(
//               color: Colors.black,
//             ),
//             pageController: PageController(initialPage: index),
//           ),
//         );
//       },
//     );
//   }
//
//   void _removeImage(int index) {
//     setState(() {
//       _images.removeAt(index);
//     });
//   }
//
//
//   List<File> _videos = []; // Add this to manage video files
//
//
//
//   Future<void> recordVideo() async {
//     try {
//       final pickedFile = await picker.pickVideo(source: ImageSource.camera);
//       if (pickedFile != null) {
//         File? compressedFile = await compressVideo(File(pickedFile.path));
//         if (compressedFile != null) {
//           setState(() {
//             _videos.add(compressedFile);
//           });
//         }
//       } else {
//         print('No video recorded');
//       }
//     } catch (e) {
//       print('Error recording video: $e');
//     }
//   }
//
//   Future<void> pickVideo() async {
//     try {
//       final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         File? compressedFile = await compressVideo(File(pickedFile.path));
//         if (compressedFile != null) {
//           setState(() {
//             _videos.add(compressedFile);
//           });
//         }
//       } else {
//         print('No video selected');
//       }
//     } catch (e) {
//       print('Error picking video: $e');
//     }
//   }
//
//
//   void _showVideoPreview(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: VideoPlayerWidget(videoFile: _videos[index]),
//         );
//       },
//     );
//   }
//
//   Future<File?> compressVideo(File videoFile) async {
//     final compressedVideo = await VideoCompress.compressVideo(
//       videoFile.path,
//       quality: VideoQuality.LowQuality, // You can adjust the quality
//     );
//
//     if (compressedVideo != null) {
//       return File(compressedVideo.path!);
//     }
//     return null;
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffE9F1FF),
//     appBar: AppBar(
//     automaticallyImplyLeading: true,
//     backgroundColor:
//     Colors.blueAccent,
//       title: Text('Generate New Complain '),
//       actions: [
//         IconButton(
//           icon: Icon(Icons.logout),
//           onPressed: _logout,
//         ),
//       ],
//     ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       'https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: profileImageUrl != null
//                     ? NetworkImage(profileImageUrl!)
//                     : NetworkImage(
//                     'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
//               ),
//               accountName: Text(userName),
//               accountEmail: Text(userEmail),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text("Profile"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Profile()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text(" Complaints"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => MyGeneratedComplaintsScreen()),
//                 );
//               },
//             ),
//     ListTile(
//               leading: Icon(Icons.info_outline),
//               title: Text("About"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AboutScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image Grid
//             Container(
//               height: 200, // Adjust the height according to your needs
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: _images.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _showImagePreview(index),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           elevation: 4,
//                           child: Image.file(
//                             _images[index],
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.remove_circle,
//                               color: Colors.red,
//                             ),
//                             onPressed: () => _removeImage(index),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             // Video Grid
//             Container(
//               height: 200, // Adjust the height according to your needs
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                 ),
//                 itemCount: _videos.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () => _showVideoPreview(index),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           elevation: 4,
//                           child: VideoPlayerWidget(
//                             videoFile: _videos[index],
//                           ),
//                         ),
//                         Positioned(
//                           right: 0,
//                           top: 0,
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.remove_circle,
//                               color: Colors.red,
//                             ),
//                             onPressed: () => _removeVideo(index),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             // Add Image Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.camera_alt),
//                   label: Text('Capture Image'),
//                   onPressed: getImageFromCamera,
//                 ),
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.photo_library),
//                   label: Text('Select Images'),
//                   onPressed: pickImage,
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.videocam),
//                   label: Text('Record Video'),
//                   onPressed: recordVideo,
//                 ),
//                 ElevatedButton.icon(
//                   icon: Icon(Icons.video_library),
//                   label: Text('Select Video'),
//                   onPressed: pickVideo,
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             // Description Input
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Description',
//                 hintText: 'Enter description here',
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 20),
//             // Priority Dropdown
//             DropdownButtonFormField<String>(
//               value: _selectedPriority,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Priority',
//               ),
//               items: ['High', 'Medium', 'Low'].map((priority) {
//                 return DropdownMenuItem<String>(
//                   value: priority,
//                   child: Text(priority),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedPriority = newValue;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             // Category Selection Button
//             ElevatedButton(
//               onPressed: _showMultiSelectDialog,
//               child: Text('Select Categories'),
//             ),
//             SizedBox(height: 20),
//             // Submit Button
//             ElevatedButton(
//               onPressed: () async {
//                 if (_descriptionController.text.isEmpty ||
//                     _images.isEmpty ||
//                     _videos.isEmpty ||
//                     _selectedPriority == null ||
//                     _selectedComplaints.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                           'Please fill all fields and select images/videos.'),
//                     ),
//                   );
//                   return;
//                 }
//
//                 _showLoaderDialog(context);
//                 try {
//                   await uploadImagesWithDescription(
//                     _images,
//                     _descriptionController.text,
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Complaint successfully submitted.'),
//                     ),
//                   );
//                   setState(() {
//                     _images.clear();
//                     _videos.clear();
//                     _descriptionController.clear();
//                     _selectedPriority = null;
//                     _selectedComplaints.clear();
//                   });
//                 } catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Error submitting complaint.'),
//                     ),
//                   );
//                 } finally {
//                   _hideLoaderDialog(context);
//                 }
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }
// //
// // //
// class VideoPlayerWidget extends StatefulWidget {
//   final File videoFile;
//
//   const VideoPlayerWidget({super.key, required this.videoFile});
//
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _initialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(widget.videoFile)
//       ..initialize().then((_) {
//         setState(() {
//           _initialized = true;
//         });
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _initialized
//         ? AspectRatio(
//       aspectRatio: _controller.value.aspectRatio,
//       child: VideoPlayer(_controller),
//     )
//         : Center(child: CircularProgressIndicator());
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
//
