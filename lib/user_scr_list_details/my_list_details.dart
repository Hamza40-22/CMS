

// include video and images more updates fixed video player
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';
//
// class ComplaintDetailScreen extends StatelessWidget {
//   final String complaintId;
//   final List<String> imageUrls;
//   final List<String> videoUrls;
//   final String description;
//   final String acceptedBy;
//   final String completedBy;
//   final String acceptedByEmail;
//   final DateTime? acceptedTimestamp;
//   final String completedByEmail;
//   final DateTime? completedTimestamp;
//
//   const ComplaintDetailScreen({
//     required this.complaintId,
//     required this.imageUrls,
//     required this.videoUrls,
//     required this.description,
//     required this.acceptedBy,
//     required this.completedBy,
//     required this.acceptedByEmail,
//     required this.acceptedTimestamp,
//     required this.completedByEmail,
//     required this.completedTimestamp,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isCompleted = completedBy != 'In Progress';
//     final statusColor = isCompleted ? Colors.green : Colors.red;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Complaint Details'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               // Refresh logic here
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (imageUrls.isNotEmpty || videoUrls.isNotEmpty)
//               _buildMediaSlider(imageUrls, videoUrls),
//             SizedBox(height: 16),
//             _buildInfoBox('Description', description),
//             SizedBox(height: 16),
//             _buildInfoBox('Accepted by', acceptedBy),
//             _buildInfoBox('Accepted Email', acceptedByEmail),
//             _buildInfoBox('Accepted At', _formatDateTime(acceptedTimestamp)),
//             SizedBox(height: 16),
//             _buildInfoBox('Completed by', completedBy),
//             _buildInfoBox('Completed Email', completedByEmail),
//             _buildInfoBox('Completed At', _formatDateTime(completedTimestamp)),
//             SizedBox(height: 16),
//             if (isCompleted)
//               _buildInfoBox('Status', 'Completed'),
//             if (!isCompleted)
//               _buildInfoBox('Status', 'Pending'),
//             SizedBox(height: 16),
//             if (isCompleted)
//               ElevatedButton(
//                 onPressed: () {
//                   // Close query logic here
//                 },
//                 child: Text('Close Query'),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12.0),
//                 ),
//               ),
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
//       child: PageView.builder(
//         itemCount: mediaUrls.length,
//         itemBuilder: (context, index) {
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
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FullScreenVideoScreen(videoUrl: mediaUrl),
//                   ),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: VideoPlayerWidget(videoUrl: mediaUrl),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
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
//
//   Widget _buildInfoBox(String label, String value) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8.0,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               textAlign: TextAlign.right,
//               style: TextStyle(color: Colors.black54),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _formatDateTime(DateTime? dateTime) {
//     if (dateTime == null) return 'Not Available';
//     return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
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
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           _duration = _controller.value.duration;
//         });
//         _controller.addListener(() {
//           setState(() {
//             _position = _controller.value.position;
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
//       body: OrientationBuilder(
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
//                       final newPosition = _position - Duration(seconds: 10);
//                       _seekTo(newPosition < Duration.zero
//                           ? Duration.zero
//                           : newPosition);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.forward_10),
//                     onPressed: () {
//                       final newPosition = _position + Duration(seconds: 10);
//                       _seekTo(newPosition > _duration
//                           ? _duration
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


