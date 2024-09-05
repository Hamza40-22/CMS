// // old code
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class MechanicalDetailScreen extends StatelessWidget {
//   final String imageUrl;
//   final String description;
//   final String acceptedBy;
//   final String completedBy;
//   final String acceptedByEmail;
//   final DateTime? acceptedTimestamp;
//   final String completedByEmail;
//   final DateTime? completedTimestamp;
//   final String priority;
//   final String complaintCategory;
//   final bool queryClosed;
//   final DateTime? queryClosedAt;
//   final String status;
//
//   MechanicalDetailScreen({
//     required this.imageUrl,
//     required this.description,
//     required this.acceptedBy,
//     required this.completedBy,
//     required this.acceptedByEmail,
//     this.acceptedTimestamp,
//     required this.completedByEmail,
//     this.completedTimestamp,
//     required this.priority,
//     required this.complaintCategory,
//     required this.queryClosed,
//     this.queryClosedAt,
//     required this.status,
//   });
//
//   void _showFullScreenImage(BuildContext context, String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.all(10),
//         child: GestureDetector(
//           onTap: () => Navigator.of(context).pop(),
//           child: InteractiveViewer(
//             child: Image.network(imageUrl, fit: BoxFit.contain),
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _formatDateTime(DateTime? dateTime) {
//     if (dateTime == null) return "N/A";
//     return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         elevation: 0,
//         title: Text('Mechanical Complaint Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 if (imageUrl.isNotEmpty) {
//                   _showFullScreenImage(context, imageUrl);
//                 }
//               },
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12.0),
//                 child: imageUrl.isNotEmpty
//                     ? Image.network(imageUrl, height: 250, width: double.infinity, fit: BoxFit.cover)
//                     : Container(
//                   height: 250,
//                   width: double.infinity,
//                   color: Colors.grey.shade300,
//                   child: Icon(Icons.image, size: 100, color: Colors.grey.shade600),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Description",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               description,
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//             SizedBox(height: 20),
//             _buildDetailRow("Priority", priority),
//             _buildDetailRow("Category", complaintCategory),
//             _buildDetailRow("Status", status),
//             _buildDetailRow("Accepted by", acceptedBy),
//             _buildDetailRow("Accepted by email", acceptedByEmail),
//             _buildDetailRow("Accepted on", _formatDateTime(acceptedTimestamp)),
//             _buildDetailRow("Completed by", completedBy),
//             _buildDetailRow("Completed by email", completedByEmail),
//             _buildDetailRow("Completed on", _formatDateTime(completedTimestamp)),
//             if (queryClosed)
//               _buildDetailRow("Query closed on", _formatDateTime(queryClosedAt)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 6,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 2,
//               child: Text(
//                 "$label: ",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Text(
//                 value,
//                 style: TextStyle(color: Colors.black87),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// complain accept and complete working
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class Mechanical_DetailScreen extends StatefulWidget {
//   final List<String> imageUrls;
//   final String description;
//   final String status;
//   final String priority;
//   final String complaintId;
//   final String userId;
//   final Timestamp timestamp;
//   final String name;
//   final String productionField;
//
//   Mechanical_DetailScreen({
//     required this.imageUrls,
//     required this.description,
//     required this.status,
//     required this.priority,
//     required this.complaintId,
//     required this.userId,
//     required this.timestamp,
//     required this.name,
//     required this.productionField,
//   });
//
//   @override
//   _Mechanical_DetailScreenState createState() => _Mechanical_DetailScreenState();
// }
//
// class _Mechanical_DetailScreenState extends State<Mechanical_DetailScreen> {
//   bool _isAccepted = false;
//   bool _isCompleted = false;
//   String? _acceptedBy;
//   String? _completedBy;
//   Timestamp? _acceptedAt;
//   Timestamp? _completedAt;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchComplaintData();
//   }
//
//   Future<void> _fetchComplaintData() async {
//     try {
//       DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//           .collection('complaints')
//           .doc(widget.complaintId)
//           .get();
//
//       if (complaintDoc.exists) {
//         var data = complaintDoc.data() as Map<String, dynamic>;
//         setState(() {
//           _isAccepted = data.containsKey('acceptedBy');
//           _isCompleted = data.containsKey('completedBy');
//           _acceptedBy = data['acceptedBy'] != null ? data['acceptedBy'] : null;
//           _completedBy = data['completedBy'] != null ? data['completedBy'] : null;
//           _acceptedAt = data['acceptedAt'] != null ? data['acceptedAt'] as Timestamp : null;
//           _completedAt = data['completedAt'] != null ? data['completedAt'] as Timestamp : null;
//         });
//
//         // Fetch user names
//         if (_acceptedBy != null) {
//           _fetchUserName(_acceptedBy!, (name) {
//             setState(() {
//               _acceptedBy = name;
//             });
//           });
//         }
//
//         if (_completedBy != null) {
//           _fetchUserName(_completedBy!, (name) {
//             setState(() {
//               _completedBy = name;
//             });
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching complaint data: $e");
//     }
//   }
//
//   Future<void> _fetchUserName(String userId, Function(String) onNameFetched) async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .get();
//
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         String userName = userData['name'] ?? 'Unknown';
//         onNameFetched(userName);
//       }
//     } catch (e) {
//       print("Error fetching user name: $e");
//     }
//   }
//
//   Future<void> _acceptComplaint(BuildContext context) async {
//     try {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Please log in to accept the complaint.'),
//         ));
//         return;
//       }
//
//       await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//         'acceptedBy': currentUser.uid,
//         'acceptedAt': Timestamp.now(),
//         'status': 'Work in Progress',
//       });
//
//       _fetchComplaintData(); // Refresh data after update
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Complaint accepted successfully!'),
//       ));
//     } catch (e) {
//       print("Error accepting complaint: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error accepting complaint.'),
//       ));
//     }
//   }
//
//   Future<void> _completeComplaint(BuildContext context) async {
//     try {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser == null) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Please log in to complete the complaint.'),
//         ));
//         return;
//       }
//
//       await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//         'completedBy': currentUser.uid,
//         'completedAt': Timestamp.now(),
//         'status': 'Completed',
//       });
//
//       _fetchComplaintData(); // Refresh data after update
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Complaint completed successfully!'),
//       ));
//     } catch (e) {
//       print("Error completing complaint: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error completing complaint.'),
//       ));
//     }
//   }
//
//   String formatDate(Timestamp timestamp) {
//     return DateFormat('MMMM dd, yyyy at hh:mm a').format(timestamp.toDate());
//   }
//
//   void _showFullScreenImage(BuildContext context, String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.all(10),
//         child: GestureDetector(
//           onTap: () => Navigator.of(context).pop(),
//           child: InteractiveViewer(
//             child: Image.network(imageUrl, fit: BoxFit.contain),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         elevation: 0,
//         title: Text('Complaint Details'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>?>(
//         future: getUserInfo(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error loading user info'));
//           }
//
//           final userInfo = snapshot.data;
//           final user = userInfo != null ? userInfo['name'] ?? 'Unknown' : 'Unknown';
//           final productionField = userInfo != null ? userInfo['production_field'] ?? 'N/A' : 'N/A';
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CarouselSlider(
//                   options: CarouselOptions(
//                     height: 250,
//                     enableInfiniteScroll: widget.imageUrls.length > 1, // Enable only if there is more than one image
//                     enlargeCenterPage: true,
//                     viewportFraction: 0.8,
//                     aspectRatio: 16 / 9,
//                   ),
//                   items: widget.imageUrls.map((imageUrl) {
//                     return GestureDetector(
//                       onTap: () {
//                         if (imageUrl.isNotEmpty) {
//                           _showFullScreenImage(context, imageUrl);
//                         }
//                       },
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12.0),
//                         child: Image.network(
//                           imageUrl,
//                           fit: BoxFit.cover,
//                           width: double.infinity,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Complaint Generated By",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "$user, $productionField",
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Complaint Generated At",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   formatDate(widget.timestamp),
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   "Description",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   widget.description,
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),
//                 SizedBox(height: 20),
//                 _buildDetailRow("Priority", widget.priority),
//                 _buildDetailRow("Status", widget.status),
//                 if (_isAccepted) ...[
//                   SizedBox(height: 20),
//                   _buildDetailRow("Accepted By", _acceptedBy ?? 'N/A'),
//                   _buildDetailRow("Accepted At", _acceptedAt != null ? formatDate(_acceptedAt!) : 'N/A'),
//                 ],
//                 if (_isCompleted) ...[
//                   SizedBox(height: 20),
//                   _buildDetailRow("Completed By", _completedBy ?? 'N/A'),
//                   _buildDetailRow("Completed At", _completedAt != null ? formatDate(_completedAt!) : 'N/A'),
//                 ],
//                 SizedBox(height: 20),
//                 // Conditional rendering of Accept and Complete buttons
//                 if (!_isAccepted) ...[
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () => _acceptComplaint(context),
//                       child: Text("Accept"),
//                     ),
//                   ),
//                 ],
//                 if (_isAccepted && !_isCompleted) ...[
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () => _completeComplaint(context),
//                       child: Text("Complete"),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String title, String value) {
//     return Row(
//       children: [
//         Text(
//           "$title:",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(fontSize: 16, color: Colors.black54),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Future<Map<String, dynamic>?> getUserInfo() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
//       if (userDoc.exists) {
//         return userDoc.data() as Map<String, dynamic>;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching user info: $e");
//       return null;
//     }
//   }
// }







//6/9-24  2:58
// worked get current uname of cmplt and acpt
// video optimization
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:video_player/video_player.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
// class MechanicalDetailScreen extends StatefulWidget {
//   final List<String> imageUrls;
//   final List<String> videoUrls;
//   final String description;
//   final String status;
//   final String priority;
//   final String complaintId;
//   final String userId;
//   final Timestamp timestamp;
//   final String name;
//   final String production_field;
//
//   MechanicalDetailScreen({
//     required this.imageUrls,
//     required this.videoUrls,
//     required this.description,
//     required this.status,
//     required this.priority,
//     required this.complaintId,
//     required this.userId,
//     required this.timestamp,
//     required this.name,
//     required this.production_field, required String imageUrl,
//   });
//
//   @override
//   _MechanicalDetailScreenState createState() => _MechanicalDetailScreenState();
// }
//
// class _MechanicalDetailScreenState extends State<MechanicalDetailScreen> {
//   bool _isAccepted = false;
//   bool _isCompleted = false;
//   String? _acceptedBy;
//   String? _completedBy;
//   Timestamp? _acceptedAt;
//   Timestamp? _completedAt;
//   String _selectedStatus = "Work in Progress";
//   late List<VideoPlayerController> _videoControllers;
//
//   // Variables to store user details
//   String? _userName;
//   String? _productionField;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchComplaintData();
//     _fetchUserData();
//     _videoControllers = widget.videoUrls.map((videoUrl) {
//       return VideoPlayerController.network(videoUrl)..initialize();
//     }).toList();
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _videoControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//
//   String? _acceptedByUserId;
//   String? _acceptedByUserName;
//
//   // Modify your _fetchComplaintData method
//   Future<void> _fetchComplaintData() async {
//     try {
//       DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//           .collection('complaints')
//           .doc(widget.complaintId)
//           .get();
//
//       if (complaintDoc.exists) {
//         var data = complaintDoc.data() as Map<String, dynamic>;
//         List<dynamic> acceptedDetails = data['acceptedDetails'] ?? [];
//         List<dynamic> completedDetails = data['completedDetails'] ?? [];
//
//         // Filter for users with the 'mechanical' role
//         List<dynamic> mechanicalAcceptedDetails = acceptedDetails
//             .where((detail) => detail['acceptedRole'] == 'mechanical')
//             .toList();
//
//         setState(() {
//           _isAccepted = mechanicalAcceptedDetails.isNotEmpty;
//           _isCompleted = completedDetails.isNotEmpty;
//
//           // Fetch acceptedByUserName, acceptedAt, and completedByUserName from the filtered details list
//           if (mechanicalAcceptedDetails.isNotEmpty) {
//             var lastAcceptedDetail = mechanicalAcceptedDetails.last;
//             _acceptedByUserName = lastAcceptedDetail['acceptedByUserName'];
//             _acceptedAt = lastAcceptedDetail['acceptedAt']; // Correctly set acceptedAt
//           }
//
//           if (completedDetails.isNotEmpty) {
//             var lastCompletedDetail = completedDetails.last;
//             _completedBy = lastCompletedDetail['completedByUserName'];
//             _completedAt = lastCompletedDetail['completedAt']; // Correctly set completedAt
//
//             // Check if the last completed role is mechanical
//             if (lastCompletedDetail['completedRole'] == 'mechanical') {
//               _isCompleted = true;
//             } else {
//               _isCompleted = false;
//             }
//           }
//
//           // Only display status if 'mechanical' role is present
//           if (_isAccepted) {
//             _selectedStatus = data['status'] ?? 'Work in Progress';
//           }
//         });
//       }
//     } catch (e) {
//       print('Error fetching complaint data: $e');
//     }
//   }
//
//
//
//   // refresh method
//   Future<void> _refreshComplaintData() async {
//     await _fetchComplaintData();
//     await _fetchUserData();
//     setState(() {}); // Rebuild the widget with updated data
//   }
//
//
//   // Fetch the name of the user who accepted the complaint
//   Future<void> _fetchAcceptedUserName(String userId) async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .get();
//
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         setState(() {
//           _acceptedByUserName = userData['name']; // Store the user's name
//         });
//       }
//     } catch (e) {
//       print('Error fetching accepted user data: $e');
//     }
//   }
//
//
//
//   Future<void> _fetchUserData() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.userId)
//           .get();
//
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         setState(() {
//           _userName = userData['name'];
//           _productionField = userData['production_field'];
//         });
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }
//
//   String _formatTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
//   }
//
//
//
//   Future<void> _acceptComplaint() async {
//     try {
//       bool confirm = await _showConfirmationDialog(
//         'Accept Complaint',
//         'Are you sure you want to accept this complaint?',
//       );
//
//       if (confirm) {
//         String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUserId)
//             .get();
//
//         String userName = '';
//         String userRole = '';
//         if (userDoc.exists) {
//           var userData = userDoc.data() as Map<String, dynamic>;
//           userName = userData['name'] ?? '';
//           userRole = userData['role'] ?? '';
//         }
//
//         Timestamp now = Timestamp.now();
//         DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .get();
//
//         if (complaintDoc.exists) {
//           var data = complaintDoc.data() as Map<String, dynamic>;
//           List<Map<String, dynamic>> acceptedList = [];
//
//           if (data.containsKey('acceptedDetails')) {
//             acceptedList = List<Map<String, dynamic>>.from(data['acceptedDetails']);
//           }
//
//           acceptedList.add({
//             'acceptedByUserId': currentUserId,
//             'acceptedByUserName': userName,
//             'acceptedAt': now,
//             'acceptedRole': userRole,
//           });
//
//           await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//             'acceptedDetails': acceptedList,
//             'status': 'Work in Progress',
//           });
//
//           setState(() {
//             _isAccepted = true;
//             _acceptedByUserId = currentUserId;
//             _acceptedByUserName = userName;
//             _acceptedAt = now;
//             _selectedStatus = 'Work in Progress';
//           });
//
//           await _refreshComplaintData(); // Refresh data
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Complaint accepted successfully')),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error accepting complaint: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to accept complaint')),
//       );
//     }
//   }
//
//
//
//
//
//   Future<void> _completeComplaint() async {
//     try {
//       bool confirm = await _showConfirmationDialog(
//         'Complete Complaint',
//         'Are you sure you want to mark this complaint as complete?',
//       );
//
//       if (confirm) {
//         String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUserId)
//             .get();
//
//         String userName = '';
//         String userRole = '';
//         if (userDoc.exists) {
//           var userData = userDoc.data() as Map<String, dynamic>;
//           userName = userData['name'] ?? '';
//           userRole = userData['role'] ?? '';
//         }
//
//         Timestamp now = Timestamp.now();
//         DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .get();
//
//         if (complaintDoc.exists) {
//           var data = complaintDoc.data() as Map<String, dynamic>;
//           List<Map<String, dynamic>> completedList = [];
//
//           if (data.containsKey('completedDetails')) {
//             completedList = List<Map<String, dynamic>>.from(data['completedDetails']);
//           }
//
//           completedList.add({
//             'completedByUserId': currentUserId,
//             'completedByUserName': userName,
//             'completedAt': now,
//             'completedRole': userRole,
//           });
//
//           await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//             'completedDetails': completedList,
//             'status': 'Completed',
//           });
//
//           setState(() {
//             _isCompleted = true;
//             _completedAt = now;
//             _completedBy = userName;
//           });
//
//           await _refreshComplaintData(); // Refresh data
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Complaint marked as complete')),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error completing complaint: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to complete complaint')),
//       );
//     }
//   }
//
//
//
//
//   Future<void> _updateStatus(String newStatus) async {
//     try {
//       // Show confirmation dialog
//       bool confirm = await _showConfirmationDialog(
//         'Update Status',
//         'Are you sure you want to update the status to $newStatus?',
//       );
//
//       if (confirm) {
//         if (newStatus == 'Completed') {
//           // If the status is set to "Completed", handle it like the complete button
//           await _completeComplaint();
//         } else {
//           // Update the status in Firestore
//           await FirebaseFirestore.instance
//               .collection('complaints')
//               .doc(widget.complaintId)
//               .update({'status': newStatus});
//
//           setState(() {
//             _selectedStatus = newStatus;
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Status updated to $newStatus')),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error updating status: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update status')),
//       );
//     }
//   }
//
//
//
//
//
//
//   Future<bool> _showConfirmationDialog(String title, String content) async {
//     return await showDialog<bool>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       },
//     ) ?? false;
//   }
//
//
//   void _showFullScreenVideo(String videoUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoScreen(videoUrl: videoUrl),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white.withOpacity(0.9), // Light and translucent background
//       appBar: AppBar(
//         backgroundColor: Colors.white.withOpacity(0.6),
//         elevation: 0,
//         title: Text(
//           'Mechanical Detail',
//           style: TextStyle(color: Colors.black54), // Light theme with a muted text color
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.imageUrls.isNotEmpty || widget.videoUrls.isNotEmpty)
//               _buildMediaSlider(widget.imageUrls, widget.videoUrls),
//             SizedBox(height: 16),
//
//             // Highlighted Description
//             _buildHighlightedContainer(
//               child: Text(
//                 'Description: ${widget.description}',
//                 style: TextStyle(
//                   color: Colors.white, // Text color for contrast
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//
//             _buildGlassContainer(
//               child: Text('Complain Generated by: ${_userName ?? "Loading..."}'),
//             ),
//             _buildGlassContainer(
//               child: Text('Production Field: ${_productionField ?? "Loading..."}'),
//             ),
//             _buildGlassContainer(
//               child: Text('Status: ${_selectedStatus}'),
//             ),
//             _buildGlassContainer(
//               child: Text('Priority: ${widget.priority}'),
//             ),
//             _buildGlassContainer(
//               child: Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
//             ),
//             if (!_isAccepted)
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF006AD7).withOpacity(0.7), // Dark blue with opacity
//                   elevation: 2,
//                   shadowColor: Colors.grey.shade200,
//                 ),
//                 onPressed: _acceptComplaint,
//                 child: Text(
//                   'Accept',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             if (_isAccepted) ...[
//               _buildGlassContainer(
//                 child: Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'),
//               ),
//               _buildGlassContainer(
//                 child: Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
//               ),
//               if (_selectedStatus != 'Completed' && !_isCompleted) ...[
//                 DropdownButton<String>(
//                   value: _selectedStatus,
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       _updateStatus(newValue);
//                     }
//                   },
//                   items: <String>[
//                     'Work in Progress',
//                     'In Review',
//                     'Pending',
//                     'Finished',
//                     'Something Else',
//                     'Completed'
//                   ].map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF9AD9EA).withOpacity(0.7), // Light blue with opacity
//                     elevation: 2,
//                     shadowColor: Colors.grey.shade200,
//                   ),
//                   onPressed: _completeComplaint,
//                   child: Text(
//                     'Complete',
//                     style: TextStyle(color: Color(0xFF21271B)), // Darker blue for text
//                   ),
//                 ),
//               ],
//               if (_isCompleted || _selectedStatus == 'Completed') ...[
//                 _buildGlassContainer(
//                   child: Text('Completed By: ${_completedBy ?? "Loading..."}'),
//                 ),
//                 _buildGlassContainer(
//                   child: Text('Completed At: ${_completedAt != null ? _formatTimestamp(_completedAt!) : "Loading..."}'),
//                 ),
//               ],
//             ],
//
//
//           ],
//         ),
//       ),
//     );
//   }
//
// // Helper method for glassy containers
//   Widget _buildGlassContainer({required Widget child}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 8,
//           ),
//         ],
//         border: Border.all(
//           color: Colors.white.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: child,
//     );
//   }
//
// // Helper method for the highlighted description container
//   Widget _buildHighlightedContainer({required Widget child}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xFF006AD7).withOpacity(0.8), // Dark blue background with higher opacity
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF006AD7).withOpacity(0.3), // Blue shadow
//             spreadRadius: 2,
//             blurRadius: 10,
//           ),
//         ],
//         border: Border.all(
//           color: Colors.white.withOpacity(0.4),
//           width: 1.5,
//         ),
//       ),
//       child: child,
//     );
//   }
//
//
//
//   Widget _buildMediaSlider(List<String> imageUrls, List<String> videoUrls) {
//     final mediaUrls = [...imageUrls, ...videoUrls];
//     return Container(
//       height: 250,
//       child: CarouselSlider.builder(
//         itemCount: mediaUrls.length,
//         itemBuilder: (context, index, realIndex) {
//           final mediaUrl = mediaUrls[index];
//           if (imageUrls.contains(mediaUrl)) {
//             return GestureDetector(
//               onTap: () => _showFullScreenImage(context, mediaUrl),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12.0),
//                 child: Image.network(
//                   mediaUrl,
//                   height: 250,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           } else {
//             return GestureDetector(
//               onTap: () => _showFullScreenVideo(mediaUrl),
//               child: VideoPlayerWidget(videoUrl: mediaUrl),
//             );
//           }
//         },
//         options: CarouselOptions(
//           height: 250,
//           viewportFraction: 1.0,
//           enlargeCenterPage: false,
//           autoPlay: false,
//         ),
//       ),
//     );
//   }
//
//   void _showFullScreenImage(BuildContext context, String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: InteractiveViewer(
//           child: Image.network(imageUrl, fit: BoxFit.contain),
//         ),
//       ),
//     );
//   }
// }
//
//
// // dog
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoPlayerWidget({required this.videoUrl});
//
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? AspectRatio(
//       aspectRatio: _controller.value.aspectRatio,
//       child: VideoPlayer(_controller),
//     )
//         : Center(child: CircularProgressIndicator());
//   }
// }
//
//
// class FullScreenVideoScreen extends StatefulWidget {
//   final String videoUrl;
//
//   const FullScreenVideoScreen({required this.videoUrl});
//
//   @override
//   _FullScreenVideoScreenState createState() => _FullScreenVideoScreenState();
// }
//
// class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isFullScreen = false;
//   bool _isDownloading = true;
//   double _downloadProgress = 0.0;
//   late String _localPath;
//
//   @override
//   void initState() {
//     super.initState();
//     _downloadVideo();
//   }
//
//   Future<void> _downloadVideo() async {
//     final directory = await getApplicationDocumentsDirectory();
//     _localPath = '${directory.path}/temp_video.mp4';
//
//     final dio = Dio();
//     dio.download(
//       widget.videoUrl,
//       _localPath,
//       onReceiveProgress: (received, total) {
//         if (total != -1) {
//           setState(() {
//             _downloadProgress = received / total;
//           });
//         }
//       },
//     ).then((_) {
//       setState(() {
//         _isDownloading = false;
//         _initializePlayer();
//       });
//     }).catchError((error) {
//       // Handle download error
//       print('Download error: $error');
//     });
//   }
//
//   void _initializePlayer() {
//     _controller = VideoPlayerController.file(File(_localPath))
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.addListener(() {
//           setState(() {
//             _isPlaying = _controller.value.isPlaying;
//           });
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlayPause() {
//     setState(() {
//       if (_isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//     });
//   }
//
//   void _seekTo(Duration duration) {
//     _controller.seekTo(duration);
//   }
//
//   void _toggleFullScreen() {
//     setState(() {
//       _isFullScreen = !_isFullScreen;
//     });
//     if (_isFullScreen) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeRight,
//         DeviceOrientation.landscapeLeft,
//       ]);
//     } else {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//       ]);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video Player'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.fullscreen),
//             onPressed: _toggleFullScreen,
//           ),
//         ],
//       ),
//       body: _isDownloading
//           ? Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CircularPercentIndicator(
//               radius: 100.0,
//               lineWidth: 8.0,
//               percent: _downloadProgress,
//               center: Text(
//                 '${(_downloadProgress * 100).toStringAsFixed(2)}%',
//                 style: TextStyle(
//                   color: Colors.black, // Set text color to black
//                   fontSize: 20.0, // Adjust font size as needed
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               progressColor: Colors.blue,
//               backgroundColor: Colors.grey.shade300,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Downloading ${(_downloadProgress * 100).toStringAsFixed(2)}%',
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       )
//           : OrientationBuilder(
//         builder: (context, orientation) {
//           return Column(
//             children: [
//               Expanded(
//                 child: AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 ),
//               ),
//               VideoProgressIndicator(
//                 _controller,
//                 allowScrubbing: true,
//                 padding: const EdgeInsets.all(8.0),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       _isPlaying ? Icons.pause : Icons.play_arrow,
//                     ),
//                     onPressed: _togglePlayPause,
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.replay_10),
//                     onPressed: () {
//                       final newPosition = _controller.value.position - Duration(seconds: 10);
//                       _seekTo(newPosition < Duration.zero
//                           ? Duration.zero
//                           : newPosition);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.forward_10),
//                     onPressed: () {
//                       final newPosition = _controller.value.position + Duration(seconds: 10);
//                       _seekTo(newPosition > _controller.value.duration
//                           ? _controller.value.duration
//                           : newPosition);
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }



// mechanical status only
// issue aaraha hai dropdown k complete pr k mech_stst ko compplete krne k baad data fS pe ja nhi raha pehle ki trhan


//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:video_player/video_player.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
// class MechanicalDetailScreen extends StatefulWidget {
//   final List<String> imageUrls;
//   final List<String> videoUrls;
//   final String description;
//   final String status;
//   final String priority;
//   final String complaintId;
//   final String userId;
//   final Timestamp timestamp;
//   final String name;
//   final String production_field;
//
//   MechanicalDetailScreen({
//     required this.imageUrls,
//     required this.videoUrls,
//     required this.description,
//     required this.status,
//     required this.priority,
//     required this.complaintId,
//     required this.userId,
//     required this.timestamp,
//     required this.name,
//     required this.production_field, required String imageUrl,
//   });
//
//   @override
//   _MechanicalDetailScreenState createState() => _MechanicalDetailScreenState();
// }
//
// class _MechanicalDetailScreenState extends State<MechanicalDetailScreen> {
//   bool _isAccepted = false;
//   bool _isCompleted = false;
//   String? _acceptedBy;
//   String? _completedBy;
//   Timestamp? _acceptedAt;
//   Timestamp? _completedAt;
//   String _mechanicalStatus = "Work in Progress"; // Default mechanical status
//
//   late List<VideoPlayerController> _videoControllers;
//
//   // Variables to store user details
//   String? _userName;
//   String? _productionField;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchComplaintData();
//     _fetchUserData();
//     _videoControllers = widget.videoUrls.map((videoUrl) {
//       return VideoPlayerController.network(videoUrl)..initialize();
//     }).toList();
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _videoControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//
//   String? _acceptedByUserId;
//   String? _acceptedByUserName;
//
//   // Modify your _fetchComplaintData method
//   Future<void> _fetchComplaintData() async {
//     try {
//       DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//           .collection('complaints')
//           .doc(widget.complaintId)
//           .get();
//
//       if (complaintDoc.exists) {
//         var data = complaintDoc.data() as Map<String, dynamic>;
//         List<dynamic> acceptedDetails = data['acceptedDetails'] ?? [];
//         List<dynamic> completedDetails = data['completedDetails'] ?? [];
//
//         List<dynamic> mechanicalAcceptedDetails = acceptedDetails
//             .where((detail) => detail['acceptedRole'] == 'mechanical')
//             .toList();
//
//         setState(() {
//           _isAccepted = mechanicalAcceptedDetails.isNotEmpty;
//           _isCompleted = completedDetails.isNotEmpty;
//           _mechanicalStatus = data['mechanicalStatus'] ?? 'Work in Progress'; // Fetch mechanical status
//
//           if (mechanicalAcceptedDetails.isNotEmpty) {
//             var lastAcceptedDetail = mechanicalAcceptedDetails.last;
//             _acceptedByUserName = lastAcceptedDetail['acceptedByUserName'];
//             _acceptedAt = lastAcceptedDetail['acceptedAt'];
//           }
//
//           if (completedDetails.isNotEmpty) {
//             var lastCompletedDetail = completedDetails.last;
//             _completedBy = lastCompletedDetail['completedByUserName'];
//             _completedAt = lastCompletedDetail['completedAt'];
//
//             if (lastCompletedDetail['completedRole'] == 'mechanical') {
//               _isCompleted = true;
//             } else {
//               _isCompleted = false;
//             }
//           }
//         });
//       }
//     } catch (e) {
//       print('Error fetching complaint data: $e');
//     }
//   }
//
//
//
//
//   // refresh method
//   Future<void> _refreshComplaintData() async {
//     await _fetchComplaintData();
//     await _fetchUserData();
//     setState(() {}); // Rebuild the widget with updated data
//   }
//
//
//   // Fetch the name of the user who accepted the complaint
//   Future<void> _fetchAcceptedUserName(String userId) async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .get();
//
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         setState(() {
//           _acceptedByUserName = userData['name']; // Store the user's name
//         });
//       }
//     } catch (e) {
//       print('Error fetching accepted user data: $e');
//     }
//   }
//
//
//
//   Future<void> _fetchUserData() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.userId)
//           .get();
//
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         setState(() {
//           _userName = userData['name'];
//           _productionField = userData['production_field'];
//         });
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }
//
//   String _formatTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
//   }
//
//
//
//   Future<void> _acceptComplaint() async {
//     try {
//       bool confirm = await _showConfirmationDialog(
//         'Accept Complaint',
//         'Are you sure you want to accept this complaint?',
//       );
//
//       if (confirm) {
//         String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUserId)
//             .get();
//
//         String userName = '';
//         String userRole = '';
//         if (userDoc.exists) {
//           var userData = userDoc.data() as Map<String, dynamic>;
//           userName = userData['name'] ?? '';
//           userRole = userData['role'] ?? '';
//         }
//
//         Timestamp now = Timestamp.now();
//         DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .get();
//
//         if (complaintDoc.exists) {
//           var data = complaintDoc.data() as Map<String, dynamic>;
//           List<Map<String, dynamic>> acceptedList = [];
//
//           if (data.containsKey('acceptedDetails')) {
//             acceptedList = List<Map<String, dynamic>>.from(data['acceptedDetails']);
//           }
//
//           acceptedList.add({
//             'acceptedByUserId': currentUserId,
//             'acceptedByUserName': userName,
//             'acceptedAt': now,
//             'acceptedRole': userRole,
//           });
//
//           await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//             'acceptedDetails': acceptedList,
//             'status': 'Work in Progress',
//           });
//
//           setState(() {
//             _isAccepted = true;
//             _acceptedByUserId = currentUserId;
//             _acceptedByUserName = userName;
//             _acceptedAt = now;
//             _mechanicalStatus = 'Work in Progress';
//           });
//
//           await _refreshComplaintData(); // Refresh data
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Complaint accepted successfully')),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error accepting complaint: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to accept complaint')),
//       );
//     }
//   }
//
//
//
//
//
//   Future<void> _completeComplaint() async {
//     try {
//       bool confirm = await _showConfirmationDialog(
//         'Complete Complaint',
//         'Are you sure you want to mark this complaint as complete?',
//       );
//
//       if (confirm) {
//         String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUserId)
//             .get();
//
//         String userName = '';
//         String userRole = '';
//         if (userDoc.exists) {
//           var userData = userDoc.data() as Map<String, dynamic>;
//           userName = userData['name'] ?? '';
//           userRole = userData['role'] ?? '';
//         }
//
//         Timestamp now = Timestamp.now();
//         DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .get();
//
//         if (complaintDoc.exists) {
//           var data = complaintDoc.data() as Map<String, dynamic>;
//           List<Map<String, dynamic>> completedList = [];
//
//           if (data.containsKey('completedDetails')) {
//             completedList = List<Map<String, dynamic>>.from(data['completedDetails']);
//           }
//
//           completedList.add({
//             'completedByUserId': currentUserId,
//             'completedByUserName': userName,
//             'completedAt': now,
//             'completedRole': userRole,
//           });
//
//           await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//             'completedDetails': completedList,
//             'status': 'Completed',
//           });
//
//           setState(() {
//             _isCompleted = true;
//             _completedAt = now;
//             _completedBy = userName;
//           });
//
//           await _refreshComplaintData(); // Refresh data
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Complaint marked as complete')),
//           );
//         }
//       }
//     } catch (e) {
//       print('Error completing complaint: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to complete complaint')),
//       );
//     }
//   }
//
//
//
//
//   Future<void> _updateMechanicalStatus(String newStatus) async {
//     try {
//       bool confirm = await _showConfirmationDialog(
//         'Update Mechanical Status',
//         'Are you sure you want to update the mechanical status to $newStatus?',
//       );
//
//       if (confirm) {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .update({'mechanicalStatus': newStatus});
//
//         setState(() {
//           _mechanicalStatus = newStatus;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Mechanical status updated to $newStatus')),
//         );
//       }
//     } catch (e) {
//       print('Error updating mechanical status: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update mechanical status')),
//       );
//     }
//   }
//
//
//
//
//
//
//
//   Future<bool> _showConfirmationDialog(String title, String content) async {
//     return await showDialog<bool>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       },
//     ) ?? false;
//   }
//
//
//   void _showFullScreenVideo(String videoUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => FullScreenVideoScreen(videoUrl: videoUrl),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white.withOpacity(0.9), // Light and translucent background
//       appBar: AppBar(
//         backgroundColor: Colors.white.withOpacity(0.6),
//         elevation: 0,
//         title: Text(
//           'Mechanical Detail',
//           style: TextStyle(color: Colors.black54), // Light theme with a muted text color
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.imageUrls.isNotEmpty || widget.videoUrls.isNotEmpty)
//               _buildMediaSlider(widget.imageUrls, widget.videoUrls),
//             SizedBox(height: 16),
//
//             // Highlighted Description
//             _buildHighlightedContainer(
//               child: Text(
//                 'Description: ${widget.description}',
//                 style: TextStyle(
//                   color: Colors.white, // Text color for contrast
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//
//             _buildGlassContainer(
//               child: Text('Complain Generated by: ${_userName ?? "Loading..."}'),
//             ),
//             _buildGlassContainer(
//               child: Text('Production Field: ${_productionField ?? "Loading..."}'),
//             ),
//             _buildGlassContainer(
//               child: Text('Status: ${_mechanicalStatus}'),
//             ),
//             _buildGlassContainer(
//               child: Text('Priority: ${widget.priority}'),
//             ),
//             _buildGlassContainer(
//               child: Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
//             ),
//             if (!_isAccepted)
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF006AD7).withOpacity(0.7), // Dark blue with opacity
//                   elevation: 2,
//                     shadowColor: Colors.grey.shade200,
//                 ),
//                 onPressed: _acceptComplaint,
//                 child: Text(
//                   'Accept',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             if (_isAccepted) ...[
//               _buildGlassContainer(
//                 child: Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'),
//               ),
//               _buildGlassContainer(
//                 child: Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
//               ),
//               // Display the Complete button only if the complaint is not marked as completed by a mechanical role
//               if (_mechanicalStatus != 'Completed' && (!_isCompleted || _completedBy != 'mechanical')) ...[
//                 DropdownButton<String>(
//                   value: _mechanicalStatus,
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       _updateMechanicalStatus(newValue);
//                     }
//                   },
//                   items: <String>[
//                     'Work in Progress',
//                     'In Review',
//                     'Pending',
//                     'Finished',
//                     'Something Else',
//                     'Completed'
//                   ].map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF9AD9EA).withOpacity(0.7), // Light blue with opacity
//                     elevation: 2,
//                     shadowColor: Colors.grey.shade200,
//                   ),
//                   onPressed: _completeComplaint,
//                   child: Text(
//                     'Complete',
//                     style: TextStyle(color: Color(0xFF21271B)), // Darker blue for text
//                   ),
//                 ),
//               ],
//               if (_isCompleted || _mechanicalStatus == 'Completed') ...[
//                 _buildGlassContainer(
//                   child: Text('Completed By: ${_completedBy ?? "Loading..."}'),
//                 ),
//                 _buildGlassContainer(
//                   child: Text('Completed At: ${_completedAt != null ? _formatTimestamp(_completedAt!) : "Loading..."}'),
//                 ),
//               ],
//             ],
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
//
// // Helper method for glassy containers
//   Widget _buildGlassContainer({required Widget child}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 8,
//           ),
//         ],
//         border: Border.all(
//           color: Colors.white.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: child,
//     );
//   }
//
// // Helper method for the highlighted description container
//   Widget _buildHighlightedContainer({required Widget child}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Color(0xFF006AD7).withOpacity(0.8), // Dark blue background with higher opacity
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF006AD7).withOpacity(0.3), // Blue shadow
//             spreadRadius: 2,
//             blurRadius: 10,
//           ),
//         ],
//         border: Border.all(
//           color: Colors.white.withOpacity(0.4),
//           width: 1.5,
//         ),
//       ),
//       child: child,
//     );
//   }
//
//
//
//   Widget _buildMediaSlider(List<String> imageUrls, List<String> videoUrls) {
//     final mediaUrls = [...imageUrls, ...videoUrls];
//     return Container(
//       height: 250,
//       child: CarouselSlider.builder(
//         itemCount: mediaUrls.length,
//         itemBuilder: (context, index, realIndex) {
//           final mediaUrl = mediaUrls[index];
//           if (imageUrls.contains(mediaUrl)) {
//             return GestureDetector(
//               onTap: () => _showFullScreenImage(context, mediaUrl),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12.0),
//                 child: Image.network(
//                   mediaUrl,
//                   height: 250,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           } else {
//             return GestureDetector(
//               onTap: () => _showFullScreenVideo(mediaUrl),
//               child: VideoPlayerWidget(videoUrl: mediaUrl),
//             );
//           }
//         },
//         options: CarouselOptions(
//           height: 250,
//           viewportFraction: 1.0,
//           enlargeCenterPage: false,
//           autoPlay: false,
//         ),
//       ),
//     );
//   }
//
//   void _showFullScreenImage(BuildContext context, String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: InteractiveViewer(
//           child: Image.network(imageUrl, fit: BoxFit.contain),
//         ),
//       ),
//     );
//   }
// }
//
//
// // dog
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoPlayerWidget({required this.videoUrl});
//
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? AspectRatio(
//       aspectRatio: _controller.value.aspectRatio,
//       child: VideoPlayer(_controller),
//     )
//         : Center(child: CircularProgressIndicator());
//   }
// }
//
//
// class FullScreenVideoScreen extends StatefulWidget {
//   final String videoUrl;
//
//   const FullScreenVideoScreen({required this.videoUrl});
//
//   @override
//   _FullScreenVideoScreenState createState() => _FullScreenVideoScreenState();
// }
//
// class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//   bool _isFullScreen = false;
//   bool _isDownloading = true;
//   double _downloadProgress = 0.0;
//   late String _localPath;
//
//   @override
//   void initState() {
//     super.initState();
//     _downloadVideo();
//   }
//
//   Future<void> _downloadVideo() async {
//     final directory = await getApplicationDocumentsDirectory();
//     _localPath = '${directory.path}/temp_video.mp4';
//
//     final dio = Dio();
//     dio.download(
//       widget.videoUrl,
//       _localPath,
//       onReceiveProgress: (received, total) {
//         if (total != -1) {
//           setState(() {
//             _downloadProgress = received / total;
//           });
//         }
//       },
//     ).then((_) {
//       setState(() {
//         _isDownloading = false;
//         _initializePlayer();
//       });
//     }).catchError((error) {
//       // Handle download error
//       print('Download error: $error');
//     });
//   }
//
//   void _initializePlayer() {
//     _controller = VideoPlayerController.file(File(_localPath))
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.addListener(() {
//           setState(() {
//             _isPlaying = _controller.value.isPlaying;
//           });
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _togglePlayPause() {
//     setState(() {
//       if (_isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//     });
//   }
//
//   void _seekTo(Duration duration) {
//     _controller.seekTo(duration);
//   }
//
//   void _toggleFullScreen() {
//     setState(() {
//       _isFullScreen = !_isFullScreen;
//     });
//     if (_isFullScreen) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeRight,
//         DeviceOrientation.landscapeLeft,
//       ]);
//     } else {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//       ]);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Video Player'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.fullscreen),
//             onPressed: _toggleFullScreen,
//           ),
//         ],
//       ),
//       body: _isDownloading
//           ? Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CircularPercentIndicator(
//               radius: 100.0,
//               lineWidth: 8.0,
//               percent: _downloadProgress,
//               center: Text(
//                 '${(_downloadProgress * 100).toStringAsFixed(2)}%',
//                 style: TextStyle(
//                   color: Colors.black, // Set text color to black
//                   fontSize: 20.0, // Adjust font size as needed
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               progressColor: Colors.blue,
//               backgroundColor: Colors.grey.shade300,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Downloading ${(_downloadProgress * 100).toStringAsFixed(2)}%',
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       )
//           : OrientationBuilder(
//         builder: (context, orientation) {
//           return Column(
//             children: [
//               Expanded(
//                 child: AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 ),
//               ),
//               VideoProgressIndicator(
//                 _controller,
//                 allowScrubbing: true,
//                 padding: const EdgeInsets.all(8.0),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       _isPlaying ? Icons.pause : Icons.play_arrow,
//                     ),
//                     onPressed: _togglePlayPause,
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.replay_5),
//                     onPressed: () {
//                       final newPosition = _controller.value.position - Duration(seconds: 5);
//                       _seekTo(newPosition < Duration.zero
//                           ? Duration.zero
//                           : newPosition);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.forward_5),
//                     onPressed: () {
//                       final newPosition = _controller.value.position + Duration(seconds: 5);
//                       _seekTo(newPosition > _controller.value.duration
//                           ? _controller.value.duration
//                           : newPosition);
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


// Mechac_sts issue fixed
//


import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MechanicalDetailScreen extends StatefulWidget {
  final List<String> imageUrls;
  final List<String> videoUrls;
  final String description;
  final String status;
  final String priority;
  final String complaintId;
  final String userId;
  final Timestamp timestamp;
  final String name;
  final String production_field;

  MechanicalDetailScreen({
    required this.imageUrls,
    required this.videoUrls,
    required this.description,
    required this.status,
    required this.priority,
    required this.complaintId,
    required this.userId,
    required this.timestamp,
    required this.name,
    required this.production_field, required String imageUrl,
  });

  @override
  _MechanicalDetailScreenState createState() => _MechanicalDetailScreenState();
}

class _MechanicalDetailScreenState extends State<MechanicalDetailScreen> {
  bool _isAccepted = false;
  bool _isCompleted = false;
  String? _acceptedBy;
  String? _completedBy;
  Timestamp? _acceptedAt;
  Timestamp? _completedAt;
  String _mechanicalStatus = "Work in Progress"; // Default mechanical status

  late List<VideoPlayerController> _videoControllers;

  // Variables to store user details
  String? _userName;
  String? _productionField;

  @override
  void initState() {
    super.initState();
    _fetchComplaintData();
    _fetchUserData();
    _videoControllers = widget.videoUrls.map((videoUrl) {
      return VideoPlayerController.network(videoUrl)..initialize();
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }


  String? _acceptedByUserId;
  String? _acceptedByUserName;

  // Modify your _fetchComplaintData method
  Future<void> _fetchComplaintData() async {
    try {
      DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
          .collection('complaints')
          .doc(widget.complaintId)
          .get();

      if (complaintDoc.exists) {
        var data = complaintDoc.data() as Map<String, dynamic>;
        List<dynamic> acceptedDetails = data['acceptedDetails'] ?? [];
        List<dynamic> completedDetails = data['completedDetails'] ?? [];

        List<dynamic> mechanicalAcceptedDetails = acceptedDetails
            .where((detail) => detail['acceptedRole'] == 'mechanical')
            .toList();

        setState(() {
          _isAccepted = mechanicalAcceptedDetails.isNotEmpty;
          _isCompleted = completedDetails.isNotEmpty;
          _mechanicalStatus = data['mechanicalStatus'] ?? 'Work in Progress'; // Fetch mechanical status

          if (mechanicalAcceptedDetails.isNotEmpty) {
            var lastAcceptedDetail = mechanicalAcceptedDetails.last;
            _acceptedByUserName = lastAcceptedDetail['acceptedByUserName'];
            _acceptedAt = lastAcceptedDetail['acceptedAt'];
          }

          if (completedDetails.isNotEmpty) {
            var lastCompletedDetail = completedDetails.last;
            _completedBy = lastCompletedDetail['completedByUserName'];
            _completedAt = lastCompletedDetail['completedAt'];

            if (lastCompletedDetail['completedRole'] == 'mechanical') {
              _isCompleted = true;
            } else {
              _isCompleted = false;
            }
          }
        });
      }
    } catch (e) {
      print('Error fetching complaint data: $e');
    }
  }




  // refresh method
  Future<void> _refreshComplaintData() async {
    await _fetchComplaintData();
    await _fetchUserData();
    setState(() {}); // Rebuild the widget with updated data
  }


  // Fetch the name of the user who accepted the complaint
  Future<void> _fetchAcceptedUserName(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _acceptedByUserName = userData['name']; // Store the user's name
        });
      }
    } catch (e) {
      print('Error fetching accepted user data: $e');
    }
  }



  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _userName = userData['name'];
          _productionField = userData['production_field'];
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }



  Future<void> _acceptComplaint() async {
    try {
      bool confirm = await _showConfirmationDialog(
        'Accept Complaint',
        'Are you sure you want to accept this complaint?',
      );

      if (confirm) {
        String currentUserId = FirebaseAuth.instance.currentUser!.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .get();

        String userName = '';
        String userRole = '';
        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;
          userName = userData['name'] ?? '';
          userRole = userData['role'] ?? '';
        }

        Timestamp now = Timestamp.now();
        DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
            .collection('complaints')
            .doc(widget.complaintId)
            .get();

        if (complaintDoc.exists) {
          var data = complaintDoc.data() as Map<String, dynamic>;
          List<Map<String, dynamic>> acceptedList = [];

          if (data.containsKey('acceptedDetails')) {
            acceptedList = List<Map<String, dynamic>>.from(data['acceptedDetails']);
          }

          acceptedList.add({
            'acceptedByUserId': currentUserId,
            'acceptedByUserName': userName,
            'acceptedAt': now,
            'acceptedRole': userRole,
          });

          await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
            'acceptedDetails': acceptedList,
            'status': 'Work in Progress',
          });

          setState(() {
            _isAccepted = true;
            _acceptedByUserId = currentUserId;
            _acceptedByUserName = userName;
            _acceptedAt = now;
            _mechanicalStatus = 'Work in Progress';
          });

          await _refreshComplaintData(); // Refresh data

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Complaint accepted successfully')),
          );
        }
      }
    } catch (e) {
      print('Error accepting complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept complaint')),
      );
    }
  }





  Future<void> _completeComplaint() async {
    try {
      bool confirm = await _showConfirmationDialog(
        'Complete Complaint',
        'Are you sure you want to mark this complaint as complete?',
      );

      if (confirm) {
        String currentUserId = FirebaseAuth.instance.currentUser!.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .get();

        String userName = '';
        String userRole = '';
        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;
          userName = userData['name'] ?? '';
          userRole = userData['role'] ?? '';
        }

        Timestamp now = Timestamp.now();
        DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
            .collection('complaints')
            .doc(widget.complaintId)
            .get();

        if (complaintDoc.exists) {
          var data = complaintDoc.data() as Map<String, dynamic>;
          List<Map<String, dynamic>> completedList = [];

          if (data.containsKey('completedDetails')) {
            completedList = List<Map<String, dynamic>>.from(data['completedDetails']);
          }

          completedList.add({
            'completedByUserId': currentUserId,
            'completedByUserName': userName,
            'completedAt': now,
            'completedRole': userRole,
          });

          await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
            'completedDetails': completedList,
            'status': 'Completed',
          });

          setState(() {
            _isCompleted = true;
            _completedAt = now;
            _completedBy = userName;
          });

          await _refreshComplaintData(); // Refresh data

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Complaint marked as complete')),
          );
        }
      }
    } catch (e) {
      print('Error completing complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to complete complaint')),
      );
    }
  }




  Future<void> _updateMechanicalStatus(String newStatus) async {
    try {
      bool confirm = await _showConfirmationDialog(
        'Update Mechanical Status',
        'Are you sure you want to update the mechanical status to $newStatus?',
      );

      if (confirm) {
        // If the new status is "Completed", directly call the _completeComplaint method
        if (newStatus == 'Completed') {
          await _completeComplaint();
        } else {
          // Otherwise, just update the status in Firestore
          await FirebaseFirestore.instance
              .collection('complaints')
              .doc(widget.complaintId)
              .update({'mechanicalStatus': newStatus});

          setState(() {
            _mechanicalStatus = newStatus;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mechanical status updated to $newStatus')),
          );
        }
      }
    } catch (e) {
      print('Error updating mechanical status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update mechanical status')),
      );
    }
  }








  Future<bool> _showConfirmationDialog(String title, String content) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ) ?? false;
  }


  void _showFullScreenVideo(String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoScreen(videoUrl: videoUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9), // Light and translucent background
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.6),
        elevation: 0,
        title: Text(
          'Mechanical Detail',
          style: TextStyle(color: Colors.black54), // Light theme with a muted text color
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.imageUrls.isNotEmpty || widget.videoUrls.isNotEmpty)
              _buildMediaSlider(widget.imageUrls, widget.videoUrls),
            SizedBox(height: 16),

            // Highlighted Description
            _buildHighlightedContainer(
              child: Text(
                'Description: ${widget.description}',
                style: TextStyle(
                  color: Colors.white, // Text color for contrast
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            _buildGlassContainer(
              child: Text('Complain Generated by: ${_userName ?? "Loading..."}'),
            ),
            _buildGlassContainer(
              child: Text('Production Field: ${_productionField ?? "Loading..."}'),
            ),
            _buildGlassContainer(
              child: Text('Status: ${_mechanicalStatus}'),
            ),
            _buildGlassContainer(
              child: Text('Priority: ${widget.priority}'),
            ),
            _buildGlassContainer(
              child: Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
            ),
            if (!_isAccepted)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF006AD7).withOpacity(0.7), // Dark blue with opacity
                  elevation: 2,
                  shadowColor: Colors.grey.shade200,
                ),
                onPressed: _acceptComplaint,
                child: Text(
                  'Accept',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (_isAccepted) ...[
              _buildGlassContainer(
                child: Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'),
              ),
              _buildGlassContainer(
                child: Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
              ),
              // Display the Complete button only if the complaint is not marked as completed by a mechanical role
              if (_mechanicalStatus != 'Completed' && (!_isCompleted || _completedBy != 'mechanical')) ...[
                DropdownButton<String>(
                  value: _mechanicalStatus,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _updateMechanicalStatus(newValue);
                    }
                  },
                  items: <String>[
                    'Work in Progress',
                    'In Review',
                    'Pending',
                    'Finished',
                    'Something Else',
                    'Completed'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9AD9EA).withOpacity(0.7), // Light blue with opacity
                    elevation: 2,
                    shadowColor: Colors.grey.shade200,
                  ),
                  onPressed: _completeComplaint,
                  child: Text(
                    'Complete',
                    style: TextStyle(color: Color(0xFF21271B)), // Darker blue for text
                  ),
                ),
              ],
              if (_isCompleted || _mechanicalStatus == 'Completed') ...[
                _buildGlassContainer(
                  child: Text('Completed By: ${_completedBy ?? "Loading..."}'),
                ),
                _buildGlassContainer(
                  child: Text('Completed At: ${_completedAt != null ? _formatTimestamp(_completedAt!) : "Loading..."}'),
                ),
              ],
            ],



          ],
        ),
      ),
    );
  }

