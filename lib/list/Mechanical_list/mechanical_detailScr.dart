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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mechanical_DetailScreen extends StatefulWidget {
  final List<String> imageUrls;
  final String description;
  final String status;
  final String priority;
  final String complaintId;
  final String userId;
  final Timestamp timestamp;
  final String name;
  final String productionField;

  Mechanical_DetailScreen({
    required this.imageUrls,
    required this.description,
    required this.status,
    required this.priority,
    required this.complaintId,
    required this.userId,
    required this.timestamp,
    required this.name,
    required this.productionField,
  });

  @override
  _Mechanical_DetailScreenState createState() => _Mechanical_DetailScreenState();
}

class _Mechanical_DetailScreenState extends State<Mechanical_DetailScreen> {
  bool _isAccepted = false;
  bool _isCompleted = false;
  String? _acceptedBy;
  String? _completedBy;
  Timestamp? _acceptedAt;
  Timestamp? _completedAt;

  @override
  void initState() {
    super.initState();
    _fetchComplaintData();
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
          _acceptedBy = data['acceptedBy'] != null ? data['acceptedBy'] : null;
          _completedBy = data['completedBy'] != null ? data['completedBy'] : null;
          _acceptedAt = data['acceptedAt'] != null ? data['acceptedAt'] as Timestamp : null;
          _completedAt = data['completedAt'] != null ? data['completedAt'] as Timestamp : null;
        });

        // Fetch user names
        if (_acceptedBy != null) {
          _fetchUserName(_acceptedBy!, (name) {
            setState(() {
              _acceptedBy = name;
            });
          });
        }

        if (_completedBy != null) {
          _fetchUserName(_completedBy!, (name) {
            setState(() {
              _completedBy = name;
            });
          });
        }
      }
    } catch (e) {
      print("Error fetching complaint data: $e");
    }
  }

  Future<void> _fetchUserName(String userId, Function(String) onNameFetched) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        String userName = userData['name'] ?? 'Unknown';
        onNameFetched(userName);
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  Future<void> _acceptComplaint(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please log in to accept the complaint.'),
        ));
        return;
      }

      await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
        'acceptedBy': currentUser.uid,
        'acceptedAt': Timestamp.now(),
        'status': 'Work in Progress',
      });

      _fetchComplaintData(); // Refresh data after update

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Complaint accepted successfully!'),
      ));
    } catch (e) {
      print("Error accepting complaint: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error accepting complaint.'),
      ));
    }
  }

  Future<void> _completeComplaint(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please log in to complete the complaint.'),
        ));
        return;
      }

      await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
        'completedBy': currentUser.uid,
        'completedAt': Timestamp.now(),
        'status': 'Completed',
      });

      _fetchComplaintData(); // Refresh data after update

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Complaint completed successfully!'),
      ));
    } catch (e) {
      print("Error completing complaint: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error completing complaint.'),
      ));
    }
  }

  String formatDate(Timestamp timestamp) {
    return DateFormat('MMMM dd, yyyy at hh:mm a').format(timestamp.toDate());
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Image.network(imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Text('Complaint Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading user info'));
          }

          final userInfo = snapshot.data;
          final user = userInfo != null ? userInfo['name'] ?? 'Unknown' : 'Unknown';
          final productionField = userInfo != null ? userInfo['production_field'] ?? 'N/A' : 'N/A';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    enableInfiniteScroll: widget.imageUrls.length > 1, // Enable only if there is more than one image
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    aspectRatio: 16 / 9,
                  ),
                  items: widget.imageUrls.map((imageUrl) {
                    return GestureDetector(
                      onTap: () {
                        if (imageUrl.isNotEmpty) {
                          _showFullScreenImage(context, imageUrl);
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text(
                  "Complaint Generated By",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "$user, $productionField",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 20),
                Text(
                  "Complaint Generated At",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  formatDate(widget.timestamp),
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 20),
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 20),
                _buildDetailRow("Priority", widget.priority),
                _buildDetailRow("Status", widget.status),
                if (_isAccepted) ...[
                  SizedBox(height: 20),
                  _buildDetailRow("Accepted By", _acceptedBy ?? 'N/A'),
                  _buildDetailRow("Accepted At", _acceptedAt != null ? formatDate(_acceptedAt!) : 'N/A'),
                ],
                if (_isCompleted) ...[
                  SizedBox(height: 20),
                  _buildDetailRow("Completed By", _completedBy ?? 'N/A'),
                  _buildDetailRow("Completed At", _completedAt != null ? formatDate(_completedAt!) : 'N/A'),
                ],
                SizedBox(height: 20),
                // Conditional rendering of Accept and Complete buttons
                if (!_isAccepted) ...[
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _acceptComplaint(context),
                      child: Text("Accept"),
                    ),
                  ),
                ],
                if (_isAccepted && !_isCompleted) ...[
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _completeComplaint(context),
                      child: Text("Complete"),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      children: [
        Text(
          "$title:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user info: $e");
      return null;
    }
  }
}




