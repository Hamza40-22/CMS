// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../login_v2.dart';
// import 'Utility_detail_Scr.dart';
//
// class UtilityListScr extends StatefulWidget {
//   @override
//   _ListScreenState createState() => _ListScreenState();
// }
//
// class _ListScreenState extends State<UtilityListScr> {
//   final FirebaseFirestore fs = FirebaseFirestore.instance;
//
//   Future<List<QueryDocumentSnapshot>> getData() async {
//     try {
//       // Fetch complaints where category is 'Utility'
//       QuerySnapshot qs = await fs
//           .collection('complaints')
//           .where('complaintCategory', isEqualTo: 'Utility')
//           .get();
//       return qs.docs;
//     } catch (e) {
//       print('Error fetching complaints: $e');
//       return [];
//     }
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//           (Route<dynamic> route) => false,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Utility Complaints List'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       body: Center(
//         child: FutureBuilder<List<QueryDocumentSnapshot>>(
//           future: getData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState != ConnectionState.done) {
//               return CircularProgressIndicator();
//             }
//
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Text('No utility complaints found');
//             }
//
//             // Filter out documents with missing or empty fields
//             final filteredData = snapshot.data!.where((doc) {
//               final data = doc.data() as Map<String, dynamic>?;
//
//               final imageUrl = data?['imageUrl'] ?? '';
//               final description = data?['description'] ?? '';
//               final status = data?['status'] ?? 'In Progress';
//
//               return imageUrl.isNotEmpty && description.isNotEmpty && status.isNotEmpty;
//             }).toList();
//
//             if (filteredData.isEmpty) {
//               return Text('No utility complaints found with valid data');
//             }
//
//             return ListView.builder(
//               itemCount: filteredData.length,
//               itemBuilder: (context, index) {
//                 final item = filteredData[index];
//                 final data = item.data() as Map<String, dynamic>?;
//
//                 final imageUrl = data?['imageUrl'] ?? '';
//                 final description = data?['description'] ?? 'No Description';
//                 final acceptedBy = data?['acceptedBy'] ?? 'In Progress';
//                 final completedBy = data?['completedBy'] ?? 'In Progress';
//                 final acceptedEmail = data?['acceptedEmail'] ?? 'No email provided';
//                 final completedEmail = data?['completedEmail'] ?? 'No email provided';
//                 final acceptedTimestamp = (data?['acceptedAt'] as Timestamp?)?.toDate();
//                 final completedTimestamp = (data?['completedAt'] as Timestamp?)?.toDate();
//                 final priority = data?['priority'] ?? 'N/A';
//                 final complaintCategory = data?['complaintCategory'] ?? 'N/A';
//                 final queryClosed = data?['queryClosed'] ?? false;
//                 final queryClosedAt = (data?['queryClosedAt'] as Timestamp?)?.toDate();
//                 final status = data?['status'] ?? 'In Progress';
//
//                 // Determine task status and color
//                 final isClosed = queryClosed;
//                 final statusColor = isClosed ? Colors.green : Colors.red;
//
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailScreen(
//                           imageUrl: imageUrl,
//                           description: description,
//                           acceptedBy: acceptedBy,
//                           completedBy: completedBy,
//                           acceptedByEmail: acceptedEmail,
//                           acceptedTimestamp: acceptedTimestamp,
//                           completedByEmail: completedEmail,
//                           completedTimestamp: completedTimestamp,
//                           priority: priority,
//                           complaintCategory: complaintCategory,
//                           queryClosed: queryClosed,
//                           queryClosedAt: queryClosedAt,
//                           status: status,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: NetworkImage(imageUrl),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.0),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 description,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Text(
//                                     status,
//                                     style: TextStyle(fontSize: 12, color: statusColor),
//                                   ),
//                                   SizedBox(width: 4),
//                                   CircleAvatar(
//                                     radius: 5,
//                                     backgroundColor: statusColor,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 10.0),
//                         Container(
//                           width: 50,
//                           height: 50,
//                           child: Icon(Icons.chevron_right, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       backgroundColor: Colors.blue.shade100,
//     );
//   }
// }

// // old code
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../login_v2.dart';
// import '../Electrical_List/Electrical_detailScreen.dart';
// import 'Utility_detail_Scr.dart';
//
// class UtilityListScr extends StatefulWidget {
//   @override
//   _ListScreenState createState() => _ListScreenState();
// }
//
// class _ListScreenState extends State<UtilityListScr> {
//   final FirebaseFirestore fs = FirebaseFirestore.instance;
//   String _sortOrder = 'latest'; // Default sort order
//
//   Future<List<QueryDocumentSnapshot>> getData() async {
//     try {
//       // Fetch complaints where category is 'Utility'
//       Query query = fs.collection('complaints')
//           .where('complaintCategory', isEqualTo: 'Utility')
//           .orderBy('timestamp', descending: _sortOrder == 'latest');
//
//       QuerySnapshot qs = await query.get();
//       return qs.docs;
//     } catch (e) {
//       print('Error fetching complaints: $e');
//       return [];
//     }
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//           (Route<dynamic> route) => false,
//     );
//   }
//
//   void _sortData(String order) {
//     setState(() {
//       _sortOrder = order;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Utility Complaints List'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//           PopupMenuButton<String>(
//             onSelected: _sortData,
//             itemBuilder: (BuildContext context) {
//               return {'latest', 'oldest'}.map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice == 'latest' ? 'Latest' : 'Oldest'),
//                 );
//               }).toList();
//             },
//             icon: Icon(Icons.sort),
//           ),
//         ],
//       ),
//       body: Center(
//         child: FutureBuilder<List<QueryDocumentSnapshot>>(
//           future: getData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState != ConnectionState.done) {
//               return CircularProgressIndicator();
//             }
//
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Text('No utility complaints found');
//             }
//
//             // Filter out documents with missing or empty fields
//             final filteredData = snapshot.data!.where((doc) {
//               final data = doc.data() as Map<String, dynamic>?;
//
//               final imageUrl = data?['imageUrl'] ?? '';
//               final description = data?['description'] ?? '';
//               final status = data?['status'] ?? 'In Progress';
//
//               return imageUrl.isNotEmpty && description.isNotEmpty && status.isNotEmpty;
//             }).toList();
//
//             if (filteredData.isEmpty) {
//               return Text('No utility complaints found with valid data');
//             }
//
//             return ListView.builder(
//               itemCount: filteredData.length,
//               itemBuilder: (context, index) {
//                 final item = filteredData[index];
//                 final data = item.data() as Map<String, dynamic>?;
//
//                 final imageUrl = data?['imageUrl'] ?? '';
//                 final description = data?['description'] ?? 'No Description';
//                 final acceptedBy = data?['acceptedBy'] ?? 'In Progress';
//                 final completedBy = data?['completedBy'] ?? 'In Progress';
//                 final acceptedEmail = data?['acceptedEmail'] ?? 'No email provided';
//                 final completedEmail = data?['completedEmail'] ?? 'No email provided';
//                 final acceptedTimestamp = (data?['acceptedAt'] as Timestamp?)?.toDate();
//                 final completedTimestamp = (data?['completedAt'] as Timestamp?)?.toDate();
//                 final priority = data?['priority'] ?? 'N/A';
//                 final complaintCategory = data?['complaintCategory'] ?? 'N/A';
//                 final queryClosed = data?['queryClosed'] ?? false;
//                 final queryClosedAt = (data?['queryClosedAt'] as Timestamp?)?.toDate();
//                 final status = data?['status'] ?? 'In Progress';
//
//                 // Determine task status and color
//                 final isClosed = queryClosed;
//                 final statusColor = isClosed ? Colors.green : Colors.red;
//
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Electrical_DetailScreen(
//                           imageUrl: imageUrl,
//                           description: description,
//                           acceptedBy: acceptedBy,
//                           completedBy: completedBy,
//                           acceptedByEmail: acceptedEmail,
//                           acceptedTimestamp: acceptedTimestamp,
//                           completedByEmail: completedEmail,
//                           completedTimestamp: completedTimestamp,
//                           priority: priority,
//                           complaintCategory: complaintCategory,
//                           queryClosed: queryClosed,
//                           queryClosedAt: queryClosedAt,
//                           status: status,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: NetworkImage(imageUrl),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.0),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 description,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Text(
//                                     status,
//                                     style: TextStyle(fontSize: 12, color: statusColor),
//                                   ),
//                                   SizedBox(width: 4),
//                                   CircleAvatar(
//                                     radius: 5,
//                                     backgroundColor: statusColor,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 10.0),
//                         Container(
//                           width: 50,
//                           height: 50,
//                           child: Icon(Icons.chevron_right, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       backgroundColor: Colors.blue.shade100,
//     );
//   }
// }

// working list
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../about.dart';
// import '../../login_v2.dart';
// import '../../profile.dart';
// import 'Utility_detail_Scr.dart';
//
// class UtilityListScreen extends StatefulWidget {
//   @override
//   _UtilityListScreenState createState() => _UtilityListScreenState();
// }
//
// class _UtilityListScreenState extends State<UtilityListScreen> {
//   final FirebaseFirestore fs = FirebaseFirestore.instance;
//   String _sortOrder = 'latest'; // Default sort order
//   String? profileImageUrl;
//   User? user;
//   String userName = "";
//   String userEmail = "";
//
//   Future<List<QueryDocumentSnapshot>> getData() async {
//     try {
//       Query query = fs
//           .collection('complaints')
//           .where('complaintCategories', arrayContains: 'Utility')
//           .orderBy('timestamp', descending: _sortOrder == 'latest');
//
//       QuerySnapshot qs = await query.get();
//       return qs.docs;
//     } catch (e) {
//       print('Error fetching complaints: $e');
//       return [];
//     }
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
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//       (Route<dynamic> route) => false,
//     );
//   }
//
//   void _sortData(String order) {
//     setState(() {
//       _sortOrder = order;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Utility Complaints List'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//           PopupMenuButton<String>(
//             onSelected: _sortData,
//             itemBuilder: (BuildContext context) {
//               return {'latest', 'oldest'}.map((String choice) {
//                 return PopupMenuItem<String>(
//                   value: choice,
//                   child: Text(choice == 'latest' ? 'Latest' : 'Oldest'),
//                 );
//               }).toList();
//             },
//             icon: Icon(Icons.sort),
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
//                 backgroundImage: profileImageUrl != null
//                     ? NetworkImage(profileImageUrl!)
//                     : NetworkImage(
//                         'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
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
//       body: Center(
//         child: FutureBuilder<List<QueryDocumentSnapshot>>(
//           future: getData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState != ConnectionState.done) {
//               return CircularProgressIndicator();
//             }
//
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Text('No Utility complaints found');
//             }
//
//             final filteredData = snapshot.data!.where((doc) {
//               final data = doc.data() as Map<String, dynamic>?;
//
//               return data != null &&
//                   data.containsKey('complaintCategories') &&
//                   data['complaintCategories'].contains('Utility');
//             }).toList();
//
//             if (filteredData.isEmpty) {
//               return Text('No Utility complaints found with valid data');
//             }
//
//             return ListView.builder(
//               itemCount: filteredData.length,
//               itemBuilder: (context, index) {
//                 final item = filteredData[index];
//                 final data = item.data() as Map<String, dynamic>?;
//
//                 final imageUrls = (data?['imageUrls'] as List<dynamic>?)
//                         ?.map((e) => e.toString())
//                         .toList() ??
//                     [];
//                 final description = data?['description'] ?? 'No Description';
//                 final status = data?['status'] ?? 'Acceptance Pending';
//                 final priority = data?['priority'] ?? 'N/A';
//                 final complaintId = item.id;
//                 final userId = data?['userId'] ?? '';
//                 final timestamp = data?['timestamp'] as Timestamp;
//
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => UtilityDetailScreen(
//                           imageUrls: imageUrls,
//                           description: description,
//                           status: status,
//                           priority: priority,
//                           complaintId: complaintId,
//                           userId: userId,
//                           timestamp: timestamp,
//                           name: '', // Update with actual data if needed
//                           productionField: '', videoUrls: [],
//                           imageUrl: '', // Update with actual data if needed
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin:
//                         EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: imageUrls.isNotEmpty
//                                   ? NetworkImage(imageUrls[0])
//                                   : AssetImage('assets/placeholder.png')
//                                       as ImageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Description: $description',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                               SizedBox(height: 4),
//                               Text('Status: $status'),
//                               Text('Priority: $priority'),
//                             ],
//                           ),
//                         ),
//                         Icon(Icons.arrow_forward_ios, size: 16),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//list with videos worked
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../about.dart';
import '../../login_v2.dart';
import '../../profile.dart';
import 'Utility_detail_Scr.dart';

class UtilityListScreen extends StatefulWidget {
  @override
  _UtilityListScreenState createState() => _UtilityListScreenState();
}

class _UtilityListScreenState extends State<UtilityListScreen> {
  final FirebaseFirestore fs = FirebaseFirestore.instance;
  String _sortOrder = 'latest'; // Default sort order
  String? profileImageUrl;
  User? user;
  String userName = "";
  String userEmail = "";

  Future<List<QueryDocumentSnapshot>> getData() async {
    try {
      Query query = fs
          .collection('complaints')
          .where('categories', arrayContains: 'Utility')
          .orderBy('timestamp', descending: _sortOrder == 'latest');


      QuerySnapshot qs = await query.get();
      return qs.docs;
    } catch (e) {
      print('Error fetching complaints: $e');
      return [];
    }
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
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }

  void _sortData(String order) {
    setState(() {
      _sortOrder = order;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utility Complaints List'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
          PopupMenuButton<String>(
            onSelected: _sortData,
            itemBuilder: (BuildContext context) {
              return {'latest', 'oldest'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice == 'latest' ? 'Latest' : 'Oldest'),
                );
              }).toList();
            },
            icon: Icon(Icons.sort),
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
      body: Center(
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No Utility complaints found');
            }

            final filteredData = snapshot.data!.where((doc) {
              final data = doc.data() as Map<String, dynamic>?;

              return data != null &&
                  data.containsKey('categories') &&
                  data['categories'].contains('Utility');
            }).toList();

            if (filteredData.isEmpty) {
              return Text('No Utility complaints found with valid data');
            }

            return ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                final data = item.data() as Map<String, dynamic>?;

                final imageUrls = (data?['imageUrls'] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList() ??
                    [];
                final videoUrls = (data?['videoUrls'] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList() ??
                    [];
                final description = data?['description'] ?? 'No Description';
                final status = data?['status'] ?? 'Acceptance Pending';
                final priority = data?['priority'] ?? 'N/A';
                final complaintId = item.id;
                final userId = data?['userId'] ?? '';
                final timestamp = data?['timestamp'] as Timestamp;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UtilityDetailScreen(
                          imageUrls: imageUrls,
                          description: description,
                          status: status,
                          priority: priority,
                          complaintId: complaintId,
                          userId: userId,
                          timestamp: timestamp,
                          videoUrls: videoUrls, // Include video URLs
                          name: '', // Update with actual data if needed
                          production_field: '', // Update with actual data if needed
                          imageUrl: ''
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: imageUrls.isNotEmpty
                                  ? NetworkImage(imageUrls[0])
                                  : AssetImage('assets/placeholder.png')
                              as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description: $description',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(height: 4),
                              Text('Status: $status'),
                              Text('Priority: $priority'),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
