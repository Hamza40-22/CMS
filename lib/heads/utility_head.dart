//2 complain at A time code works but UI issue
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
//
// import '../list/Utility_List/Utility_list_scr.dart';
// import '../login_v2.dart';
// import '../profile.dart';
//
// class UtilityHead extends StatefulWidget {
//   @override
//   _UtilityHeadState createState() => _UtilityHeadState();
// }
//
// class _UtilityHeadState extends State<UtilityHead> {
//   String? imageUrl;
//   String? description;
//   User? user;
//   String userName = "";
//   String userEmail = "";
//   String? profileImageUrl;
//   bool isAccepted = false;
//   bool isWorkCompleted = false;
//   String? acceptedBy = "";
//   String? acceptedEmail = "";
//   String? workCompletedBy = "";
//   String? workCompletedEmail = "";
//   String? complaintId; // Store the complaint ID
//   Timestamp? acceptedAt;
//   Timestamp? workCompletedAt;
//   String? _status; // Add a field to store the selected status
//   final List<String> _statusOptions = [
//     'Work in Progress',
//     'Pending Review',
//     'In Review',
//     'Resolved',
//     'Closed'
//   ];
//
//   List<DocumentSnapshot> _complaints = [];
//   int _currentComplaintIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     _loadComplaints();
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
//   Future<void> _loadComplaints() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('complaints')
//           .where('complaintCategory', isEqualTo: 'Utility')
//           .get();
//
//       if (snapshot.docs.isNotEmpty) {
//         _complaints = snapshot.docs.where((doc) {
//           return doc.data()['acceptedAt'] == null || doc.data()['workCompletedAt'] == null;
//         }).toList();
//
//         if (_complaints.isNotEmpty) {
//           _loadComplaintData();
//         } else {
//           setState(() {
//             imageUrl = null;
//             description = 'No complaints available';
//           });
//         }
//       } else {
//         setState(() {
//           imageUrl = null;
//           description = 'No complaints available';
//         });
//       }
//     } catch (e) {
//       print('Error loading complaints: $e');
//     }
//   }
//
//   void _loadComplaintData() {
//     if (_complaints.isEmpty) return;
//
//     final data = _complaints[_currentComplaintIndex].data() as Map<String, dynamic>;
//     setState(() {
//       complaintId = _complaints[_currentComplaintIndex].id;
//       imageUrl = data['imageUrl'];
//       description = data['description'];
//       isAccepted = data['acceptedBy'] != null;
//       acceptedBy = data['acceptedBy'];
//       acceptedEmail = data['acceptedEmail'];
//       acceptedAt = data['acceptedAt'];
//       isWorkCompleted = data['workCompletedBy'] != null;
//       workCompletedBy = data['workCompletedBy'];
//       workCompletedEmail = data['workCompletedEmail'];
//       workCompletedAt = data['workCompletedAt'];
//       _status = data['status'];
//     });
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     if (!mounted) return;
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ),
//           (Route<dynamic> route) => false,
//     );
//   }
//
//   void _showConfirmationDialog(String action, VoidCallback onConfirm) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm $action'),
//           content: Text('Are you sure you want to $action this complaint?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 onConfirm(); // Perform the action
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _accept() async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('accept', () async {
//       setState(() {
//         isAccepted = true;
//         acceptedBy = userName;
//         acceptedEmail = userEmail;
//         acceptedAt = Timestamp.now();
//       });
//
//       try {
//         await FirebaseFirestore.instance.collection('complaints').doc(complaintId).update({
//           'acceptedBy': userName,
//           'acceptedEmail': userEmail,
//           'acceptedAt': acceptedAt,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint accepted by $userName')),
//         );
//
//         // Refresh the complaint data to reflect the update
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating acceptance: $e');
//       }
//     });
//   }
//
//   void _workCompleted() async {
//     if (!isAccepted || complaintId == null) return;
//
//     _showConfirmationDialog('mark as completed', () async {
//       setState(() {
//         isWorkCompleted = true;
//         workCompletedBy = userName;
//         workCompletedEmail = userEmail;
//         workCompletedAt = Timestamp.now();
//         _status = 'Closed'; // Set status to 'Closed'
//       });
//
//       try {
//         await FirebaseFirestore.instance.collection('complaints').doc(complaintId).update({
//           'workCompletedBy': userName,
//           'workCompletedEmail': userEmail,
//           'workCompletedAt': workCompletedAt,
//           'status': _status, // Update the status in Firestore
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Work completed by $userName')),
//         );
//
//         // Refresh the complaint data to reflect the update
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating work completion: $e');
//       }
//     });
//   }
//
//   void _updateStatus(String newStatus) async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('update status to $newStatus', () async {
//       setState(() {
//         _status = newStatus;
//       });
//
//       try {
//         await FirebaseFirestore.instance.collection('complaints').doc(complaintId).update({
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Status updated to $newStatus')),
//         );
//
//         // Refresh the complaint data to reflect the update
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating status: $e');
//       }
//     });
//   }
//
//   void _nextComplaint() {
//     if (_currentComplaintIndex < _complaints.length - 1) {
//       setState(() {
//         _currentComplaintIndex++;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   void _previousComplaint() {
//     if (_currentComplaintIndex > 0) {
//       setState(() {
//         _currentComplaintIndex--;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   String formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return "N/A";
//     DateTime date = timestamp.toDate();
//     return DateFormat('dd MMM yyyy, hh:mm a').format(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffB8D0F8),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         foregroundColor: Colors.white,
//         backgroundColor: Color(0xcc0061FF),
//         title: Center(
//           child: Text(
//             "Utility",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadComplaints,
//           ),
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
//               leading: Icon(Icons.list),
//               title: Text("Complaints"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => UtilityListScr()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: _complaints.isEmpty
//           ? Center(child: Text(description ?? 'Loading complaints...'))
//           : SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 10),
//             Text(
//               "Issue Description:",
//               style: TextStyle(
//                   color: Color(0xff0061FF),
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//             Padding(
//               padding: EdgeInsets.all(10.0),
//               child: Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: Color(0xff0061FF),
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   description ?? 'No Description Available',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Issue Image:",
//               style: TextStyle(
//                   color: Color(0xff0061FF),
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//             if (imageUrl != null)
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Container(
//                   height: 300,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Color(0xff0061FF),
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       imageUrl!,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               )
//             else
//               Text('No Image Available'),
//             SizedBox(height: 20),
//             Text(
//               'Complaint Status: $_status',
//               style: TextStyle(
//                   color: Color(0xff0061FF),
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//             Padding(
//               padding: EdgeInsets.all(10.0),
//               child: DropdownButtonFormField<String>(
//                 value: _status,
//                 onChanged: _status == 'Closed'
//                     ? null
//                     : (newValue) {
//                   _updateStatus(newValue!);
//                 },
//                 items: _statusOptions.map((String status) {
//                   return DropdownMenuItem<String>(
//                     value: status,
//                     child: Text(status),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Update Status',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ListTile(
//               leading: Icon(Icons.check, color: Color(0xff0061FF)),
//               title: Text(
//                 isAccepted
//                     ? 'Accepted by $acceptedBy (${acceptedEmail ?? "N/A"}) at ${formatTimestamp(acceptedAt)}'
//                     : 'Not yet accepted',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             if (isAccepted)
//               ListTile(
//                 leading: Icon(Icons.done_all, color: Color(0xff0061FF)),
//                 title: Text(
//                   isWorkCompleted
//                       ? 'Work completed by $workCompletedBy (${workCompletedEmail ?? "N/A"}) at ${formatTimestamp(workCompletedAt)}'
//                       : 'Work not yet completed',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                   ),
//                   onPressed: isAccepted ? null : _accept,
//                   child: Text('Accept'),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                   ),
//                   onPressed:
//                   isWorkCompleted || !isAccepted ? null : _workCompleted,
//                   child: Text('Mark as Completed'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff0061FF),
//                   ),
//                   onPressed: _previousComplaint,
//                   child: Text('Previous'),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff0061FF),
//                   ),
//                   onPressed: _nextComplaint,
//                   child: Text('Next'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // //new UI update good but status update problem
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
//
// import '../list/Utility_List/Utility_list_scr.dart';
// import '../login_v2.dart';
// import '../profile.dart';
//
// class UtilityHead extends StatefulWidget {
//   @override
//   _UtilityHeadState createState() => _UtilityHeadState();
// }
//
// class _UtilityHeadState extends State<UtilityHead> {
//   String? imageUrl;
//   String? description;
//   User? user;
//   String userName = "";
//   String userEmail = "";
//   String? profileImageUrl;
//   bool isAccepted = false;
//   bool isWorkCompleted = false;
//   String? acceptedBy = "";
//   String? acceptedEmail = "";
//   String? workCompletedBy = "";
//   String? workCompletedEmail = "";
//   String? complaintId;
//   Timestamp? acceptedAt;
//   Timestamp? workCompletedAt;
//   String? _status;
//   final List<String> _statusOptions = [
//     'Work in Progress',
//     'Pending Review',
//     'In Review',
//     'Resolved',
//     'Closed'
//   ];
//
//   List<DocumentSnapshot> _complaints = [];
//   int _currentComplaintIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     _loadComplaints();
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
//   Future<void> _loadComplaints() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('complaints')
//           .where('complaintCategory', isEqualTo: 'Utility')
//           .get();
//
//       if (snapshot.docs.isNotEmpty) {
//         _complaints = snapshot.docs.where((doc) {
//           return doc.data()['acceptedAt'] == null ||
//               doc.data()['workCompletedAt'] == null;
//         }).toList();
//
//         if (_complaints.isNotEmpty) {
//           _loadComplaintData();
//         } else {
//           setState(() {
//             imageUrl = null;
//             description = 'No complaints available';
//           });
//         }
//       } else {
//         setState(() {
//           imageUrl = null;
//           description = 'No complaints available';
//         });
//       }
//     } catch (e) {
//       print('Error loading complaints: $e');
//     }
//   }
//
//   void _loadComplaintData() {
//     if (_complaints.isEmpty) return;
//
//     final data = _complaints[_currentComplaintIndex].data()
//     as Map<String, dynamic>;
//     setState(() {
//       complaintId = _complaints[_currentComplaintIndex].id;
//       imageUrl = data['imageUrl'];
//       description = data['description'];
//       isAccepted = data['acceptedBy'] != null;
//       acceptedBy = data['acceptedBy'];
//       acceptedEmail = data['acceptedEmail'];
//       acceptedAt = data['acceptedAt'];
//       isWorkCompleted = data['workCompletedBy'] != null;
//       workCompletedBy = data['workCompletedBy'];
//       workCompletedEmail = data['workCompletedEmail'];
//       workCompletedAt = data['workCompletedAt'];
//       _status = data['status'];
//     });
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     if (!mounted) return;
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ),
//           (Route<dynamic> route) => false,
//     );
//   }
//
//   void _showConfirmationDialog(String action, VoidCallback onConfirm) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm $action'),
//           content: Text('Are you sure you want to $action this complaint?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 onConfirm();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _accept() async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('accept', () async {
//       setState(() {
//         isAccepted = true;
//         acceptedBy = userName;
//         acceptedEmail = userEmail;
//         acceptedAt = Timestamp.now();
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'acceptedBy': userName,
//           'acceptedEmail': userEmail,
//           'acceptedAt': acceptedAt,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint accepted by $userName')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating acceptance: $e');
//       }
//     });
//   }
//
//   void _workCompleted() async {
//     if (!isAccepted || complaintId == null) return;
//
//     _showConfirmationDialog('mark as completed', () async {
//       setState(() {
//         isWorkCompleted = true;
//         workCompletedBy = userName;
//         workCompletedEmail = userEmail;
//         workCompletedAt = Timestamp.now();
//         _status = 'Closed';
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'workCompletedBy': userName,
//           'workCompletedEmail': userEmail,
//           'workCompletedAt': workCompletedAt,
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Work completed by $userName')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating work completion: $e');
//       }
//     });
//   }
//
//   void _updateStatus(String newStatus) async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('update status to $newStatus', () async {
//       setState(() {
//         _status = newStatus;
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Status updated to $newStatus')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating status: $e');
//       }
//     });
//   }
//
//   void _nextComplaint() {
//     if (_currentComplaintIndex < _complaints.length - 1) {
//       setState(() {
//         _currentComplaintIndex++;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   void _previousComplaint() {
//     if (_currentComplaintIndex > 0) {
//       setState(() {
//         _currentComplaintIndex--;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   String formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return "N/A";
//     DateTime date = timestamp.toDate();
//     return DateFormat('dd MMM yyyy, hh:mm a').format(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffE6EAF2),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         foregroundColor: Colors.white,
//         backgroundColor: Color(0xff0061FF),
//         title: Center(
//           child: Text(
//             "Utility Complaints",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadComplaints,
//           ),
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
//               title: Text("Utility Complaints"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => UtilityListScr()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Card(
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//           color: Color(0xffFFFFFF),
//           elevation: 4.0,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 imageUrl != null
//                     ? ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Image.network(
//                     imageUrl!,
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 )
//                     : Text('No image available'),
//                 SizedBox(height: 16.0),
//                 Text(
//                   'Description',
//                   style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   description ?? 'No description available',
//                   style: TextStyle(fontSize: 16.0, color: Colors.black54),
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     isAccepted
//                         ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Accepted By:',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0,
//                               color: Colors.black87),
//                         ),
//                         SizedBox(height: 4.0),
//                         Text('$acceptedBy ($acceptedEmail)',
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.black54)),
//                         SizedBox(height: 4.0),
//                         Text('At: ${formatTimestamp(acceptedAt)}',
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.black54)),
//                       ],
//                     )
//                         : ElevatedButton(
//                       onPressed: _accept,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xff0061FF),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: Text(
//                         'Accept',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                     isWorkCompleted
//                         ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Completed By:',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0,
//                               color: Colors.black87),
//                         ),
//                         SizedBox(height: 4.0),
//                         Text('$workCompletedBy ($workCompletedEmail)',
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.black54)),
//                         SizedBox(height: 4.0),
//                         Text('At: ${formatTimestamp(workCompletedAt)}',
//                             style: TextStyle(
//                                 fontSize: 14.0,
//                                 color: Colors.black54)),
//                       ],
//                     )
//                         : SizedBox.shrink(),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 isWorkCompleted
//                     ? SizedBox.shrink()
//                     : DropdownButtonFormField<String>(
//                   value: _status,
//                   hint: Text('Select Status'),
//                   items: _statusOptions.map((String status) {
//                     return DropdownMenuItem<String>(
//                       value: status,
//                       child: Text(status),
//                     );
//                   }).toList(),
//                   onChanged: (String? newStatus) {
//                     if (newStatus != null) {
//                       _updateStatus(newStatus);
//                     }
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 isAccepted && !isWorkCompleted
//                     ? ElevatedButton(
//                   onPressed: _workCompleted,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xffFF6B00),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: Text(
//                     'Mark as Completed',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 )
//                     : SizedBox.shrink(),
//                 SizedBox(height: 16.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: _previousComplaint,
//                       icon: Icon(Icons.arrow_back),
//                     ),
//                     IconButton(
//                       onPressed: _nextComplaint,
//                       icon: Icon(Icons.arrow_forward),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//video display
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:video_player/video_player.dart';
//
// import '../login_v2.dart';
// import '../profile.dart';
//
// class UtilityHead extends StatefulWidget {
//   @override
//   _UtilityHeadState createState() => _UtilityHeadState();
// }
//
// class _UtilityHeadState extends State<UtilityHead> {
//   User? user;
//   String? complaintId;
//   VideoPlayerController? _videoController;
//   String? _videoUrl;
//   String? imageUrl;
//   String? description;
//   bool isAccepted = false;
//   bool isWorkCompleted = false;
//   String? acceptedBy = "";
//   String? acceptedEmail = "";
//   String? workCompletedBy = "";
//   String? workCompletedEmail = "";
//   Timestamp? acceptedAt;
//   Timestamp? workCompletedAt;
//   String? _status;
//   final List<String> _statusOptions = [
//     'Work in Progress',
//     'Pending Review',
//     'In Review',
//     'Resolved',
//     'Closed'
//   ];
//
//   List<DocumentSnapshot> _complaints = [];
//   int _currentComplaintIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     _loadComplaints();
//   }
//
//   Future<void> fetchUserData() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       setState(() {
//         user = currentUser;
//       });
//     }
//   }
//
//   Future<void> _loadComplaints() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('complaints')
//           .where('complaintCategories', arrayContains: 'Utility')
//           .get();
//
//       if (snapshot.docs.isNotEmpty) {
//         setState(() {
//           _complaints = snapshot.docs.where((doc) {
//             final data = doc.data() as Map<String, dynamic>;
//             return data['acceptedAt'] == null || data['workCompletedAt'] == null;
//           }).toList();
//
//           if (_complaints.isNotEmpty) {
//             _loadComplaintData();
//           } else {
//             imageUrl = null;
//             description = 'No complaints available';
//             _videoUrl = null;
//           }
//         });
//       } else {
//         setState(() {
//           imageUrl = null;
//           description = 'No complaints available';
//           _videoUrl = null;
//         });
//       }
//     } catch (e) {
//       print('Error loading complaints: $e');
//     }
//   }
//
//   void _loadComplaintData() {
//     if (_complaints.isEmpty) return;
//
//     final data = _complaints[_currentComplaintIndex].data() as Map<String, dynamic>;
//     setState(() {
//       complaintId = _complaints[_currentComplaintIndex].id;
//       imageUrl = data['imageUrl'];
//       description = data['description'];
//       _videoUrl = data['videoUrl'];
//       isAccepted = data['acceptedBy'] != null;
//       acceptedBy = data['acceptedBy'];
//       acceptedEmail = data['acceptedEmail'];
//       acceptedAt = data['acceptedAt'];
//       isWorkCompleted = data['workCompletedBy'] != null;
//       workCompletedBy = data['workCompletedBy'];
//       workCompletedEmail = data['workCompletedEmail'];
//       workCompletedAt = data['workCompletedAt'];
//       _status = data['status'];
//
//       if (_videoUrl != null) {
//         _videoController = VideoPlayerController.network(_videoUrl!)
//           ..initialize().then((_) {
//             setState(() {});
//           }).catchError((error) {
//             print('Error initializing video: $error');
//           });
//       }
//     });
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     if (!mounted) return;
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ),
//           (Route<dynamic> route) => false,
//     );
//   }
//
//   void _showConfirmationDialog(String action, VoidCallback onConfirm) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm $action'),
//           content: Text('Are you sure you want to $action this complaint?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 onConfirm();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _accept() async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('accept', () async {
//       setState(() {
//         isAccepted = true;
//         acceptedBy = user?.displayName ?? 'Unknown';
//         acceptedEmail = user?.email ?? 'Unknown';
//         acceptedAt = Timestamp.now();
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'acceptedBy': acceptedBy,
//           'acceptedEmail': acceptedEmail,
//           'acceptedAt': acceptedAt,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint accepted by $acceptedBy')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating acceptance: $e');
//       }
//     });
//   }
//
//   void _workCompleted() async {
//     if (!isAccepted || complaintId == null) return;
//
//     _showConfirmationDialog('mark as completed', () async {
//       setState(() {
//         isWorkCompleted = true;
//         workCompletedBy = user?.displayName ?? 'Unknown';
//         workCompletedEmail = user?.email ?? 'Unknown';
//         workCompletedAt = Timestamp.now();
//         _status = 'Closed';
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'workCompletedBy': workCompletedBy,
//           'workCompletedEmail': workCompletedEmail,
//           'workCompletedAt': workCompletedAt,
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Work completed by $workCompletedBy')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating work completion: $e');
//       }
//     });
//   }
//
//   void _updateStatus(String newStatus) async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('update status to $newStatus', () async {
//       setState(() {
//         _status = newStatus;
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Status updated to $newStatus')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating status: $e');
//       }
//     });
//   }
//
//   void _nextComplaint() {
//     if (_currentComplaintIndex < _complaints.length - 1) {
//       setState(() {
//         _currentComplaintIndex++;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   void _previousComplaint() {
//     if (_currentComplaintIndex > 0) {
//       setState(() {
//         _currentComplaintIndex--;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   String formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return "N/A";
//     DateTime date = timestamp.toDate();
//     return DateFormat('dd MMM yyyy, hh:mm a').format(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffE6EAF2),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         foregroundColor: Colors.white,
//         backgroundColor: Color(0xff0061FF),
//         title: Center(
//           child: Text(
//             "Utility Complaints",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadComplaints,
//           ),
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
//                 image: DecorationImage(
//                   image: NetworkImage(
//                       'https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: user?.photoURL != null
//                     ? NetworkImage(user!.photoURL!)
//                     : NetworkImage(
//                     'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg'),
//               ),
//               accountName: Text(user?.displayName ?? 'Guest'),
//               accountEmail: Text(user?.email ?? ''),
//             ),
//             ListTile(
//               title: Text('Profile'),
//               leading: Icon(Icons.person),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Profile()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text('Logout'),
//               leading: Icon(Icons.logout),
//               onTap: _logout,
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: _complaints.isNotEmpty
//             ? Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (imageUrl != null) ...[
//               Image.network(
//                 imageUrl!,
//                 fit: BoxFit.cover,
//                 height: 200,
//                 width: double.infinity,
//               ),
//               SizedBox(height: 8),
//             ],
//             if (_videoUrl != null && _videoController != null) ...[
//               AspectRatio(
//                 aspectRatio: _videoController!.value.aspectRatio,
//                 child: VideoPlayer(_videoController!),
//               ),
//               SizedBox(height: 8),
//             ],
//             if (description != null) ...[
//               Text(
//                 description!,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 8),
//             ],
//             Text(
//               'Accepted by: ${acceptedBy ?? 'N/A'}',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//             Text(
//               'Accepted email: ${acceptedEmail ?? 'N/A'}',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//             Text(
//               'Accepted at: ${formatTimestamp(acceptedAt)}',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Work completed by: ${workCompletedBy ?? 'N/A'}',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//             Text(
//               'Work completed email: ${workCompletedEmail ?? 'N/A'}',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//             Text(
//               'Work completed at: ${formatTimestamp(workCompletedAt)}',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: _previousComplaint,
//                   child: Text('Previous'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _nextComplaint,
//                   child: Text('Next'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             if (!isAccepted) ...[
//               ElevatedButton(
//                 onPressed: _accept,
//                 child: Text('Accept'),
//               ),
//             ],
//             if (isAccepted && !isWorkCompleted) ...[
//               ElevatedButton(
//                 onPressed: _workCompleted,
//                 child: Text('Work Completed'),
//               ),
//               SizedBox(height: 8),
//               DropdownButton<String>(
//                 value: _status,
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     _updateStatus(newValue);
//                   }
//                 },
//                 items: _statusOptions.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 hint: Text('Select Status'),
//               ),
//             ],
//           ],
//         )
//             : Center(
//           child: Text(
//             'No complaints available',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }
// }

