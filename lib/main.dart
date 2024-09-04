// import 'package:complaint_management_sys/user_scr_list_details/labor_scr_1_v2.dart';
// import 'package:complaint_management_sys/labor_screen1.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:complaint_management_sys/signup_v2.dart';
// import 'package:flutter/material.dart';
// import 'SignUpScreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'auth/SignUp_V3.dart';
// import 'firebase_options.dart';
// import 'heads/HVAC_head.dart';
// import 'heads/electrical_head.dart';
// import 'heads/head_complain_scr_V1.dart';
// import 'heads/mechanical_head.dart';
// import 'heads/utility_head.dart';
// import 'list/list_screen.dart';
// import 'login_v2.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Center(
//                 child: Image(
//                   image: AssetImage("assets/loginLogo.png"),
//                   height: 300,
//                   width: 300,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'email',
//                     hintStyle: TextStyle(color: Color(0xffCACACA)),
//                     fillColor: Colors.grey[50],
//                     filled: true,
//                     prefixIcon: const Icon(
//                       Icons.mail_outline_outlined,
//                       color: Color(0xffCACACA),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Color(0xff0061FF)),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Color(0xffCACACA)),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 13),
//               Row(
//                 children: [
//                   Flexible(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           hintText: 'password',
//                           hintStyle: const TextStyle(color: Color(0xffCACACA)),
//                           fillColor: Colors.grey[50],
//                           filled: true,
//                           prefixIcon: const Icon(
//                             Icons.lock_outline,
//                             color: Color(0xffCACACA),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Color(0xff0061FF)),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Color(0xffCACACA)),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
//                     child: Container(
//                       height: 60,
//                       width: 65,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(17),
//                         border: Border.all(color: Color(0xffCACACA)),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios_outlined,
//                         size: 29.83,
//                         color: Color(0xffCACACA),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 13),
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
//                     child: Text(
//                       'Or continue with',
//                       style: TextStyle(fontSize: 20, color: Color(0xff9D9C9C)),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 0, 25, 0),
//                       child: Divider(
//                         thickness: 1,
//                         color: Color(0xff9D9C9C),
//                         height: 15,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Container(
//                 height: 45,
//                 width: 164,
//                 decoration: BoxDecoration(
//                   color: Color(0xffF6F5F5),
//                   borderRadius: BorderRadius.circular(7),
//                   border: Border.all(color: Color(0xffDADADA)),
//                 ),
//                 child: Center(
//                   child: Image(
//                     image: AssetImage("assets/google.png"),
//                     width: 31,
//                     height: 31,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 21),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 139,
//                     decoration: BoxDecoration(
//                       color: Color(0xff0366FF),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(7),
//                         bottomLeft: Radius.circular(7),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Log in",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignUpScreen()),
//                       );
//                     },
//                     child: Container(
//                       height: 40,
//                       width: 139,
//                       decoration: BoxDecoration(
//                         color: Color(0xffF6F5F5),
//                         borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(7),
//                           topRight: Radius.circular(7),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Sign up",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//



