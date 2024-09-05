


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




//
// //good txt field UI
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
//   final String production_field;
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
//     required this.production_field, required String imageUrl,
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
//           _acceptedByUserId = data['acceptedByUserId']; // Fetch userId here
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
//       // Get the currently logged-in user's userId (who is accepting the complaint)
//       String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//       Timestamp now = Timestamp.now();
//
//       // Update the Firestore complaint document with the accepting user's userId and timestamp
//       await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//         'acceptedByUserId': currentUserId, // Store the userId of the current user
//         'acceptedAt': now,
//         'status': 'Work in Progress',
//       });
//
//       setState(() {
//         _isAccepted = true;
//         _acceptedByUserId = currentUserId; // Store the current user's userId in state
//         _acceptedAt = now;
//         _selectedStatus = 'Work in Progress';
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Complaint accepted successfully')),
//       );
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
//   Future<void> _updateStatus(String newStatus) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('complaints')
//           .doc(widget.complaintId)
//           .update({'status': newStatus});
//
//       setState(() {
//         _selectedStatus = newStatus;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Status updated to $newStatus')),
//       );
//     } catch (e) {
//       print('Error updating status: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update status')),
//       );
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
//             Text('Complain Generated by: ${_userName ?? "Loading..."}'),
//             SizedBox(height: 8),
//             Text('Production Field: ${_productionField ?? "Loading..."}'),
//             SizedBox(height: 16),
//             Text('Description: ${widget.description}'),
//             SizedBox(height: 16),
//             Text('Status: ${_selectedStatus}'),
//             SizedBox(height: 16),
//             Text('Priority: ${widget.priority}'),
//             SizedBox(height: 16),
//             Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
//             SizedBox(height: 16),
//             if (!_isAccepted)
//               ElevatedButton(
//                 onPressed: _acceptComplaint,
//                 child: Text('Accept'),
//               ),
//             if (_isAccepted) ...[
//               SizedBox(height: 16),
//               Text('Accepted By: ${_acceptedBy ?? "Loading..."}'),
//               SizedBox(height: 8),
//               Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
//               SizedBox(height: 16),
//               DropdownButton<String>(
//                 value: _selectedStatus,
//                 items: <String>[
//                   'Work in Progress',
//                   'In Review',
//                   'Pending',
//                   'Done',
//                 ].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   if (newValue != null) {
//                     _updateStatus(newValue);
//                   }
//                 },
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
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
// // cat
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



//
// // upper code doesn't show accepted u_name but get Uid
// //it worked but didnt store user it into list
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
//   final String production_field;
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
//     required this.production_field, required String imageUrl,
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
//   Future<void> _fetchComplaintData() async {
//     try {
//       DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//           .collection('complaints')
//           .doc(widget.complaintId)
//           .get();
//
//       if (complaintDoc.exists) {
//         var data = complaintDoc.data() as Map<String, dynamic>;
//         String? acceptedByUserId = data['acceptedByUserId']; // Fetch acceptedByUserId
//
//         setState(() {
//           _isAccepted = acceptedByUserId != null;
//           _acceptedAt = data['acceptedAt'];
//           _completedBy = data['completedBy'];
//           _completedAt = data['completedAt'];
//         });
//
//         // Fetch the accepted user's name if available
//         if (acceptedByUserId != null) {
//           await _fetchAcceptedUserName(acceptedByUserId);
//         }
//       }
//     } catch (e) {
//       print('Error fetching complaint data: $e');
//     }
//   }
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
//       // Get the currently logged-in user's userId (who is accepting the complaint)
//       String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//       Timestamp now = Timestamp.now();
//
//       // Update the Firestore complaint document with the accepting user's userId and timestamp
//       await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//         'acceptedByUserId': currentUserId, // Store the userId of the current user
//         'acceptedAt': now,
//         'status': 'Work in Progress',
//       });
//
//       setState(() {
//         _isAccepted = true;
//         _acceptedByUserId = currentUserId; // Store the current user's userId in state
//         _acceptedAt = now;
//         _selectedStatus = 'Work in Progress';
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Complaint accepted successfully')),
//       );
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
//   Future<void> _updateStatus(String newStatus) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('complaints')
//           .doc(widget.complaintId)
//           .update({'status': newStatus});
//
//       setState(() {
//         _selectedStatus = newStatus;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Status updated to $newStatus')),
//       );
//     } catch (e) {
//       print('Error updating status: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update status')),
//       );
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
//             Text('Complain Generated by: ${_userName ?? "Loading..."}'),
//             SizedBox(height: 8),
//             Text('Production Field: ${_productionField ?? "Loading..."}'),
//             SizedBox(height: 16),
//             Text('Description: ${widget.description}'),
//             SizedBox(height: 16),
//             Text('Status: ${_selectedStatus}'),
//             SizedBox(height: 16),
//             Text('Priority: ${widget.priority}'),
//             SizedBox(height: 16),
//             Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
//             SizedBox(height: 16),
//             if (!_isAccepted)
//               ElevatedButton(
//                 onPressed: _acceptComplaint,
//                 child: Text('Accept'),
//               ),
//     if (_isAccepted) ...[
//     SizedBox(height: 16),
//     Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'), // Display the accepted user's name
//     SizedBox(height: 8),
//     Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
//           ],
//         ]),
//       ),
//     );
//   }
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
// // cat
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




