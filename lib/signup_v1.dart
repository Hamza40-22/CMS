// import 'package:complaint_management_sys/Utils/utils.dart';
// import 'package:complaint_management_sys/login_v1.dart';
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
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
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
// void signup(){
//   setState(() {
//     loading = true;
//   });
//   _auth
//       .createUserWithEmailAndPassword(
//       email: emailController.text.toString(),
//       password: passwordController.text.toString()).then((value){
//     setState(() {
//       loading = false;
//     });
//   }).onError((error ,stackTrace){
//     Utils().toastmessage(error.toString());
//     setState(() {
//       loading = false;
//     });
//   });
// }
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
//               RoundButton(
//                 loading: loading,
//                 title: 'Sign Up',
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {
//                     signup();
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
//                   Text("Have an account?"),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginScreen()));
//                       },
//                       child: Text(
//                         "Login Up",
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
