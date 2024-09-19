//first code proper login


// import 'package:complaint_management_sys/Utils/utils.dart';

// import 'package:complaint_management_sys/signup_v1.dart';
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'heads/head_complain_scr_V1.dart';
// import 'labor_scr_1_v2.dart';
// import 'signup_v2.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//
//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
//
//   void login() {
//     _auth.signInWithEmailAndPassword(
//       email: emailController.text,
//       password: passwordController.text.toString(),
//     ).then((value) {
//       // Retrieve user role from Firestore
//       _firestore.collection('users').doc(value.user!.uid).get().then((document) {
//         String role = document['role'];
//         if (role == 'user') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => LaborScreen1()),
//           );
//         } else if (role == 'head') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => FetchImageScreen()),
//           );
//         }
//       }).catchError((error) {
//         Utils().toastmessage(error.toString());
//       });
//     }).catchError((error, stackTrace) {
//       Utils().toastmessage(error.toString());
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         hintText: "Email",
//                         helperText: "enter email e.g : hamza@gmail.com",
//                         prefixIcon: Icon(Icons.mail_outline),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Email';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         prefixIcon: Icon(Icons.lock_outline_rounded),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Password';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               RoundButton(
//                 title: 'Login',
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     login();
//                   }
//                 },
//               ),
//               SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account?"),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignupScrV1()),
//                       );
//                     },
//                     child: Text(
//                       "Sign Up",
//                       style: TextStyle(color: Colors.lightBlue),
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

//good with new features


