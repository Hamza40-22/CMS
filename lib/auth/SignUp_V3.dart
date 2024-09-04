



//UI good
// import 'package:complaint_management_sys/Utils/utils.dart';
// import 'package:complaint_management_sys/widgets/round_btn.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../login_v2.dart';
//
// class SignupScrV3 extends StatefulWidget {
//   const SignupScrV3({super.key});
//
//   @override
//   State<SignupScrV3> createState() => _SignupScrV3State();
// }
//
// class _SignupScrV3State extends State<SignupScrV3> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final nameController = TextEditingController();
//   final productionFieldController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool loading = false;
//   String selectedRole = 'user'; // Default role selection
//   bool isEngineeringHead = false;
//   bool isProduction = false;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     nameController.dispose();
//     productionFieldController.dispose();
//     super.dispose();
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
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     ).then((value) {
//       _firestore.collection('users').doc(value.user!.uid).set({
//         'name': nameController.text.trim(),
//         'email': emailController.text.trim(),
//         'role': selectedRole,
//         if (selectedRole == 'production')
//           'production_field': productionFieldController.text.trim(),
//       }).then((_) {
//         setState(() {
//           loading = false;
//         });
//         Utils().toastmessage('Signup successful! Please login.');
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
//     final themeColor = Color(0xFF01B3F1); // Define the theme color
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade100, // Light background
//         body: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Create Account",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: themeColor,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "Please fill the form to create your account.",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey.shade600,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: nameController,
//                       decoration: InputDecoration(
//                         hintText: "Name",
//                         prefixIcon: Icon(Icons.person_outline, color: themeColor),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Name';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                     SizedBox(height: 15),
//                     TextFormField(
//                       controller: emailController,
//                       decoration: InputDecoration(
//                         hintText: "Email",
//                         helperText: "Enter email e.g: hamza@gmail.com",
//                         prefixIcon: Icon(Icons.mail_outline, color: themeColor),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Email';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                     SizedBox(height: 15),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: "Password",
//                         prefixIcon: Icon(Icons.lock_outline_rounded, color: themeColor),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Enter Password';
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                     SizedBox(height: 15),
//                     Column(
//                       children: [
//                         CheckboxListTile(
//                           title: Text(
//                             "Engineering Department",
//                             style: TextStyle(color: themeColor, fontWeight: FontWeight.w600),
//                           ),
//                           value: isEngineeringHead,
//                           activeColor: themeColor,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isEngineeringHead = value!;
//                               if (value) {
//                                 selectedRole = 'admin';
//                                 isProduction = false; // Deselect Production
//                               }
//                             });
//                           },
//                         ),
//                         if (isEngineeringHead)
//                           Column(
//                             children: [
//                               buildRoleSelectionTile('Admin', 'admin'),
//                               buildRoleSelectionTile('Mechanical', 'mechanical_head'),
//                               buildRoleSelectionTile('HVAC', 'hvac'),
//                               buildRoleSelectionTile('Electrical', 'electrical_head'),
//                               buildRoleSelectionTile('Utility', 'utility'),
//                             ],
//                           ),
//                         CheckboxListTile(
//                           title: Row(
//                             children: [
//                               Text(
//                                 "Production Department",
//                                 style: TextStyle(color: themeColor, fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(width: 10),
//                               if (isProduction)
//                                 Expanded(
//                                   child: TextFormField(
//                                     controller: productionFieldController,
//                                     decoration: InputDecoration(
//                                       hintText: "Production field",
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12),
//                                         borderSide: BorderSide.none,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                           value: isProduction,
//                           activeColor: themeColor,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isProduction = value!;
//                               if (value) {
//                                 selectedRole = 'production';
//                                 isEngineeringHead = false; // Deselect Engineering Head
//                               }
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white, backgroundColor: themeColor, // Text color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: loading ? null : signup, // Disable button when loading
//                 child: loading
//                     ? CircularProgressIndicator(color: Colors.white)
//                     : Text('Sign Up'),
//               ),
//               SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   ListTile buildRoleSelectionTile(String title, String roleValue) {
//     return ListTile(
//       title: Text(
//         title,
//         style: TextStyle(color: Colors.grey.shade800),
//       ),
//       leading: Radio<String>(
//         value: roleValue,
//         groupValue: selectedRole,
//         activeColor: Color(0xFF01B3F1), // Use the theme color
//         onChanged: (String? value) {
//           setState(() {
//             selectedRole = value!;
//           });
//         },
//       ),
//     );
//   }
// }


import 'package:complaint_management_sys/Utils/utils.dart';
import 'package:complaint_management_sys/widgets/round_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login_v2.dart';

class SignupScrV3 extends StatefulWidget {
  const SignupScrV3({super.key});

  @override
  State<SignupScrV3> createState() => _SignupScrV3State();
}

class _SignupScrV3State extends State<SignupScrV3> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final productionFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String selectedRole = 'user'; // Default role selection
  bool isEngineeringHead = false;
  bool isProduction = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    productionFieldController.dispose();
    super.dispose();
  }

  void signup() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    _auth.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    ).then((value) {
      _firestore.collection('users').doc(value.user!.uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'role': selectedRole,
        if (selectedRole == 'production')
          'production_field': productionFieldController.text.trim(),
      }).then((_) {
        setState(() {
          loading = false;
        });
        Utils().toastmessage('Signup successful! Please login.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }).catchError((error) {
        Utils().toastmessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    }).catchError((error) {
      Utils().toastmessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(0xFF01B3F1); // Define the theme color

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100, // Light background
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Please fill the form to create your account.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person_outline, color: themeColor),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        helperText: "Enter email e.g: hamza@gmail.com",
                        prefixIcon: Icon(Icons.mail_outline, color: themeColor),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock_outline_rounded, color: themeColor),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: [
                        CheckboxListTile(
                          title: Text(
                            "Engineering Department",
                            style: TextStyle(color: themeColor, fontWeight: FontWeight.w600),
                          ),
                          value: isEngineeringHead,
                          activeColor: themeColor,
                          onChanged: (bool? value) {
                            setState(() {
                              isEngineeringHead = value!;
                              if (value) {
                                selectedRole = 'admin';
                                isProduction = false; // Deselect Production
                              }
                            });
                          },
                        ),
                        if (isEngineeringHead)
                          Column(
                            children: [
                              buildRoleSelectionTile('Admin', 'admin'),
                              buildRoleSelectionTile('Mechanical', 'mechanical_head'),
                              buildRoleSelectionTile('HVAC', 'hvac'),
                              buildRoleSelectionTile('Electrical', 'electrical_head'),
                              buildRoleSelectionTile('Utility', 'utility'),
                            ],
                          ),
                        CheckboxListTile(
                          title: Text(
                            "Production Department",
                            style: TextStyle(color: themeColor, fontWeight: FontWeight.w600),
                          ),
                          value: isProduction,
                          activeColor: themeColor,
                          onChanged: (bool? value) {
                            setState(() {
                              isProduction = value!;
                              if (value) {
                                selectedRole = 'production';
                                isEngineeringHead = false; // Deselect Engineering Head
                              }
                            });
                          },
                        ),
                        if (isProduction)
                          TextFormField(
                            controller: productionFieldController,
                            decoration: InputDecoration(
                              hintText: "Production field",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: themeColor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: loading ? null : signup, // Disable button when loading
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Sign Up'),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildRoleSelectionTile(String title, String roleValue) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.grey.shade800),
      ),
      leading: Radio<String>(
        value: roleValue,
        groupValue: selectedRole,
        activeColor: Color(0xFF01B3F1), // Use the theme color
        onChanged: (String? value) {
          setState(() {
            selectedRole = value!;
          });
        },
      ),
    );
  }
}