//FCM foreground and background message
// import 'package:complaint_management_sys/user_scr_list_details/labor_scr_1_v2.dart';
// import 'package:complaint_management_sys/labor_screen1.dart';
// import 'package:complaint_management_sys/profile.dart';
// import 'package:complaint_management_sys/signup_v2.dart';
// import 'package:flutter/material.dart';
// import 'SignUpScreen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'auth/SignUp_V3.dart';
// import 'firebase_options.dart';
// import 'heads/HVAC_head.dart';
// import 'heads/electrical_head.dart';
// import 'heads/head_complain_scr_V1.dart';
// import 'heads/mechanical_head.dart';
// import 'heads/utility_head.dart';
// import 'list/list_screen.dart';
// import 'login_v2.dart';
//
// // Handle background messages
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
//   // You can perform any specific action here based on the message data.
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   // Initialize Firebase Messaging
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   // Request permission on iOS
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   print('User granted permission: ${settings.authorizationStatus}');
//
//   // Handle foreground messages
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('Got a message while in the foreground!');
//     print('Message data: ${message.data}');
//
//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//       // You can display a notification or update the UI based on the message data.
//     }
//   });
//
//   // Handle background messages
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Center(
//                 child: Image(
//                   image: AssetImage("assets/loginLogo.png"),
//                   height: 300,
//                   width: 300,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(25.0, 0, 25, 0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     hintText: 'email',
//                     hintStyle: TextStyle(color: Color(0xffCACACA)),
//                     fillColor: Colors.grey[50],
//                     filled: true,
//                     prefixIcon: const Icon(
//                       Icons.mail_outline_outlined,
//                       color: Color(0xffCACACA),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Color(0xff0061FF)),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Color(0xffCACACA)),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 13),
//               Row(
//                 children: [
//                   Flexible(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           hintText: 'password',
//                           hintStyle: const TextStyle(color: Color(0xffCACACA)),
//                           fillColor: Colors.grey[50],
//                           filled: true,
//                           prefixIcon: const Icon(
//                             Icons.lock_outline,
//                             color: Color(0xffCACACA),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Color(0xff0061FF)),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(color: Color(0xffCACACA)),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
//                     child: Container(
//                       height: 60,
//                       width: 65,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(17),
//                         border: Border.all(color: Color(0xffCACACA)),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios_outlined,
//                         size: 29.83,
//                         color: Color(0xffCACACA),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 13),
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
//                     child: Text(
//                       'Or continue with',
//                       style: TextStyle(fontSize: 20, color: Color(0xff9D9C9C)),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 0, 25, 0),
//                       child: Divider(
//                         thickness: 1,
//                         color: Color(0xff9D9C9C),
//                         height: 15,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Container(
//                 height: 45,
//                 width: 164,
//                 decoration: BoxDecoration(
//                   color: Color(0xffF6F5F5),
//                   borderRadius: BorderRadius.circular(7),
//                   border: Border.all(color: Color(0xffDADADA)),
//                 ),
//                 child: Center(
//                   child: Image(
//                     image: AssetImage("assets/google.png"),
//                     width: 31,
//                     height: 31,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 21),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 139,
//                     decoration: BoxDecoration(
//                       color: Color(0xff0366FF),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(7),
//                         bottomLeft: Radius.circular(7),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Log in",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignUpScreen()),
//                       );
//                     },
//                     child: Container(
//                       height: 40,
//                       width: 139,
//                       decoration: BoxDecoration(
//                         color: Color(0xffF6F5F5),
//                         borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(7),
//                           topRight: Radius.circular(7),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Sign up",
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'login_v2.dart';
import 'firebase_options.dart';
import 'auth/SignUp_V3.dart';
import 'heads/HVAC_head.dart';
import 'heads/electrical_head.dart';
import 'heads/head_complain_scr_V1.dart';
import 'heads/mechanical_head.dart';
import 'heads/utility_head.dart';
import 'list/list_screen.dart';
import 'profile.dart';
import 'signup_v2.dart';
import 'SignUpScreen.dart';
import 'user_scr_list_details/labor_scr_1_v2.dart';
import 'labor_screen1.dart';

// Handle background messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission on iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
            icon: 'launch_background',
          ),
        ),
      );
    }
  });

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize flutter_local_notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
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
              SizedBox(height: 13),
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
              SizedBox(height: 13),
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
              SizedBox(height: 20),
              Container(
                height: 45,
                width: 164,
                decoration: BoxDecoration(
                  color: Color(0xffF6F5F5),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Color(0xffDADADA)),
                ),
                child: Center(
                  child: Image(
                    image: AssetImage("assets/google.png"),
                    width: 31,
                    height: 31,
                  ),
                ),
              ),
              SizedBox(height: 21),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 139,
                    decoration: BoxDecoration(
                      color: Color(0xff0366FF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 139,
                      decoration: BoxDecoration(
                        color: Color(0xffF6F5F5),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
