  // import 'package:cloud_firestore/cloud_firestore.dart';
  // import 'package:complaint_management_sys/labor_screen1.dart';
  // import 'package:flutter/material.dart';
  // import 'package:flutter/widgets.dart';
  //
  // import 'heads/head_complain_scr_V1.dart';
  // import 'heads/head_complain_screen.dart';
  // import 'labor_screen_1_v1.dart';
  //
  // class LaborScreen2 extends StatefulWidget {
  //   const LaborScreen2({super.key,required this.docref});
  //   final DocumentReference docref;
  //   @override
  //   State<LaborScreen2> createState() => _LaborScreen2State();
  // }
  //
  // class _LaborScreen2State extends State<LaborScreen2> {
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       backgroundColor: Color(0xffB8D0F8),
  //       body: Center(
  //           child: SafeArea(
  //         child: Center(
  //           child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [SizedBox(height: 250,),
  //                 Center(
  //                     child: Text(
  //                   'Complaint has been recorded',textAlign: TextAlign.center,
  //                   style: TextStyle(fontSize: 30),
  //                 )),
  //                 SizedBox(
  //                   height: 200,
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     Navigator.pop(
  //                         context,
  //                     );
  //                   },
  //                   child: Container(
  //                     width: 312,
  //                     decoration: BoxDecoration(
  //                       color: Color(0xff0366FF),
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                     child: Center(
  //                       child: const Row(
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.all(8.0),
  //                             child: Text(
  //                               "Generate Another Report",
  //                               style: TextStyle(
  //                                   fontSize: 19,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.white),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
  //                             child: Image(
  //                               image: AssetImage("assets/submit.png"),
  //                               height: 60,
  //                               width: 60,
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ]),
  //         ),
  //       )),
  //     );
  //   }
  // }
  //
  //
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';

  class LaborScreen2 extends StatefulWidget {
    const LaborScreen2({super.key, required this.docref});
    final DocumentReference? docref; // Make it nullable

    @override
    State<LaborScreen2> createState() => _LaborScreen2State();
  }

  class _LaborScreen2State extends State<LaborScreen2> {
    @override
    Widget build(BuildContext context) {
      if (widget.docref == null) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('No Document Reference'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Back button functionality
              },
            ),
          ),
          body: const Center(
            child: Text('No document reference provided.'),
          ),
        );
      }

      return Scaffold(
        backgroundColor: const Color(0xffB8D0F8),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Back button functionality
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 250),
                  const Center(
                    child: Text(
                      'Complaint has been recorded',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 200),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 312,
                      decoration: BoxDecoration(
                        color: const Color(0xff0366FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Generate Another Report",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Image(
                                image: AssetImage("assets/submit.png"),
                                height: 60,
                                width: 60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