//get multi category or single  complain solved
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
//
// import '../list/Utility_List/Utility_list_scr.dart';
// import '../login_v2.dart';
// import '../profile.dart';
//
// class UtilityHead extends StatefulWidget {
//   @override
//   _UtilityHeadState createState() => _UtilityHeadState();
// }
//
// class _UtilityHeadState extends State<UtilityHead> {
//   String? imageUrl;
//   String? description;
//   User? user;
//   String userName = "";
//   String userEmail = "";
//   String? profileImageUrl;
//   bool isAccepted = false;
//   bool isWorkCompleted = false;
//   String? acceptedBy = "";
//   String? acceptedEmail = "";
//   String? workCompletedBy = "";
//   String? workCompletedEmail = "";
//   String? complaintId;
//   Timestamp? acceptedAt;
//   Timestamp? workCompletedAt;
//   String? _status;
//   final List<String> _statusOptions = [
//     'Work in Progress',
//     'Pending Review',
//     'In Review',
//     'Resolved',
//     'Closed'
//   ];
//
//   List<DocumentSnapshot> _complaints = [];
//   int _currentComplaintIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     _loadComplaints();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Handle incoming message
//       print('Message received: ${message.messageId}');
//       if (message.notification != null) {
//         // Show notification
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(message.notification!.title ?? 'Notification')),
//         );
//       }
//     });
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
//   Future<void> _loadComplaints() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('complaints')
//           .where('complaintCategories', arrayContains: 'Utility')
//           .get();
//
//       if (snapshot.docs.isNotEmpty) {
//         print('Complaints found: ${snapshot.docs.length}');
//         setState(() {
//           _complaints = snapshot.docs.where((doc) {
//             final data = doc.data() as Map<String, dynamic>;
//             print('Complaint data: $data');
//             return data['acceptedAt'] == null || data['workCompletedAt'] == null;
//           }).toList();
//
//           if (_complaints.isNotEmpty) {
//             _loadComplaintData();
//           } else {
//             imageUrl = null;
//             description = 'No complaints available';
//           }
//         });
//       } else {
//         setState(() {
//           imageUrl = null;
//           description = 'No complaints available';
//         });
//       }
//     } catch (e) {
//       print('Error loading complaints: $e');
//     }
//   }
//
//   void _loadComplaintData() {
//     if (_complaints.isEmpty) return;
//
//     final data = _complaints[_currentComplaintIndex].data() as Map<String, dynamic>;
//     setState(() {
//       complaintId = _complaints[_currentComplaintIndex].id;
//       imageUrl = data['imageUrl'];
//       description = data['description'];
//       isAccepted = data['acceptedBy'] != null;
//       acceptedBy = data['acceptedBy'];
//       acceptedEmail = data['acceptedEmail'];
//       acceptedAt = data['acceptedAt'];
//       isWorkCompleted = data['workCompletedBy'] != null;
//       workCompletedBy = data['workCompletedBy'];
//       workCompletedEmail = data['workCompletedEmail'];
//       workCompletedAt = data['workCompletedAt'];
//       _status = data['status'];
//     });
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     if (!mounted) return;
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ),
//           (Route<dynamic> route) => false,
//     );
//   }
//
//   void _showConfirmationDialog(String action, VoidCallback onConfirm) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm $action'),
//           content: Text('Are you sure you want to $action this complaint?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 onConfirm();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _accept() async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('accept', () async {
//       setState(() {
//         isAccepted = true;
//         acceptedBy = userName;
//         acceptedEmail = userEmail;
//         acceptedAt = Timestamp.now();
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'acceptedBy': userName,
//           'acceptedEmail': userEmail,
//           'acceptedAt': acceptedAt,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint accepted by $userName')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating acceptance: $e');
//       }
//     });
//   }
//
//   void _workCompleted() async {
//     if (!isAccepted || complaintId == null) return;
//
//     _showConfirmationDialog('mark as completed', () async {
//       setState(() {
//         isWorkCompleted = true;
//         workCompletedBy = userName;
//         workCompletedEmail = userEmail;
//         workCompletedAt = Timestamp.now();
//         _status = 'Closed';
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'workCompletedBy': userName,
//           'workCompletedEmail': userEmail,
//           'workCompletedAt': workCompletedAt,
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Work completed by $userName')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating work completion: $e');
//       }
//     });
//   }
//
//   void _updateStatus(String newStatus) async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('update status to $newStatus', () async {
//       setState(() {
//         _status = newStatus;
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Status updated to $newStatus')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating status: $e');
//       }
//     });
//   }
//
//   void _nextComplaint() {
//     if (_currentComplaintIndex < _complaints.length - 1) {
//       setState(() {
//         _currentComplaintIndex++;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   void _previousComplaint() {
//     if (_currentComplaintIndex > 0) {
//       setState(() {
//         _currentComplaintIndex--;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   String formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return "N/A";
//     DateTime date = timestamp.toDate();
//     return DateFormat('dd MMM yyyy, hh:mm a').format(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//               backgroundColor: Color(0xffE6EAF2),
//               appBar: AppBar(
//                 automaticallyImplyLeading: true,
//                 foregroundColor: Colors.white,
//                 backgroundColor: Color(0xff0061FF),
//                 title: Center(
//                   child: Text(
//                     "Utility Complaints",
//                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 actions: [
//                   IconButton(
//                     icon: Icon(Icons.refresh),
//                     onPressed: _loadComplaints,
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.logout),
//                     onPressed: _logout,
//                   ),
//                 ],
//               ),
//               drawer: Drawer(
//                 child: ListView(
//                   children: [
//                     UserAccountsDrawerHeader(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: NetworkImage(
//                               'https://i.pinimg.com/564x/ae/aa/07/aeaa0746d1061c3a4a958088cd77ccf9.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       currentAccountPicture: CircleAvatar(
//                         backgroundImage: profileImageUrl != null
//                             ? NetworkImage(profileImageUrl!)
//                             : NetworkImage(
//                             'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
//                       ),
//                       accountName: Text(userName),
//                       accountEmail: Text(userEmail),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.person),
//                       title: Text("Profile"),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Profile()),
//                         );
//                       },
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.settings),
//                       title: Text("Utility Complaints"),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => UtilityListScreen()),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               body: SingleChildScrollView(
//                 padding: EdgeInsets.all(16.0),
//                 child: Card(
//                   shape:
//                   RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//                   color: Color(0xffFFFFFF),
//                   elevation: 4.0,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         imageUrl != null
//                             ? ClipRRect(
//                           borderRadius: BorderRadius.circular(8.0),
//                           child: Image.network(
//                             imageUrl!,
//                             height: 200,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         )
//                             : Text('No image available'),
//                         SizedBox(height: 16.0),
//                         Text(
//                           'Description',
//                           style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87),
//                         ),
//                         SizedBox(height: 8.0),
//                         Text(
//                           description ?? 'No description available',
//                           style: TextStyle(fontSize: 16.0, color: Colors.black54),
//                         ),
//                         SizedBox(height: 16.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             isAccepted
//                                 ? Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Accepted By:',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16.0,
//                                       color: Colors.black87),
//                                 ),
//                                 SizedBox(height: 4.0),
//                                 Text('$acceptedBy ($acceptedEmail)',
//                                     style: TextStyle(
//                                         fontSize: 14.0, color: Colors.black54)),
//                                 SizedBox(height: 4.0),
//                                 Text('At: ${formatTimestamp(acceptedAt)}',
//                                     style: TextStyle(
//                                         fontSize: 14.0, color: Colors.black54)),
//                               ],
//                             )
//                                 : ElevatedButton(
//                               onPressed: _accept,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xff0061FF),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Accept',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                             isWorkCompleted
//                                 ? Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Completed By:',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16.0,
//                                       color: Colors.black87),
//                                 ),
//                                 SizedBox(height: 4.0),
//                                 Text('$workCompletedBy ($workCompletedEmail)',
//                                     style: TextStyle(
//                                         fontSize: 14.0, color: Colors.black54)),
//                                 SizedBox(height: 4.0),
//                                 Text('At: ${formatTimestamp(workCompletedAt)}',
//                                     style: TextStyle(
//                                         fontSize: 14.0, color: Colors.black54)),
//                               ],
//                             )
//                                 : SizedBox.shrink(),
//                           ],
//                         ),
//                         SizedBox(height: 16.0),
//                         if (isAccepted && !isWorkCompleted)
//                           DropdownButtonFormField<String>(
//                             value: _status,
//                             hint: Text('Select Status'),
//                             items: _statusOptions.map((String status) {
//                               return DropdownMenuItem<String>(
//                                 value: status,
//                                 child: Text(status),
//                               );
//                             }).toList(),
//                             onChanged: (String? newStatus) {
//                               if (newStatus != null) {
//                                 _updateStatus(newStatus);
//                               }
//                             },
//                           ),
//                         SizedBox(height: 16.0),
//                         isAccepted && !isWorkCompleted
//                             ? ElevatedButton(
//                           onPressed: _workCompleted,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xffFF6B00),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           child: Text(
//                             'Mark as Completed',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, color: Colors.white),
//                           ),
//                         )
//                             : SizedBox.shrink(),
//                         SizedBox(height: 16.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             IconButton(
//                               onPressed: _previousComplaint,
//                               icon: Icon(Icons.arrow_back),
//                             ),
//                             IconButton(
//                               onPressed: _nextComplaint,
//                               icon: Icon(Icons.arrow_forward),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//   }
// }
//
//

