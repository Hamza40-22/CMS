// // import 'package:complaint_management_sys/Utils/utils.dart';
// // import 'package:complaint_management_sys/login_v1.dart';
// // import 'package:complaint_management_sys/widgets/round_btn.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // import 'login_v2.dart';
// //
// // class SignupScrV1 extends StatefulWidget {
// //   const SignupScrV1({super.key});
// //
// //   @override
// //   State<SignupScrV1> createState() => _SignupScrV1State();
// // }
// //
// // class _SignupScrV1State extends State<SignupScrV1> {
// //   final emailController = TextEditingController();
// //   final passwordController = TextEditingController();
// //   final nameController = TextEditingController();
// //   final _formKey = GlobalKey<FormState>();
// //   bool loading = false;
// //   String selectedRole = 'user'; // Default role selection
// //
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     emailController.dispose();
// //     passwordController.dispose();
// //     nameController.dispose();
// //   }
// //
// //   void signup() {
// //     if (!_formKey.currentState!.validate()) return;
// //
// //     setState(() {
// //       loading = true;
// //     });
// //
// //     _auth
// //         .createUserWithEmailAndPassword(
// //         email: emailController.text.toString(),
// //         password: passwordController.text.toString())
// //         .then((value) {
// //       _firestore.collection('users').doc(value.user!.uid).set({
// //         'name': nameController.text.toString(),
// //         'email': emailController.text.toString(),
// //         'role': selectedRole
// //       }).then((_) {
// //         setState(() {
// //           loading = false;
// //         });
// //         Utils().toastmessage('Signup successful! Please login.');
// //         // No navigation, just show a message
// //       }).catchError((error) {
// //         Utils().toastmessage(error.toString());
// //         setState(() {
// //           loading = false;
// //         });
// //       });
// //     }).catchError((error) {
// //       Utils().toastmessage(error.toString());
// //       setState(() {
// //         loading = false;
// //       });
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 20),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Form(
// //                 key: _formKey,
// //                 child: Column(
// //                   children: [
// //                     TextFormField(
// //                       controller: nameController,
// //                       decoration: InputDecoration(
// //                         hintText: "Name",
// //                         prefixIcon: Icon(Icons.person_outline),
// //                       ),
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Enter Name';
// //                         } else {
// //                           return null;
// //                         }
// //                       },
// //                     ),
// //                     SizedBox(height: 10),
// //                     TextFormField(
// //                       controller: emailController,
// //                       decoration: InputDecoration(
// //                         hintText: "Email",
// //                         helperText: "Enter email e.g: hamza@gmail.com",
// //                         prefixIcon: Icon(Icons.mail_outline),
// //                       ),
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Enter Email';
// //                         } else {
// //                           return null;
// //                         }
// //                       },
// //                     ),
// //                     SizedBox(height: 10),
// //                     TextFormField(
// //                       controller: passwordController,
// //                       obscureText: true,
// //                       decoration: InputDecoration(
// //                         hintText: "Password",
// //                         prefixIcon: Icon(Icons.lock_outline_rounded),
// //                       ),
// //                       validator: (value) {
// //                         if (value!.isEmpty) {
// //                           return 'Enter Password';
// //                         } else {
// //                           return null;
// //                         }
// //                       },
// //                     ),
// //                     SizedBox(height: 10),
// //                     Row(
// //                       children: [
// //                         Expanded(
// //                           child: ListTile(
// //                             title: const Text('User'),
// //                             leading: Radio<String>(
// //                               value: 'user',
// //                               groupValue: selectedRole,
// //                               onChanged: (String? value) {
// //                                 setState(() {
// //                                   selectedRole = value!;
// //                                 });
// //                               },
// //                             ),
// //                           ),
// //                         ),
// //                         Expanded(
// //                           child: ListTile(
// //                             title: const Text('Head'),
// //                             leading: Radio<String>(
// //                               value: 'head',
// //                               groupValue: selectedRole,
// //                               onChanged: (String? value) {
// //                                 setState(() {
// //                                   selectedRole = value!;
// //                                 });
// //                               },
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(height: 20),
// //               RoundButton(
// //                 loading: loading,
// //                 title: 'Sign Up',
// //                 onTap: signup,
// //               ),
// //               SizedBox(height: 30),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text("Have an account?"),
// //                   TextButton(
// //                     onPressed: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => LoginScreen()),
// //                       );
// //                     },
// //                     child: Text(
// //                       "Login",
// //                       style: TextStyle(color: Colors.lightBlue),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:complaint_management_sys/Utils/utils.dart';
// import 'package:complaint_management_sys/login_v1.dart';
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'login_v2.dart';
//
// class SignupScrV1 extends StatefulWidget {
//   const SignupScrV1({super.key});
//
//   @override
//   State<SignupScrV1> createState() => _SignupScrV1State();
// }
//
// class _SignupScrV1State extends State<SignupScrV1> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final nameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool loading = false;
//   String selectedRole = 'user'; // Default role selection
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//   }
//
//   void signup() {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       loading = true;
//     });
//
//     _auth.createUserWithEmailAndPassword(
//       email: emailController.text.toString(),
//       password: passwordController.text.toString(),
//     ).then((value) {
//       _firestore.collection('users').doc(value.user!.uid).set({
//         'name': nameController.text.toString(),
//         'email': emailController.text.toString(),
//         'role': selectedRole
//       }).then((_) {
//         setState(() {
//           loading = false;
//         });
//         Utils().toastmessage('Signup successful! Please login.');
//         // Navigate to the login screen after signup
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//         );
//       }).catchError((error) {
//         Utils().toastmessage(error.toString());
//         setState(() {
//           loading = false;
//         });
//       });
//     }).catchError((error) {
//       Utils().toastmessage(error.toString());
//       setState(() {
//         loading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           hintText: "Name",
//                           prefixIcon: Icon(Icons.person_outline),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Enter Name';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           hintText: "Email",
//                           helperText: "Enter email e.g: hamza@gmail.com",
//                           prefixIcon: Icon(Icons.mail_outline),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Enter Email';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           hintText: "Password",
//                           prefixIcon: Icon(Icons.lock_outline_rounded),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Enter Password';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                       SizedBox(height: 10),
//                       Column(
//                         children: [
//                           ListTile(
//                             title: const Text('User'),
//                             leading: Radio<String>(
//                               value: 'user',
//                               groupValue: selectedRole,
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   selectedRole = value!;
//                                 });
//                               },
//                             ),
//                           ),
//                           ListTile(
//                             title: const Text('Admin'),
//                             leading: Radio<String>(
//                               value: 'admin',
//                               groupValue: selectedRole,
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   selectedRole = value!;
//                                 });
//                               },
//                             ),
//                           ),
//                           ListTile(
//                             title: const Text('Mechanical Head'),
//                             leading: Radio<String>(
//                               value: 'mechanical_head',
//                               groupValue: selectedRole,
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   selectedRole = value!;
//                                 });
//                               },
//                             ),
//                           ),
//                           ListTile(
//                             title: const Text('HVAC'),
//                             leading: Radio<String>(
//                               value: 'hvac',
//                               groupValue: selectedRole,
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   selectedRole = value!;
//                                 });
//                               },
//                             ),
//                           ),
//                           ListTile(
//                             title: const Text('Electrical Head'),
//                             leading: Radio<String>(
//                               value: 'electrical_head',
//                               groupValue: selectedRole,
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   selectedRole = value!;
//                                 });
//                               },
//                             ),
//                           ),
//                           ListTile(
//                             title: const Text('Utility'),
//                             leading: Radio<String>(
//                               value: 'utility',
//                               groupValue: selectedRole,
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   selectedRole = value!;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 RoundButton(
//                   loading: loading,
//                   title: 'Sign Up',
//                   onTap: signup,
//                 ),
//                 SizedBox(height: 30),
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     Text("Have an account?"),
//                 //     TextButton(
//                 //       onPressed: () {
//                 //         Navigator.push(
//                 //           context,
//                 //           MaterialPageRoute(builder: (context) => LoginScreen()),
//                 //         );
//                 //       },
//                 //       child: Text(
//                 //         "Login",
//                 //         style: TextStyle(color: Colors.lightBlue),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