//downloading video with showing %
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:video_player/video_player.dart';
//
// class ComplaintDetailScreen extends StatelessWidget {
//   final String complaintId;
//   final List<String> imageUrls;
//   final List<String> videoUrls;
//   final String description;
//   final String acceptedBy;
//   final String completedBy;
//   final String acceptedByEmail;
//   final DateTime? acceptedTimestamp;
//   final String completedByEmail;
//   final DateTime? completedTimestamp;
//
//   const ComplaintDetailScreen({
//     required this.complaintId,
//     required this.imageUrls,
//     required this.videoUrls,
//     required this.description,
//     required this.acceptedBy,
//     required this.completedBy,
//     required this.acceptedByEmail,
//     required this.acceptedTimestamp,
//     required this.completedByEmail,
//     required this.completedTimestamp,
//   });
//
//
//
//
//
//   Future<Map<String, dynamic>?> fetchComplaintDetails() async {
//     try {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection('complaints') // Replace with your collection name
//           .doc(complaintId)
//           .get();
//
//       if (snapshot.exists) {
//         return snapshot.data() as Map<String, dynamic>;
//       } else {
//         print('No such document!');
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching complaint details: $e');
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Complaint Details', style: TextStyle(color: Color(0xFF055B5C))),
//         backgroundColor: Color(0xFFCCABD8).withOpacity(0.8),
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh, color: Color(0xFF055B5C)),
//             onPressed: () {
//               // Refresh logic here
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<Map<String, dynamic>?>(
//         future: fetchComplaintDetails(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('No complaint details available.'));
//           }
//
//           final complaintData = snapshot.data!;
//           final imageUrls = List<String>.from(complaintData['imageUrls'] ?? []);
//           final videoUrls = List<String>.from(complaintData['videoUrls'] ?? []);
//           final description = complaintData['description'] ?? 'N/A';
//
//           // Fetching "Accepted by" and "Completed by" with null safety
//           final acceptedBy = (complaintData['acceptedDetails']?[0]['acceptedByUserName'] ?? 'N/A');
//           final completedBy = (complaintData['completedDetails']?[0]['completedByUserName'] ?? 'N/A');
//
//           // Fetching timestamps with null safety
//           final acceptedAt = complaintData['acceptedDetails']?[0]['acceptedAt']?.toDate();
//           final completedAt = complaintData['completedDetails']?[0]['completedAt']?.toDate();
//
//           // Fetch the status from Firestore
//           final status = complaintData['status'] ?? 'Unknown'; // Default to 'Unknown' if status is missing
//
//           final isCompleted = status == 'Completed';
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (imageUrls.isNotEmpty || videoUrls.isNotEmpty)
//                   _buildMediaSlider(imageUrls, videoUrls),
//                 SizedBox(height: 16),
//                 _buildGlassContainer(
//                   child: _buildInfoBox('Description', description),
//                 ),
//                 SizedBox(height: 16),
//                 _buildGlassContainer(
//                   child: _buildInfoBox('Accepted by', acceptedBy), // Displaying "Accepted by"
//                 ),
//                 _buildGlassContainer(
//                   child: _buildInfoBox('Accepted At', _formatDateTime(acceptedAt)), // Displaying "Accepted At"
//                 ),
//                 SizedBox(height: 16),
//                 _buildGlassContainer(
//                   child: _buildInfoBox('Completed by', completedBy), // Displaying "Completed by"
//                 ),
//                 _buildGlassContainer(
//                   child: _buildInfoBox('Completed At', _formatDateTime(completedAt)), // Displaying "Completed At"
//                 ),
//                 SizedBox(height: 16),
//                 _buildGlassContainer(
//                   child: _buildInfoBox('Status', status), // Displaying the fetched status
//                 ),
//                 SizedBox(height: 16),
//                 if (isCompleted)
//                   ElevatedButton(
//                     onPressed: () {
//                       // Close query logic here
//                     },
//                     child: Text('Close Query'),
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: Color(0xFF08979D),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 12.0),
//                     ),
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//
//
//   // Helper method for glassy containers
//   Widget _buildGlassContainer({required Widget child}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Color(0xFFFFFFFF).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 8,
//           ),
//         ],
//         border: Border.all(
//           color: Color(0xFFCCABD8).withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: child,
//     );
//   }
//
//   // Helper method for info boxes
//   Widget _buildInfoBox(String title, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           '$title:',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF055B5C),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.end,
//             style: TextStyle(
//               color: Color(0xFF08979D),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   String _formatDateTime(DateTime? dateTime) {
//     if (dateTime == null) return 'N/A';
//     return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
//   }
//
//   Widget _buildMediaSlider(List<String> imageUrls, List<String> videoUrls) {
//     final mediaUrls = [...imageUrls, ...videoUrls];
//     return Container(
//       height: 250,
//       child: PageView.builder(
//         itemCount: mediaUrls.length,
//         itemBuilder: (context, index) {
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
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FullScreenVideoScreen(videoUrl: mediaUrl),
//                   ),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: VideoPlayerWidget(videoUrl: mediaUrl),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
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
//
//
// }
//
//
//
// // hello
//
//
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

