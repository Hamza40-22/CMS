// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class DetailScreen extends StatelessWidget {
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
//
//   DetailScreen({
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
//       backgroundColor: Colors.blue.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         elevation: 0,
//       ),
//       body: Center(
//         child: Container(
//           color: Colors.blue.shade100,
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   if (imageUrl.isNotEmpty) {
//                     _showFullScreenImage(context, imageUrl);
//                   }
//                 },
//                 child: imageUrl.isNotEmpty
//                     ? Image.network(imageUrl, height: 200, fit: BoxFit.cover)
//                     : Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Icon(Icons.image, size: 100, color: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 16),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Description: $description",
//                       style: TextStyle(fontSize: 16, color: Colors.black54),
//                     ),
//                     SizedBox(height: 16),
//                     Divider(color: Colors.grey),
//                     SizedBox(height: 16),
//                     Text(
//                       "Priority: $priority",
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                     ),
//                     Text(
//                       "Category: $complaintCategory",
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Accepted by: $acceptedBy",
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                     ),
//                     Text(
//                       "Accepted by email: $acceptedByEmail",
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                     ),
//                     Text(
//                       "Accepted on: ${_formatDateTime(acceptedTimestamp)}",
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Completed by: $completedBy",
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                     ),
//                     Text(
//                       "Completed by email: $completedByEmail",
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                     ),
//                     Text(
//                       "Completed on: ${_formatDateTime(completedTimestamp)}",
//                       style: TextStyle(fontSize: 14, color: Colors.black87),
//                     ),
//                     SizedBox(height: 16),
//                     if (queryClosed)
//                       Text(
//                         "Query closed on: ${_formatDateTime(queryClosedAt)}",
//                         style: TextStyle(fontSize: 14, color: Colors.black87),
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// // UI update //old code
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class Utility_DetailScreen extends StatelessWidget {
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
//   final String status; // New field
//
//   Utility_DetailScreen({
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
//     required this.status, // New field
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
//         title: Text('Complaint Details'),
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


// notification plus
// complain accept and complete working
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../../main.dart';
//
// class UtilityDetailScreen extends StatefulWidget {
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
//   UtilityDetailScreen({
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
//   _UtilityDetailScreenState createState() => _UtilityDetailScreenState();
// }
//
// class _UtilityDetailScreenState extends State<UtilityDetailScreen> {
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
//   Future<void> showLocalNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
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
//       if (currentUser != null) {
//         await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//           'status': 'Work in Progress',
//           'acceptedBy': currentUser.uid,
//           'acceptedAt': FieldValue.serverTimestamp(),
//         });
//
//         setState(() {
//           _isAccepted = true;
//         });
//
//         showLocalNotification('Complaint Accepted', 'Complaint has been accepted.');
//       }
//     } catch (error) {
//       print('Error accepting complaint: $error');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Failed to accept complaint. Please try again.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ),
//       );
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
//         'completedAt': FieldValue.serverTimestamp(),
//         'status': 'Completed',
//       });
//
//       setState(() {
//         _isCompleted = true;
//       });
//
//       showLocalNotification('Complaint Completed', 'Complaint has been marked as completed.');
//     } catch (error) {
//       print('Error completing complaint: $error');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Failed to complete complaint. Please try again.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ),
//       );
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
//         backgroundColor: Colors.grey.shade100,
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           elevation: 0,
//           title: Text('Complaint Details'),
//         ),
//         body: FutureBuilder<Map<String, dynamic>?>(
//         future: getUserInfo(),
//     builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//     return Center(child: CircularProgressIndicator());
//     }
//
//     if (snapshot.hasError) {
//     return Center(child: Text('Error loading user info'));
//     }
//
//     final userInfo = snapshot.data;
//     final user = userInfo != null ? userInfo['name'] ?? 'Unknown' : 'Unknown';
//     final productionField = userInfo != null ? userInfo['production_field'] ?? 'N/A' : 'N/A';
//
//     return SingleChildScrollView(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     CarouselSlider(
//     options: CarouselOptions(
//     height: 250,
//     enableInfiniteScroll: widget.imageUrls.length > 1, // Enable only if there is more than one image
//     enlargeCenterPage: true,
//     viewportFraction: 0.8,
//     aspectRatio: 16 / 9,
//     ),
//     items: widget.imageUrls.map((imageUrl) {
//     return GestureDetector(
//     onTap: () {
//     if (imageUrl.isNotEmpty) {
//     _showFullScreenImage(context, imageUrl);
//     }
//     },
//     child: ClipRRect(
//     borderRadius: BorderRadius.circular(12.0),
//     child: Image.network(
//     imageUrl,
//     fit: BoxFit.cover,
//     width: double.infinity,
//     ),
//     ),
//     );
//     }).toList(),
//     ),
//     SizedBox(height: 20),
//     Text(
//     "Complaint Generated By",
//     style: TextStyle(
//     fontSize: 22,
//     fontWeight: FontWeight.bold,
//     color: Colors.black87,
//     ),
//     ),
//     SizedBox(height: 8),
//     Text(
//     "$user, $productionField",
//     style: TextStyle(fontSize: 16, color: Colors.black54),
//     ),
//     SizedBox(height: 20),
//     Text(
//     "Complaint Generated At",
//     style: TextStyle(
//     fontSize: 22,
//     fontWeight: FontWeight.bold,
//     color: Colors.black87,
//     ),
//     ),
//     SizedBox(height: 8),
//     Text(
//     formatDate(widget.timestamp),
//     style: TextStyle(fontSize: 16, color: Colors.black54),
//     ),
//     SizedBox(height: 20),
//       Text(
//         "Description",
//         style: TextStyle(
//           fontSize: 22,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//       ),
//       SizedBox(height: 8),
//       Text(
//         widget.description,
//         style: TextStyle(fontSize: 16, color: Colors.black54),
//       ),
//       SizedBox(height: 20),
//       _buildDetailRow("Priority", widget.priority),
//       _buildDetailRow("Status", widget.status),
//       if (_isAccepted) ...[
//         SizedBox(height: 20),
//         _buildDetailRow("Accepted By", _acceptedBy ?? 'N/A'),
//         _buildDetailRow("Accepted At", _acceptedAt != null ? formatDate(_acceptedAt!) : 'N/A'),
//       ],
//       if (_isCompleted) ...[
//         SizedBox(height: 20),
//         _buildDetailRow("Completed By", _completedBy ?? 'N/A'),
//         _buildDetailRow("Completed At", _completedAt != null ? formatDate(_completedAt!) : 'N/A'),
//       ],
//       SizedBox(height: 20),
//       // Conditional rendering of Accept and Complete buttons
//       if (!_isAccepted) ...[
//         Center(
//           child: ElevatedButton(
//             onPressed: () => _acceptComplaint(context),
//             child: Text("Accept"),
//           ),
//         ),
//       ],
//       if (_isAccepted && !_isCompleted) ...[
//         Center(
//           child: ElevatedButton(
//             onPressed: () => _completeComplaint(context),
//             child: Text("Complete"),
//           ),
//         ),
//       ],
//     ],
//     ),
//     );
//     },
//         ),
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


//video accepting code
// complain accept and complete working
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../main.dart';
//
// class UtilityDetailScreen extends StatefulWidget {
//   final List<String> imageUrls;
//   final List<String> videoUrls;
//   final String description;
//   final String status;
//   final String priority;
//   final String complaintId;
//   final String userId;
//   final Timestamp timestamp;
//   final String name;
//   final String productionField;
//
//   UtilityDetailScreen({
//     required this.imageUrls,
//     required this.videoUrls,
//     required this.description,
//     required this.status,
//     required this.priority,
//     required this.complaintId,
//     required this.userId,
//     required this.timestamp,
//     required this.name,
//     required this.productionField, required String imageUrl,
//   });
//
//   @override
//   _UtilityDetailScreenState createState() => _UtilityDetailScreenState();
// }
//
// class _UtilityDetailScreenState extends State<UtilityDetailScreen> {
//   bool _isAccepted = false;
//   bool _isCompleted = false;
//   String? _acceptedBy;
//   String? _completedBy;
//   Timestamp? _acceptedAt;
//   Timestamp? _completedAt;
//
//   late List<VideoPlayerController> _videoControllers;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchComplaintData();
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
//   Future<void> showLocalNotification(String title, String body) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'item x',
//     );
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
//       if (currentUser != null) {
//         await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//           'status': 'Work in Progress',
//           'acceptedBy': currentUser.uid,
//           'acceptedAt': FieldValue.serverTimestamp(),
//         });
//
//         setState(() {
//           _isAccepted = true;
//         });
//
//         showLocalNotification('Complaint Accepted', 'Complaint has been accepted.');
//       }
//     } catch (error) {
//       print('Error accepting complaint: $error');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Failed to accept complaint. Please try again.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ),
//       );
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
//         'completedAt': FieldValue.serverTimestamp(),
//         'status': 'Completed',
//       });
//
//       setState(() {
//         _isCompleted = true;
//       });
//
//       showLocalNotification('Complaint Completed', 'Complaint has been marked as completed.');
//     } catch (error) {
//       print('Error completing complaint: $error');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text('Failed to complete complaint. Please try again.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ],
//         ),
//       );
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
//   void _showFullScreenVideo(BuildContext context, String videoUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.all(10),
//         child: GestureDetector(
//           onTap: () => Navigator.of(context).pop(),
//           child: InteractiveViewer(
//             child: VideoPlayerScreen(videoUrl: videoUrl),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey.shade100,
//         appBar: AppBar(
//           backgroundColor: Colors.blue,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           elevation: 0,
//           title: Text('Complaint Details'),
//         ),
//         body: FutureBuilder<Map<String, dynamic>?>(
//           future: getUserInfo(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }
//
//             if (snapshot.hasError) {
//               return Center(child: Text('Error loading user info'));
//             }
//
//             final userInfo = snapshot.data;
//             final user = userInfo != null ? userInfo['name'] ?? 'Unknown' : 'Unknown';
//             final productionField = userInfo != null ? userInfo['production_field'] ?? 'N/A' : 'N/A';
//
//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CarouselSlider(
//                     options: CarouselOptions(
//                       height: 250,
//                       enableInfiniteScroll: false,
//                     ),
//                     items: [
//                       ...widget.imageUrls.map((imageUrl) {
//                         return GestureDetector(
//                           onTap: () {
//                             _showFullScreenImage(context, imageUrl);
//                           },
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12.0),
//                             child: Image.network(
//                               imageUrl,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                       ...widget.videoUrls.map((videoUrl) {
//                         final videoIndex = widget.videoUrls.indexOf(videoUrl);
//                         final controller = _videoControllers[videoIndex];
//
//                         return GestureDetector(
//                           onTap: () {
//                             if (videoUrl.isNotEmpty) {
//                               _showFullScreenVideo(context, videoUrl);
//                             }
//                           },
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12.0),
//                             child: Stack(
//                               children: [
//                                 VideoPlayer(controller),
//                                 Center(
//                                   child: Icon(
//                                     Icons.play_circle_outline,
//                                     color: Colors.white,
//                                     size: 64.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Text('Complaint Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 8),
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       widget.description,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   if (_acceptedAt != null) Text('Accepted At: ${formatDate(_acceptedAt!)}', style: TextStyle(fontSize: 16)),
//                   if (_acceptedBy != null) Text('Accepted By: $_acceptedBy', style: TextStyle(fontSize: 16)),
//                   if (_completedAt != null) Text('Completed At: ${formatDate(_completedAt!)}', style: TextStyle(fontSize: 16)),
//                   if (_completedBy != null) Text('Completed By: $_completedBy', style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 16),
//                   if (!_isAccepted)
//                     ElevatedButton(
//                       onPressed: () => _acceptComplaint(context),
//                       child: Text('Accept'),
//                     ),
//                   if (_isAccepted && !_isCompleted)
//                     ElevatedButton(
//                       onPressed: () => _completeComplaint(context),
//                       child: Text('Complete'),
//                     ),
//                 ],
//               ),
//             );
//           },
//         )
//     );
//   }
// }
//
// // Video player screen
// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;
//
//   VideoPlayerScreen({required this.videoUrl});
//
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
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
// Future<Map<String, dynamic>?> getUserInfo() async {
//   try {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUser.uid)
//           .get();
//
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         return userData;
//       }
//     }
//   } catch (e) {
//     print("Error fetching user info: $e");
//   }
//   return null;
// }



