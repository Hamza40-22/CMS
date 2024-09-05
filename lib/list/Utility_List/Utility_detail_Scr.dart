


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







//
//
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
//   Future<void> _completeComplaint() async {
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
//         // Initialize list to store completion details
//         List<Map<String, dynamic>> completedList = [];
//
//         if (data.containsKey('completedDetails')) {
//           completedList = List<Map<String, dynamic>>.from(data['completedDetails']);
//         }
//
//         // Add current user's completion details
//         completedList.add({
//           'completedByUserId': currentUserId,
//           'completedAt': now,
//           'completedRole': userRole,
//         });
//
//         // Update Firestore with the new completion list and status
//         await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//           'completedDetails': completedList, // Store the list of maps
//           'status': 'Completed', // Update status to completed
//         });
//
//         setState(() {
//           _isCompleted = true;
//           _completedAt = now;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint marked as complete')),
//         );
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
//
//             // Show "Accept" button if the complaint is not accepted yet
//             if (!_isAccepted)
//               ElevatedButton(
//                 onPressed: _acceptComplaint,
//                 child: Text('Accept'),
//               ),
//
//             // Show details and dropdown after acceptance
//             if (_isAccepted) ...[
//               SizedBox(height: 16),
//               Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'),
//               SizedBox(height: 8),
//               Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
//               SizedBox(height: 16),
//
//               // Only show the dropdown and "Complete" button if the complaint is not completed
//               if (_selectedStatus != 'Completed') ...[
//                 DropdownButton<String>(
//                   value: _selectedStatus,
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       _updateStatus(newValue);
//                     }
//                   },
//                   items: <String>{'Work in Progress', 'In Review', 'Pending', 'Finished', 'Something Else', 'Completed'}
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 16),
//
//                 ElevatedButton(
//                   onPressed: _completeComplaint,
//                   child: Text('Complete'),
//                 ),
//               ],
//
//               // Show completion details if the complaint is completed
//               if (_isCompleted || _selectedStatus == 'Completed') ...[
//                 SizedBox(height: 16),
//                 Text('Completed By: ${_acceptedByUserName ?? "Loading..."}'),
//                 SizedBox(height: 8),
//                 Text('Completed At: ${_completedAt != null ? _formatTimestamp(_completedAt!) : "Loading..."}'),
//               ],
//             ],
//           ],
//         ),
//       ),
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





//
//
// // again
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
//   Future<void> _completeComplaint() async {
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
//         // Initialize list to store completion details
//         List<Map<String, dynamic>> completedList = [];
//
//         if (data.containsKey('completedDetails')) {
//           completedList = List<Map<String, dynamic>>.from(data['completedDetails']);
//         }
//
//         // Add current user's completion details
//         completedList.add({
//           'completedByUserId': currentUserId,
//           'completedAt': now,
//           'completedRole': userRole,
//         });
//
//         // Update Firestore with the new completion list and status
//         await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//           'completedDetails': completedList, // Store the list of maps
//           'status': 'Completed', // Update status to completed
//         });
//
//         setState(() {
//           _isCompleted = true;
//           _completedAt = now;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint marked as complete')),
//         );
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
//
//             // Show "Accept" button if the complaint is not accepted yet
//             if (!_isAccepted)
//               ElevatedButton(
//                 onPressed: _acceptComplaint,
//                 child: Text('Accept'),
//               ),
//
//             // Show details and dropdown after acceptance
//             if (_isAccepted) ...[
//               SizedBox(height: 16),
//               Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'),
//               SizedBox(height: 8),
//               Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
//               SizedBox(height: 16),
//
//               // Only show the dropdown and "Complete" button if the complaint is not completed
//               if (_selectedStatus != 'Completed') ...[
//                 DropdownButton<String>(
//                   value: _selectedStatus,
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       _updateStatus(newValue);
//                     }
//                   },
//                   items: <String>{'Work in Progress', 'In Review', 'Pending', 'Finished', 'Something Else', 'Completed'}
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(height: 16),
//
//                 ElevatedButton(
//                   onPressed: _completeComplaint,
//                   child: Text('Complete'),
//                 ),
//               ],
//
//               // Show completion details if the complaint is completed
//               if (_isCompleted || _selectedStatus == 'Completed') ...[
//                 SizedBox(height: 16),
//                 Text('Completed By: ${_acceptedByUserName ?? "Loading..."}'),
//                 SizedBox(height: 8),
//                 Text('Completed At: ${_completedAt != null ? _formatTimestamp(_completedAt!) : "Loading..."}'),
//               ],
//             ],
//           ],
//         ),
//       ),
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