// import 'package:complaint_management_sys/Utils/utils.dart'; // Ensure this import is correct
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'auth/SignUp_V3.dart';
// import 'heads/HVAC_head.dart';
// import 'heads/electrical_head.dart';
// import 'heads/mechanical_head.dart';
// import 'heads/utility_head.dart';
// import 'labor_scr_1_v2.dart';
// import 'signup_v2.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//
//   final Utils _utils = Utils(); // Create an instance of Utils
//
//   @override
//   void initState() {
//     login(checkLogin: true);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void login({bool checkLogin = false}) async {
//     try {
//       // Sign in the user with email and password
//       final UserCredential userCredential;
//       if(_auth.currentUser != null && checkLogin) {
//         userCredential = _auth.currentUser as UserCredential;
//       } else
//      {
//          userCredential =
//             await _auth.signInWithEmailAndPassword(
//           email: emailController.text,
//           password: passwordController.text,
//         );
//       }
//
//       // Retrieve user role from Firestore
//       final DocumentSnapshot document = await _firestore
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .get();
//       final String role = document['role'];
//
//       // Navigate based on user role
//       switch (role) {
//         case 'user':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LaborScreen1()),
//           );
//           break;
//         case 'admin':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => SignupScrV3()),
//           );
//           break;
//         case 'mechanical_head':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => MechanicalHead()),
//           );
//           break;
//         case 'hvac':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HvacHead()),
//           );
//           break;
//         case 'electrical_head':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => ElectricalHead()),
//           );
//           break;
//         case 'utility':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => UtilityHead()),
//           );
//           break;
//         default:
//           _utils.toastmessage(
//               'Role not recognized'); // Use the instance to call the method
//           break;
//       }
//     } catch (error) {
//       _utils.toastmessage(
//           error.toString()); // Use the instance to call the method
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         hintText: "Email",
//                         helperText: "Enter email e.g: hamza@gmail.com",
//                         prefixIcon: Icon(Icons.mail_outline),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         prefixIcon: Icon(Icons.lock_outline_rounded),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Password';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               RoundButton(
//                 title: 'Login',
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     login();
//                   }
//                 },
//               ),
//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// new login code
// import 'package:complaint_management_sys/Utils/utils.dart';
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'auth/SignUp_V3.dart';
// import 'heads/HVAC_head.dart';
// import 'heads/electrical_head.dart';
// import 'heads/mechanical_head.dart';
// import 'heads/utility_head.dart';
// import 'user_scr_list_details/labor_scr_1_v2.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   bool loading = false;
//
//   final Utils _utils = Utils();
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void login() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       loading = true;
//     });
//
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//
//       DocumentSnapshot document = await _firestore
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .get();
//       String role = document['role'];
//
//       switch (role) {
//         case 'admin':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => SignupScrV3()),
//           );
//           break;
//         case 'mechanical_head':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => MechanicalHead()),
//           );
//           break;
//         case 'hvac':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HvacHead()),
//           );
//           break;
//         case 'electrical_head':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => ElectricalHead()),
//           );
//           break;
//         case 'utility':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => UtilityHead()),
//           );
//           break;
//         case 'production':
//         case 'user': // Add user role to navigate to LaborScreen1
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LaborScreen1()),
//           );
//           break;
//         default:
//           _utils.toastmessage('Role not recognized');
//           break;
//       }
//     } catch (error) {
//       _utils.toastmessage(error.toString());
//     }
//
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         hintText: "Email",
//                         helperText: "Enter email e.g: hamza@gmail.com",
//                         prefixIcon: Icon(Icons.mail_outline),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         prefixIcon: Icon(Icons.lock_outline_rounded),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Password';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               RoundButton(
//                 loading: loading,
//                 title: 'Login',
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     login();
//                   }
//                 },
//               ),
//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//Forgot Password , Remember Me / Stay Logged In ,Remember Me / Stay Logged In) suggestions in this code
//   import 'package:complaint_management_sys/Utils/utils.dart';
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'auth/SignUp_V3.dart';
// import 'heads/HVAC_head.dart';
// import 'heads/electrical_head.dart';
// import 'heads/mechanical_head.dart';
// import 'heads/utility_head.dart';
// import 'user_scr_list_details/labor_scr_1_v2.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   bool loading = false;
//   bool rememberMe = false;
//
//   final Utils _utils = Utils();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserEmailPassword();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void _loadUserEmailPassword() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedEmail = prefs.getString('email');
//     final savedPassword = prefs.getString('password');
//     final savedRememberMe = prefs.getBool('rememberMe') ?? false;
//
//     if (savedEmail != null && savedPassword != null && savedRememberMe) {
//       emailController.text = savedEmail;
//       passwordController.text = savedPassword;
//       setState(() {
//         rememberMe = savedRememberMe;
//       });
//     }
//   }
//
//   void _saveUserEmailPassword() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (rememberMe) {
//       await prefs.setString('email', emailController.text);
//       await prefs.setString('password', passwordController.text);
//       await prefs.setBool('rememberMe', rememberMe);
//     } else {
//       await prefs.remove('email');
//       await prefs.remove('password');
//       await prefs.remove('rememberMe');
//     }
//   }
//
//   void login() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       loading = true;
//     });
//
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//
//       _saveUserEmailPassword();
//
//       DocumentSnapshot document = await _firestore
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .get();
//       String role = document['role'];
//
//       switch (role) {
//         case 'admin':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => SignupScrV3()),
//           );
//           break;
//         case 'mechanical_head':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => MechanicalHead()),
//           );
//           break;
//         case 'hvac':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HvacHead()),
//           );
//           break;
//         case 'electrical_head':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => ElectricalHead()),
//           );
//           break;
//         case 'utility':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => UtilityHead()),
//           );
//           break;
//         case 'production':
//         case 'user': // Add user role to navigate to LaborScreen1
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LaborScreen1()),
//           );
//           break;
//         default:
//           _utils.toastmessage('Role not recognized');
//           break;
//       }
//     } catch (error) {
//       _utils.toastmessage(error.toString());
//     }
//
//     setState(() {
//       loading = false;
//     });
//   }
//
//   void _forgotPassword() async {
//     if (emailController.text.isEmpty) {
//       _utils.toastmessage('Please enter your email to reset your password');
//       return;
//     }
//
//     try {
//       await _auth.sendPasswordResetEmail(email: emailController.text);
//       _utils.toastmessage('Password reset email sent');
//     } catch (error) {
//       _utils.toastmessage(error.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         hintText: "Email",
//                         helperText: "Enter email e.g: hamza@gmail.com",
//                         prefixIcon: Icon(Icons.mail_outline),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 10),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         prefixIcon: Icon(Icons.lock_outline_rounded),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Password';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: rememberMe,
//                         onChanged: (value) {
//                           setState(() {
//                             rememberMe = value!;
//                           });
//                         },
//                       ),
//                       Text('Remember Me'),
//                     ],
//                   ),
//                   TextButton(
//                     onPressed: _forgotPassword,
//                     child: Text('Forgot Password?'),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               RoundButton(
//                 loading: loading,
//                 title: 'Login',
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     login();
//                   }
//                 },
//               ),
//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// // without FCM token
// import 'package:complaint_management_sys/Utils/utils.dart';
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'auth/SignUp_V3.dart';
// import 'heads/HVAC_head.dart';
// import 'heads/electrical_head.dart';
// import 'heads/mechanical_head.dart';
// import 'heads/utility_head.dart';
// import 'list/Electrical_List/Electrical_listScreen.dart';
// import 'list/HvacList/hvac_listScreen.dart';
// import 'list/Mechanical_list/mechanical_listScreen.dart';
// import 'list/Utility_List/Utility_detail_Scr.dart';
// import 'list/Utility_List/Utility_list_scr.dart';
// import 'user_scr_list_details/labor_scr_1_v2.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   bool loading = false;
//   bool rememberMe = false;
//
//   final Utils _utils = Utils();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserEmailPassword();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void _loadUserEmailPassword() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedEmail = prefs.getString('email');
//     final savedPassword = prefs.getString('password');
//     final savedRememberMe = prefs.getBool('rememberMe') ?? false;
//
//     if (savedEmail != null && savedPassword != null && savedRememberMe) {
//       emailController.text = savedEmail;
//       passwordController.text = savedPassword;
//       setState(() {
//         rememberMe = savedRememberMe;
//       });
//     }
//   }
//
//   void _saveUserEmailPassword() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (rememberMe) {
//       await prefs.setString('email', emailController.text);
//       await prefs.setString('password', passwordController.text);
//       await prefs.setBool('rememberMe', rememberMe);
//     } else {
//       await prefs.remove('email');
//       await prefs.remove('password');
//       await prefs.remove('rememberMe');
//     }
//   }
//
//   void login() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       loading = true;
//     });
//
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: emailController.text,
//         password: passwordController.text,
//       );
//
//       _saveUserEmailPassword();
//
//       DocumentSnapshot document = await _firestore
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .get();
//       String role = document['role'];
//
//       switch (role) {
//         case 'admin':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => SignupScrV3()),
//           );
//           break;
//         case 'mechanical':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => MechanicalListScr()),
//           );
//           break;
//         case 'hvac':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HvacListScreen()),
//           );
//           break;
//         case 'electrical':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => ElectricalListScr()),
//           );
//           break;
//         case 'utility':
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => UtilityListScreen()),
//           );
//           break;
//         case 'production':
//         case 'user': // Add user role to navigate to LaborScreen1
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LaborScreen1()),
//           );
//           break;
//         default:
//           _utils.toastmessage('Role not recognized');
//           break;
//       }
//     } catch (error) {
//       _utils.toastmessage(error.toString());
//     }
//
//     setState(() {
//       loading = false;
//     });
//   }
//
//   void _forgotPassword() async {
//     if (emailController.text.isEmpty) {
//       _utils.toastmessage('Please enter your email to reset your password');
//       return;
//     }
//
//     try {
//       await _auth.sendPasswordResetEmail(email: emailController.text);
//       _utils.toastmessage('Password reset email sent');
//     } catch (error) {
//       _utils.toastmessage(error.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           color: Color(0xFFE0F7FA), // Light cyan background color
//           child: Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset('assets/highqlogo.png', height: 100),
//                     Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF212121), // Dark gray text color
//                       ),
//                     ),
//                     SizedBox(height: 40),
//                     Form(
//                       key: _formKey,
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         elevation: 5,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             children: [
//                               TextFormField(
//                                 controller: emailController,
//                                 decoration: InputDecoration(
//                                   hintText: "Email",
//                                   prefixIcon: Icon(Icons.mail_outline),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Enter Email';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               SizedBox(height: 20),
//                               TextFormField(
//                                 controller: passwordController,
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   hintText: "Password",
//                                   prefixIcon: Icon(Icons.lock_outline_rounded),
//                                   filled: true,
//                                   fillColor: Colors.white,
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Enter Password';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               SizedBox(height: 10),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Checkbox(activeColor: Color(0xff00B2E2),
//                                         value: rememberMe,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             rememberMe = value!;
//                                           });
//                                         },
//                                       ),
//                                       Text('Remember Me'),
//                                     ],
//                                   ),
//                                   TextButton(
//                                     onPressed: _forgotPassword,
//                                     child: Text(
//                                       'Forgot Password?',
//                                       style: TextStyle(color: Color(0xFF0288D1)), // Deep blue accent color
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 20),
//                               RoundButton(
//                                 loading: loading,
//                                 title: 'Login',
//                                 onTap: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     login();
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// with FCM token
import 'package:complaint_management_sys/Utils/utils.dart';
import 'package:complaint_management_sys/widgets/round_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/SignUp_V3.dart';
import 'heads/HVAC_head.dart';
import 'heads/electrical_head.dart';
import 'heads/mechanical_head.dart';
import 'heads/utility_head.dart';
import 'list/Electrical_List/Electrical_listScreen.dart';
import 'list/HvacList/hvac_listScreen.dart';
import 'list/Mechanical_list/mechanical_listScreen.dart';
import 'list/Utility_List/Utility_detail_Scr.dart';
import 'list/Utility_List/Utility_list_scr.dart';
import 'user_scr_list_details/labor_scr_1_v2.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loading = false;
  bool rememberMe = false;



  final Utils _utils = Utils();

  String? fcmToken; // Remove initialization here

  @override
  void initState() {
    super.initState();
    _loadUserEmailPassword();

    // Get the FCM token when the user logs in and update in Firestore
    _getFcmToken();

    // Listen for FCM token refresh and update the token in Firestore
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .update({'fcmToken': newToken}).then((_) {
        print("FCM Token updated in Firestore");
      }).catchError((error) {
        print("Failed to update FCM token: $error");
      });
    });
  }