// //
// // // store uid into list and show dropdown
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
//   final String production_field;
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
//     required this.production_field, required String imageUrl,
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
//         bool hasUtilityRole = acceptedDetails.any((detail) =>
//         detail['acceptedRole'] == 'utility'); // Check for role 'utility'
//
//         setState(() {
//           _isAccepted = acceptedDetails.isNotEmpty;
//           _acceptedAt = data['acceptedAt'];
//           _completedBy = data['completedBy'];
//           _completedAt = data['completedAt'];
//           _isAccepted = hasUtilityRole;
//           if (hasUtilityRole) {
//             _selectedStatus = data['status'] ?? 'Work in Progress'; // Set status if role 'utility' is present
//           }
//         });
//
//         // Fetch the accepted user's name if available
//         String? acceptedByUserId = data['acceptedByUserId'];
//         if (acceptedByUserId != null) {
//           await _fetchAcceptedUserName(acceptedByUserId);
//         }
//       }
//     } catch (e) {
//       print('Error fetching complaint data: $e');
//     }
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
//       // Get the currently logged-in user's userId and role
//       String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Fetch the user's role from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUserId)
//           .get();
//
//       String userRole = '';
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         userRole = userData['role'] ?? ''; // Fetch user role
//       }
//
//       Timestamp now = Timestamp.now();
//
//       // Fetch the complaint document
//       DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//           .collection('complaints')
//           .doc(widget.complaintId)
//           .get();
//
//       if (complaintDoc.exists) {
//         var data = complaintDoc.data() as Map<String, dynamic>;
//
//         // Initialize list to store acceptance details
//         List<Map<String, dynamic>> acceptedList = [];
//
//         if (data.containsKey('acceptedDetails')) {
//           acceptedList = List<Map<String, dynamic>>.from(data['acceptedDetails']);
//         }
//
//         // Add current user's acceptance details
//         acceptedList.add({
//           'acceptedByUserId': currentUserId,
//           'acceptedAt': now,
//           'acceptedRole': userRole,
//         });
//
//         // Update Firestore with the new acceptance list and status
//         await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//           'acceptedDetails': acceptedList, // Store the list of maps
//           'status': 'Work in Progress',
//         });
//
//         setState(() {
//           _isAccepted = true;
//           _acceptedByUserId = currentUserId;
//           _acceptedAt = now;
//           _selectedStatus = 'Work in Progress';
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint accepted successfully')),
//         );
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
//   Future<void> _updateStatus(String newStatus) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('complaints')
//           .doc(widget.complaintId)
//           .update({'status': newStatus});
//
//       setState(() {
//         _selectedStatus = newStatus;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Status updated to $newStatus')),
//       );
//     } catch (e) {
//       print('Error updating status: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to update status')),
//       );
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
//             Text('Complain Generated by: ${_userName ?? "Loading..."}'),
//             SizedBox(height: 8),
//             Text('Production Field: ${_productionField ?? "Loading..."}'),
//             SizedBox(height: 16),
//             Text('Description: ${widget.description}'),
//             SizedBox(height: 16),
//             Text('Status: ${_selectedStatus}'),
//             SizedBox(height: 16),
//             Text('Priority: ${widget.priority}'),
//             SizedBox(height: 16),
//             Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
//             SizedBox(height: 16),
//             if (!_isAccepted)
//               ElevatedButton(
//                 onPressed: _acceptComplaint,
//                 child: Text('Accept'),
//               ),
//             if (_isAccepted) ...[
//               SizedBox(height: 16),
//               Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'),
//               SizedBox(height: 8),
//               Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
//               SizedBox(height: 16),
//               DropdownButton<String>(
//                 value: _selectedStatus,
//                 onChanged: (String? newValue) {
//                   if (newValue != null) {
//                     _updateStatus(newValue);
//                   }
//                 },
//                 items: <String>['Work in Progress', 'In Review', 'Pending', 'Finished', 'Something Else']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
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