//  new accept and complete all details

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_player/video_player.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final String complaintId;
  final List<String> imageUrls;
  final List<String> videoUrls;
  final String description;
  final String acceptedBy;
  final String completedBy;
  final String acceptedByEmail;
  final DateTime? acceptedTimestamp;
  final String completedByEmail;
  final DateTime? completedTimestamp;

  const ComplaintDetailScreen({
    required this.complaintId,
    required this.imageUrls,
    required this.videoUrls,
    required this.description,
    required this.acceptedBy,
    required this.completedBy,
    required this.acceptedByEmail,
    required this.acceptedTimestamp,
    required this.completedByEmail,
    required this.completedTimestamp,
  });

  Future<Map<String, dynamic>?> fetchComplaintDetails() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('complaints') // Replace with your collection name
          .doc(complaintId)
          .get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        print('No such document!');
        return null;
      }
    } catch (e) {
      print('Error fetching complaint details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Complaint Details', style: TextStyle(color: Color(0xFF055B5C))),
        backgroundColor: Color(0xFFCCABD8).withOpacity(0.8),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Color(0xFF055B5C)),
            onPressed: () {
              // Refresh logic here
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchComplaintDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No complaint details available.'));
          }

          final complaintData = snapshot.data!;
          final imageUrls = List<String>.from(complaintData['imageUrls'] ?? []);
          final videoUrls = List<String>.from(complaintData['videoUrls'] ?? []);
          final description = complaintData['description'] ?? 'N/A';

          // Fetching "Accepted by" and "Completed by" with null safety
          final acceptedDetails = List<Map<String, dynamic>>.from(
              complaintData['acceptedDetails'] ?? []);
          final completedDetails = List<Map<String, dynamic>>.from(
              complaintData['completedDetails'] ?? []);

          // Fetch the status from Firestore
          final status = complaintData['status'] ?? 'Unknown'; // Default to 'Unknown' if status is missing
          final isCompleted = status == 'Completed';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageUrls.isNotEmpty || videoUrls.isNotEmpty)
                  _buildMediaSlider(imageUrls, videoUrls),
                SizedBox(height: 16),
                _buildGlassContainer(
                  child: _buildInfoBox('Description', description),
                ),
                SizedBox(height: 16),
                _buildGlassContainer(
                  child: _buildInfoBox('Status', status), // Displaying the fetched status
                ),
                SizedBox(height: 16),
                if (acceptedDetails.isNotEmpty)
                  _buildDetailsSection('Accepted Details', acceptedDetails, 'acceptedByUserName', 'acceptedAt', 'acceptedRole'),
                SizedBox(height: 16),
                if (completedDetails.isNotEmpty)
                  _buildDetailsSection('Completed Details', completedDetails, 'completedByUserName', 'completedAt', 'completedRole'),
                SizedBox(height: 16),
                if (isCompleted)
                  ElevatedButton(
                    onPressed: () {
                      // Close query logic here
                    },
                    child: Text('Close Query'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF08979D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailsSection(String title, List<Map<String, dynamic>> details, String userField, String dateField, String roleField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF055B5C),
          ),
        ),
        SizedBox(height: 8),
        Column(
          children: details.map((detail) {
            final userName = detail[userField] ?? 'N/A';
            final date = detail[dateField]?.toDate() ?? null;
            final role = detail[roleField] ?? 'N/A';
            return _buildGlassContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Role: $role',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF08979D),
                    ),
                  ),
                  _buildInfoBox('User', userName),
                  _buildInfoBox('Date', _formatDateTime(date)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Helper method for glassy containers
  Widget _buildGlassContainer({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
        border: Border.all(
          color: Color(0xFFCCABD8).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: child,
    );
  }

  // Helper method for info boxes
  Widget _buildInfoBox(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF055B5C),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Color(0xFF08979D),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }

  Widget _buildMediaSlider(List<String> imageUrls, List<String> videoUrls) {
    final mediaUrls = [...imageUrls, ...videoUrls];
    return Container(
      height: 250,
      child: PageView.builder(
        itemCount: mediaUrls.length,
        itemBuilder: (context, index) {
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenVideoScreen(videoUrl: mediaUrl),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: VideoPlayerWidget(videoUrl: mediaUrl),
              ),
            );
          }
        },
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: InteractiveViewer(
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}



// hello



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
