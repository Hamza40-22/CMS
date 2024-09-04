
//new list details
//   import 'package:cloud_firestore/cloud_firestore.dart';
//   import 'package:flutter/material.dart';
//   import 'package:intl/intl.dart';
//  
//   class ComplaintDetailScreen extends StatefulWidget {
//     final String complaintId;
//     final List<String> imageUrls; // Update to accept multiple image URLs
//     final String description;
//     final String acceptedBy;
//     final String completedBy;
//     final String acceptedByEmail;
//     final DateTime? acceptedTimestamp;
//     final String completedByEmail;
//     final DateTime? completedTimestamp;
//  
//     ComplaintDetailScreen({
//       required this.complaintId,
//       required this.imageUrls,
//       required this.description,
//       required this.acceptedBy,
//       required this.completedBy,
//       required this.acceptedByEmail,
//       this.acceptedTimestamp,
//       required this.completedByEmail,
//       this.completedTimestamp,
//     });
//  
//     @override
//     _ComplaintDetailScreenState createState() => _ComplaintDetailScreenState();
//   }
//  
//   class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
//     bool _queryClosed = false;
//     String? _status; // Field to store the status
//  
//     @override
//     void initState() {
//       super.initState();
//       _fetchComplaintData();
//     }
//  
//     Future<void> _fetchComplaintData() async {
//       final complaintDoc = FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId);
//       final snapshot = await complaintDoc.get();
//       final data = snapshot.data();
//  
//       setState(() {
//         _queryClosed = data?['queryClosed'] ?? false;
//         _status = data?['status']; // Fetching the status field from Firestore
//       });
//     }
//  
//     Future<void> _closeQuery() async {
//       final complaintDoc = FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId);
//       await complaintDoc.update({
//         'queryClosed': true,
//         'queryClosedAt': Timestamp.now(),
//       });
//       setState(() {
//         _queryClosed = true;
//       });
//     }
//  
//     String _formatDateTime(DateTime? dateTime) {
//       if (dateTime == null) return "N/A";
//       return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
//     }
//  
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Complaint Details'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.refresh),
//               onPressed: _fetchComplaintData,
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (widget.imageUrls.isNotEmpty)
//                 _buildImageSlider(widget.imageUrls) // Use the image slider
//               else
//                 Container(
//                   height: 250,
//                   width: double.infinity,
//                   color: Colors.grey.shade300,
//                   child: Icon(Icons.image, size: 100, color: Colors.grey.shade600),
//                 ),
//               SizedBox(height: 16),
//               _buildInfoBox('Description', widget.description),
//               SizedBox(height: 16),
//               _buildInfoBox('Accepted by', widget.acceptedBy),
//               _buildInfoBox('Accepted Email', widget.acceptedByEmail),
//               _buildInfoBox('Accepted At', _formatDateTime(widget.acceptedTimestamp)),
//               SizedBox(height: 16),
//               _buildInfoBox('Completed by', widget.completedBy),
//               _buildInfoBox('Completed Email', widget.completedByEmail),
//               _buildInfoBox('Completed At', _formatDateTime(widget.completedTimestamp)),
//               SizedBox(height: 16),
//               if (_status != null) // Display status if available
//                 _buildInfoBox('Status', _status!),
//               SizedBox(height: 16),
//               if (widget.completedBy != 'In Progress' && !_queryClosed)
//                 ElevatedButton(
//                   onPressed: _closeQuery,
//                   child: Text('Close Query'),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: 12.0),
//                   ),
//                 ),
//               if (_queryClosed)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'The Query has been closed at ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now())}',
//                     style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       );
//     }
//  
//     Widget _buildImageSlider(List<String> imageUrls) {
//       return Container(
//         height: 250,
//         child: PageView.builder(
//           itemCount: imageUrls.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 _showFullScreenImage(context, imageUrls[index]);
//               },
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12.0),
//                 child: Image.network(
//                   imageUrls[index],
//                   height: 250,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//  
//     void _showFullScreenImage(BuildContext context, String imageUrl) {
//       showDialog(
//         context: context,
//         builder: (context) => Dialog(
//           backgroundColor: Colors.transparent,
//           child: InteractiveViewer(
//             child: Image.network(imageUrl, fit: BoxFit.contain),
//           ),
//         ),
//       );
//     }
//  
//     Widget _buildInfoBox(String label, String value) {
//       return Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8.0,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             Expanded(
//               child: Text(
//                 value,
//                 textAlign: TextAlign.right,
//                 style: TextStyle(color: Colors.black54),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//  


