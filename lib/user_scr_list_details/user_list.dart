// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../list/detail_screen.dart';
// import 'my_list_details.dart';
//
// class MyGeneratedComplaintsScreen extends StatelessWidget {
//   const MyGeneratedComplaintsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final User? user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       return Center(
//         child: Text('User not logged in'),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Complain List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('complaints')
//             .where('userId', isEqualTo: user.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No complaints found'));
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
//               final data = docSnapshot.data() as Map<String, dynamic>;
//
//               final complaintId = docSnapshot.id;
//               final imageUrl = data['imageUrl'] ?? '';
//               final description = data['description'] ?? 'No Description';
//               final acceptedBy = data['acceptedBy'] ?? 'In Progress';
//               final workCompletedBy = data['workCompletedBy'] ?? 'In Progress';
//               final acceptedEmail = data['acceptedEmail'] ?? 'No email provided';
//               final workCompletedEmail = data['workCompletedEmail'] ?? 'No email provided';
//               final acceptedAt = (data['acceptedAt'] as Timestamp?)?.toDate();
//               final workCompletedAt = (data['workCompletedAt'] as Timestamp?)?.toDate();
//               final priority = data['priority'] ?? 'Not Specified';
//               final complaintCategory = data['complaintCategory'] ?? 'General';
//
//               return ListTile(
//                 leading: imageUrl.isNotEmpty
//                     ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
//                     : null,
//                 title: Text(description),
//                 subtitle: Text('Category: $complaintCategory\nPriority: $priority\nStatus: ${workCompletedBy == 'In Progress' ? 'In Progress' : 'Completed'}'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ComplaintDetailScreen(
//                         complaintId: complaintId,
//                         imageUrl: imageUrl,
//                         description: description,
//                         acceptedBy: acceptedBy,
//                         completedBy: workCompletedBy,
//                         acceptedByEmail: acceptedEmail,
//                         acceptedTimestamp: acceptedAt,
//                         completedByEmail: workCompletedEmail,
//                         completedTimestamp: workCompletedAt,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

