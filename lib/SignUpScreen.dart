// lib/SignUpScreen.dart

import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Image(
                  image: AssetImage("assets/loginLogo.png"),
                  height: 300,
                  width: 300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'email',
                    hintStyle: TextStyle(color: Color(0xffCACACA)),
                    fillColor: Colors.grey[50],
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.mail_outline_outlined,
                      color: Color(0xffCACACA),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff0061FF)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xffCACACA)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'password',
                          hintStyle: const TextStyle(color: Color(0xffCACACA)),
                          fillColor: Colors.grey[50],
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xffCACACA),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xff0061FF)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xffCACACA)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Container(
                      height: 60,
                      width: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(color: Color(0xffCACACA)),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 29.83,
                        color: Color(0xffCACACA),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(fontSize: 20, color: Color(0xff9D9C9C)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 25, 0),
                      child: Divider(
                        thickness: 1,
                        color: Color(0xff9D9C9C),
                        height: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                width: 164,
                decoration: BoxDecoration(
                    color: Color(0xffF6F5F5),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Color(0xffDADADA))),
                child: Center(
                    child: Image(
                      image: AssetImage("assets/google.png"),
                      width: 31,
                      height: 31,
                    )),
              ),
              SizedBox(
                height: 21,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.pop(context);
                    } ,
                    child: Container(
                      height: 40,
                      width: 139,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F5F5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 139,
                    decoration: BoxDecoration(
                      color: Color(0xff0366FF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
