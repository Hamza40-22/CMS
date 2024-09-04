import 'package:flutter/material.dart';

import 'labor_screen1.dart';

class rejectionScreen extends StatefulWidget {
  const rejectionScreen({super.key});

  @override
  State<rejectionScreen> createState() => _rejectionScreenState();
}

class _rejectionScreenState extends State<rejectionScreen> {
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
                  children: [


                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 247,
                      width: 309,
                      child: Container(
                        height: double.infinity,
                        child: TextField(
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: 'Type your rejection description here...',
                            hintStyle: TextStyle(color: Color(0xffCACACA)),
                            fillColor: Colors.grey[50],
                            filled: true,
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Color(0xffCACACA),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff0061FF)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffCACACA)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        print('will go to DB');
                      },
                      child: Container(
                        width: 150,
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
                                  "Submit",
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