// // store uid into list and show dropdown
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
    required this.production_field, required String imageUrl,
  });

  @override
  _UtilityDetailScreenState createState() => _UtilityDetailScreenState();
}

class _UtilityDetailScreenState extends State<UtilityDetailScreen> {
  bool _isAccepted = false;
  bool _isCompleted = false;
  String? _acceptedByUserName;
  Timestamp? _acceptedAt;
  String _selectedStatus = "Work in Progress";
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

  Future<void> _fetchComplaintData() async {
    try {
      DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
          .collection('complaints')
          .doc(widget.complaintId)
          .get();

      if (complaintDoc.exists) {
        var data = complaintDoc.data() as Map<String, dynamic>;
        List<dynamic> acceptedDetails = data['acceptedDetails'] ?? [];

        if (acceptedDetails.isNotEmpty) {
          // Assume the first entry in the list is the most relevant
          var firstAcceptedDetail = acceptedDetails.first;
          _acceptedAt = firstAcceptedDetail['acceptedAt'];
          String? acceptedByUserId = firstAcceptedDetail['acceptedByUserId'];

          if (acceptedByUserId != null) {
            await _fetchAcceptedUserName(acceptedByUserId);
          }
        }

        bool hasUtilityRole = acceptedDetails.any((detail) =>
        detail['acceptedRole'] == 'utility'); // Check for role 'utility'

        setState(() {
          _isAccepted = acceptedDetails.isNotEmpty;
          _selectedStatus = data['status'] ?? 'Work in Progress'; // Set status if role 'utility' is present
        });
      }
    } catch (e) {
      print('Error fetching complaint data: $e');
    }
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
      // Get the currently logged-in user's userId and role
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch the user's role from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      String userRole = '';
      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;
        userRole = userData['role'] ?? ''; // Fetch user role
      }

      Timestamp now = Timestamp.now();

      // Fetch the complaint document
      DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
          .collection('complaints')
          .doc(widget.complaintId)
          .get();

      if (complaintDoc.exists) {
        var data = complaintDoc.data() as Map<String, dynamic>;

        // Initialize list to store acceptance details
        List<Map<String, dynamic>> acceptedList = [];

        if (data.containsKey('acceptedDetails')) {
          acceptedList = List<Map<String, dynamic>>.from(data['acceptedDetails']);
        }

        // Add current user's acceptance details
        acceptedList.add({
          'acceptedByUserId': currentUserId,
          'acceptedAt': now,
          'acceptedRole': userRole,
        });

        // Update Firestore with the new acceptance list and status
        await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
          'acceptedDetails': acceptedList, // Store the list of maps
          'status': 'Work in Progress',
        });

        setState(() {
          _isAccepted = true;
          _acceptedByUserName = FirebaseAuth.instance.currentUser!.displayName; // Set the current user's name
          _acceptedAt = now;
          _selectedStatus = 'Work in Progress';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Complaint accepted successfully')),
        );
      }
    } catch (e) {
      print('Error accepting complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept complaint')),
      );
    }
  }

  Future<void> _updateStatus(String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(widget.complaintId)
          .update({'status': newStatus});

      setState(() {
        _selectedStatus = newStatus;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status updated to $newStatus')),
      );
    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status')),
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
            Text('Status: ${_selectedStatus}'),
            SizedBox(height: 16),
            Text('Priority: ${widget.priority}'),
            SizedBox(height: 16),
            Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
            SizedBox(height: 16),
            if (!_isAccepted)
              ElevatedButton(
                onPressed: _acceptComplaint,
                child: Text('Accept'),
              ),
            if (_isAccepted) ...[
              SizedBox(height: 16),
              Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'),
              SizedBox(height: 8),
              Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedStatus,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _updateStatus(newValue);
                  }
                },
                items: <String>['Work in Progress', 'In Review', 'Pending', 'Finished', 'Something Else']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
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