//
// //6/9-24  11:23
// // worked get current uname of cmplt and acpt
// // again
// // // store uid into list and show dropdown
//   import 'package:carousel_slider/carousel_slider.dart';
//   import 'package:cloud_firestore/cloud_firestore.dart';
//   import 'package:firebase_auth/firebase_auth.dart';
//   import 'package:flutter/material.dart';
//   import 'package:intl/intl.dart';
//   import 'package:video_player/video_player.dart';
//   import 'package:path_provider/path_provider.dart';
//   import 'dart:io';
//   import 'package:dio/dio.dart';
//   import 'package:flutter/services.dart';
//   import 'package:percent_indicator/circular_percent_indicator.dart';
//
//   class UtilityDetailScreen extends StatefulWidget {
//     final List<String> imageUrls;
//     final List<String> videoUrls;
//     final String description;
//     final String status;
//     final String priority;
//     final String complaintId;
//     final String userId;
//     final Timestamp timestamp;
//     final String name;
//     final String production_field;
//
//     UtilityDetailScreen({
//       required this.imageUrls,
//       required this.videoUrls,
//       required this.description,
//       required this.status,
//       required this.priority,
//       required this.complaintId,
//       required this.userId,
//       required this.timestamp,
//       required this.name,
//       required this.production_field, required String imageUrl,
//     });
//
//     @override
//     _UtilityDetailScreenState createState() => _UtilityDetailScreenState();
//   }
//
//   class _UtilityDetailScreenState extends State<UtilityDetailScreen> {
//     bool _isAccepted = false;
//     bool _isCompleted = false;
//     String? _acceptedBy;
//     String? _completedBy;
//     Timestamp? _acceptedAt;
//     Timestamp? _completedAt;
//     String _selectedStatus = "Work in Progress";
//     late List<VideoPlayerController> _videoControllers;
//
//     // Variables to store user details
//     String? _userName;
//     String? _productionField;
//
//     @override
//     void initState() {
//       super.initState();
//       _fetchComplaintData();
//       _fetchUserData();
//       _videoControllers = widget.videoUrls.map((videoUrl) {
//         return VideoPlayerController.network(videoUrl)..initialize();
//       }).toList();
//     }
//
//     @override
//     void dispose() {
//       for (var controller in _videoControllers) {
//         controller.dispose();
//       }
//       super.dispose();
//     }
//
//
//     String? _acceptedByUserId;
//     String? _acceptedByUserName;
//
//     Future<void> _fetchComplaintData() async {
//       try {
//         DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .get();
//
//         if (complaintDoc.exists) {
//           var data = complaintDoc.data() as Map<String, dynamic>;
//           List<dynamic> acceptedDetails = data['acceptedDetails'] ?? [];
//           List<dynamic> completedDetails = data['completedDetails'] ?? [];
//
//           bool hasUtilityRole = acceptedDetails.any((detail) =>
//           detail['acceptedRole'] == 'utility'); // Check for role 'utility'
//
//           setState(() {
//             _isAccepted = acceptedDetails.isNotEmpty;
//             _isCompleted = completedDetails.isNotEmpty;
//
//             // Fetch acceptedByUserName, acceptedAt, and completedByUserName from the details lists
//             if (acceptedDetails.isNotEmpty) {
//               var lastAcceptedDetail = acceptedDetails.last;
//               _acceptedByUserName = lastAcceptedDetail['acceptedByUserName'];
//               _acceptedAt = lastAcceptedDetail['acceptedAt']; // Correctly set acceptedAt
//             }
//
//             if (completedDetails.isNotEmpty) {
//               var lastCompletedDetail = completedDetails.last;
//               _completedBy = lastCompletedDetail['completedByUserName'];
//               _completedAt = lastCompletedDetail['completedAt']; // Correctly set completedAt
//             }
//
//             _isAccepted = hasUtilityRole;
//             if (hasUtilityRole) {
//               _selectedStatus = data['status'] ?? 'Work in Progress'; // Set status if role 'utility' is present
//             }
//           });
//         }
//       } catch (e) {
//         print('Error fetching complaint data: $e');
//       }
//     }
//
//
//
//
//     // Fetch the name of the user who accepted the complaint
//     Future<void> _fetchAcceptedUserName(String userId) async {
//       try {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userId)
//             .get();
//
//         if (userDoc.exists) {
//           var userData = userDoc.data() as Map<String, dynamic>;
//           setState(() {
//             _acceptedByUserName = userData['name']; // Store the user's name
//           });
//         }
//       } catch (e) {
//         print('Error fetching accepted user data: $e');
//       }
//     }
//
//
//
//     Future<void> _fetchUserData() async {
//       try {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(widget.userId)
//             .get();
//
//         if (userDoc.exists) {
//           var userData = userDoc.data() as Map<String, dynamic>;
//           setState(() {
//             _userName = userData['name'];
//             _productionField = userData['production_field'];
//           });
//         }
//       } catch (e) {
//         print('Error fetching user data: $e');
//       }
//     }
//
//     String _formatTimestamp(Timestamp timestamp) {
//       DateTime dateTime = timestamp.toDate();
//       return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
//     }
//
//
//
//     Future<void> _acceptComplaint() async {
//       try {
//         // Get the currently logged-in user's userId and fetch their details
//         String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//         // Fetch the user's name and role from Firestore
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUserId)
//             .get();
//
//         String userName = '';
//         String userRole = '';
//         if (userDoc.exists) {
//           var userData = userDoc.data() as Map<String, dynamic>;
//           userName = userData['name'] ?? ''; // Fetch user name
//           userRole = userData['role'] ?? ''; // Fetch user role
//         }
//
//         Timestamp now = Timestamp.now();
//
//         // Fetch the complaint document
//         DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .get();
//
//         if (complaintDoc.exists) {
//           var data = complaintDoc.data() as Map<String, dynamic>;
//
//           // Initialize list to store acceptance details
//           List<Map<String, dynamic>> acceptedList = [];
//
//           if (data.containsKey('acceptedDetails')) {
//             acceptedList = List<Map<String, dynamic>>.from(data['acceptedDetails']);
//           }
//
//           // Add current user's acceptance details including user name
//           acceptedList.add({
//             'acceptedByUserId': currentUserId,
//             'acceptedByUserName': userName, // Store the user's name
//             'acceptedAt': now,
//             'acceptedRole': userRole,
//           });
//
//           // Update Firestore with the new acceptance list and status
//           await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//             'acceptedDetails': acceptedList, // Store the list of maps with user details
//             'status': 'Work in Progress',
//           });
//
//           setState(() {
//             _isAccepted = true;
//             _acceptedByUserId = currentUserId;
//             _acceptedByUserName = userName; // Store the accepted user's name in the state
//             _acceptedAt = now;
//             _selectedStatus = 'Work in Progress';
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Complaint accepted successfully')),
//           );
//         }
//       } catch (e) {
//         print('Error accepting complaint: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to accept complaint')),
//         );
//       }
//     }
//
//
//
//     Future<void> _completeComplaint() async {
//       try {
//         // Get the currently logged-in user's userId
//         String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//         // Fetch the user's name and role from Firestore
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentUserId)
//             .get();
//
//         String userName = '';
//         String userRole = '';
//         if (userDoc.exists) {
//           var userData = userDoc.data() as Map<String, dynamic>;
//           userName = userData['name'] ?? ''; // Fetch user's name
//           userRole = userData['role'] ?? ''; // Fetch user's role
//         }
//
//         Timestamp now = Timestamp.now();
//
//         // Fetch the complaint document
//         DocumentSnapshot complaintDoc = await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .get();
//
//         if (complaintDoc.exists) {
//           var data = complaintDoc.data() as Map<String, dynamic>;
//
//           // Initialize list to store completion details
//           List<Map<String, dynamic>> completedList = [];
//
//           if (data.containsKey('completedDetails')) {
//             completedList = List<Map<String, dynamic>>.from(data['completedDetails']);
//           }
//
//           // Add current user's completion details including their name
//           completedList.add({
//             'completedByUserId': currentUserId,
//             'completedByUserName': userName, // Store user's name
//             'completedAt': now,
//             'completedRole': userRole,
//           });
//
//           // Update Firestore with the new completion list and status
//           await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//             'completedDetails': completedList, // Store the list of maps with user details
//             'status': 'Completed', // Update status to completed
//           });
//
//           setState(() {
//             _isCompleted = true;
//             _completedAt = now;
//             _completedBy = userName; // Store the completed user's name in the state
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Complaint marked as complete')),
//           );
//         }
//       } catch (e) {
//         print('Error completing complaint: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to complete complaint')),
//         );
//       }
//     }
//
//
//     Future<void> _updateStatus(String newStatus) async {
//       try {
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .update({'status': newStatus});
//
//         setState(() {
//           _selectedStatus = newStatus;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Status updated to $newStatus')),
//         );
//       } catch (e) {
//         print('Error updating status: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update status')),
//         );
//       }
//     }
//
//     void _showFullScreenVideo(String videoUrl) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => FullScreenVideoScreen(videoUrl: videoUrl),
//         ),
//       );
//     }
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Utility Detail'),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (widget.imageUrls.isNotEmpty || widget.videoUrls.isNotEmpty)
//                 _buildMediaSlider(widget.imageUrls, widget.videoUrls),
//               SizedBox(height: 16),
//               Text('Complain Generated by: ${_userName ?? "Loading..."}'),
//               SizedBox(height: 8),
//               Text('Production Field: ${_productionField ?? "Loading..."}'),
//               SizedBox(height: 16),
//               Text('Description: ${widget.description}'),
//               SizedBox(height: 16),
//               Text('Status: ${_selectedStatus}'),
//               SizedBox(height: 16),
//               Text('Priority: ${widget.priority}'),
//               SizedBox(height: 16),
//               Text('Timestamp: ${_formatTimestamp(widget.timestamp)}'),
//               SizedBox(height: 16),
//
//               // Show "Accept" button if the complaint is not accepted yet
//               if (!_isAccepted)
//                 ElevatedButton(
//                   onPressed: _acceptComplaint,
//                   child: Text('Accept'),
//                 ),
//
//               // Show details and dropdown after acceptance
//               if (_isAccepted) ...[
//                 SizedBox(height: 16),
//                 Text('Accepted By: ${_acceptedByUserName ?? "Loading..."}'),
//                 SizedBox(height: 8),
//                 Text('Accepted At: ${_acceptedAt != null ? _formatTimestamp(_acceptedAt!) : "Loading..."}'),
//                 SizedBox(height: 16),
//
//                 if (_selectedStatus != 'Completed') ...[
//                   DropdownButton<String>(
//                     value: _selectedStatus,
//                     onChanged: (String? newValue) {
//                       if (newValue != null) {
//                         _updateStatus(newValue);
//                       }
//                     },
//                     items: <String>{'Work in Progress', 'In Review', 'Pending', 'Finished', 'Something Else', 'Completed'}
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(height: 16),
//
//                   ElevatedButton(
//                     onPressed: _completeComplaint,
//                     child: Text('Complete'),
//                   ),
//                 ],
//
//                 if (_isCompleted || _selectedStatus == 'Completed') ...[
//                   SizedBox(height: 16),
//                   Text('Completed By: ${_completedBy ?? "Loading..."}'),
//                   SizedBox(height: 8),
//                   Text('Completed At: ${_completedAt != null ? _formatTimestamp(_completedAt!) : "Loading..."}'),
//                 ],
//               ],
//
//             ],
//           ),
//         ),
//       );
//     }
//
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