// Helper method for glassy containers
  Widget _buildGlassContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: child,
    );
  }

// Helper method for the highlighted description container
  Widget _buildHighlightedContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF006AD7).withOpacity(0.8), // Dark blue background with higher opacity
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF006AD7).withOpacity(0.3), // Blue shadow
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: child,
    );
  }



  Widget _buildMediaSlider(List<String> imageUrls, List<String> videoUrls) {
    final mediaUrls = [...imageUrls, ...videoUrls];
    return Container(
      height: 250,
      child: CarouselSlider.builder(
        itemCount: mediaUrls.length,
        itemBuilder: (context, index, realIndex) {
          final mediaUrl = mediaUrls[index];
          if (imageUrls.contains(mediaUrl)) {
            return GestureDetector(
              onTap: () => _showFullScreenImage(context, mediaUrl),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  mediaUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () => _showFullScreenVideo(mediaUrl),
              child: VideoPlayerWidget(videoUrl: mediaUrl),
            );
          }
        },
        options: CarouselOptions(
          height: 250,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: false,
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: InteractiveViewer(
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}


// dog

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }
}


class FullScreenVideoScreen extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoScreen({required this.videoUrl});

  @override
  _FullScreenVideoScreenState createState() => _FullScreenVideoScreenState();
}

class _FullScreenVideoScreenState extends State<FullScreenVideoScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  bool _isDownloading = true;
  double _downloadProgress = 0.0;
  late String _localPath;

  @override
  void initState() {
    super.initState();
    _downloadVideo();
  }

  Future<void> _downloadVideo() async {
    final directory = await getApplicationDocumentsDirectory();
    _localPath = '${directory.path}/temp_video.mp4';

    final dio = Dio();
    dio.download(
      widget.videoUrl,
      _localPath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          setState(() {
            _downloadProgress = received / total;
          });
        }
      },
    ).then((_) {
      setState(() {
        _isDownloading = false;
        _initializePlayer();
      });
    }).catchError((error) {
      // Handle download error
      print('Download error: $error');
    });
  }

  void _initializePlayer() {
    _controller = VideoPlayerController.file(File(_localPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(() {
          setState(() {
            _isPlaying = _controller.value.isPlaying;
          });
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _seekTo(Duration duration) {
    _controller.seekTo(duration);
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
    if (_isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.fullscreen),
            onPressed: _toggleFullScreen,
          ),
        ],
      ),
      body: _isDownloading
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 8.0,
              percent: _downloadProgress,
              center: Text(
                '${(_downloadProgress * 100).toStringAsFixed(2)}%',
                style: TextStyle(
                  color: Colors.black, // Set text color to black
                  fontSize: 20.0, // Adjust font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
            ),
            SizedBox(height: 20),
            Text(
              'Downloading ${(_downloadProgress * 100).toStringAsFixed(2)}%',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      )
          : OrientationBuilder(
        builder: (context, orientation) {
          return Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                padding: const EdgeInsets.all(8.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                  IconButton(
                    icon: Icon(Icons.replay_5),
                    onPressed: () {
                      final newPosition = _controller.value.position - Duration(seconds: 5);
                      _seekTo(newPosition < Duration.zero
                          ? Duration.zero
                          : newPosition);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.forward_5),
                    onPressed: () {
                      final newPosition = _controller.value.position + Duration(seconds: 5);
                      _seekTo(newPosition > _controller.value.duration
                          ? _controller.value.duration
                          : newPosition);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
