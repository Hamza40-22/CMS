// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   User? user;
//   String userName = "";
//   String userEmail = "";
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }
//
//   void fetchUserData() async {
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
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Settings',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: CircleAvatar(
//                 radius: 100,
//                 backgroundImage: NetworkImage('https://via.placeholder.com/155'),
//               ),
//             ),
//             Text(
//               userName,
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.underline,
//                 decorationThickness: 1,
//                 decorationColor: Colors.cyan,
//                 decorationStyle: TextDecorationStyle.double,
//               ),
//             ),
//             SizedBox(height: 40),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text(
//                 'Name',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 userName,
//                 style: TextStyle(fontSize: 16),
//               ),
//               onTap: () {},
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.email),
//               title: Text(
//                 'Email',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 userEmail,
//                 style: TextStyle(fontSize: 16),
//               ),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// not good UI
// import 'dart:io';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   User? user;
//   String userName = "";
//   String userEmail = "";
//   String? profileImageUrl;
//   File? _image;
//
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }
//
//   void fetchUserData() async {
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
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       // Upload the image to Firebase Storage and update Firestore with the image URL
//       _uploadImageToFirebase();
//     }
//   }
//
//   Future<void> _uploadImageToFirebase() async {
//     if (_image == null) return;
//
//     try {
//       String fileName = user!.uid + '.jpg';
//       UploadTask uploadTask = FirebaseStorage.instance
//           .ref()
//           .child('profile_images/$fileName')
//           .putFile(_image!);
//
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//       // Update Firestore with the new profile image URL
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .update({'profileImageUrl': downloadUrl});
//
//       setState(() {
//         profileImageUrl = downloadUrl;
//       });
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Settings',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Stack(
//                 children: [
//                   CircleAvatar(
//                     radius: 100,
//                     backgroundImage: _image != null
//                         ? FileImage(_image!)
//                         : (profileImageUrl != null
//                         ? NetworkImage(profileImageUrl!)
//                         : NetworkImage('https://via.placeholder.com/150')) as ImageProvider,
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: _pickImage,
//                       child: CircleAvatar(
//                         radius: 25,
//                         backgroundColor: Colors.white,
//                         child: Icon(
//                           Icons.camera_alt,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               userName,
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//                 decoration: TextDecoration.underline,
//                 decorationThickness: 1,
//                 decorationColor: Colors.cyan,
//                 decorationStyle: TextDecorationStyle.double,
//               ),
//             ),
//             SizedBox(height: 40),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text(
//                 'Name',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 userName,
//                 style: TextStyle(fontSize: 16),
//               ),
//               onTap: () {},
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.email),
//               title: Text(
//                 'Email',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 userEmail,
//                 style: TextStyle(fontSize: 16),
//               ),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// good UI
// import 'dart:io';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   User? user;
//   String userName = "";
//   String userEmail = "";
//   String? profileImageUrl;
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }
//
//   void fetchUserData() async {
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
//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       _uploadImageToFirebase();
//     }
//   }
//
//   Future<void> _uploadImageToFirebase() async {
//     if (_image == null) return;
//
//     try {
//       String fileName = user!.uid + '.jpg';
//       UploadTask uploadTask = FirebaseStorage.instance
//           .ref()
//           .child('profile_images/$fileName')
//           .putFile(_image!);
//
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//       // Update Firestore with the new profile image URL
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user!.uid)
//           .update({'profileImageUrl': downloadUrl});
//
//       setState(() {
//         profileImageUrl = downloadUrl;
//       });
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Profile',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.cyan,
//         foregroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 200,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.cyan, Colors.blue],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Center(
//               child: Stack(
//                 children: [
//                   CircleAvatar(
//                     radius: 80,
//                     backgroundImage: _image != null
//                         ? FileImage(_image!)
//                         : (profileImageUrl != null
//                         ? NetworkImage(profileImageUrl!)
//                         : NetworkImage('https://via.placeholder.com/150')) as ImageProvider,
//                   ),
//                   Positioned(
//                     bottom: 10,
//                     right: 10,
//                     child: GestureDetector(
//                       onTap: _pickImage,
//                       child: CircleAvatar(
//                         radius: 25,
//                         backgroundColor: Colors.white,
//                         child: Icon(
//                           Icons.camera_alt,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           Text(
//             userName,
//             style: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//               decoration: TextDecoration.underline,
//               decorationThickness: 1,
//               decorationColor: Colors.cyan,
//               decorationStyle: TextDecorationStyle.double,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             userEmail,
//             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//           ),
//           SizedBox(height: 30),
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text(
//               'Name',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               userName,
//               style: TextStyle(fontSize: 16),
//             ),
//             onTap: () {},
//           ),
//           Divider(),
//           ListTile(
//             leading: Icon(Icons.email),
//             title: Text(
//               'Email',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               userEmail,
//               style: TextStyle(fontSize: 16),
//             ),
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

// liquid pull to refresh


import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  String userName = "";
  String userEmail = "";
  String? profileImageUrl;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchUserData();
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

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _uploadImageToFirebase();
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image == null) return;

    try {
      String fileName = user!.uid + '.jpg';
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);

      await uploadTask.whenComplete(() async {
        String downloadUrl = await storageReference.getDownloadURL();

        // Update Firestore with the new profile image URL
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'profileImageUrl': downloadUrl});

        setState(() {
          profileImageUrl = downloadUrl;
        });
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _handleRefresh() async {
    await fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: Colors.cyan,
        // height: 100, // Reduced height for a more subtle pull effect
        // backgroundColor: Colors.white,
        // showChildOpacityTransition: true, // Allows opacity transition for a smoother effect
        springAnimationDurationInMilliseconds: 500, // Faster animation duration
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : (profileImageUrl != null
                          ? NetworkImage(profileImageUrl!)
                          : NetworkImage('https://via.placeholder.com/150')) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                userName,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  decorationColor: Colors.cyan,
                  decorationStyle: TextDecorationStyle.double,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                userEmail,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                userName,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'Email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                userEmail,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