//
// //6/9-24  12:01
// // worked get current uname of cmplt and acpt
// // better UI
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
//         List<dynamic> completedDetails = data['completedDetails'] ?? [];
//
//         bool hasUtilityRole = acceptedDetails.any((detail) =>
//         detail['acceptedRole'] == 'utility'); // Check for role 'utility'
//
//         setState(() {
//           _isAccepted = acceptedDetails.isNotEmpty;
//           _isCompleted = completedDetails.isNotEmpty;
//
//           // Fetch acceptedByUserName, acceptedAt, and completedByUserName from the details lists
//           if (acceptedDetails.isNotEmpty) {
//             var lastAcceptedDetail = acceptedDetails.last;
//             _acceptedByUserName = lastAcceptedDetail['acceptedByUserName'];
//             _acceptedAt = lastAcceptedDetail['acceptedAt']; // Correctly set acceptedAt
//           }
//
//           if (completedDetails.isNotEmpty) {
//             var lastCompletedDetail = completedDetails.last;
//             _completedBy = lastCompletedDetail['completedByUserName'];
//             _completedAt = lastCompletedDetail['completedAt']; // Correctly set completedAt
//           }
//
//           _isAccepted = hasUtilityRole;
//           if (hasUtilityRole) {
//             _selectedStatus = data['status'] ?? 'Work in Progress'; // Set status if role 'utility' is present
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
//       // Get the currently logged-in user's userId and fetch their details
//       String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Fetch the user's name and role from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUserId)
//           .get();
//
//       String userName = '';
//       String userRole = '';
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         userName = userData['name'] ?? ''; // Fetch user name
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
//         // Add current user's acceptance details including user name
//         acceptedList.add({
//           'acceptedByUserId': currentUserId,
//           'acceptedByUserName': userName, // Store the user's name
//           'acceptedAt': now,
//           'acceptedRole': userRole,
//         });
//
//         // Update Firestore with the new acceptance list and status
//         await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//           'acceptedDetails': acceptedList, // Store the list of maps with user details
//           'status': 'Work in Progress',
//         });
//
//         setState(() {
//           _isAccepted = true;
//           _acceptedByUserId = currentUserId;
//           _acceptedByUserName = userName; // Store the accepted user's name in the state
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
//   Future<void> _completeComplaint() async {
//     try {
//       // Get the currently logged-in user's userId
//       String currentUserId = FirebaseAuth.instance.currentUser!.uid;
//
//       // Fetch the user's name and role from Firestore
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUserId)
//           .get();
//
//       String userName = '';
//       String userRole = '';
//       if (userDoc.exists) {
//         var userData = userDoc.data() as Map<String, dynamic>;
//         userName = userData['name'] ?? ''; // Fetch user's name
//         userRole = userData['role'] ?? ''; // Fetch user's role
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
//         // Initialize list to store completion details
//         List<Map<String, dynamic>> completedList = [];
//
//         if (data.containsKey('completedDetails')) {
//           completedList = List<Map<String, dynamic>>.from(data['completedDetails']);
//         }
//
//         // Add current user's completion details including their name
//         completedList.add({
//           'completedByUserId': currentUserId,
//           'completedByUserName': userName, // Store user's name
//           'completedAt': now,
//           'completedRole': userRole,
//         });
//
//         // Update Firestore with the new completion list and status
//         await FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId).update({
//           'completedDetails': completedList, // Store the list of maps with user details
//           'status': 'Completed', // Update status to completed
//         });
//
//         setState(() {
//           _isCompleted = true;
//           _completedAt = now;
//           _completedBy = userName; // Store the completed user's name in the state
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Complaint marked as complete')),
//         );
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
//       backgroundColor: Colors.white.withOpacity(0.9), // Light and translucent background
//       appBar: AppBar(
//         backgroundColor: Colors.white.withOpacity(0.6),
//         elevation: 0,
//         title: Text(
//           'Utility Detail',
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
//               if (_selectedStatus != 'Completed') ...[
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






