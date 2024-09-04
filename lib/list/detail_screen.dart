//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DetailScreen extends StatelessWidget {
//   final String imageUrl;
//   final String description;
//
//   DetailScreen({required this.imageUrl, required this.description});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(  backgroundColor: Colors.blue.shade100,
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
//               imageUrl.isNotEmpty
//                   ? Image.network(imageUrl, height: 200, fit: BoxFit.cover)
//                   : Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Icon(Icons.image, size: 100, color: Colors.white),
//               ),
//               SizedBox(height: 16),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Text(
//                   description,
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// zoom feature

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DetailScreen extends StatelessWidget {
//   final String imageUrl;
//   final String description;
//
//   DetailScreen({required this.imageUrl, required this.description});
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
//                 child: Text(
//                   description,
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//accepted description
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String acceptedBy;
  final String completedBy;
  final String acceptedByEmail;
  final DateTime? acceptedTimestamp;
  final String completedByEmail;
  final DateTime? completedTimestamp;

  DetailScreen({
    required this.imageUrl,
    required this.description,
    required this.acceptedBy,
    required this.completedBy,
    required this.acceptedByEmail,
    this.acceptedTimestamp,
    required this.completedByEmail,
    this.completedTimestamp,
  });

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

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "N/A";
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          color: Colors.blue.shade100,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (imageUrl.isNotEmpty) {
                    _showFullScreenImage(context, imageUrl);
                  }
                },
                child: imageUrl.isNotEmpty
                    ? Image.network(imageUrl, height: 200, fit: BoxFit.cover)
                    : Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.image, size: 100, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: 16),
                    Divider(color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "Accepted by: $acceptedBy",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Text(
                      "Accepted by email: $acceptedByEmail",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Text(
                      "Accepted on: ${_formatDateTime(acceptedTimestamp)}",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Completed by: $completedBy",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Text(
                      "Completed by email: $completedByEmail",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    Text(
                      "Completed on: ${_formatDateTime(completedTimestamp)}",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