// Add this async method to get the FCM token
  Future<void> _getFcmToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");

    // Check if the user is logged in and then update the Firestore with the token
    if (_auth.currentUser != null && fcmToken != null) {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.uid)
          .update({'fcmToken': fcmToken});
    }
  }



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _loadUserEmailPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');
    final savedRememberMe = prefs.getBool('rememberMe') ?? false;

    if (savedEmail != null && savedPassword != null && savedRememberMe) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      setState(() {
        rememberMe = savedRememberMe;
      });
    }
  }

  void _saveUserEmailPassword() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('rememberMe', rememberMe);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('rememberMe');
    }
  }

  void login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    try {
      // Sign in the user with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      _saveUserEmailPassword();

      // Retrieve the user's role from Firestore
      DocumentSnapshot document = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      String role = document['role'];

      // Get the FCM token for the user
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print('FCM Token: $fcmToken');

      // Check if FCM token is not null and update it in Firestore
      if (fcmToken != null) {
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .update({'fcmToken': fcmToken});
      }

      // Navigate to different screens based on the role
      switch (role) {
        case 'admin':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignupScrV3()),
          );
          break;
        case 'mechanical':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MechanicalListScr()),
          );
          break;
        case 'hvac':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HvacListScreen()),
          );
          break;
        case 'electrical':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ElectricalListScr()),
          );
          break;
        case 'utility':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UtilityListScreen()),
          );
          break;
        case 'production':
        case 'user': // Add user role to navigate to LaborScreen1
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LaborScreen1()),
          );
          break;
        default:
          _utils.toastmessage('Role not recognized');
          break;
      }
    } catch (error) {
      _utils.toastmessage(error.toString());
    }

    setState(() {
      loading = false;
    });
  }



  void _forgotPassword() async {
    if (emailController.text.isEmpty) {
      _utils.toastmessage('Please enter your email to reset your password');
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      _utils.toastmessage('Password reset email sent');
    } catch (error) {
      _utils.toastmessage(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xFFE0F7FA), // Light cyan background color
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/highqlogo.png', height: 100),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121), // Dark gray text color
                      ),
                    ),
                    SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.mail_outline),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock_outline_rounded),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(activeColor: Color(0xff00B2E2),
                                        value: rememberMe,
                                        onChanged: (value) {
                                          setState(() {
                                            rememberMe = value!;
                                          });
                                        },
                                      ),
                                      Text('Remember Me'),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: _forgotPassword,
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(color: Color(0xFF0288D1)), // Deep blue accent color
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              RoundButton(
                                loading: loading,
                                title: 'Login',
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    login();
                                  }
                                },
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
        ),
      ),
    );
  }
}