// //6/9-24  2:06
// // worked get current uname of cmplt and acpt
// // confirmation popup
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
//         List<dynamic> completedDetails = data['completedDetails'] ?? [];
//
//         bool hasUtilityRole = acceptedDetails.any((detail) =>
//         detail['acceptedRole'] == 'utility'); // Check for role 'utility'
//
//         setState(() {
//           _isAccepted = acceptedDetails.isNotEmpty;
//           _isCompleted = completedDetails.isNotEmpty;
//
//           // Fetch acceptedByUserName, acceptedAt, and completedByUserName from the details lists
//           if (acceptedDetails.isNotEmpty) {
//             var lastAcceptedDetail = acceptedDetails.last;
//             _acceptedByUserName = lastAcceptedDetail['acceptedByUserName'];
//             _acceptedAt = lastAcceptedDetail['acceptedAt']; // Correctly set acceptedAt
//           }
//
//           if (completedDetails.isNotEmpty) {
//             var lastCompletedDetail = completedDetails.last;
//             _completedBy = lastCompletedDetail['completedByUserName'];
//             _completedAt = lastCompletedDetail['completedAt']; // Correctly set completedAt
//           }
//
//           _isAccepted = hasUtilityRole;
//           if (hasUtilityRole) {
//             _selectedStatus = data['status'] ?? 'Work in Progress'; // Set status if role 'utility' is present
//           }
//         });
//       }
//     } catch (e) {
//       print('Error fetching complaint data: $e');
//     }
//   }
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
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .update({'status': newStatus});
//
//         setState(() {
//           _selectedStatus = newStatus;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Status updated to $newStatus')),
//         );
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
//           'Utility Detail',
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
//               if (_selectedStatus != 'Completed') ...[
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