//accept complain with video bad UI
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:video_player/video_player.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
//
// class UtilityDetailScreen extends StatefulWidget {
//   final List<String> imageUrls;
//   final List<String> videoUrls;
//   final String description;
//   final String status;
//   final String priority;
//   final String complaintId;
//   final String userId;
//   final Timestamp timestamp;
//   final String name;
//   final String productionField;
//
//   UtilityDetailScreen({
//     required this.imageUrls,
//     required this.videoUrls,
//     required this.description,
//     required this.status,
//     required this.priority,
//     required this.complaintId,
//     required this.userId,
//     required this.timestamp,
//     required this.name,
//     required this.productionField,
//     required String imageUrl,
//   });
//
//   @override
//   _UtilityDetailScreenState createState() => _UtilityDetailScreenState();
// }
//
// class _UtilityDetailScreenState extends State<UtilityDetailScreen> {
//   bool _isAccepted = false;
//   bool _isCompleted = false;
//   String? _acceptedBy;
//   String? _completedBy;
//   Timestamp? _acceptedAt;
//   Timestamp? _completedAt;
//   late List<VideoPlayerController> _videoControllers;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchComplaintData();
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
//           _acceptedBy = data['acceptedBy'];
//           _completedBy = data['completedBy'];
//           _acceptedAt = data['acceptedAt'];
//           _completedAt = data['completedAt'];
//         });
//       }
//     } catch (e) {
//       print('Error fetching complaint data: $e');
//     }
//   }
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
//       appBar: AppBar(
//         title: Text('Utility Detail'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.imageUrls.isNotEmpty || widget.videoUrls.isNotEmpty)
//               _buildMediaSlider(widget.imageUrls, widget.videoUrls),
//             SizedBox(height: 16),
//             Text('Description: ${widget.description}'),
//             SizedBox(height: 16),
//             Text('Status: ${widget.status}'),
//             SizedBox(height: 16),
//             Text('Priority: ${widget.priority}'),
//             SizedBox(height: 16),
//             // Other fields...
//           ],
//         ),
//       ),
//     );
//   }
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





