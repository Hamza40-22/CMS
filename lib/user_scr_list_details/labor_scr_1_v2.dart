

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
// import 'user_list.dart';
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


// this code is considerable
//notification code and video code incomplete but good UI
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
// import 'package:video_player/video_player.dart';
// import '../about.dart';
// import '../login_v2.dart';
// import 'user_list.dart';
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
//   Future<void> pickVideo() async {
//     try {
//       final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         setState(() {
//           _videos.add(File(pickedFile.path));
//         });
//       } else {
//         print('No video selected');
//       }
//     } catch (e) {
//       print('Error picking video: $e');
//     }
//   }
//
//   Future<void> recordVideo() async {
//     try {
//       final pickedFile = await picker.pickVideo(source: ImageSource.camera);
//       if (pickedFile != null) {
//         setState(() {
//           _videos.add(File(pickedFile.path));
//         });
//       } else {
//         print('No video recorded');
//       }
//     } catch (e) {
//       print('Error recording video: $e');
//     }
//   }
//
//   void _showVideoPreview(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: VideoPlayerWidget(videoFile: _videos[index], videoUrl: '', file: null,),
//         );
//       },
//     );
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
//                   MaterialPageRoute(builder: (context) => user_list_screen()),
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
//                             videoFile: _videos[index], videoUrl: '', file: null,
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
//   const VideoPlayerWidget({super.key, required this.videoFile, required String videoUrl, required file});
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
// import 'user_list.dart';
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



import 'dart:convert';
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
import 'user_list.dart';
import 'package:http/http.dart' as http;


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

      // Upload images if available
      if (images.isNotEmpty) {
        for (File image in images) {
          String imageUrl = await uploadFile(image, 'images/');
          imageUrls.add(imageUrl);
        }
      }

      // Upload videos if available
      if (_videos.isNotEmpty) {
        for (File video in _videos) {
          String videoUrl = await uploadFile(video, 'videos/');
          videoUrls.add(videoUrl);
        }
      }

      // Add the complaint document with the available fields
      return FirebaseFirestore.instance.collection('complaints').add({
        if (description.isNotEmpty) 'description': description,
        if (imageUrls.isNotEmpty) 'imageUrls': imageUrls,
        if (videoUrls.isNotEmpty) 'videoUrls': videoUrls,
        if (_selectedPriority != null) 'priority': _selectedPriority,
        'timestamp': Timestamp.now(),
        'userId': userId,
        if (_selectedComplaints.isNotEmpty) 'categories': _selectedComplaints,
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


  Future<void> sendNotificationToAll(String title, String body) async {
    final cloudFunctionUrl = 'https://<your-region>-<your-project-id>.cloudfunctions.net/sendNotificationToAll'; // Replace with your actual function URL

    try {
      final response = await http.post(
        Uri.parse(cloudFunctionUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': title,
          'body': body,
        }),
      );

      if (response.statusCode == 200) {
        print('Notifications sent successfully.');
      } else {
        print('Failed to send notifications: ${response.body}');
      }
    } catch (e) {
      print('Error sending notifications: $e');
    }
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
                  MaterialPageRoute(builder: (context) => user_list_screen()),
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
                // Validate priority
                if (_selectedPriority == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select a priority.'),
                    ),
                  );
                  return;
                }

                // Validate category selection
                if (_selectedComplaints.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please select at least one category.'),
                    ),
                  );
                  return;
                }

                // Validate input (description, images, or videos)
                if (_descriptionController.text.isEmpty &&
                    _images.isEmpty &&
                    _videos.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please provide at least one: description, image, or video.'),
                    ),
                  );
                  return;
                }

                _showLoaderDialog(context);
                try {
                  // Submit the available inputs
                  await uploadImagesWithDescription(_images, _descriptionController.text);

                  // Send notifications to users subscribed to the selected categories
                  await sendNotificationToAll(_selectedComplaints.join(', '), 'New Complaint Submitted');


                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Complaint successfully submitted.'),
                    ),
                  );

                  // Clear fields after successful submission
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
                      content: Text('Error submitting complaint: $e'),
                    ),
                  );
                } finally {
                  _hideLoaderDialog(context);
                }
              },
              child: Text('Submit'),
            )


          ],
        ),
      ),
    );

  }
}
//
// //hello
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