//6/9-24  2:58
// worked get current uname of cmplt and acpt
// video optimization
// good code working

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
//         List<dynamic> completedDetails = data['completedDetails'] ?? [];
//
//         bool hasUtilityRole = acceptedDetails.any((detail) =>
//         detail['acceptedRole'] == 'utility'); // Check for role 'utility'
//
//         setState(() {
//           _isAccepted = acceptedDetails.isNotEmpty;
//           _isCompleted = completedDetails.isNotEmpty;
//
//           // Fetch acceptedByUserName, acceptedAt, and completedByUserName from the details lists
//           if (acceptedDetails.isNotEmpty) {
//             var lastAcceptedDetail = acceptedDetails.last;
//             _acceptedByUserName = lastAcceptedDetail['acceptedByUserName'];
//             _acceptedAt = lastAcceptedDetail['acceptedAt']; // Correctly set acceptedAt
//           }
//
//           if (completedDetails.isNotEmpty) {
//             var lastCompletedDetail = completedDetails.last;
//             _completedBy = lastCompletedDetail['completedByUserName'];
//             _completedAt = lastCompletedDetail['completedAt']; // Correctly set completedAt
//           }
//
//           _isAccepted = hasUtilityRole;
//           if (hasUtilityRole) {
//             _selectedStatus = data['status'] ?? 'Work in Progress'; // Set status if role 'utility' is present
//           }
//         });
//       }
//     } catch (e) {
//       print('Error fetching complaint data: $e');
//     }
//   }
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
//         await FirebaseFirestore.instance
//             .collection('complaints')
//             .doc(widget.complaintId)
//             .update({'status': newStatus});
//
//         setState(() {
//           _selectedStatus = newStatus;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Status updated to $newStatus')),
//         );
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
//           'Utility Detail',
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
//               if (_selectedStatus != 'Completed') ...[
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

