// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // import 'list_screen.dart';
// // import 'profile.dart';
// //
// // class FetchImageScreen extends StatefulWidget {
// //   const FetchImageScreen({super.key});
// //
// //   @override
// //   _FetchImageScreenState createState() => _FetchImageScreenState();
// // }
// //
// // class _FetchImageScreenState extends State<FetchImageScreen> {
// //   String? imageUrl;
// //   String? description;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadImageAndDescription();
// //   }
// //
// //   Future<void> _loadImageAndDescription() async {
// //     try {
// //       final snapshot = await FirebaseFirestore.instance
// //           .collection('complaints')
// //           .orderBy("timestamp", descending: true)
// //           .get();
// //
// //       final data = snapshot.docs.first.data();
// //       setState(() {
// //         imageUrl = data?['imageUrl'];
// //         description = data?['description'];
// //       });
// //     } catch (e) {
// //       print('Error loading image and description: $e');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Color(0xffB8D0F8),
// //       appBar: AppBar(
// //         automaticallyImplyLeading: false,
// //         backgroundColor: Color(0xcc0061FF),
// //         title: Center(
// //           child: Text(
// //             "[@Username]",
// //             style: TextStyle(color: Colors.white),
// //           ),
// //         ),
// //       ),
// //       drawer: Drawer(
// //         child: ListView(
// //           children: [
// //             UserAccountsDrawerHeader(decoration: BoxDecoration(
// //                image: DecorationImage(image: NetworkImage('https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),fit: BoxFit.cover),
// //
// //             ),
// //                currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage('https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),), accountName: Text('Hamza'), accountEmail: Text('hamza@cat.com'))
// //           ,ListTile(
// //               leading: Icon(Icons.person),
// //               title: Text('Profile'),
// //                 onTap: (){
// //                 Navigator.push(context, MaterialPageRoute(builder: (context) => Profile() ));
// //                 },
// //             )
// //             ,ListTile(
// //               leading: Icon(Icons.list),
// //               title: Text('Logs'),
// //               onTap: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => ListScreen()),
// //                 );
// //               },
// //             )
// //           ],
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               SizedBox(height: 120),
// //               Center(
// //                 child: imageUrl != null
// //                     ? Image.network(
// //                         imageUrl!,
// //                         height: 150,
// //                       )
// //                     : Text('No image available.'),
// //               ),
// //               SizedBox(height: 29),
// //               Container(
// //                 height: 247,
// //                 width: 309,
// //                 child: TextField(
// //                   controller: TextEditingController(text: description),
// //                   readOnly: true,
// //                   maxLines: null,
// //                   expands: true,
// //                   decoration: InputDecoration(
// //                     hintText: 'No description available',
// //                     hintStyle: TextStyle(color: Color(0xffCACACA)),
// //                     fillColor: Colors.grey[50],
// //                     filled: true,
// //                     prefixIcon: Icon(
// //                       Icons.description,
// //                       color: Color(0xffCACACA),
// //                     ),
// //                     focusedBorder: OutlineInputBorder(
// //                       borderSide: BorderSide(color: Color(0xff0061FF)),
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     enabledBorder: OutlineInputBorder(
// //                       borderSide: BorderSide(color: Color(0xffCACACA)),
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 20),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../list_screen.dart';
// import '../profile.dart';
//
// class FetchImageScreen extends StatefulWidget {
//   const FetchImageScreen({super.key});
//
//   @override
//   _FetchImageScreenState createState() => _FetchImageScreenState();
// }
//
// class _FetchImageScreenState extends State<FetchImageScreen> {
//   String? imageUrl;
//   String? description;
//   User? user;
//   String userName = "";
//   String userEmail = "";
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     _loadImageAndDescription();
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
//       });
//     }
//   }
//
//   Future<void> _loadImageAndDescription() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('complaints')
//           .orderBy("timestamp", descending: true)
//           .get();
//
//       final data = snapshot.docs.first.data();
//       setState(() {
//         imageUrl = data?['imageUrl'];
//         description = data?['description'];
//       });
//     } catch (e) {
//       print('Error loading image and description: $e');
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
//         title: Center(
//           child: Text(
//             "[@Username]",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
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
//               accountName: Text(userName),
//               accountEmail: Text(userEmail),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Profile()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.list),
//               title: Text('Logs'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ListScreen()),
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
//                 child: imageUrl != null
//                     ? Image.network(
//                   imageUrl!,
//                   height: 150,
//                 )
//                     : Text('No image available.'),
//               ),
//               SizedBox(height: 29),
//               Container(
//                 height: 247,
//                 width: 309,
//                 child: TextField(
//                   controller: TextEditingController(text: description),
//                   readOnly: true,
//                   maxLines: null,
//                   expands: true,
//                   decoration: InputDecoration(
//                     hintText: 'No description available',
//                     hintStyle: TextStyle(color: Color(0xffCACACA)),
//                     fillColor: Colors.grey[50],
//                     filled: true,
//                     prefixIcon: Icon(
//                       Icons.description,
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
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../list/list_screen.dart';
import '../profile.dart';
import '../login_v2.dart'; // Assuming you have a login screen defined in login_v2.dart

class FetchImageScreen extends StatefulWidget {
  const FetchImageScreen({super.key});

  @override
  _FetchImageScreenState createState() => _FetchImageScreenState();
}

class _FetchImageScreenState extends State<FetchImageScreen> {
  String? imageUrl;
  String? description;
  User? user;
  String userName = "";
  String userEmail = "";
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    _loadImageAndDescription();
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

  Future<void> _loadImageAndDescription() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('complaints')
          .orderBy("timestamp", descending: true)
          .get();

      final data = snapshot.docs.first.data();
      setState(() {
        imageUrl = data?['imageUrl'];
        description = data?['description'];
      });
    } catch (e) {
      print('Error loading image and description: $e');
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to your login screen
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB8D0F8),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xcc0061FF),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
        title: Center(
          child: Text(
            "[@Username]",
            style: TextStyle(color: Colors.white),
          ),
        ),
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
                    'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
              ),
              accountName: Text(userName),
              accountEmail: Text(userEmail),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Logs'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 120),
              Center(
                child: imageUrl != null
                    ? Image.network(
                  imageUrl!,
                  height: 150,
                )
                    : Text('No image available.'),
              ),
              SizedBox(height: 29),
              Container(
                height: 247,
                width: 309,
                child: TextField(
                  controller: TextEditingController(text: description),
                  readOnly: true,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'No description available',
                    hintStyle: TextStyle(color: Color(0xffCACACA)),
                    fillColor: Colors.grey[50],
                    filled: true,
                    prefixIcon: Icon(
                      Icons.description,
                      color: Color(0xffCACACA),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0061FF)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffCACACA)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