//good txt field UI
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UtilityDetailScreen extends StatefulWidget {
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

  UtilityDetailScreen({
    required this.imageUrls,
    required this.videoUrls,
    required this.description,
    required this.status,
    required this.priority,
    required this.complaintId,
    required this.userId,
    required this.timestamp,
    required this.name,
    required this.production_field,
    required String imageUrl,
  });

  @override
  _UtilityDetailScreenState createState() => _UtilityDetailScreenState();
}

class _UtilityDetailScreenState extends State<UtilityDetailScreen> {
  bool _isAccepted = false;
  bool _isCompleted = false;
  String? _acceptedBy;
  String? _completedBy;
  Timestamp? _acceptedAt;
  Timestamp? _completedAt;
  late List<VideoPlayerController> _videoControllers;

  // Variables to store user details
  String? _userName;
  String? _productionField;

  @override
  void initState() {
    super.initState();
    _fetchComplaintData();
    _fetchUserData(); // Fetch user data when the screen initializes
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

  Future<void> _fetchComplaintData() async {
    try {
      DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
          .collection('complaints')
          .doc(widget.complaintId)
          .get();

      if (complaintDoc.exists) {
        var data = complaintDoc.data() as Map<String, dynamic>;
        setState(() {
          _isAccepted = data.containsKey('acceptedBy');
          _isCompleted = data.containsKey('completedBy');
          _acceptedBy = data['acceptedBy'];
          _completedBy = data['completedBy'];
          _acceptedAt = data['acceptedAt'];
          _completedAt = data['completedAt'];
        });
      }
    } catch (e) {
      print('Error fetching complaint data: $e');
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
      await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
        'acceptedBy': _userName,
        'acceptedAt': Timestamp.now(),
      });

      setState(() {
        _isAccepted = true;
        _acceptedBy = _userName;
        _acceptedAt = Timestamp.now();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Complaint accepted successfully')),
      );
    } catch (e) {
      print('Error accepting complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept complaint')),
      );
    }
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
      appBar: AppBar(
        title: Text('Utility Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.imageUrls.isNotEmpty || widget.videoUrls.isNotEmpty)
              _buildMediaSlider(widget.imageUrls, widget.videoUrls),
            SizedBox(height: 16),
            Text('Complain Generated by: ${_userName ?? "Loading..."}'),
            SizedBox(height: 8),
            Text('Production Field: ${_productionField ?? "Loading..."}'),
            SizedBox(height: 16),
            Text('Description: ${widget.description}'),
            SizedBox(height: 16),
            Text('Status: ${widget.status}'),
            SizedBox(height: 16),
            Text('Priority: ${widget.priority}'),
            SizedBox(height: 16),
            Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
            SizedBox(height: 16),
            // Show "Accept" button if the complaint is not yet accepted
            if (!_isAccepted)
              ElevatedButton(
                onPressed: _acceptComplaint,
                child: Text('Accept'),
              ),
            if (_isAccepted) ...[
              SizedBox(height: 16),
              Text('Accepted By: ${_acceptedBy ?? "Loading..."}'),
              SizedBox(height: 8),
              Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
            ],
            // Other fields...
          ],
        ),
      ),
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

// cat

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
                    icon: Icon(Icons.replay_10),
                    onPressed: () {
                      final newPosition = _controller.value.position - Duration(seconds: 10);
                      _seekTo(newPosition < Duration.zero
                          ? Duration.zero
                          : newPosition);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.forward_10),
                    onPressed: () {
                      final newPosition = _controller.value.position + Duration(seconds: 10);
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