// mechanical code  copy


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
  String? _acceptedBy;
  String? _completedBy;
  Timestamp? _acceptedAt;
  Timestamp? _completedAt;
  String _utilityStatus = "Work in Progress"; // Default utility status

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

        List<dynamic> utilityAcceptedDetails = acceptedDetails
            .where((detail) => detail['acceptedRole'] == 'utility')
            .toList();

        setState(() {
          _isAccepted = utilityAcceptedDetails.isNotEmpty;
          _isCompleted = completedDetails.isNotEmpty;
          _utilityStatus = data['utilityStatus'] ?? 'Work in Progress'; // Fetch utility status

          if (utilityAcceptedDetails.isNotEmpty) {
            var lastAcceptedDetail = utilityAcceptedDetails.last;
            _acceptedByUserName = lastAcceptedDetail['acceptedByUserName'];
            _acceptedAt = lastAcceptedDetail['acceptedAt'];
          }

          if (completedDetails.isNotEmpty) {
            var lastCompletedDetail = completedDetails.last;
            _completedBy = lastCompletedDetail['completedByUserName'];
            _completedAt = lastCompletedDetail['completedAt'];

            if (lastCompletedDetail['completedRole'] == 'utility') {
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
            _utilityStatus = 'Work in Progress';
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




  Future<void> _updateUtilityStatus(String newStatus) async {
    try {
      bool confirm = await _showConfirmationDialog(
        'Update Utility Status',
        'Are you sure you want to update the utility status to $newStatus?',
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
              .update({'utilityStatus': newStatus});

          setState(() {
            _utilityStatus = newStatus;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('utility status updated to $newStatus')),
          );
        }
      }
    } catch (e) {
      print('Error updating utility status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update utility status')),
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
          'utility Detail',
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
              child: Text('Status: ${_utilityStatus}'),
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
              // Display the Complete button only if the complaint is not marked as completed by a utility role
              if (_utilityStatus != 'Completed' && (!_isCompleted || _completedBy != 'utility')) ...[
                DropdownButton<String>(
                  value: _utilityStatus,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _updateUtilityStatus(newValue);
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
              if (_isCompleted || _utilityStatus == 'Completed') ...[
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