//UI updated only
// //list sorting
//   import 'package:cloud_firestore/cloud_firestore.dart';
//   import 'package:firebase_auth/firebase_auth.dart';
//   import 'package:flutter/material.dart';
//   import '../list/detail_screen.dart';
//   import 'my_list_details.dart';
//
//   class MyGeneratedComplaintsScreen extends StatelessWidget {
//     const MyGeneratedComplaintsScreen({Key? key}) : super(key: key);
//
//     @override
//     Widget build(BuildContext context) {
//       final User? user = FirebaseAuth.instance.currentUser;
//
//       if (user == null) {
//         return const Center(
//           child: Text('User not logged in'),
//         );
//       }
//
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('My Complaints List'),
//           backgroundColor: Colors.blue,
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('complaints')
//               .where('userId', isEqualTo: user.uid)
//               .orderBy('timestamp', descending: true) // Order by timestamp in descending order
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(child: Text('No complaints found'));
//             }
//
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
//                 final data = docSnapshot.data() as Map<String, dynamic>;
//
//                 final complaintId = docSnapshot.id;
//                 final imageUrl = data['imageUrl'] ?? '';
//                 final description = data['description'] ?? 'No Description';
//                 final acceptedBy = data['acceptedBy'] ?? 'In Progress';
//                 final workCompletedBy = data['workCompletedBy'] ?? 'In Progress';
//                 final acceptedEmail = data['acceptedEmail'] ?? 'No email provided';
//                 final workCompletedEmail = data['workCompletedEmail'] ?? 'No email provided';
//                 final acceptedAt = (data['acceptedAt'] as Timestamp?)?.toDate();
//                 final workCompletedAt = (data['workCompletedAt'] as Timestamp?)?.toDate();
//                 final priority = data['priority'] ?? 'Not Specified';
//                 final complaintCategory = data['complaintCategory'] ?? 'General';
//
//                 final isCompleted = workCompletedBy != 'In Progress';
//                 final statusColor = isCompleted ? Colors.green : Colors.red;
//
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ComplaintDetailScreen(
//                           complaintId: complaintId,
//                           imageUrl: imageUrl,
//                           description: description,
//                           acceptedBy: acceptedBy,
//                           completedBy: workCompletedBy,
//                           acceptedByEmail: acceptedEmail,
//                           acceptedTimestamp: acceptedAt,
//                           completedByEmail: workCompletedEmail,
//                           completedTimestamp: workCompletedAt, imageUrls: [],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: const EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         if (imageUrl.isNotEmpty)
//                           Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8.0),
//                               image: DecorationImage(
//                                 image: NetworkImage(imageUrl),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         const SizedBox(width: 10.0),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 description,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Category: $complaintCategory',
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                               Text(
//                                 'Priority: $priority',
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     isCompleted ? 'Completed' : 'In Progress',
//                                     style: TextStyle(fontSize: 12, color: statusColor),
//                                   ),
//                                   const SizedBox(width: 4),
//                                   CircleAvatar(
//                                     radius: 5,
//                                     backgroundColor: statusColor,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 10.0),
//                         Container(
//                           width: 50,
//                           height: 50,
//                           child: const Icon(Icons.chevron_right, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//         backgroundColor: Colors.blue.shade100,
//       );
//     }
//   }


//new code
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../list/detail_screen.dart';
// import 'my_list_details.dart';
//
// class MyGeneratedComplaintsScreen extends StatelessWidget {
//   const MyGeneratedComplaintsScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final User? user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       return const Center(
//         child: Text('User not logged in'),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Complaints List'),
//         backgroundColor: Colors.blue,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('complaints')
//             .where('userId', isEqualTo: user.uid)
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No complaints found'));
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
//               final data = docSnapshot.data() as Map<String, dynamic>;
//
//               final complaintId = docSnapshot.id;
//               final imageUrls = List<String>.from(data['imageUrls'] ?? []);
//               final description = data['description'] ?? 'No Description';
//               final acceptedBy = data['acceptedBy'] ?? 'In Progress';
//               final workCompletedBy = data['workCompletedBy'] ?? 'In Progress';
//               final acceptedEmail = data['acceptedEmail'] ?? 'No email provided';
//               final workCompletedEmail = data['workCompletedEmail'] ?? 'No email provided';
//               final acceptedAt = (data['acceptedAt'] as Timestamp?)?.toDate();
//               final workCompletedAt = (data['workCompletedAt'] as Timestamp?)?.toDate();
//               final priority = data['priority'] ?? 'Not Specified';
//               final complaintCategory = data['complaintCategory'] ?? 'General';
//
//               final isCompleted = workCompletedBy != 'In Progress';
//               final statusColor = isCompleted ? Colors.green : Colors.red;
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ComplaintDetailScreen(
//                         complaintId: complaintId,
//                         imageUrls: imageUrls,
//                         description: description,
//                         acceptedBy: acceptedBy,
//                         completedBy: workCompletedBy,
//                         acceptedByEmail: acceptedEmail,
//                         acceptedTimestamp: acceptedAt,
//                         completedByEmail: workCompletedEmail,
//                         completedTimestamp: workCompletedAt, mediaUrls: [],
//                       ),
//                     ),
//                   );
//                 },
//                 child: Card(
//                   margin: const EdgeInsets.all(8.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   elevation: 4.0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 description,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16.0,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             if (imageUrls.isNotEmpty)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: Image.network(
//                                   imageUrls.first,
//                                   width: 48.0,
//                                   height: 48.0,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                           ],
//                         ),
//                         const SizedBox(height: 8.0),
//                         Text('Category: $complaintCategory', style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
//                         Text('Priority: $priority', style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
//                         const SizedBox(height: 8.0),
//                         Text(
//                           isCompleted ? 'Completed' : 'Pending',
//                           style: TextStyle(
//                             color: statusColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8.0),
//                         Row(
//                           children: [
//                             Icon(Icons.timer, size: 16.0, color: Colors.grey[600]),
//                             const SizedBox(width: 4.0),
//                             Text(
//                               (data['timestamp'] as Timestamp).toDate().toString(),
//                               style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


// // include video and images
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'my_list_details.dart';
//
//
//
// class MyGeneratedComplaintsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       return const Center(
//         child: Text('User not logged in'),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Complaints List'),
//         backgroundColor: Colors.blue,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('complaints')
//             .where('userId', isEqualTo: user.uid)
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No complaints found'));
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
//               final data = docSnapshot.data() as Map<String, dynamic>;
//
//               final complaintId = docSnapshot.id;
//               final imageUrls = List<String>.from(data['imageUrls'] ?? []);
//               final videoUrls = List<String>.from(data['videoUrls'] ?? []);
//               final description = data['description'] ?? 'No Description';
//               final acceptedBy = data['acceptedBy'] ?? 'In Progress';
//               final workCompletedBy = data['workCompletedBy'] ?? 'In Progress';
//               final acceptedEmail = data['acceptedEmail'] ?? 'No email provided';
//               final workCompletedEmail = data['workCompletedEmail'] ?? 'No email provided';
//               final acceptedAt = (data['acceptedAt'] as Timestamp?)?.toDate();
//               final workCompletedAt = (data['workCompletedAt'] as Timestamp?)?.toDate();
//               final priority = data['priority'] ?? 'Not Specified';
//               final complaintCategory = data['complaintCategory'] ?? 'General';
//
//               final isCompleted = workCompletedBy != 'In Progress';
//               final statusColor = isCompleted ? Colors.green : Colors.red;
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ComplaintDetailScreen(
//                         complaintId: complaintId,
//                         imageUrls: imageUrls,
//                         videoUrls: videoUrls,
//                         description: description,
//                         acceptedBy: acceptedBy,
//                         completedBy: workCompletedBy,
//                         acceptedByEmail: acceptedEmail,
//                         acceptedTimestamp: acceptedAt,
//                         completedByEmail: workCompletedEmail,
//                         completedTimestamp: workCompletedAt,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Card(
//                   margin: const EdgeInsets.all(8.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   elevation: 4.0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 description,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16.0,
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             if (imageUrls.isNotEmpty || videoUrls.isNotEmpty)
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: (imageUrls.isNotEmpty)
//                                     ? Image.network(
//                                   imageUrls.first,
//                                   width: 48.0,
//                                   height: 48.0,
//                                   fit: BoxFit.cover,
//                                 )
//                                     : Icon(Icons.videocam, size: 48.0, color: Colors.grey),
//                               ),
//                           ],
//                         ),
//                         const SizedBox(height: 8.0),
//                         Text('Category: $complaintCategory', style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
//                         Text('Priority: $priority', style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
//                         const SizedBox(height: 8.0),
//                         Text(
//                           isCompleted ? 'Completed' : 'Pending',
//                           style: TextStyle(
//                             color: statusColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8.0),
//                         Row(
//                           children: [
//                             Icon(Icons.timer, size: 16.0, color: Colors.grey[600]),
//                             const SizedBox(width: 4.0),
//                             Text(
//                               (data['timestamp'] as Timestamp).toDate().toString(),
//                               style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


// include video and images
// // UI + indicators
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'my_list_details.dart';
//
// class user_list_screen extends StatefulWidget {
//   @override
//   _user_list_screenState createState() => _user_list_screenState();
// }
//
// class _user_list_screenState extends State<user_list_screen> {
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
//
//   Future<void> _handleRefresh() async {
//     setState(() {}); // This will refresh the data
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       return const Center(
//         child: Text('User not logged in'),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Complaints List'),
//         backgroundColor: Colors.blue,
//       ),
//       body: LiquidPullToRefresh(
//         key: _refreshIndicatorKey,
//         onRefresh: _handleRefresh,
//         color: Colors.blue,
//         backgroundColor: Colors.white,
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('complaints')
//               .where('userId', isEqualTo: user.uid)
//               .orderBy('timestamp', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(child: Text('No complaints found'));
//             }
//
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
//                 final data = docSnapshot.data() as Map<String, dynamic>;
//
//                 final complaintId = docSnapshot.id;
//                 final imageUrls = List<String>.from(data['imageUrls'] ?? []);
//                 final videoUrls = List<String>.from(data['videoUrls'] ?? []);
//                 final description = data['description'] ?? 'No Description';
//                 final acceptedBy = data['acceptedBy'] ?? 'In Progress';
//                 final workCompletedBy = data['workCompletedBy'] ?? 'In Progress';
//                 final acceptedEmail = data['acceptedEmail'] ?? 'No email provided';
//                 final workCompletedEmail = data['workCompletedEmail'] ?? 'No email provided';
//                 final acceptedAt = (data['acceptedAt'] as Timestamp?)?.toDate();
//                 final workCompletedAt = (data['workCompletedAt'] as Timestamp?)?.toDate();
//                 final priority = data['priority'] ?? 'Not Specified';
//                 final complaintCategory = data['complaintCategory'] ?? 'General';
//                 final status = data['status'] ?? 'Pending'; // Retrieve the status from Firestore
//
//                 final isCompleted = workCompletedBy != 'In Progress';
//                 final statusColor = isCompleted ? Colors.green : Colors.red;
//
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ComplaintDetailScreen(
//                           complaintId: complaintId,
//                           imageUrls: imageUrls,
//                           videoUrls: videoUrls,
//                           description: description,
//                           acceptedBy: acceptedBy,
//                           completedBy: workCompletedBy,
//                           acceptedByEmail: acceptedEmail,
//                           acceptedTimestamp: acceptedAt,
//                           completedByEmail: workCompletedEmail,
//                           completedTimestamp: workCompletedAt,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     margin: const EdgeInsets.all(8.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                     elevation: 4.0,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   description,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16.0,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               if (imageUrls.isNotEmpty || videoUrls.isNotEmpty)
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   child: (imageUrls.isNotEmpty)
//                                       ? Image.network(
//                                     imageUrls.first,
//                                     width: 48.0,
//                                     height: 48.0,
//                                     fit: BoxFit.cover,
//                                   )
//                                       : Icon(Icons.videocam, size: 48.0, color: Colors.grey),
//                                 ),
//                             ],
//                           ),
//                           const SizedBox(height: 8.0),
//                           Text('Category: $complaintCategory',
//                               style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
//                           Text('Priority: $priority',
//                               style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
//                           const SizedBox(height: 8.0),
//                           Text(
//                             'Status: $status',  // Display the status retrieved from Firestore
//                             style: TextStyle(
//                               color: statusColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8.0),
//                           Row(
//                             children: [
//                               Icon(Icons.timer, size: 16.0, color: Colors.grey[600]),
//                               const SizedBox(width: 4.0),
//                               Text(
//                                 (data['timestamp'] as Timestamp).toDate().toString(),
//                                 style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
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
//




// UI + multi indicators


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'my_list_details.dart';

class user_list_screen extends StatefulWidget {
  @override
  _user_list_screenState createState() => _user_list_screenState();
}

class _user_list_screenState extends State<user_list_screen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _handleRefresh() async {
    setState(() {}); // This will refresh the data
  }

  // Color mapping based on status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'In Review':
        return Colors.blue;
      case 'Work in Progress':
        return Colors.yellow;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey; // Default color for unknown statuses
    }
  }

  // Widget to display status indicators for each category
  Widget _buildStatusIndicator(String category, String status) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$category:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 6.0,
                backgroundColor: _getStatusColor(status),
              ),
              SizedBox(width: 8.0),
              Text(status, style: TextStyle(color: _getStatusColor(status))),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(
        child: Text('User not logged in'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Complaints List'),
        backgroundColor: Colors.blue,
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: Colors.blue,
        backgroundColor: Colors.white,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('complaints')
              .where('userId', isEqualTo: user.uid)
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No complaints found'));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                final data = docSnapshot.data() as Map<String, dynamic>;

                final complaintId = docSnapshot.id;
                final imageUrls = List<String>.from(data['imageUrls'] ?? []);
                final videoUrls = List<String>.from(data['videoUrls'] ?? []);
                final description = data['description'] ?? 'No Description';
                final priority = data['priority'] ?? 'Not Specified';
                final complaintCategory = data['complaintCategory'] ?? 'General';
                final status = data['status'] ?? 'Pending'; // Retrieve the status from Firestore
                final timestamp = (data['timestamp'] as Timestamp).toDate();


                // Format full timestamp to 12-hour format with AM/PM
                String formattedTimestamp = DateFormat('MMM dd, yyyy hh:mm a').format(timestamp);

                // Statuses for categories
                final utilityStatus = data['utilityStatus'] ?? 'Not Available';
                final hvacStatus = data['hvacStatus'] ?? 'Not Available';
                final mechanicalStatus = data['mechanicalStatus'] ?? 'Not Available';
                final electricalStatus = data['electricalStatus'] ?? 'Not Available';

                final categories = List<String>.from(data['categories'] ?? []);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComplaintDetailScreen(
                          complaintId: complaintId,
                          imageUrls: imageUrls,
                          videoUrls: videoUrls,
                          description: description,
                          acceptedBy: 'N/A', // Pass actual data as per your needs
                          completedBy: 'N/A', // Pass actual data as per your needs
                          acceptedByEmail: 'N/A', // Pass actual data as per your needs
                          acceptedTimestamp: null, // Pass actual data as per your needs
                          completedByEmail: 'N/A', // Pass actual data as per your needs
                          completedTimestamp: null, // Pass actual data as per your needs
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  description,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (imageUrls.isNotEmpty || videoUrls.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: (imageUrls.isNotEmpty)
                                      ? Image.network(
                                    imageUrls.first,
                                    width: 48.0,
                                    height: 48.0,
                                    fit: BoxFit.cover,
                                  )
                                      : Icon(Icons.videocam, size: 48.0, color: Colors.grey),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text('Category: $complaintCategory', style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
                          Text('Priority: $priority', style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
                          const SizedBox(height: 8.0),
                          Text(
                            'Status: $status',
                            style: TextStyle(
                              color: _getStatusColor(status),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),

                          // Display indicators for available categories and their statuses
                          if (categories.contains('Utility'))
                            _buildStatusIndicator('Utility', utilityStatus),
                          if (categories.contains('HVAC'))
                            _buildStatusIndicator('HVAC', hvacStatus),
                          if (categories.contains('Mechanical'))
                            _buildStatusIndicator('Mechanical', mechanicalStatus),
                          if (categories.contains('Electrical'))
                            _buildStatusIndicator('Electrical', electricalStatus),

                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.timer, size: 16.0, color: Colors.grey[600]),
                              const SizedBox(width: 4.0),
                              Text(
                                formattedTimestamp, // Use the formatted full timestamp here
                                style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
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
