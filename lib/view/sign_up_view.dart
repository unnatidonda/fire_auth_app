import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  User? userdata;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    EdgeInsets devicePadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      body: Padding(
        padding: devicePadding,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.all(screenWidth / 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    // validator: (value) {
                    //   if (!RegExp(
                    //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //       .hasMatch(value!)) {
                    //     return "Enter email id ";
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0.8, color: Color(0x8EB3B3B3)),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,
                      labelText: "Name",
                      hintText: "Enter Name ",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  TextFormField(
                    controller: emailcontroller,
                    validator: (value) {
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)) {
                        return "Enter email id ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0.8, color: Color(0x8EB3B3B3)),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,
                      labelText: "email",
                      hintText: "Enter email ",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    validator: (value) {
                      if (!RegExp(r"^[a-zA-Z0-9]{6}$").hasMatch(value!)) {
                        return "Enter Passcode";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 0.8, color: Color(0x8EB3B3B3)),
                      ),
                      // contentPadding: const EdgeInsets.all(00),
                      isDense: true,
                      labelText: "password",
                      hintText: "Enter password ",
                      contentPadding: const EdgeInsets.all(12),
                      hintStyle: const TextStyle(color: Color(0xFFB3B3B3), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                      fixedSize: MaterialStatePropertyAll(Size(screenWidth / 1, screenHeight / 18)),
                      backgroundColor: const MaterialStatePropertyAll(Color(0xFF00AB6C)),
                    ),
                    onPressed: () {
                      signuser();
                      if (formkey.currentState!.validate()) {
                        debugPrint("is valid");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      } else {
                        debugPrint("is not valid");
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 40,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signuser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailcontroller.text,
            password: passwordcontroller.text,
          )
          .then(
            (value) => (value) {
              userdata = value.user;
              userdata!.emailVerified;
              debugPrint(value.user.toString());
              setState(() {});
            },
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.------------------------------------------------------------------->>>');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.------------------------------------------------------------------->>>');
      }
    } catch (e) {
      debugPrint("$e ------------------------------------------------------------------->>>");
    }
  }

  @override
  void initState() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
}