//
// // include video and images
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:video_player/video_player.dart';
//
// import '../VideoPlayerWidget.dart';
//
// class ComplaintDetailScreen extends StatefulWidget {
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
//   ComplaintDetailScreen({
//     required this.complaintId,
//     required this.imageUrls,
//     required this.videoUrls,
//     required this.description,
//     required this.acceptedBy,
//     required this.completedBy,
//     required this.acceptedByEmail,
//     this.acceptedTimestamp,
//     required this.completedByEmail,
//     this.completedTimestamp,
//   });
//
//   @override
//   _ComplaintDetailScreenState createState() => _ComplaintDetailScreenState();
// }
//
// class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
//   bool _queryClosed = false;
//   String? _status;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchComplaintData();
//   }
//
//   Future<void> _fetchComplaintData() async {
//     final complaintDoc = FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId);
//     final snapshot = await complaintDoc.get();
//     final data = snapshot.data();
//
//     setState(() {
//       _queryClosed = data?['queryClosed'] ?? false;
//       _status = data?['status'];
//     });
//   }
//
//   Future<void> _closeQuery() async {
//     final complaintDoc = FirebaseFirestore.instance.collection('complaints').doc(widget.complaintId);
//     await complaintDoc.update({
//       'queryClosed': true,
//       'queryClosedAt': Timestamp.now(),
//     });
//     setState(() {
//       _queryClosed = true;
//     });
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
//       appBar: AppBar(
//         title: Text('Complaint Details'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: _fetchComplaintData,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (widget.imageUrls.isNotEmpty || widget.videoUrls.isNotEmpty)
//               _buildMediaSlider(widget.imageUrls, widget.videoUrls)
//             else
//               Container(
//                 height: 250,
//                 width: double.infinity,
//                 color: Colors.grey.shade300,
//                 child: Icon(Icons.image, size: 100, color: Colors.grey.shade600),
//               ),
//             SizedBox(height: 16),
//             _buildInfoBox('Description', widget.description),
//             SizedBox(height: 16),
//             _buildInfoBox('Accepted by', widget.acceptedBy),
//             _buildInfoBox('Accepted Email', widget.acceptedByEmail),
//             _buildInfoBox('Accepted At', _formatDateTime(widget.acceptedTimestamp)),
//             SizedBox(height: 16),
//             _buildInfoBox('Completed by', widget.completedBy),
//             _buildInfoBox('Completed Email', widget.completedByEmail),
//             _buildInfoBox('Completed At', _formatDateTime(widget.completedTimestamp)),
//             SizedBox(height: 16),
//             if (_status != null)
//               _buildInfoBox('Status', _status!),
//             SizedBox(height: 16),
//             if (widget.completedBy != 'In Progress' && !_queryClosed)
//               ElevatedButton(
//                 onPressed: _closeQuery,
//                 child: Text('Close Query'),
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white, backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12.0),
//                 ),
//               ),
//             if (_queryClosed)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'The Query has been closed at ${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now())}',
//                   style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
//           final url = mediaUrls[index];
//           final isVideo = videoUrls.contains(url);
//           return GestureDetector(
//             onTap: () {
//               if (isVideo) {
//                 _showFullScreenVideo(context, url);
//               } else {
//                 _showFullScreenImage(context, url);
//               }
//             },
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12.0),
//               child: isVideo
//                   ? VideoPlayerWidget(videoUrl: url)
//                   : Image.network(
//                 url,
//                 height: 250,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//         },
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
//
//   void _showFullScreenVideo(BuildContext context, String videoUrl) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.transparent,
//         child: FullScreenVideoScreen(videoUrl: videoUrl),
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
// }
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
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {
//           _isPlaying = _controller.value.isPlaying;
//         });
//       });
//     _controller.addListener(() {
//       setState(() {
//         _isPlaying = _controller.value.isPlaying;
//       });
//     });
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
//   @override
//   Widget build(BuildContext context) {
//     return _controller.value.isInitialized
//         ? GestureDetector(
//       onTap: _togglePlayPause,
//       onDoubleTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => FullScreenVideoScreen(videoUrl: widget.videoUrl),
//           ),
//         );
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           ),
//           if (!_isPlaying)
//             Icon(
//               Icons.play_arrow,
//               color: Colors.white,
//               size: 64.0,
//             ),
//         ],
//       ),
//     )
//         : Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }
//
//
//
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
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
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
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.close),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }




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

  @override
  Widget build(BuildContext context) {
    final isCompleted = completedBy != 'In Progress';
    final statusColor = isCompleted ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh logic here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrls.isNotEmpty || videoUrls.isNotEmpty)
              _buildMediaSlider(imageUrls, videoUrls),
            SizedBox(height: 16),
            _buildInfoBox('Description', description),
            SizedBox(height: 16),
            _buildInfoBox('Accepted by', acceptedBy),
            _buildInfoBox('Accepted Email', acceptedByEmail),
            _buildInfoBox('Accepted At', _formatDateTime(acceptedTimestamp)),
            SizedBox(height: 16),
            _buildInfoBox('Completed by', completedBy),
            _buildInfoBox('Completed Email', completedByEmail),
            _buildInfoBox('Completed At', _formatDateTime(completedTimestamp)),
            SizedBox(height: 16),
            if (isCompleted)
              _buildInfoBox('Status', 'Completed'),
            if (!isCompleted)
              _buildInfoBox('Status', 'Pending'),
            SizedBox(height: 16),
            if (isCompleted)
              ElevatedButton(
                onPressed: () {
                  // Close query logic here
                },
                child: Text('Close Query'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
          ],
        ),
      ),
    );
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
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Not Available';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}

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
