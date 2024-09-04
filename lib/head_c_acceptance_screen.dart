import 'package:flutter/material.dart';

class acceptanceScreen extends StatefulWidget {
  const acceptanceScreen({super.key});

  @override
  State<acceptanceScreen> createState() => _acceptanceScreenState();
}

class _acceptanceScreenState extends State<acceptanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB8D0F8),
      body: Center(
          child: SafeArea(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [SizedBox(height: 250,),
                    Center(
                        child: Text(
                          'Complaint has been accepted',textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        )),
                    SizedBox(
                      height: 200,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 250,
                        decoration: BoxDecoration(
                          color: Color(0xff0366FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Somewhere it'll go",
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}