//status issue fix
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
//
// import '../list/Utility_List/Utility_list_scr.dart';
// import '../login_v2.dart';
// import '../profile.dart';
//
// class UtilityHead extends StatefulWidget {
//   @override
//   _UtilityHeadState createState() => _UtilityHeadState();
// }
//
// class _UtilityHeadState extends State<UtilityHead> {
//   String? imageUrl;
//   String? description;
//   User? user;
//   String userName = "";
//   String userEmail = "";
//   String? profileImageUrl;
//   bool isAccepted = false;
//   bool isWorkCompleted = false;
//   String? acceptedBy = "";
//   String? acceptedEmail = "";
//   String? workCompletedBy = "";
//   String? workCompletedEmail = "";
//   String? complaintId;
//   Timestamp? acceptedAt;
//   Timestamp? workCompletedAt;
//   String? _status;
//   final List<String> _statusOptions = [
//     'Work in Progress',
//     'Pending Review',
//     'In Review',
//     'Resolved',
//     'Closed'
//   ];
//
//   List<DocumentSnapshot> _complaints = [];
//   int _currentComplaintIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     _loadComplaints();
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
//   Future<void> _loadComplaints() async {
//     try {
//       final snapshot = await FirebaseFirestore.instance
//           .collection('complaints')
//           .where('complaintCategory', isEqualTo: 'Utility')
//           .get();
//
//       if (snapshot.docs.isNotEmpty) {
//         _complaints = snapshot.docs.where((doc) {
//           return doc.data()['acceptedAt'] == null ||
//               doc.data()['workCompletedAt'] == null;
//         }).toList();
//
//         if (_complaints.isNotEmpty) {
//           _loadComplaintData();
//         } else {
//           setState(() {
//             imageUrl = null;
//             description = 'No complaints available';
//           });
//         }
//       } else {
//         setState(() {
//           imageUrl = null;
//           description = 'No complaints available';
//         });
//       }
//     } catch (e) {
//       print('Error loading complaints: $e');
//     }
//   }
//
//   void _loadComplaintData() {
//     if (_complaints.isEmpty) return;
//
//     final data =
//         _complaints[_currentComplaintIndex].data() as Map<String, dynamic>;
//     setState(() {
//       complaintId = _complaints[_currentComplaintIndex].id;
//       imageUrl = data['imageUrl'];
//       description = data['description'];
//       isAccepted = data['acceptedBy'] != null;
//       acceptedBy = data['acceptedBy'];
//       acceptedEmail = data['acceptedEmail'];
//       acceptedAt = data['acceptedAt'];
//       isWorkCompleted = data['workCompletedBy'] != null;
//       workCompletedBy = data['workCompletedBy'];
//       workCompletedEmail = data['workCompletedEmail'];
//       workCompletedAt = data['workCompletedAt'];
//       _status = data['status'];
//     });
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     if (!mounted) return;
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ),
//       (Route<dynamic> route) => false,
//     );
//   }
//
//   void _showConfirmationDialog(String action, VoidCallback onConfirm) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm $action'),
//           content: Text('Are you sure you want to $action this complaint?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Confirm'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 onConfirm();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _accept() async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('accept', () async {
//       setState(() {
//         isAccepted = true;
//         acceptedBy = userName;
//         acceptedEmail = userEmail;
//         acceptedAt = Timestamp.now();
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'acceptedBy': userName,
//           'acceptedEmail': userEmail,
//           'acceptedAt': acceptedAt,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint accepted by $userName')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating acceptance: $e');
//       }
//     });
//   }
//
//   void _workCompleted() async {
//     if (!isAccepted || complaintId == null) return;
//
//     _showConfirmationDialog('mark as completed', () async {
//       setState(() {
//         isWorkCompleted = true;
//         workCompletedBy = userName;
//         workCompletedEmail = userEmail;
//         workCompletedAt = Timestamp.now();
//         _status = 'Closed';
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'workCompletedBy': userName,
//           'workCompletedEmail': userEmail,
//           'workCompletedAt': workCompletedAt,
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Work completed by $userName')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating work completion: $e');
//       }
//     });
//   }
//
//   void _updateStatus(String newStatus) async {
//     if (complaintId == null) return;
//
//     _showConfirmationDialog('update status to $newStatus', () async {
//       setState(() {
//         _status = newStatus;
//       });
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(complaintId)
//             .update({
//           'status': _status,
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Status updated to $newStatus')),
//         );
//
//         _loadComplaintData();
//       } catch (e) {
//         print('Error updating status: $e');
//       }
//     });
//   }
//
//   void _nextComplaint() {
//     if (_currentComplaintIndex < _complaints.length - 1) {
//       setState(() {
//         _currentComplaintIndex++;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   void _previousComplaint() {
//     if (_currentComplaintIndex > 0) {
//       setState(() {
//         _currentComplaintIndex--;
//       });
//       _loadComplaintData();
//     }
//   }
//
//   String formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) return "N/A";
//     DateTime date = timestamp.toDate();
//     return DateFormat('dd MMM yyyy, hh:mm a').format(date);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffE6EAF2),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         foregroundColor: Colors.white,
//         backgroundColor: Color(0xff0061FF),
//         title: Center(
//           child: Text(
//             "Utility Complaints",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _loadComplaints,
//           ),
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
//               leading: Icon(Icons.settings),
//               title: Text("Utility Complaints"),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => UtilityListScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//           color: Color(0xffFFFFFF),
//           elevation: 4.0,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 imageUrl != null
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(8.0),
//                         child: Image.network(
//                           imageUrl!,
//                           height: 200,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : Text('No image available'),
//                 SizedBox(height: 16.0),
//                 Text(
//                   'Description',
//                   style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87),
//                 ),
//                 SizedBox(height: 8.0),
//                 Text(
//                   description ?? 'No description available',
//                   style: TextStyle(fontSize: 16.0, color: Colors.black54),
//                 ),
//                 SizedBox(height: 16.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     isAccepted
//                         ? Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Accepted By:',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16.0,
//                                     color: Colors.black87),
//                               ),
//                               SizedBox(height: 4.0),
//                               Text('$acceptedBy ($acceptedEmail)',
//                                   style: TextStyle(
//                                       fontSize: 14.0, color: Colors.black54)),
//                               SizedBox(height: 4.0),
//                               Text('At: ${formatTimestamp(acceptedAt)}',
//                                   style: TextStyle(
//                                       fontSize: 14.0, color: Colors.black54)),
//                             ],
//                           )
//                         : ElevatedButton(
//                             onPressed: _accept,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xff0061FF),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Text(
//                               'Accept',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                           ),
//                     isWorkCompleted
//                         ? Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Completed By:',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16.0,
//                                     color: Colors.black87),
//                               ),
//                               SizedBox(height: 4.0),
//                               Text('$workCompletedBy ($workCompletedEmail)',
//                                   style: TextStyle(
//                                       fontSize: 14.0, color: Colors.black54)),
//                               SizedBox(height: 4.0),
//                               Text('At: ${formatTimestamp(workCompletedAt)}',
//                                   style: TextStyle(
//                                       fontSize: 14.0, color: Colors.black54)),
//                             ],
//                           )
//                         : SizedBox.shrink(),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 if (isAccepted && !isWorkCompleted)
//                   DropdownButtonFormField<String>(
//                     value: _status,
//                     hint: Text('Select Status'),
//                     items: _statusOptions.map((String status) {
//                       return DropdownMenuItem<String>(
//                         value: status,
//                         child: Text(status),
//                       );
//                     }).toList(),
//                     onChanged: (String? newStatus) {
//                       if (newStatus != null) {
//                         _updateStatus(newStatus);
//                       }
//                     },
//                   ),
//                 SizedBox(height: 16.0),
//                 isAccepted && !isWorkCompleted
//                     ? ElevatedButton(
//                         onPressed: _workCompleted,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xffFF6B00),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                         child: Text(
//                           'Mark as Completed',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, color: Colors.white),
//                         ),
//                       )
//                     : SizedBox.shrink(),
//                 SizedBox(height: 16.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: _previousComplaint,
//                       icon: Icon(Icons.arrow_back),
//                     ),
//                     IconButton(
//                       onPressed: _nextComplaint,
//                       icon: Icon(Icons.arrow_forward),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
