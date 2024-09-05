

// // old code
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../about.dart';
// import '../../login_v2.dart';
// import '../../profile.dart';
// import 'Hvac_detailScreen.dart';
//
// class HvacListScreen extends StatefulWidget {
//   @override
//   _HvacListScreenState createState() => _HvacListScreenState();
// }
//
// class _HvacListScreenState extends State<HvacListScreen> {
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
//           .where('complaintCategories', arrayContains: 'HVAC')
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
//   void initState() {
//     super.initState();
//     fetchUserData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HVAC Complaints List'),
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
//               return Text('No HVAC complaints found');
//             }
//
//             final filteredData = snapshot.data!.where((doc) {
//               final data = doc.data() as Map<String, dynamic>?;
//
//               return data != null &&
//                   data.containsKey('complaintCategories') &&
//                   data['complaintCategories'].contains('HVAC');
//             }).toList();
//
//             if (filteredData.isEmpty) {
//               return Text('No HVAC complaints found with valid data');
//             }
//
//             return ListView.builder(
//               itemCount: filteredData.length,
//               itemBuilder: (context, index) {
//                 final item = filteredData[index];
//                 final data = item.data() as Map<String, dynamic>?;
//
//                 final imageUrls = (data?['imageUrls'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];
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
//                         builder: (context) => HvacDetailScreen(
//                           imageUrls: imageUrls,
//                           description: description,
//                           status: status,
//                           priority: priority,
//                           complaintId: complaintId,
//                           userId: userId,
//                           timestamp: timestamp,
//                           name: '', // Update with actual data if needed
//                           productionField: '', // Update with actual data if needed
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
//                               image: imageUrls.isNotEmpty
//                                   ? NetworkImage(imageUrls[0])
//                                   : AssetImage('assets/placeholder.png')
//                               as ImageProvider,
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




// mechanical code copy


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../about.dart';
import '../../login_v2.dart';
import '../../profile.dart';
import 'Hvac_detailScreen.dart';


class HvacListScreen extends StatefulWidget {
  @override
  _HvacListScreenState createState() => _HvacListScreenState();
}

class _HvacListScreenState extends State<HvacListScreen> {
  final FirebaseFirestore fs = FirebaseFirestore.instance;
  String _sortOrder = 'latest'; // Default sort order
  String? profileImageUrl;
  User? user;
  String userName = "";
  String userEmail = "";

  // Fetch data from Firestore
  Future<List<QueryDocumentSnapshot>> getData() async {
    try {
      Query query = fs
          .collection('complaints')
          .where('categories', arrayContains: 'HVAC')
          .orderBy('timestamp', descending: _sortOrder == 'latest');

      QuerySnapshot qs = await query.get();
      return qs.docs;
    } catch (e) {
      print('Error fetching complaints: $e');
      return [];
    }
  }

  // Fetch user data from Firestore
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

  // Logout the user
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  // Handle pull-to-refresh action
  Future<void> _handleRefresh() async {
    setState(() {
      // Refresh data by calling getData or other relevant methods
    });
  }

  // Sort data based on the selected order
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
    final appBarColor = Colors.blue; // AppBar color

    return Scaffold(
      appBar: AppBar(
        title: Text('HVAC Complaints List'),
        backgroundColor: appBarColor,
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
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: appBarColor, // Refresh indicator color
        backgroundColor: Colors.white, // Background color of the refresh area
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No HVAC complaints found'));
            }

            final filteredData = snapshot.data!.where((doc) {
              final data = doc.data() as Map<String, dynamic>?;

              return data != null &&
                  data.containsKey('categories') &&
                  data['categories'].contains('HVAC');
            }).toList();

            if (filteredData.isEmpty) {
              return Center(child: Text('No HVAC complaints found with valid data'));
            }

            return ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                final data = item.data() as Map<String, dynamic>?;

                final imageUrls = (data?['imageUrls'] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList() ?? [];
                final videoUrls = (data?['videoUrls'] as List<dynamic>?)
                    ?.map((e) => e.toString())
                    .toList() ?? [];
                final description = data?['description'] ?? 'No Description';
                final status = data?['status'] ?? 'Acceptance Pending'; // Default status if not provided
                final priority = data?['priority'] ?? 'N/A';
                final complaintId = item.id;
                final userId = data?['userId'] ?? '';
                final timestamp = data?['timestamp'] as Timestamp;

                // Determine indicator color based on status
                final Color statusIndicatorColor = status.toLowerCase() == 'completed'
                    ? Colors.green
                    : Colors.red;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HvacDetailScreen(
                          imageUrls: imageUrls,
                          description: description,
                          priority: priority,
                          complaintId: complaintId,
                          userId: userId,
                          timestamp: timestamp,
                          videoUrls: videoUrls,
                          name: '',
                          production_field: '',
                          imageUrl: '', status: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                        // Image Thumbnail
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
                        // Status Indicator
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: statusIndicatorColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10),
                        // Complaint Details
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
