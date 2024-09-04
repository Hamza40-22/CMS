//
//
//
// //get multi category or single  complain solved
// import 'package:complaint_management_sys/about.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
//
//
// import '../list/HvacList/hvac_listScreen.dart';
// import '../login_v2.dart';
// import '../profile.dart';
//
// class HvacHead extends StatefulWidget {
//   @override
//   _HvacHeadState createState() => _HvacHeadState();
// }
//
// class _HvacHeadState extends State<HvacHead> {
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
//     'acceptance pending',
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
//           .where('complaintCategories', arrayContains: 'HVAC')
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
//       backgroundColor: Color(0xffE6EAF2),
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         foregroundColor: Colors.white,
//         backgroundColor: Color(0xff0061FF),
//         title: Center(
//           child: Text(
//             "HVAC Complaints",
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
//             // ListTile(
//             //   leading: Icon(Icons.settings),
//             //   title: Text("HVAC Complaints"),
//             //   onTap: () {
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(builder: (context) => HvacListScr()),
//             //     );
//             //   },
//             // ),
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
//                                 fontSize: 14.0, color: Colors.black54)),
//                         SizedBox(height: 4.0),
//                         Text('At: ${formatTimestamp(acceptedAt)}',
//                             style: TextStyle(
//                                 fontSize: 14.0, color: Colors.black54)),
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
//                                 fontSize: 14.0, color: Colors.black54)),
//                         SizedBox(height: 4.0),
//                         Text('At: ${formatTimestamp(workCompletedAt)}',
//                             style: TextStyle(
//                                 fontSize: 14.0, color: Colors.black54)),
//                       ],
//                     )
//                         : SizedBox.shrink(),
//                   ],
//                 ),
//                 SizedBox(height: 16.0),
//                 if (isAccepted && !isWorkCompleted)
//                   DropdownButton<String>(
//                     value: _status,
//                     items: _statusOptions
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       if (newValue != null && newValue != _status) {
//                         _updateStatus(newValue);
//                       }
//                     },
//                   ),
//                 SizedBox(height: 16.0),
//                 isAccepted && !isWorkCompleted
//                     ? ElevatedButton(
//                   onPressed: _workCompleted,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: Text(
//                     'Mark as Completed',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//                     : SizedBox.shrink(),
//                 SizedBox(height: 16.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _currentComplaintIndex > 0
//                         ? ElevatedButton(
//                       onPressed: _previousComplaint,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xff0061FF),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: Text(
//                         'Previous',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                         : SizedBox.shrink(),
//                     _currentComplaintIndex < _complaints.length - 1
//                         ? ElevatedButton(
//                       onPressed: _nextComplaint,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xff0061FF),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: Text(
//                         'Next',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                         : SizedBox.shrink(),
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


import '../list/HvacList/hvac_listScreen.dart';

import '../login_v2.dart';
import '../profile.dart';
import 'HVAC_head.dart';

class HvacHead extends StatefulWidget {
  @override
  _HvacHeadState createState() => _HvacHeadState();
}

class _HvacHeadState extends State<HvacHead> {
  String? imageUrl;
  String? description;
  User? user;
  String userName = "";
  String userEmail = "";
  String? profileImageUrl;
  bool isAccepted = false;
  bool isWorkCompleted = false;
  String? acceptedBy = "";
  String? acceptedEmail = "";
  String? workCompletedBy = "";
  String? workCompletedEmail = "";
  String? complaintId;
  Timestamp? acceptedAt;
  Timestamp? workCompletedAt;
  String? _status;
  final List<String> _statusOptions = [
    'Work in Progress',
    'Pending Review',
    'In Review',
    'Resolved',
    'Closed'
  ];

  List<DocumentSnapshot> _complaints = [];
  int _currentComplaintIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    _loadComplaints();
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

  Future<void> _loadComplaints() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('complaints')
          .where('complaintCategories', arrayContains: 'hvac')
          .get();

      if (snapshot.docs.isNotEmpty) {
        print('Complaints found: ${snapshot.docs.length}');
        setState(() {
          _complaints = snapshot.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            print('Complaint data: $data');
            return data['acceptedAt'] == null || data['workCompletedAt'] == null;
          }).toList();

          if (_complaints.isNotEmpty) {
            _loadComplaintData();
          } else {
            imageUrl = null;
            description = 'No complaints available';
          }
        });
      } else {
        setState(() {
          imageUrl = null;
          description = 'No complaints available';
        });
      }
    } catch (e) {
      print('Error loading complaints: $e');
    }
  }

  void _loadComplaintData() {
    if (_complaints.isEmpty) return;

    final data = _complaints[_currentComplaintIndex].data() as Map<String, dynamic>;
    setState(() {
      complaintId = _complaints[_currentComplaintIndex].id;
      imageUrl = data['imageUrl'];
      description = data['description'];
      isAccepted = data['acceptedBy'] != null;
      acceptedBy = data['acceptedBy'];
      acceptedEmail = data['acceptedEmail'];
      acceptedAt = data['acceptedAt'];
      isWorkCompleted = data['workCompletedBy'] != null;
      workCompletedBy = data['workCompletedBy'];
      workCompletedEmail = data['workCompletedEmail'];
      workCompletedAt = data['workCompletedAt'];
      _status = data['status'];
    });
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
          (Route<dynamic> route) => false,
    );
  }

  void _showConfirmationDialog(String action, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm $action'),
          content: Text('Are you sure you want to $action this complaint?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  void _accept() async {
    if (complaintId == null) return;

    _showConfirmationDialog('accept', () async {
      setState(() {
        isAccepted = true;
        acceptedBy = userName;
        acceptedEmail = userEmail;
        acceptedAt = Timestamp.now();
      });

      try {
        await FirebaseFirestore.instance
            .collection('complaints')
            .doc(complaintId)
            .update({
          'acceptedBy': userName,
          'acceptedEmail': userEmail,
          'acceptedAt': acceptedAt,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint accepted by $userName')),
        );

        _loadComplaintData();
      } catch (e) {
        print('Error updating acceptance: $e');
      }
    });
  }

  void _workCompleted() async {
    if (!isAccepted || complaintId == null) return;

    _showConfirmationDialog('mark as completed', () async {
      setState(() {
        isWorkCompleted = true;
        workCompletedBy = userName;
        workCompletedEmail = userEmail;
        workCompletedAt = Timestamp.now();
        _status = 'Closed';
      });

      try {
        await FirebaseFirestore.instance
            .collection('complaints')
            .doc(complaintId)
            .update({
          'workCompletedBy': userName,
          'workCompletedEmail': userEmail,
          'workCompletedAt': workCompletedAt,
          'status': _status,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Work completed by $userName')),
        );

        _loadComplaintData();
      } catch (e) {
        print('Error updating work completion: $e');
      }
    });
  }

  void _updateStatus(String newStatus) async {
    if (complaintId == null) return;

    _showConfirmationDialog('update status to $newStatus', () async {
      setState(() {
        _status = newStatus;
      });

      try {
        await FirebaseFirestore.instance
            .collection('complaints')
            .doc(complaintId)
            .update({
          'status': _status,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status updated to $newStatus')),
        );

        _loadComplaintData();
      } catch (e) {
        print('Error updating status: $e');
      }
    });
  }

  void _nextComplaint() {
    if (_currentComplaintIndex < _complaints.length - 1) {
      setState(() {
        _currentComplaintIndex++;
      });
      _loadComplaintData();
    }
  }

  void _previousComplaint() {
    if (_currentComplaintIndex > 0) {
      setState(() {
        _currentComplaintIndex--;
      });
      _loadComplaintData();
    }
  }

  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "N/A";
    DateTime date = timestamp.toDate();
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE6EAF2),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff0061FF),
        title: Center(
          child: Text(
            "Hvac Complaints",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadComplaints,
          ),
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
              title: Text("Hvac Complaints"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HvacListScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          color: Color(0xffFFFFFF),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                    : Text('No image available'),
                SizedBox(height: 16.0),
                Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                SizedBox(height: 8.0),
                Text(
                  description ?? 'No description available',
                  style: TextStyle(fontSize: 16.0, color: Colors.black54),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isAccepted
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Accepted By:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black87),
                        ),
                        SizedBox(height: 4.0),
                        Text('$acceptedBy ($acceptedEmail)',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54)),
                        SizedBox(height: 4.0),
                        Text('At: ${formatTimestamp(acceptedAt)}',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54)),
                      ],
                    )
                        : ElevatedButton(
                      onPressed: _accept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff0061FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    isWorkCompleted
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Completed By:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.black87),
                        ),
                        SizedBox(height: 4.0),
                        Text('$workCompletedBy ($workCompletedEmail)',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54)),
                        SizedBox(height: 4.0),
                        Text('At: ${formatTimestamp(workCompletedAt)}',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54)),
                      ],
                    )
                        : SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 16.0),
                if (isAccepted && !isWorkCompleted)
                  DropdownButtonFormField<String>(
                    value: _status,
                    hint: Text('Select Status'),
                    items: _statusOptions.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (String? newStatus) {
                      if (newStatus != null) {
                        _updateStatus(newStatus);
                      }
                    },
                  ),
                SizedBox(height: 16.0),
                isAccepted && !isWorkCompleted
                    ? ElevatedButton(
                  onPressed: _workCompleted,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF6B00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Mark as Completed',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )
                    : SizedBox.shrink(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: _previousComplaint,
                      icon: Icon(Icons.arrow_back),
                    ),
                    IconButton(
                      onPressed: _nextComplaint,
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


