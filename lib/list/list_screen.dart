// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// enum Feilds{
//   complaintCategory,
//   description,
//   imageUrl,
//   priority,
//   timestamp
// }
// class ListScreen extends StatelessWidget {
//    ListScreen({super.key});
//   final FirebaseFirestore fs=FirebaseFirestore.instance;
//   Future<List<QueryDocumentSnapshot>> getData()async {
//     QuerySnapshot qs=await fs.collection('complaints').get();
//     return qs.docs;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder(future: getData(), builder: (context,snapshot){
//           if(snapshot.connectionState!= ConnectionState.done&& snapshot.hasData){
//             return CircularProgressIndicator();
//           }
//
//          return ListView.builder(
//            itemCount: snapshot.data?.length,
//              itemBuilder: (context,index){
//            final item=snapshot.data?[index];
//
//
//            return ListTile(leading: Image.network(item?[Feilds.imageUrl.name]),
//              title: Text(item?[Feilds.description.name]??" No Category"),trailing: Text("${item?[Feilds.timestamp.name]}",));
//          }
//          );
//         }),
//       ),
//     );
//   }
// }



// //ok code
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'detail_screen.dart';
//
// enum Fields {
//   complaintCategory,
//   description,
//   imageUrl,
//   priority,
//   timestamp
// }
//
// class ListScreen extends StatelessWidget {
//   ListScreen({super.key});
//   final FirebaseFirestore fs = FirebaseFirestore.instance;
//
//   Future<List<QueryDocumentSnapshot>> getData() async {
//     QuerySnapshot qs = await fs.collection('complaints').get();
//     return qs.docs;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Problems list'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Center(
//         child: FutureBuilder<List<QueryDocumentSnapshot>>(
//           future: getData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState != ConnectionState.done) {
//               return CircularProgressIndicator();
//             }
//
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Text('No complaints found');
//             }
//
//             return ListView.builder(
//               itemCount: snapshot.data?.length,
//               itemBuilder: (context, index) {
//                 final item = snapshot.data?[index];
//                 final imageUrl = item?[Fields.imageUrl.name] ?? '';
//                 final description = item?[Fields.description.name] ?? 'No Description';
//                 final timestamp = item?[Fields.timestamp.name]?.toDate().toString() ?? 'No Timestamp';
//
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailScreen(
//                           imageUrl: imageUrl,
//                           description: description,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: NetworkImage(imageUrl),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 16.0),
//                         Expanded(
//                           child: Text(
//                             description,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         SizedBox(width: 16.0),
//                         Icon(Icons.arrow_forward_ios),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       backgroundColor: Colors.blue.shade100,
//     );
//   }
// }




//missing handel
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../login_v2.dart';
// import 'detail_screen.dart';
//
// class ListScreen extends StatefulWidget {
//   @override
//   _ListScreenState createState() => _ListScreenState();
// }
//
// class _ListScreenState extends State<ListScreen> {
//   final FirebaseFirestore fs = FirebaseFirestore.instance;
//
//   Future<List<QueryDocumentSnapshot>> getData() async {
//     try {
//       QuerySnapshot qs = await fs.collection('complaints').get();
//       return qs.docs;
//     } catch (e) {
//       print('Error fetching complaints: $e');
//       return [];
//     }
//   }
//
//   Future<void> _logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//           (Route<dynamic> route) => false,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Problems List'),
//         backgroundColor: Colors.blue,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _logout,
//           ),
//         ],
//       ),
//       body: Center(
//         child: FutureBuilder<List<QueryDocumentSnapshot>>(
//           future: getData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState != ConnectionState.done) {
//               return CircularProgressIndicator();
//             }
//
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Text('No complaints found');
//             }
//
//             // Filter out documents with missing or empty fields
//             final filteredData = snapshot.data!.where((doc) {
//               final data = doc.data() as Map<String, dynamic>?;
//               final imageUrl = data?['imageUrl'] ?? '';
//               final description = data?['description'] ?? '';
//               final acceptedBy = data?['acceptedBy'] ?? 'In Progress';
//               final completedBy = data?['completedBy'] ?? 'In Progress';
//
//               return imageUrl.isNotEmpty && description.isNotEmpty;
//             }).toList();
//
//             if (filteredData.isEmpty) {
//               return Text('No complaints found with valid data');
//             }
//
//             return ListView.builder(
//               itemCount: filteredData.length,
//               itemBuilder: (context, index) {
//                 final item = filteredData[index];
//                 final data = item.data() as Map<String, dynamic>?;
//
//                 final imageUrl = data?['imageUrl'] ?? '';
//                 final description = data?['description'] ?? 'No Description';
//                 final acceptedBy = data?['acceptedBy'] ?? 'In Progress';
//                 final completedBy = data?['completedBy'] ?? 'In Progress';
//                 final acceptedByEmail = data?['acceptedByEmail'] ?? 'No email provided';
//                 final completedByEmail = data?['completedByEmail'] ?? 'No email provided';
//                 final acceptedTimestamp = (data?['acceptedAt'] as Timestamp?)?.toDate();
//                 final completedTimestamp = (data?['completedAt'] as Timestamp?)?.toDate();
//
//                 // Determine task status and color
//                 final isCompleted = completedBy != 'In Progress';
//                 final statusColor = isCompleted ? Colors.green : Colors.red;
//
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DetailScreen(
//                           imageUrl: imageUrl,
//                           description: description,
//                           acceptedBy: acceptedBy,
//                           completedBy: completedBy,
//                           acceptedByEmail: acceptedByEmail,
//                           acceptedTimestamp: acceptedTimestamp,
//                           completedByEmail: completedByEmail,
//                           completedTimestamp: completedTimestamp,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     padding: EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8.0),
//                             image: DecorationImage(
//                               image: NetworkImage(imageUrl),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 10.0),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 description,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Text(
//                                     isCompleted ? 'Completed' : 'In Progress',
//                                     style: TextStyle(fontSize: 12, color: statusColor),
//                                   ),
//                                   SizedBox(width: 4),
//                                   CircleAvatar(
//                                     radius: 5,
//                                     backgroundColor: statusColor,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 10.0),
//                         Container(
//                           width: 50,
//                           height: 50,
//                           child: Icon(Icons.chevron_right, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       backgroundColor: Colors.blue.shade100,
//     );
//   }
// }


// UI update only

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../login_v2.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final FirebaseFirestore fs = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot>> getData() async {
    try {
      QuerySnapshot qs = await fs.collection('complaints').get();
      return qs.docs;
    } catch (e) {
      print('Error fetching complaints: $e');
      return [];
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Problems List'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No complaints found');
            }

            final filteredData = snapshot.data!.where((doc) {
              final data = doc.data() as Map<String, dynamic>?;

              final imageUrl = data?['imageUrl'] ?? '';
              final description = data?['description'] ?? '';
              final acceptedBy = data?['acceptedBy'] ?? 'In Progress';
              final completedBy = data?['completedBy'] ?? 'In Progress';

              return imageUrl.isNotEmpty && description.isNotEmpty;
            }).toList();

            if (filteredData.isEmpty) {
              return Text('No complaints found with valid data');
            }

            return ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                final data = item.data() as Map<String, dynamic>?;

                final imageUrl = data?['imageUrl'] ?? '';
                final description = data?['description'] ?? 'No Description';
                final acceptedBy = data?['acceptedBy'] ?? 'In Progress';
                final completedBy = data?['completedBy'] ?? 'In Progress';
                final acceptedByEmail = data?['acceptedByEmail'] ?? 'No email provided';
                final completedByEmail = data?['completedByEmail'] ?? 'No email provided';
                final acceptedTimestamp = (data?['acceptedAt'] as Timestamp?)?.toDate();
                final completedTimestamp = (data?['completedAt'] as Timestamp?)?.toDate();

                final isCompleted = completedBy != 'In Progress';
                final statusColor = isCompleted ? Colors.green : Colors.red;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          imageUrl: imageUrl,
                          description: description,
                          acceptedBy: acceptedBy,
                          completedBy: completedBy,
                          acceptedByEmail: acceptedByEmail,
                          acceptedTimestamp: acceptedTimestamp,
                          completedByEmail: completedByEmail,
                          completedTimestamp: completedTimestamp,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    isCompleted ? 'Completed' : 'In Progress',
                                    style: TextStyle(fontSize: 12, color: statusColor),
                                  ),
                                  SizedBox(width: 4),
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: statusColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Container(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.chevron_right, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      backgroundColor: Colors.blue.shade100,
    );
  }
}
