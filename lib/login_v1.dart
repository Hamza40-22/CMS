//
// import 'package:complaint_management_sys/Utils/utils.dart';
// import 'package:complaint_management_sys/signup_v1.dart';
// import 'package:complaint_management_sys/signup_v2.dart';
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'labor_scr_1_v2.dart';
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
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
//
//   void login(){
//     _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text.toString()).then(
//             (value){
//               Navigator.push(context, MaterialPageRoute(builder: (context)=> LaborScreen1()));
//             }).onError(
//             (error , stackTrace){
// Utils().toastmessage(error.toString());
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
//                   key: _formKey,
//                   child: Column(children: [
//                     TextFormField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                           hintText: "Email",
//                           helperText: "enter email e.g : hamza@gmail.com",
//                           prefixIcon: Icon(Icons.mail_outline)),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Email';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                           hintText: "Password",
//                           prefixIcon: Icon(Icons.lock_outline_rounded)),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Password';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ])),
//               SizedBox(
//                 height: 20,
//               ),
//
//               RoundButton(
//                 title: 'Login',
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     login();
//
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account?"),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScrV1()) );
//                       },
//                       child: Text(
//                         "Sign Up",
//                         style: TextStyle(color: Colors.lightBlue),
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
